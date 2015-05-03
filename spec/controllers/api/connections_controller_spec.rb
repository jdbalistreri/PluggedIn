require 'rails_helper'

describe Api::ConnectionsController do
  let(:current_user) { create(:user) }
  let(:other_user) { create(:user) }

  context 'when user is not logged in' do
    it "redirects to the new session url" do
      post :create, connection: { receiver_id: other_user.id }
      expect(response).to redirect_to '/session/new'
    end
  end

  context 'when user is logged in' do
    before(:each) do
      @controller.log_in!(current_user)
    end

    describe "#create" do
      context "when the connection is valid" do
        it "adds a new connection to the database" do
          expect do
            post :create, connection: { receiver_id: other_user.id }
          end.to change { Connection.count }.from(0).to(1)
        end

        it 'renders the new connection template' do
          post :create, connection: { receiver_id: other_user.id }
          assert_template "api/shared/_connection.json.jbuilder"
        end
      end

      context "when the connection is invalid" do
        it 'responds with a status 422' do
          post :create, connection: { receiver_id: current_user.id }
          expect(response.code).to eq("422")
        end
      end
    end

    describe "#update" do
      context "when the connection is valid" do
        it 'updates the connection to the database'
        it 'renders the updated connection as JSON'
      end

      context "when the connection is invalid" do
        it 'responds with a status 422'
      end
    end
  end
end
