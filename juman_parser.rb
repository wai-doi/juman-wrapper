require 'open3'
module JumanParser
  class Parser
    attr_reader :lines, :morphemes, :surfaces
    def initialize(text)
      @text = text

      # jumanを実行
      out, err, status = run_juman

      # 解析結果一行を要素にもつ配列
      @lines = out.split("\n")[0..-2]

      # 形態素オブジェクトを要素にもつ配列
      @morphemes = @lines.map{ |line| Morpheme.new(line) }
      @surfaces = @morphemes.map(&:surface)
    end

    private
    def run_juman
      Open3.capture3("juman -b", :stdin_data => @text)
    end
  end


  class Morpheme
    # 解析結果一行から形態素の情報を取得
    # 表層形 読み 見出し語 品詞大分類 品詞大分類ID 品詞細分類 品詞細分類ID 活用型 活用型ID 活用形 活用形ID 意味情報

    attr_reader :surface, :yomi, :midasi, :pos, :detail_pos
    def initialize(line)
      data = line.split
      @surface = data[0]
      @yomi = data[1]
      @midasi = data[2]
      @pos = data[3]
      @detail_pos = data[5]
    end
  end
end



if $0 == __FILE__
  text = "東京は日本の首都です。"
  juman = JumanParser::Parser.new(text)
  pp juman.surfaces
  pp juman.morphemes.map(&:pos)
end