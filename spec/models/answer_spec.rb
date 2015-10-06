require 'rails_helper'

RSpec.describe Answer, type: :model do
  context "factory" do
    let(:answer) { FactoryGirl.create(:answer)}
    it "has a valid factory" do
      expect(answer).to be_valid
    end

    context "multiple answer creation" do
      let(:answers) {FactoryGirl.create_list(:answer, 5)}
      it "creates many answers" do
        expect(answers.count).to eq(5)
        expect(Answer.count).to eq(5)
      end
    end

    context "factory reloads for each test" do
      let(:answer) {FactoryGirl.create(:answer)}
      it "for(:each) test reload factory" do
        expect(answer.value).to be_within(0.0001).of(1.5099)
      end
      let(:answer_2) {FactoryGirl.create(:answer)}
      it "reloads factory" do
         expect(answer_2.value).to be_within(0.0001).of(1.5099)
      end
    end
  end

  context "Interviewee on_delete :cascade" do
    let(:interview) { FactoryGirl.create(:interviewees_with_answer)}
    it "creates 5 interviewees" do
      interview
      expect(Answer.count).to eq(5)
    end

    it "interviewees are deleted on interview.destroy" do
      interview.destroy
      expect(Answer.count).to eq(0)
    end

    it "Answers are deleted on interview.delete" do
      interview.delete
      expect(Answer.count).to eq(0)
    end
  end

  context "Question on_delete :cascade" do
    let(:question) { FactoryGirl.create(:question_with_answers)}
    it "creates 5 questionees" do
      question
      expect(Answer.count).to eq(5)
    end

    it "questionees are deleted on question.destroy" do
      question.destroy
      expect(Answer.count).to eq(0)
    end

    it "Answers are deleted on question.delete" do
      question.delete
      expect(Answer.count).to eq(0)
    end
  end

  context "invalid answer" do
    context "with no interveiwee_id" do
      let(:answer_no_interviewee) { FactoryGirl.build(:answer, :interviewee_id => nil)  }
      it "is invalid" do
        expect(answer_no_interviewee).not_to be_valid
      end
      it "raises an invalid error" do
        expect{answer_no_interviewee.save!}.to raise_error(ActiveRecord::RecordInvalid, /Validation failed: Interviewee can't be blank/)
      end
    end
  end

  context "has association" do
    context "interviewee" do
      let(:association) { Answer.reflect_on_association(:interviewee) }
      it "belongs_to :interviewee" do
        expect(association.macro).to eq(:belongs_to)
      end
    end

    context "question" do
      let(:association) { Answer.reflect_on_association(:question) }
      it "belongs_to :question" do
        expect(association.macro).to eq(:belongs_to)
      end
    end
  end
end
