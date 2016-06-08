class User < ActiveRecord::Base
    has_many :feeds , dependent: :destroy
    
    has_secure_password
    
    validates :name, presence: true, length: {maximum: 50},
                     uniqueness: {case_sensitive: false}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email,presence: true, length:{maximum: 255},
                     format: {with: VALID_EMAIL_REGEX},
                     uniqueness: {case_sensitive: false}
    validates :password, presence: true, length:{minimum:6},allow_nit: false
    
    attr_accessor :token
    
    before_create :create_token
    before_save   {email.downcase!}
    
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
  
    def self.new_token
        SecureRandom.urlsafe_base64
    end
    
    def remember
        self.token = User.new_token
        update_attribute(:token_digest,User.digest(token))
    end
    
    def authenticated?(token)
        return false if token_digest
        BCrypt::Password.new(token).is_password?(token_digest)
    end
    
    def forget
        update_attribute(:token_digest,nil)
    end
    
    def same?(another)
        self.id == another.id
    end
    
    private
      def create_token
         self.token = User.new_token
         self.token_digest = User.digest(token)
      end
end
