require 'rails_helper'

describe SkillsController do
  let!(:skill1) { Fabricate(:skill) }
  let!(:skill2) { Fabricate(:skill) }

  describe "GET #index" do
    context "for the unauthenticated user" do
      it_behaves_like "require_signed_in" do
        let(:action) { get :index }
      end
    end

    context "for the authenticated user" do
      before { sign_in }

      it "assigns the requested skills to the @skills" do
        get :index
        expect(assigns(:skills)).to match_array([skill1, skill2])
      end

      it "assigns the requested my_skills to the @my_skills" do
        current_user.skills << skill1
        get :index
        expect(assigns(:my_skills)).to eq([skill1])
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "POST #update" do
    context "for the unauthenticated user" do
      it_behaves_like "require_signed_in" do
        let(:action) { post :update, skills: [{id: skill1.id}] }
      end
    end

    context "for the authenticated user" do
      before { sign_in }

      it "sets one skill for the user in the database" do
        post :update, skills: [{id: skill1.id}]
        expect(current_user.skills).to eq([skill1])
      end

      it "sets two skills for the user in the database" do
        post :update, skills: [{id: skill1.id}, {id: skill2.id}]
        expect(current_user.skills).to match_array([skill1, skill2])
      end

      it "sets 0 skill for the user in the database" do
        post :update
        expect(current_user.skills).to eq([])
      end

      it "redirects to the root path" do
        post :update, skills: [{id: skill1.id}]
        expect(response).to redirect_to root_path
      end
    end
  end
end