namespace :db do
  desc "Fill database with skill data"

  task skill_data: :environment do
    skills = [
      { name: 'cook' },
      { name: 'fix computer' },
      { name: 'wash' },
      { name: 'cleaning the house' },
      { name: 'repair of household appliances' },
      { name: 'weed' },
      { name: 'shop' },
      { name: 'cleaning the pool' },
      { name: 'driving' },
      { name: 'translation' },
      { name: 'care for the elderly' },
      { name: 'gardening' },
      { name: 'estate agent' },
      { name: 'taxi driver' }
    ]

    skills.each do |attributes|
      Skill.find_or_initialize_by(name: attributes[:name]).tap do |skill|
        skill.save!
      end
    end
  end
end