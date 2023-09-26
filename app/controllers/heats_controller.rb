class HeatsController < ApplicationController
		before_action :authenticate_user!
		def show
					@heat = Heat.find_by(:slug => params[:slug])
					if @heat == nil
							redirect_to root_path, flash: {alert: "Heat does not exist."}
					end
		end   
end
