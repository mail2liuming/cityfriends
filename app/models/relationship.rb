class Relationship < ActiveRecord::Base
    belongs_to :user , class_name: "User"
    belongs_to :positive_user, class_name: "User"
    
    validates :user_id, presence: true
    validates :positive_user_id, presence: true
    
    def allFriendsOfUser(id)
        Relationship.includes(:user,:positive_user).where("user_id=:user_id OR positive_user_id=:user_id",user_id: id)
    end
    
end
