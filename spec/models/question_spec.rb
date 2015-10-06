require 'rails_helper'

RSpec.describe Question, type: :model do
  context "factory" do
    let(:question) { FactoryGirl.create(:question)}
    it "has a valid factory" do
      expect(question).to be_valid
    end

    context "multiple question creation" do
      let(:questions) {FactoryGirl.create_list(:question, 5)}
      it "creates many questions" do
        expect(questions.count).to eq(5)
        expect(Question.count).to eq(5)
      end
    end

    context "factory reloads for each test" do
      let(:question) {FactoryGirl.create(:question)}
      it "for(:each) test reload factory" do
        expect(question.content).to eq("Content1")
      end
      let(:question_2) {FactoryGirl.create(:question)}
      it "reloads factory" do
         expect(question_2.content).to eq("Content1")
      end
    end
  end

  context "question without content is invalid " do
    let(:question_null_content) { FactoryGirl.build(:question, content: "") }
    it "should not be valid" do
      expect(question_null_content).not_to be_valid
    end

    it "should raise RecordInvalid error" do
      expect{question_null_content.save!}.to raise_error(ActiveRecord::RecordInvalid,
        /Validation failed: Content can't be blank/)
    end
  end
end
