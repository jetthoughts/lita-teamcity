module Lita
  module Handlers
    class Teamcity < Handler
      namespace "teamcity"

      config :endpoint, type: String, default: 'http://localhost:8111/httpAuth/app/rest'
      config :user, type: String
      config :password, type: String

      route(/^teamcity\s+projects(\s+(.+))?/, :projects, command: true, help: { "teamcity projects [KEY]" => "List of TeamCity projects." })
      route(/^teamcity\s+builds(\s+(.+))?/, :builds, command: true, help: { "teamcity builds [KEY]" => "List of TeamCity builds." })
      route(/^teamcity\s+build\s+(.+)/, :build, command: true, help: { "teamcity build <buildtype_id>" => "Trigger a build for buildtype_id." })
      
      def projects(response)
        message = {
          title: 'Projects',
          text: render_template('projects', projects: client.projects),
        }
        
        reply(response, message)
      end

      def builds(response)
        records = client.builds
        Lita.logger.debug(records)
        message = {
          title: 'Builds',
          text: render_template('builds', builds: records),
        }
        reply(response, message)
      end

      def build(response)
        Lita.logger.debug(response.matches)
        Lita.logger.debug(response.args)
        Lita.logger.debug(response.room.metadata)
        options = {
          comment: {text: "Triggered by #{response.user.name} in room #{response.room.name} via chatbot"},
        }
        options[:branchName] = response.args[2] if response.args[2]

        result = client.create_buildqueue(response.args[1], options)
        Lita.logger.debug(result)

        message = {
          title: 'Done!',
          text: render_template('build', build: result),
        }
        reply(response, message)
      end

      private
      def client
        @_client ||= ::TeamCity::Client.new(endpoint: config.endpoint, http_user: config.user, http_password: config.password)
      end

      def reply(response, message)
        Lita.logger.info(message[:text])
        case robot.config.robot.adapter
        when :slack
          _message = {
            mrkdwn: true,
            color: '#36a64f',
          }.merge(message)
          attachment = Lita::Adapters::Slack::Attachment.new(message[:text], _message)
          robot.chat_service.send_attachment(response.room, attachment)
        else
          response.reply(message[:title], message[:text])
        end
      end

      Lita.register_handler(self)
    end
  end
end
