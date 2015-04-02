class SkillsController < ApplicationController
  before_action :require_sign_in

  def index
    @skills = Skill.all
    @my_skills = current_user.skills
  end

  def update
    current_user.skill_ids = params[:skill_ids]
    redirect_to root_path
  end
end