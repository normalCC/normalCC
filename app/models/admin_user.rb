class AdminUser < ActiveRecord::Base

  has_and_belongs_to_many
  has_many 
  has_many 

  FORBIDDEN_USERNAMES = ['littlebopeep','humptydumpty','marymary']

  #validates :first_name, :presence => true,
  #                       :length => { :maximum => 25 }
  #validates :last_name, :presence => true,
  #                      :length => { :maximum => 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
             format: {with: VALID_EMAIL_REGEX},
             uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: 5 }, allow_blank: true
  
  scope :sorted, lambda { order("last_name ASC, first_name ASC") }

  def name
    "#{first_name} #{last_name}"
    # Or: first_name + ' ' + last_name
    # Or: [first_name, last_name].join(' ')
  end

  private

  def username_is_allowed
    if FORBIDDEN_USERNAMES.include?(username)
      errors.add(:username, "has been restricted from use.")
    end
  end

end
