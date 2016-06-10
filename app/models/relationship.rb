class Relationship < ActiveRecord::Base
    belongs_to :user , class_name: "User"
    belongs_to :positive_user, class_name: "User"
    
    validates user_id, presence: true
    validates positive_user_id, presence: true
    
end
