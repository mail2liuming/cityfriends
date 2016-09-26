class Feed < ActiveRecord::Base
    TYPE_STANDARD = 1
    
    
    STATUS_ONGONIG = 1
    STATUS_DONE   =2
    
    before_create :init_feed
    
    
    belongs_to :user
    default_scope ->{order(created_at: :desc)}
    
    validates :user, presence: true
    
    private
      def init_feed
         self.status=STATUS_ONGONIG
         self.feed_type = TYPE_STANDARD
         self.up=0
      end

end
