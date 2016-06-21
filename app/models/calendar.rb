class Calendar < ActiveRecord::Base
    TYPE_OWNER = 1
    TYPE_JOINER = 2
    
    belongs_to :user
    belongs_to :feed
    
    validates :user ,presence: true
    validates :feed ,presence: true
    
    default_scope ->{order(created_at: :desc)}
end
