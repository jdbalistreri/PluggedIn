require 'rails_helper'

describe UsersController do

  describe "create" do
    let(:user) { build(:user) }

    context "valid user information is submitted" do
      it "adds a user to the database" do
        expect do
          post :create, user: { email: user.email, password: user.password,
                                fname: user.fname, lname: user.lname }
        end.to change { User.count }.from(0).to(1)
      end

      context do
        before(:each) do
          post :create, user: { email: user.email, password: user.password,
                                fname: user.fname, lname: user.lname }
        end

        it "logs in the user" do
          expect(@controller.current_user.email).to eq(user.email)
        end

        it "redirects to the root" do
          expect(response).to redirect_to '/'
        end
      end
    end

    context "invalid user information is submitted" do
      before(:each) do
        post :create, user: { email: user.email }
      end

      it "adds the error messages to the flash" do
        expect(flash[:errors]).to_not be(nil)
      end

      it "renders the new user view" do
        assert_template :new
      end
    end
  end

  describe "new" do
    it "renders the new user view" do
      get :new
      assert_template :new
    end
  end
end
