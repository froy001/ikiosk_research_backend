require 'rails_helper'

RSpec.describe Kiosk, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  context "factory" do
    let(:kiosk) { FactoryGirl.create(:kiosk)}
    it "has a valid factory" do
      expect(kiosk).to be_valid
    end

    context "multiple kiosk creation" do
      let(:kiosks) {FactoryGirl.create_list(:kiosk, 5)}
      it "creates many kiosks" do
        expect(kiosks.count).to eq(5)
        expect(Kiosk.count).to eq(5)
      end
    end

    context "factory reloads for each test" do
      let(:kiosk) {FactoryGirl.create(:kiosk)}
      it "for(:each) test reload factory" do
        expect(kiosk.name).to eq("kiosk1")
      end
      let(:kiosk_2) {FactoryGirl.create(:kiosk)}
      it "reloads factory" do
         expect(kiosk_2.name).to eq("kiosk1")
      end
    end

  end

  context "invalid kiosk" do
    let(:kiosk_build) { FactoryGirl.create(:kiosk, :name => "")}
    it "is invalid without a name" do
      expect{kiosk_build}.to raise_error(ActiveRecord::RecordInvalid,
        "Validation failed: Name can't be blank")
    end

    let(:kiosk_no_lat) { FactoryGirl.build(:kiosk, :latitude => "") }
    it "is invalid with nil latitude" do
      expect(kiosk_no_lat).not_to be_valid
    end

    let(:kiosk_no_lng) { FactoryGirl.build(:kiosk, :longitude => "") }
    it "is invalid without longtitude" do
      expect(kiosk_no_lng).not_to be_valid
    end
  end

  context "associations" do
    let(:association) { Kiosk.reflect_on_association(:interviewees) }
    it "has_many :interviewees" do
      expect(association.macro).to eq(:has_many)
    end
  end

end
