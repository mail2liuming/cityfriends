class User < ActiveRecord::Base
    has_many :feeds , dependent: :destroy
    
    has_many :active_relationship, class_name: "Relationship",
                                 foreign_key: "user_id",
                                 dependent: :destroy
                                 
    has_many :active_freinds, through: :active_relationship, source: :positive_user
    
    has_many :positive_relationship, class_name: "Relationship",
                                     foreign_key: "positive_user_id",
                                     dependent: :destroy
                                     
    has_many :positive_freinds, through: :positive_relationship, source: :user
    
    has_many :sending_messages, class_name: "InSiteMessage",
                                foreign_key: "sender_id",
                                dependent: :destroy
    has_many :receiving_messages, class_name: "InSiteMessage",
                                  foreign_key: "receiver_id",
                                  dependent: :destroy
    has_many :calendars, dependent: :destroy
                                  
    
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
    
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
  
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    def login
        self.token = User.new_token
        update_attribute(:token_digest,User.digest(token))
    end
    
    def authenticated?(token)
        return false if token_digest == nil
        BCrypt::Password.new(token_digest).is_password?(token)
    end
    
    def logout
        update_attribute(:token_digest,nil)
    end
    
    def same?(another)
        self.id == another.id
    end
    
    def freinds
        active_freinds + positive_freinds
    end
    
    def freind?(other_user)
        active_freinds.exists?(other_user.id) || positive_freinds.exists?(other_user.id)
    end
    
    def add_freind(other_user)
        if !freind?(other_user)
            active_relationship.create(positive_user_id: other_user.id)
        end
    end
    
    def delete_freind(other_user)
        if freind?(other_user)
            rel = active_relationship.find_by(positive_user_id: other_user.id)
            if rel
                return rel.destroy
            end
            rel = positive_relationship.find_by(user_id: other_user.id)
            if rel
                return rel.destroy
            end
        end 
        return false;
    end
    
    private
      def create_token
         self.token = User.new_token
         self.token_digest = User.digest(token)
      end
end
