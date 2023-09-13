ActiveAdmin.register Level do
	# See permitted parameters documentation:
	# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
	#
	# Uncomment all parameters which should be permitted for assignment
	#
	# permit_params :level, :name, :duration, :contest_id
	#
	# or
	#
	# permit_params do
	#   permitted = [:level, :name, :duration, :contest_id]
	#   permitted << :other if params[:action] == 'create' && current_user.admin?
	#   permitted
	# end

	permit_params :level, :name, :duration, :contest_id

	index do
		selectable_column
		id_column
		column :level
		column :contest_id
		column "Contest" do |level|
			link_to(Contest.find_by!(:id => level.contest_id).name, admin_contest_path(level.contest_id))
		end
		column :name
		column :duration
		actions
	end

	filter :level
	filter :contest_id
	filter :name
	filter :duration

	form do |f|
		f.inputs do
			f.input :contest_id, :as => :select, :collection => Contest.all.map { |u| [u.name.to_s, u.id] }
			f.input :level
			f.input :name
			f.input :duration, label: "Duration in minutes"
		end
		f.actions
	end
end
