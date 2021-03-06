require "lita"
require 'cgi'
require 'teamcity'

Lita.load_locales Dir[File.expand_path(
  File.join("..", "..", "locales", "*.yml"), __FILE__
)]

require "lita/handlers/teamcity"

Lita::Handlers::Teamcity.template_root File.expand_path(
  File.join("..", "..", "templates"),
 __FILE__
)
