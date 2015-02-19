class User < ActiveRecord::Base
  belongs_to :country

  has_many :questions, dependent: :nullify
  has_many :scorecards, dependent: :destroy
  has_many :answers, through: :scorecards

  validates :email, :birth_year, :female, :country, presence: true
  validates :email, uniqueness: true
  validates :female, inclusion: { in: [true, false] }

end
