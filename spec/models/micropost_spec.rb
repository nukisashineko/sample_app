require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user) }

  before do
    @microposts = Micropost.new(content: "Lorem ipsum", user_id: user.id)
  end
  subject { @microposts }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
end