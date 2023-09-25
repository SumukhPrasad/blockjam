class Heat < ApplicationRecord
		belongs_to :level
		has_many :submissions
		delegate :contest, :to => :level, :allow_nil => false
		def self.ransackable_attributes(auth_object = nil)
			["created_at", "id", "level_id", "name", "slug", "start_time", "updated_at"]
		end

		validates :name, :presence => true
		validates :start_time, :presence => true
		validates :slug, :presence => true
end
