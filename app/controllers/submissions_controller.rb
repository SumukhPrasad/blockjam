class SubmissionsController < ApplicationController
     def save_submission

          @submission = Submission.new()

          @heat = Heat.find_by(:slug => params[:heat_slug])

          @question = Question.find_by(:question_number => params[:question_question_number], :level => @heat.level)

          if Submission.find_by(heat: @heat, question: @question, user: current_user) == nil && (@heat.start_time.to_datetime + @heat.level.duration*1.minute) > Time.now.to_datetime
               @submission.heat = @heat
               @submission.question = @question 
               @submission.time = Time.now
               @submission.user = current_user
               
               @submission.save
          end
          
     end
     helper_method :save_submission

end
