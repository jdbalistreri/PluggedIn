require 'rails_helper'

describe SessionsController do

  describe "#create" do

    context 'when user email/password is invalid' do
      it 'rerenders the login page' do
        user = create(:user)

        post :create, user: { email: user.email, password: "invalid" }

        expect(response).to render_template(:new)
      end
    end

    context 'when user email/password is valid' do
      it 'sets the user in the session and redirects to the user profile page' do
        user = create(:user, password: "password")

        post :create, user: { email: user.email, password: "password" }
        expect(response). to redirect_to '/'
        expect(controller.current_user).to eq(user)
      end
    end

  end

  describe "#destroy"

  describe "#new"

end
