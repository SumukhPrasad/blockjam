class AddFilesToQuestion < ActiveRecord::Migration[7.0]
	def change
		add_column :questions, :preseed, :binary, :limit => 10.megabyte
		add_column :questions, :seed, :binary, :limit => 10.megabyte
		add_column :questions, :postseed, :binary, :limit => 10.megabyte

	end
end
