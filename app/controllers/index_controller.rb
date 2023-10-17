class IndexController < ApplicationController
		def index
					if params[:slug] != nil
							@heat = Heat.find_by(:slug => params[:slug])
							if @heat == nil
								redirect_to root_path, flash: {alert: "Heat does not exist."}
							else
										redirect_to heat_path(@heat.slug)
							end
					end
		end
end
