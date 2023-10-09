class QuestionsController < ApplicationController
		before_action :authenticate_user!

		def show
					
					ActiveStorage::Current.host = request.base_url

					

					@heat = Heat.find_by(:slug => params[:heat_slug])
					if @heat == nil
							redirect_to root_path, flash: {alert: "Heat does not exist."}
					end

					@question = Question.find_by(:question_number => params[:question_number], :level => @heat.level)
					if @question == nil
							redirect_to heat_path(@heat.slug), flash: {alert: "Question does not exist."}
					end
					@preseed = heat_question_preseedfile_path(@heat.slug, @question)+".js"
					@seed = heat_question_seedfile_path(@heat.slug, @question)+".js"
					@postseed = heat_question_postseedfile_path(@heat.slug, @question)+".js"
		end  
end


