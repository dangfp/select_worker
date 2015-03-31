class SkillsController < ApplicationController
  before_action :require_sign_in

  def index
    @skills = Skill.all
    @my_skills = current_user.skills
  end

  def update
    current_user.skills = selected_skills
    redirect_to root_path
  end

  private

  def selected_skills
    skills = []
    
    if params[:skills]
      params[:skills].each do |skill_data|
        skill = Skill.find(skill_data[:id])
        skills << skill
      end
    end
    skills
  end
end