require 'rails_helper'

describe Api::InboxController do
  let(:current_user) { create(:user) }
  let(:other_user) { create(:user) }

  context 'when user is not logged in' do
    it "redirects to the new session url" do
      get :index
      expect(response).to redirect_to '/session/new'
    end
  end

  context 'when user is logged in' do
    before(:each) do
      @controller.log_in!(current_user)
    end

    describe "#connected_users" do
      before(:each) do
        create(:connection, sender: current_user, receiver: other_user, status: "approved")
        get :connected_users
      end

      it "assigns the current user's connected_users to @connected_users" do
        expect(assigns[:connected_users]).to eq([other_user])
      end

      it 'renders the connected users view' do
        assert_template "api/inbox/connected_users.json.jbuilder"
      end
    end

    describe "#index" do
      it "assigns a user's sent messages to @sent_messages" do
        sent_message = create(:message, sender: current_user)
        get :index
        expect(assigns[:sent_messages]).to eq([sent_message])
      end

      it "assigns a user's received messages to @received_messages" do
        received_message = create(:message, receiver: current_user)
        get :index
        expect(assigns[:received_messages]).to eq([received_message])
      end

      it "assigns a user's sent connections to @sent_connections" do
        sent_connection = create(:connection, sender: current_user)
        get :index
        expect(assigns[:sent_connections]).to eq([sent_connection])
      end

      it "assigns a user's received connections to @received_connections" do
        received_connection = create(:connection, receiver: current_user)
        get :index
        expect(assigns[:received_connections]).to eq([received_connection])
      end

      it "renders the #index view" do
        get :index
        assert_template "api/inbox/index.json.jbuilder"
      end
    end
  end
end
