require 'spec_helper'

describe "MicropostPages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "microposts counter" do
    describe "with zero count" do
      before { visit root_path }
      it { should have_content('0 micropost') }
    end

    describe "with two count" do
      before do
        FactoryGirl.create(:micropost, user: user)
        FactoryGirl.create(:micropost, user: user)
        visit root_path
      end
      it { should have_content('2 microposts') }
    end
  end

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not a create micropost" do
        expect{ click_button "Post" }.not_to change(Micropost, :count)
      end
      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before { fill_in "micropost_content", with: "Lorem ipsum"}
      it "should a create micropost" do
        expect{ click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }
    describe "as  correct user" do
      before { visit root_path }
      it "should delete a micropost" do
        expect{ click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end

  describe "other user's micropost without delete_link" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      FactoryGirl.create(:micropost, user: user)
      visit user_path(other_user)
    end

    it { should_not have_link('delete') }
  end
end
