require 'open3'
module JumanParser
  class Parser
    attr_reader :lines
    def initialize(text)
      @text = text

      # jumanを実行
      out, err, status = run_juman

      # 解析結果一行を要素にもつ配列
      @lines = out.split("\n")[0..-2]
    end

    private
    def run_juman
      Open3.capture3("juman -b", :stdin_data => @text)
    end
  end
end



if $0 == __FILE__
  text = "東京は日本の首都です。"
  juman = JumanParser::Parser.new(text)
  pp juman.lines
end