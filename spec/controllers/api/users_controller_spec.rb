require 'rails_helper'

describe Api::UsersController do
  let(:current_user) { create(:user) }

  context 'when user is not logged in' do
    it "redirects to the new session url" do
      get :show, id: current_user.id
      expect(response).to redirect_to '/session/new'
    end
  end

  context 'when user is logged in' do
    before(:each) do
      @controller.log_in!(current_user)
    end

    describe "#show" do
      before(:each) do
        get :show, id: current_user.id
      end

      it "assigns the requested user to @user" do
        expect(assigns[:user]).to eq(current_user)
      end

      it "renders the #show partial view" do
        assert_template 'api/users/show.json.jbuilder'
      end
    end

    describe "#update" do
      context "when the user updates are valid" do
        before(:each) do
          put :update, id: current_user.id, user: { fname: "TestName" }
        end

        it 'updates the user in the database' do
          current_user.reload
          expect(current_user.fname).to eq("TestName")
        end

        it 'renders the updated user' do
          assert_template 'api/users/show.json.jbuilder'
        end
      end

      context "when the user update are invalid" do
        it 'responds with a status 422' do
          put :update, id: current_user.id, user: { fname: "" }
          expect(response.code).to eq("422")
        end
      end
    end
  end
end
