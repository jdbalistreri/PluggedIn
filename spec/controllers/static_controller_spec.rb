require 'rails_helper'

describe StaticController do
  describe "#root" do
    it 'renders the root page for a logged in user' do
      allow(@controller).to receive(:require_logged_in).and_return(true)
      get :root
      assert_template :root
    end

    it 'redirects to the new session page if a user is not logged in' do
      get :root
      expect(response).to redirect_to '/session/new'
    end
  end
end
