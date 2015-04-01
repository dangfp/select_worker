class SkillsController < ApplicationController
  before_action :require_sign_in

  def index
    @skills = Skill.all
    @my_skills = current_user.skills
  end

  def update
    current_user.set_skills(selected_skills)
    redirect_to root_path
  end

  private

  def selected_skills
    reset_skills = []
    
    if params[:skills].present?
      params[:skills].each do |skill_data|
        skill = Skill.find(skill_data[:id])
        reset_skills << skill
      end
    end
    reset_skills
  end
end