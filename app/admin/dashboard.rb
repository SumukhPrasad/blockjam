# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
	menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

	content title: proc { I18n.t("active_admin.dashboard") } do
		# columns do
		# 	column do
		# 		panel "Timezone Information" do
		# 			para "The current server time is #{Time.now.strftime('%a %d %b %H:%M:%S %p %z')}. If this does not match your current timezone, edit <span style=\"font-family:monospace;\">config/application.rb</span>.".html_safe
		# 		end
		# 	end
		# end

		div class: "blank_slate_container", id: "dashboard_default_message" do
			span class: "blank_slate" do
				span "Welcome to BlockJam Admin."
				small I18n.t("active_admin.dashboard_welcome.call_to_action")
			end
		end
	end 
end
