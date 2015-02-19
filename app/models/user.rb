class User < ActiveRecord::Base
  belongs_to :country

  has_many :questions, dependent: :nullify
  has_many :scorecards, dependent: :destroy
  has_many :answers, through: :scorecards

  validates :email, :birth_year, :female, :country, presence: true
  validates :email, uniqueness: true, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  validates :female, inclusion: { in: [true, false] }

  validate :valid_birth_year #validates the field for birth_year, 1910 - 2015, shorter range?

  def valid_birth_years
    if (birth_year < 1910) && (birth_year > 2015)
      errors.add(:birth_year, "valid birth year must be between 1920 and 2015!")
    end
  end

end
