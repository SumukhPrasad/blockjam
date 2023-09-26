class Submission < ApplicationRecord
		belongs_to :question
		belongs_to :heat
		belongs_to :user
		delegate :level, :to => :heat, :allow_nil => false
		delegate :contest, :to => :heat, :allow_nil => false
end
