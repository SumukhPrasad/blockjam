	ActiveAdmin.register Question do

	# See permitted parameters documentation:
	# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
	#
	# Uncomment all parameters which should be permitted for assignment
	#
	# permit_params :title, :level_id, :preseed, :seed, :postseed
	#
	# or
	#
	# permit_params do
	#   permitted = [:title, :level_id, :preseed, :seed, :postseed]
	#   permitted << :other if params[:action] == 'create' && current_user.admin?
	#   permitted
	# end


		permit_params :title, :description, :level_id, :preseed, :seed, :postseed

		index do
			selectable_column
			id_column
			column "Level" do |question|
				link_to(Level.find_by!(:id => question.level_id).name, admin_level_path(question.level_id))
			end
			column :title
			column :description
			actions
		end

		show do
				ActiveStorage::Current.host = request.base_url
			attributes_table do
			  	row :title
				row :description
			  	row "Level" do |question|
					link_to(Level.find_by!(:id => question.level_id).name, admin_level_path(question.level_id))
				end

				row "Preseed File" do |question|
					link_to(question.preseed.filename.to_s, question.preseed.url, target: "_blank" )
				end

				row "Seed File" do |question|
					link_to(question.seed.filename.to_s, question.seed.url, target: "_blank" )
				end

				row "Postseed File" do |question|
					link_to(question.postseed.filename.to_s, question.postseed.url, target: "_blank" )
				end

				row :created_at
				row :updated_at
			end
			active_admin_comments
		   end

		filter :title
		filter :description
	filter :preseed
	filter :seed
	filter :postseed
		filter :level_id

		form do |f|
			f.inputs do
				f.input :level_id, :as => :select, :collection => Level.all.map { |u| ["#{u.contest.name.to_s} >> #{u.name.to_s}", u.id] }
				f.input :title
		f.input :description
		f.input :preseed, as: :file
		f.input :seed, as: :file
		f.input :postseed, as: :file
			end
			f.actions
		end

	end
