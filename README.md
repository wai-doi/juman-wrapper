# juman-parser
形態素解析器[JUMAN](http://nlp.ist.i.kyoto-u.ac.jp/index.php?JUMAN)のparser
## 使い方

```ruby
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
```