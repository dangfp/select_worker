class SearchWorkersController < ApplicationController
  before_action :require_sign_in, only: [:index, :search]
  before_action :initialize_set

  def index; end

  def search
    if params[:skill]
      @match_workers = search_workers.page(params[:page])
      flash.now[:danger] = "Sorry,no match workers." if @match_workers.empty?
    else
      flash.now[:danger] = "Please select one skill at least."
    end
    render :index
  end

  private

  def initialize_set
    @skills = Skill.all
    @match_workers = []
  end

  def search_workers
    User.joins(:skills).where(skills: {id: params[:skill][:id]}).uniq.where.not(id: current_user.id)
  end
end