class User < ActiveRecord::Base
  has_secure_password validation: false

  validates_presence_of :email
  validates_format_of :email, with: /@/, on: :create
  validates_uniqueness_of :email

  validates_presence_of :password
  validates_length_of :password, in: 6..20

  validates_presence_of :full_name
  validates_length_of :full_name, in: 3..20

  validates_presence_of :phone
  validates_numericality_of :phone, only_integer: true
  validates_length_of :phone, is: 11

  has_and_belongs_to_many :skills
end