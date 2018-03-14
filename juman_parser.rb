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
  text = "私はコンビニでお弁当を買った。"
  juman = JumanParser::Parser.new(text)

  # 表層形の配列
  p juman.surfaces
  # => ["私", "は", "コンビニ", "で", "お", "弁当", "を", "買った", "。"]

  # 形態素オブジェクト
  p juman.morphemes.first
  # => #<JumanParser::Morpheme:0x00007fd56388e5b0 @surface="私", @yomi="わたし", @midasi="私", @pos="名詞", @detail_pos="普通名詞">

  # 品詞の配列
  p juman.morphemes.map(&:pos)
  # => ["名詞", "助詞", "名詞", "助詞", "接頭辞", "名詞", "助詞", "動詞", "特殊"]
end