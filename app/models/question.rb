class Question < ApplicationRecord
     belongs_to :level

     has_one_attached :preseed
     validates :preseed, attached: true, content_type: { content_type: ["text/javascript", "application/x-javascript"] }

     has_one_attached :seed
     validates :seed, attached: true, content_type: { content_type: ["text/javascript", "application/x-javascript"] }

     has_one_attached :postseed
     validates :postseed, attached: true, content_type: { content_type: ["text/javascript", "application/x-javascript"] }

     def self.ransackable_attributes(auth_object = nil)
          ["created_at", "description", "id", "level_id", "postseed", "preseed", "seed", "title", "updated_at"]
        end
end
