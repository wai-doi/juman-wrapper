require 'open3'
module JumanParser
  class Parser
    def initialize(text)
      @text = text
      out, err, status = run_juman
      puts out
    end

    private
    def run_juman
      Open3.capture3("juman -b", :stdin_data => @text)
    end
  end
end



if $0 == __FILE__
  text = "東京は日本の首都です。"
  JumanParser::Parser.new(text)
end