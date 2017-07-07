require 'teamcity'

module Lita
  module Handlers
    class Teamcity < Handler
      namespace "teamcity"

      config :endpoint, type: String, default: 'http://localhost:8111/httpAuth/app/rest'
      config :user, type: String
      config :password, type: String

      route(/^teamcity\s+projects(\s+(.+))?/, :projects, command: true, help: { "teamcity projects TEXT" => "Echoes back TEXT." })
      
      def projects(response)
        message = {
          text: render_template("projects", projects: client.projects)
        }
        Lita.logger.debug(message[:text])
        attachment = Lita::Adapters::Slack::Attachment.new(message[:text], {"color": "#36a64f", "pretext": "Projects"})
        case robot.config.robot.adapter
        when :slack
          robot.chat_service.send_attachment(response.room, attachment)
        else
          response.reply(message[:text])
        end
      end

      def builds(response)
        builds = client.builds
        builds.each do |build|
          response.reply(build)
        end
      end

      private
      def client
        @_client ||= ::TeamCity::Client.new(endpoint: config.endpoint, http_user: config.user, http_password: config.password)
      end

      Lita.register_handler(self)
    end
  end
end
