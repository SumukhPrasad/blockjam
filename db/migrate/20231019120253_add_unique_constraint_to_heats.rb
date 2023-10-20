class AddUniqueConstraintToHeats < ActiveRecord::Migration[7.0]
	def change
		add_index :heats, [:slug], unique: true, name: 'uniq_slug_per_heat'
	end
end
