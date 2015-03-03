class User < ActiveRecord::Base
  belongs_to :country
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest
  before_save :birth_year_to_i
  FORBIDDEN_USERNAMES = ['shit','fuck','ass', 'piss', 'cunt', 'cock']

  has_many :questions, dependent: :nullify
  has_many :scorecards, dependent: :destroy
  has_many :answers, through: :scorecards

#  validates :birth_year, :female, presence: true
#  validates :female, presence: true, inclusion: { in: [true, false] }
  validates :birth_year, presence: true, numericality: true
  #validates :country, presence: true  #do not turn this on in case of perform_reverse_geocode returns "nil" for country
  validate :valid_birth_year #custom validate birth_year, 1910 - 2015, shorter range?
  
  attr_accessor :address
  geocoded_by :ip_address
 # after_validation :geocode, :if => lambda{ |obj| obj.ip_address_changed? }
  reverse_geocoded_by :latitude, :longitude
  after_validation :perform_reverse_geocode  # auto-fetch address

  def perform_reverse_geocode
    reverse_geocode
    # Rails.logger.info ">>>>>>>>>>> #{address}"

    if address != nil
      country = Country.find_by_name address.split(",").last.strip
      self.country = country
    else
      self.country = nil  #just in weird cases or errors, if the address/coountry cannot be found properly
    end
  end

  validates :name, presence: true, length: {minimum: 5, maximum: 30}

# warrick: I don't think we need an email if we have a name
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, length: {maximum: 255},
             # format: {with: VALID_EMAIL_REGEX},
             # uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: 5 }, allow_blank: true

  def valid_birth_year
    if (self.birth_year.to_i < 1910) || (self.birth_year.to_i > 2015)
      errors.add(:birth_year, "valid birth year must be between 1910 and 2015!")
    end
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

    # Sends password reset email.
  def send_password_reset_email
      #UserMailer.password_reset(self).deliver_now
  end

    private 

      def downcase_email
        self.email = email.downcase
      end

      def create_activation_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
      end

      def birth_year_to_i
        self.birth_year.to_i
      end

      def username_is_allowed
        if FORBIDDEN_USERNAMES.include?(username)
          errors.add(:username, "has been restricted from use.")
        end
      end
      
end