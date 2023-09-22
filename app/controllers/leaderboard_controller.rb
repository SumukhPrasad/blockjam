class LeaderboardController < ApplicationController
     before_action :authenticate_user!
     def index          
          ActiveStorage::Current.host = request.base_url

          @heat = Heat.find_by(:slug => params[:heat_slug])
          if @heat == nil
               redirect_to root_path, flash: {alert: "Heat does not exist."}
          end

          all_submissions = Submission.where(:heat => @heat)

          @aggr_obj=aggregate_all_scores(all_submissions)

          @aggr = []

          @aggr_obj.each { |(key, value)|
               @aggr.append( {name: key, score: value[:score], timescore: value[:timescore]} )
          }
          
     end  

     private
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
