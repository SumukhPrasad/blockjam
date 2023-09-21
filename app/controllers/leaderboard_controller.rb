class LeaderboardController < ApplicationController
     before_action :authenticate_user!
     def index
          
          ActiveStorage::Current.host = request.base_url

          

          @heat = Heat.find_by(:slug => params[:heat_slug])
          if @heat == nil
               redirect_to root_path, flash: {alert: "Heat does not exist."}
          end

     end  
end
