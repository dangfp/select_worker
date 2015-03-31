class SearchWorkersController < ApplicationController
  before_action :require_sign_in, only: [:index, :search]
  before_action :initialize_set

  def index
  end

  def search
    if params[:skills]
      search_workers
      flash[:danger] = "Sorry,no match workers." if @match_workers.empty?
    else
      flash[:danger] = "Please select at least one skill."
    end
    render :index
  end

  private

  def initialize_set
    @skills = Skill.all
    @match_workers = []
  end

  def search_workers
    skill_ids = []
    params[:skills].each do |skill_data|
      skill_ids << skill_data[:id]
    end
    @match_workers = User.joins(:skills).where(skills: {id: skill_ids}).uniq.where.not(id: current_user.id)
  end
end