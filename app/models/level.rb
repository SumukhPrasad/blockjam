class Level < ApplicationRecord
	belongs_to :contest
	has_many :questions
	has_many :heats

	def self.ransackable_attributes(auth_object = nil)
		["contest_id", "created_at", "duration", "id", "level", "name", "updated_at"]
	end
end
