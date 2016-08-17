class InSiteMessage < ActiveRecord::Base
    TYPE_REQUEST_FRIEND = 1
    TYPE_ACCEPT_FRIEND = 2
    TYPE_REJECT_FRIEND = 3
    
    TYPE_COMMON_TEXT = 4
    
    STATUS_UNREAD = 15
    STATUS_READ = 16
    
    
    belongs_to :sender ,class_name: "User"
    belongs_to :receiver, class_name: "User"
    
    validates :sender_id, presence: true
    validates :receiver_id, presence: true
    validates :msg_type,presence: true
    validate :check_message_type
    
    
    default_scope ->{order(created_at: :desc)}
    
    private 
      def check_message_type
          if self.msg_type < TYPE_COMMON_TEXT || self.sender.freind?(self.receiver)
              true
          else
              errors.add(:receiver, "must be a freind")
              false
          end
      end
        
end
