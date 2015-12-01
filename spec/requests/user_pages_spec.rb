require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Create my accunt" }
    describe "with invalid information" do
      it "should not create a user" do
        expect{ click_button submit }.not_to change(User, :count)
      end

      describe "after submission error check" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }

        describe "with no inputed" do
          it { should have_content("Name can't be blank") }
          it { should have_content("Email can't be blank") }
          it { should have_content("Email is invalid") }
          it { should have_content('Password is too short (minimum is 6 characters)') }
          it { should have_content("Password can't be blank") }
        end
        describe "with already email" do
          let(:user) { FactoryGirl.create(:user) }
          before do
            user.save!
            fill_in "Email", with: user.email
            click_button submit
          end
          it { should have_content("Email has already been taken") }
        end
      end

    end
    describe "with valid information"  do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: "user@example.com") }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome')}
      end
    end

    it { should have_content('Sign up')}
    it { should have_title(full_title('Sign up'))}
  end
end
