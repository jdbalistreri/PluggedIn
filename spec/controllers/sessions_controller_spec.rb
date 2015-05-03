require 'rails_helper'

describe SessionsController do

  describe "#create" do

    context 'when user email/password is invalid' do
      it 'rerenders the login page' do
        user = create(:user)

        post :create, user: { email: user.email, password: "invalid" }

        expect(response).to render_template(:new)
        expect(session[:token]).to be(nil)
      end
    end

    context 'when user email/password is valid' do
      it 'sets the user in the session and redirects to the user profile page' do
        user = create(:user, password: "password")

        post :create, user: { email: user.email, password: "password" }
        expect(response).to redirect_to '/'
        expect(session[:token]).to_not be(nil)
        expect(controller.current_user).to eq(user)
      end
    end

  end

  describe "#destroy" do
    let(:user) { create(:user, password: "password") }

    before(:each) do
      post :create, user: { email: user.email, password: "password" }
    end

    it "clears the session token" do
      delete :destroy
      expect(session[:token]).to be(nil)
    end

    it "resets the user's session token attribute" do
      current_user = @controller.current_user
      old_token = current_user.session_token
      delete :destroy
      expect(current_user.session_token).to_not eq(old_token)
    end

    it "redirects to the new session url" do
      delete :destroy
      expect(response).to redirect_to '/session/new'
    end

  end

  describe "#new" do
    it 'renders the new session view' do
      get :new
      assert_template :new
    end
  end

end
