module Lita
  module Handlers
    class Teamcity < Handler
      namespace "teamcity"

      config :endpoint, type: String, default: 'http://localhost:8111/httpAuth/app/rest'
      config :user, type: String
      config :password, type: String

      route(/^echo\s+(.+)/, :echo, help: { "echo TEXT" => "Echoes back TEXT." })
      
      def echo(response)
        builds = client.builds
        builds.each do |build|
          response.reply(build)
        end
      end

      def client
        @_client ||= TeamCity::Client.new(endpoint: config.endpoint, http_user: config.user, http_password: config.password)
      end

      Lita.register_handler(self)
    end
  end
end
