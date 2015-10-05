require 'rails_helper'

RSpec.describe Interviewee, type: :model do
  context "factory" do
    let(:interviewee) { FactoryGirl.create(:interviewee)}
    it "has a valid factory" do
      expect(interviewee).to be_valid
    end

    context "multiple interviewee creation" do
      let(:interviewees) {FactoryGirl.create_list(:interviewee, 5)}
      it "creates many interviewees" do
        expect(interviewees.count).to eq(5)
        expect(Interviewee.count).to eq(5)
      end
    end

    context "factory reloads for each test" do
      let(:interviewee) {FactoryGirl.create(:interviewee)}
      it "for(:each) test reload factory" do
        expect(interviewee.name).to eq("MyName1")
      end
      let(:interviewee_2) {FactoryGirl.create(:interviewee)}
      it "reloads factory" do
         expect(interviewee_2.name).to eq("MyName1")
      end
    end
  end

  context "invalid interviewee" do
    context "no name" do
      let(:interviewee_no_name) { FactoryGirl.build(:interviewee, :name => "") }
      it "raises DB validation error" do
        expect{interviewee_no_name.save!}.to raise_error(ActiveRecord::RecordInvalid,
          "Validation failed: Name can't be blank")
      end

      it "is invalid without name" do
        expect(interviewee_no_name).not_to be_valid
      end
    end

    context "no latitude" do
      let(:interviewee_no_lat) { FactoryGirl.build(:interviewee, :latitude => "") }
      it "isn't valid without latitude" do
        expect(interviewee_no_lat).not_to be_valid
      end

      it "raises DB validation error" do
        expect{interviewee_no_lat.save!}.to raise_error(ActiveRecord::RecordInvalid,
        "Validation failed: Latitude can't be blank")
      end
    end

    context "no latitude" do
      let(:interviewee_no_lon) { FactoryGirl.build(:interviewee, :longitude => "") }
      it "isn't valid without latitude" do
        expect(interviewee_no_lon).not_to be_valid
      end

      it "raises DB validation error" do
        expect{interviewee_no_lon.save!}.to raise_error(ActiveRecord::RecordInvalid,
        "Validation failed: Longitude can't be blank")
      end
    end
  end

  context "has associations" do
    context "kiosk" do
      let(:association) { Interviewee.reflect_on_association(:kiosk) }
      it "belongs_to :kiosk" do
        expect(association.macro).to eq(:belongs_to)
      end
    end

    context "answer" do
      let(:association) { Interviewee.reflect_on_association(:answers) }
      it "has_many :answers" do
        expect(association.macro).to eq(:has_many)
      end
    end
  end

  context "delete record" do
    let(:kiosk) { FactoryGirl.create(:kiosk_with_interviewees)}
    it "creates 5 interviewees" do
      kiosk
      expect(Interviewee.count).to eq(5)
    end

    it "interviewees are deleted on kiosk.destroy" do
      kiosk.destroy
      expect(Interviewee.count).to eq(0)
    end

    it "interviewees are deleted on kiosk.delete" do
      kiosk.delete
      expect(Interviewee.count).to eq(0)
    end

    let(:inter) { kiosk.interviewees.first }
    it "doen't delete dependee" do
      inter
      expect(Kiosk.count).to eq(1)
      inter.destroy
      expect(Kiosk.count).to eq(1)
    end
  end

  context "gender field" do
    let(:interviewee) { Interviewee.new }
    it "defaults to 0" do
      expect(Interviewee.genders[interviewee.gender]).to eq(0)
    end
    let(:gender_nil) { FactoryGirl.build(:interviewee, gender: nil) }
    it "can't be nil" do
      expect{gender_nil.save!}.to raise_error(ActiveRecord::StatementInvalid,
        /PG::NotNullViolation: ERROR:  null value in column "gender" violates not-null constraint/)
    end
  end

end
