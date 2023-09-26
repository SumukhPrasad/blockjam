class CreateSubmissions < ActiveRecord::Migration[7.0]
	def change
		create_table :submissions do |t|
			t.datetime :time

			t.references :heat, null: false, foreign_key: true

			t.references :question, null: false, foreign_key: true

			t.references :user, null: false, foreign_key: true

			t.timestamps
		end
	end
end
