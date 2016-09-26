module Match
  class TablePrinter
    def self.print_summary(params)
      rows = []

      app_identifier = params[:app_identifier]
      type = params[:type].to_sym
      platform = params[:platform]

      rows << ["App Identifier", "", app_identifier]
      rows << ["Type", "", type]
      rows << ["Platform", platform]

      {
        Utils.environment_variable_name(app_identifier: app_identifier, type: type, platform: platform) => "Profile UUID",
        Utils.environment_variable_name_profile_name(app_identifier: app_identifier, type: type, platform: platform) => "Profile Name",
        Utils.environment_variable_name_team_id(app_identifier: app_identifier, type: type, platform: platform) => "Development Team ID"
      }.each do |env_key, name|
        rows << [name, env_key, ENV[env_key]]
      end

      params = {}
      params[:rows] = rows
      params[:title] = "Installed Provisioning Profile".green
      params[:headings] = ['Parameter', 'Environment Variable', 'Value']

      puts ""
      puts Terminal::Table.new(params)
      puts ""
    end
  end
end
