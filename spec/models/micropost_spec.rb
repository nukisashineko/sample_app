require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user) }

  before { @microposts = user.microposts.build(content: "Lorem ipsum") }
  subject { @microposts }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user}

  it { should be_valid }

  describe "when user id is not present" do
    before { @microposts.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @microposts.content = " " }
    it { should_not be_valid }
  end


  describe "with content that is too long" do
    before { @microposts.content = "a"*141 }
    it { should_not be_valid }
  end
end