describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end


  context "roles" do
    it "creates default role 'user' " do
      expect(@user.user?).to be true
    end
    let(:user_roleless) { FactoryGirl.build(:user, role: nil) }
    it "PG validates not null" do
      expect{user_roleless.save!}.to raise_error(ActiveRecord::StatementInvalid,
        /PG::NotNullViolation: ERROR:  null value in column "role" violates not-null constraint/)
    end
  end

end
