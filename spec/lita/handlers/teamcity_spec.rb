require "spec_helper"

describe Lita::Handlers::Teamcity, lita_handler: true do
  it { is_expected.to route("projects").to(:some_callback) }
end
