class Contest < ApplicationRecord
	def self.ransackable_attributes(auth_object = nil)
		["about", "created_at", "id", "name", "updated_at"]
	end

	validates :name, :presence => true
	validates :about, :presence => true

	has_many :levels, dependent: :destroy
	has_many :questions, through: :levels, dependent: :destroy
	has_many :submissions, through: :heats, dependent: :destroy
	has_many :heats, through: :levels, dependent: :destroy
end
