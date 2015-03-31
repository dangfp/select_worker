class SkillsController < ApplicationController
  def index
    @skills = Skill.all
    @my_skills = User.first.skills
  end

  def update
    skills = []
    
    if params[:skills]
      params[:skills].each do |skill_data|
        skill = Skill.find(skill_data[:id])
        skills << skill
      end
    end
    
    current_user = User.first
    current_user.skills = skills
    redirect_to root_path
  end
end