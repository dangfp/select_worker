require 'rails_helper'

describe SearchWorkersController do
  let!(:worker1) { Fabricate(:user) }
  let!(:worker2) { Fabricate(:user) }
  let!(:skill1) { Fabricate(:skill) }
  let!(:skill2) { Fabricate(:skill) }

  before do
    worker1.skills = [skill1, skill2]
    worker2.skills = [skill1]
  end

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

      it "assigns the empty array to the @match_workers" do
        get :index
        expect(assigns(:match_workers)).to eq([])
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "POST #search" do
    context "for the unauthenticated user" do
      it_behaves_like "require_signed_in" do
        let(:action) { post :search, skills: [{id: skill1.id}] }
      end
    end

    context "for the authenticated user" do
      before { sign_in }

      context "mahch workers" do
        it "populates an array of workers match search condition" do
          post :search, skills: [{id: skill1.id}]
          expect(assigns(:match_workers)).to match_array([worker1, worker2])
        end

        it "don't include the customer self when customer have the skills be searched" do
          current_user.skills = [skill1]
          post :search, skills: [{id: skill1.id}]
          expect(assigns(:match_workers)).to match_array([worker1, worker2])
        end

        it "renders the :index template" do
          post :search, skills: [{id: skill1.id}]
          expect(response).to render_template :index
        end
      end

      context "no match workers" do
        it "sets the error message when the customer don't select skill" do
          post :search
          expect(flash[:danger]).not_to be_nil
        end

        it "sets the error message when no match workers" do
          skill3 = Fabricate(:skill)
          post :search, skills: [{id: skill3}]
          expect(flash[:danger]).not_to be_nil
        end
      end
    end
  end
end