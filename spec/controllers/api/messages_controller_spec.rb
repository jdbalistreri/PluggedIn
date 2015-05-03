require 'rails_helper'

describe Api::MessagesController do
  let(:current_user) { create(:user) }
  let(:other_user) { create(:user) }

  context 'when user is not logged in' do
    it "redirects to the new session url" do
      message = create(:message, sender: current_user)
      get :show, id: message.id
      expect(response).to redirect_to '/session/new'
    end
  end

  context 'when user is logged in' do
    before(:each) do
      @controller.log_in!(current_user)
    end

    let(:message) { build(:message, receiver: other_user) }

    describe "#create" do
      context "when the message is valid" do
        it "adds a new message to the database" do
          expect do
            post :create, message: { subject: message.subject, body: message.body,
                                    receiver_id: other_user.id }
          end.to change { Message.count }.from(0).to(1)
        end

        it 'renders the new message template' do
          post :create, message: { subject: message.subject, body: message.body,
                                  receiver_id: other_user.id }
          assert_template "api/shared/_message.json.jbuilder"
        end
      end

      context "when the message is invalid" do
        it 'responds with a status 422' do
          post :create, message: { subject: message.subject, body: message.body,
                                  receiver_id: nil }
          expect(response.code).to eq("422")
        end
      end
    end

    describe "#show" do
      let(:message) { create(:message, sender: other_user, receiver: current_user) }

      before(:each) do
        get :show, id: message.id
      end

      it "assigns the requested message to @message" do
        expect(assigns[:message]).to eq(message)
      end

      it "renders the #show partial view" do
        assert_template "api/shared/_message.json.jbuilder"
      end
    end
  end
end
