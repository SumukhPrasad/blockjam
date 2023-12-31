class Question < ApplicationRecord
		belongs_to :level
		delegate :contest, :to => :level, :allow_nil => false
		has_many :submissions
		has_one_attached :preseed
		validates :preseed, attached: true, content_type: { content_type: ["text/javascript", "application/x-javascript"] }

		has_one_attached :seed
		validates :seed, attached: true, content_type: { content_type: ["text/javascript", "application/x-javascript"] }

		has_one_attached :postseed
		validates :postseed, attached: true, content_type: { content_type: ["text/javascript", "application/x-javascript"] }

		validates :title, :presence => true
		validates :description, :presence => true
		validates :question_number, :presence => true
		validates :score, :presence => true

		def self.ransackable_attributes(auth_object = nil)
					["created_at", "description", "score", "question_number", "id", "level_id", "postseed", "preseed", "seed", "title", "updated_at"]
				end
end
