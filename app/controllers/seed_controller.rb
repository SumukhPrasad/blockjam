class SeedController < ApplicationController
		respond_to :js
		protect_from_forgery unless: -> { request.format.js? }

		def preseedfile
					@heat = Heat.find_by(:slug => params[:heat_slug])
					@question = Question.find_by(:question_number => params[:question_question_number], :level => @heat.level)

					file = @question.preseed
					
					send_data file.download, filename: file.filename.to_s, type: file.content_type, disposition: 'inline'
		end

		def seedfile
					@heat = Heat.find_by(:slug => params[:heat_slug])
					@question = Question.find_by(:question_number => params[:question_question_number], :level => @heat.level)

					file = @question.seed
					
					send_data file.download, filename: file.filename.to_s, type: file.content_type, disposition: 'inline'
		end
		
		def postseedfile
					@heat = Heat.find_by(:slug => params[:heat_slug])
					@question = Question.find_by(:question_number => params[:question_question_number], :level => @heat.level)

					file = @question.postseed
					
					send_data file.download, filename: file.filename.to_s, type: file.content_type, disposition: 'inline'
		end
end
