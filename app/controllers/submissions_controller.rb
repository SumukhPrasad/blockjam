class SubmissionsController < ApplicationController
     def save_submission
          @submission = Submission.new()

          @heat = Heat.find_by(:slug => params[:heat_slug])

          @question = Question.find_by(:question_number => params[:question_question_number], :level => @heat.level)

          @submission.heat = @heat
          @submission.question = @question 
          @submission.time = Time.now
          @submission.user = current_user
          
          @submission.save
     end
     helper_method :save_submission

end
