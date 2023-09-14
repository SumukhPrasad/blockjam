class Heat < ApplicationRecord
		belongs_to :level
		delegate :contest, :to => :level, :allow_nil => false
		def self.ransackable_attributes(auth_object = nil)
					["created_at", "id", "level_id", "name", "slug", "start_time", "updated_at"]
				end
end
