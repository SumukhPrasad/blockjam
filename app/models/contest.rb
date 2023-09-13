class Contest < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["about", "created_at", "id", "name", "updated_at"]
  end

  has_many :levels, dependent: :destroy
end
