class QuestionsController < ApplicationController
     def show
          @heat = Heat.find_by(:slug => params[:heat_slug])
          if @heat == nil
               redirect_to root_path, flash: {alert: "Heat does not exist."}
          end

          @question = Question.find_by(:question_number => params[:question_number], :level => @heat.level)
          if @question == nil
               redirect_to heat_path(@heat.slug), flash: {alert: "Question does not exist."}
          end
     end  
end
