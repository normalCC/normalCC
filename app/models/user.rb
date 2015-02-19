class User < ActiveRecord::Base
  belongs_to :country

  has_many :questions, dependent: :nullify
  has_many :scorecards, dependent: :destroy
  has_many :answers, through: :scorecards

  validates :email, :birth_year, :female, :country, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  validates :female, inclusion: { in: [true, false] }

  validates :birth_year, numericality: true
  validate :valid_birth_year #validates the field for birth_year, 1910 - 2015, shorter range?

  def valid_birth_year
    if (birth_year < 1910) && (:birth_year > 2015)
      errors.add(:birth_year, "valid birth year must be between 1910 and 2015!")
    end
  end

end