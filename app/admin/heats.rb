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


	show do
		all_submissions = Submission.where(:heat => heat)
		@aggr_obj=controller.aggregate_all_scores(all_submissions)
		@aggr = []
		@aggr_obj.each { |(key, value)|
			@aggr.append( {name: key, score: value[:score], timescore: value[:timescore]} )
		}
		

		tabs do
			tab :about do
				default_main_content
			end
			
			tab :leaderboard do
				h1 "Leaderboard"
				table_for (@aggr.sort_by { |score| [-score[:score], -score[:timescore]] }) do
					column "Name",		:name
					column "Score",	:score
					column "Time score",:timescore
				end
			end

			tab :countdown do
				h1 "Countdown"
				
			end
		end

	end

	
	
	controller do
		def aggregate_all_scores submissions
			scores = {}
			submissions.each { |submission|
				if scores[submission.user.username] == nil
					scores[submission.user.username] = {
						score: submission.question.score,
						timescore: (((submission.heat.start_time.to_datetime + submission.level.duration*1.minute) - submission.time.to_datetime)  * 24 * 60 * 60).to_i
					}
				else
					scores[submission.user.username][:score] += submission.question.score
					scores[submission.user.username][:timescore] += submission.heat.start_time + submission.level.duration*1.minute - submission.time
				end
			}
			return scores
		end
	end
end
