require 'rails_helper'

describe SessionsController do
  describe "GET #new" do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    let!(:valid_user) { Fabricate(:user) }

    context "with the valid credentials" do
      it "puts the signed in user in the session" do
        post :create, email: valid_user.email, password: valid_user.password
        expect(session[:user_id]).to eq(valid_user.id)
      end

      it "redirects to the home page" do
        post :create, email: valid_user.email, password: valid_user.password
        expect(response).to redirect_to(home_path)
      end
    end

    context "with the invalid credentials" do
      before { post :create, email: valid_user.email, password: valid_user.password + "123" }

      it "doesn't put the sign in user in the session" do
        expect(session[:user_id]).to be_nil
      end

      it "re-renders the :new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #destroy" do
    before { session[:user_id] = Fabricate(:user).id }

    it "clears the session for the user" do
      get :destroy
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the sign in page" do
      get :destroy
      expect(response).to redirect_to(sign_in_path)
    end
  end
end