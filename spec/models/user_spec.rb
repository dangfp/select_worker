require 'rails_helper'

describe User do
  it { should have_secure_password }

  it { should validate_presence_of(:email) }
  it { should allow_value('test@yahoo.cn').for(:email) }
  it { should_not allow_value('yahoo.cn').for(:email) }
  it { should validate_uniqueness_of(:email) }

  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6).is_at_most(20) }

  it { should validate_presence_of(:full_name) }
  it { should validate_length_of(:full_name).is_at_least(3).is_at_most(20) }

  it { should validate_presence_of(:phone) }
  it { should validate_length_of(:phone).is_equal_to(11) }
  it { should validate_numericality_of(:phone).only_integer }

  it { should have_and_belong_to_many(:skills) }

  describe "#set_skills" do
    it "sets skills of the user with selected skills" do
      user = Fabricate(:user)
      skill1 = Fabricate(:skill)
      skill2 = Fabricate(:skill)
      user.set_skills([skill1, skill2])
      expect(user.skills).to match_array([skill1, skill2])
    end
  end
end