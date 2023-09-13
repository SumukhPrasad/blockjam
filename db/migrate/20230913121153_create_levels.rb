class CreateLevels < ActiveRecord::Migration[7.0]
	def change
		create_table :levels do |t|
			t.integer :level
			t.string :name
			t.integer :duration
			t.references :contest, null: false, foreign_key: true

			t.timestamps
		end
	end
end
