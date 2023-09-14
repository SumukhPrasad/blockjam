ActiveAdmin.register Heat do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :start_time, :slug, :level_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :start_time, :slug, :level_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

	permit_params :name, :start_time, :slug, :level_id
  
	index do
		selectable_column
		id_column
		column :name
		column "Start time" do |heat|
			heat.start_time.strftime('%a %d %b %H:%M:%S %p %z')
		end
		column :slug
		column "Level" do |heat|
			link_to(Level.find_by!(:id => heat.level_id).name, admin_level_path(heat.level_id))
		end
		actions
	end

	

	filter :name
	filter :start_time
	filter :slug
	filter :level_id

	form do |f|
		f.inputs do
			f.input :name
			f.input :start_time, as: :datetime_picker
			f.input :slug
			f.input :level_id, :as => :select, :collection => Level.all.map { |u| ["#{u.contest.name.to_s} >> #{u.name.to_s}", u.id] }
		end
		f.actions
	end

end
