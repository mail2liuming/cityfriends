class Feed < ActiveRecord::Base
    TYPE_PROVIDER = 1
    TYPE_COMSUMER = 2
    
    STATUS_ONGONIG = 1
    STATUS_DONE   =2
    
    before_create :init_feed
    
    
    belongs_to :user
    default_scope ->{order(created_at: :desc)}
    
    validates :user, presence: true
    validates :feed_type, presence: true
    
    private
      def init_feed
         self.status=STATUS_ONGONIG
         self.up=0
      end

end
