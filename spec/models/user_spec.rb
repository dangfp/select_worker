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
end