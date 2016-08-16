class Calendar < ActiveRecord::Base
    TYPE_OWNER = 1
    TYPE_JOINER = 2
    
    belongs_to :user
    belongs_to :feed
    
    validates :user ,presence: true
    validates :feed ,presence: true
    validates :exact_time ,presence: true
    validate :check_feed_type
    
    
    default_scope ->{order(exact_time: :desc)}
    
    private 
      def check_feed_type
          if self.feed.feed_type != Feed::TYPE_PROVIDER
              errors.add(:feed, "must be a provider feed as a calendar")
          end
      end
end
