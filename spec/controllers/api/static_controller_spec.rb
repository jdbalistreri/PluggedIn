require 'rails_helper'

describe Api::StaticController do
  let(:current_user) { create(:user, fname: "InDatabase") }

  context 'when user is not logged in' do
    it "redirects to the new session url" do
      get :search
      expect(response).to redirect_to '/session/new'
    end
  end

  context 'when user is logged in' do
    before(:each) do
      @controller.log_in!(current_user)
    end

    describe "#search" do
      context "when the query string is found" do
        before(:each) do
          get :search, query: "InDatabase"
        end

        it 'assigns @found to true' do
          expect(assigns[:found]).to be(true)
        end

        it 'assigns found users to @result_users' do
          expect(assigns[:result_users]).to eq([current_user])
        end

        it 'assigns @total_count to match the number of found users' do
          expect(assigns[:total_count]).to be(1)
        end

        it 'renders the search template' do
          assert_template "api/static/search.json.jbuilder"
        end
      end

      context 'when the query string is not found' do
        before(:each) do
          get :search, query: "NotInDatabase"
        end

        it 'assigns @found to false' do
          expect(assigns[:found]).to be(false)
        end

        it 'renders the search template' do
          assert_template "api/static/search.json.jbuilder"
        end
      end
    end

    describe "#connections_search" do
      let(:other_user) { create(:user) }

      before(:each) do
        create(:connection, sender: other_user, receiver: current_user, status: "approved")
        get :connections_search, user_id: current_user.id
      end

      it "assigns a user's connected_users to @connected_users" do
        expect(assigns[:connected_users]).to eq([other_user])
      end

      it 'renders the connection_search template' do
        assert_template "api/static/connections_search.json.jbuilder"
      end
    end
  end
end
