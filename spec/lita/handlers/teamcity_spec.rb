require "spec_helper"

describe Lita::Handlers::Teamcity, lita_handler: true do
  it { is_expected.to route_command("teamcity projects").to(:projects) }

   describe "#projects" do
    it "list of active projects" do
      send_command("teamcity projects")

      expect(replies.first).to eq("boom!")
    end
  end
end
