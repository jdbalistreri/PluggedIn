require 'rails_helper'

describe Api::ExperiencesController do
  let(:current_user) { create(:user) }

  context 'when user is not logged in' do
    it "redirects to the new session url" do
      experience = create(:experience, user: current_user)
      get :show, id: experience.id
      expect(response).to redirect_to '/session/new'
    end
  end

  context 'when user is logged in' do
    before(:each) do
      @controller.log_in!(current_user)
    end

    describe "#create" do
      context "when the experience is valid" do
        it "adds a new experience to the database" do
          expect do
            post :create, experience: attributes_for(:experience)
          end.to change { Experience.count }.from(0).to(1)
        end

        it 'renders the new connection template' do
          post :create, experience: attributes_for(:experience)
          assert_template "api/shared/_experience.json.jbuilder"
        end
      end

      context "when the experience is invalid" do
        it 'responds with a status 422' do
          post :create, experience: { role: "test" }
          expect(response.code).to eq("422")
        end
      end
    end

    describe "#destroy" do
      it "deletes the experience" do
        experience = create(:experience, user: current_user)
        expect do
          delete :destroy, id: experience.id
        end.to change { Experience.count }.from(1).to(0)
      end
    end

    describe "#show" do
      let(:experience) { create(:experience, user: current_user) }

      before(:each) do
        get :show, id: experience.id
      end

      it "assigns the requested experience to @experience" do
        expect(assigns[:experience]).to eq(experience)
      end

      it "renders the #show partial view" do
        assert_template "api/shared/_experience.json.jbuilder"
      end
    end

    describe "#update" do
      let(:experience) { create(:experience, user: current_user) }

      context "when the experience is valid" do
        before(:each) do
          put :update, id: experience.id, experience: { role: "Test Role" }
        end

        it 'updates the experience to the database' do
          experience.reload
          expect(experience.role).to eq("Test Role")
        end

        it 'renders the updated experience as JSON' do
          assert_template "api/shared/_experience.json.jbuilder"
        end
      end

      context "when the experience is invalid" do
        it 'responds with a status 422' do
          put :update, id: experience.id, experience: { role: "" }
          expect(response.code).to eq("422")
        end
      end
    end
  end
end
