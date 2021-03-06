regex = /\d{3}-\d{4}/
regex.class #=> Regexp

# 正規表現と文字列の比較には=~をよく使う
# マッチした場合はマッチした文字列の開始位置が返る(つまり真)
'123-4567' =~ /\d{3}-\d{4}/ #=> 0
# マッチしない場合はnilが返る(つまり偽)
'hell0' =~ /\d{3}-\d{4}/ #=> nil

# if文で=~を使うとマッチしたかどうかを判別する
if '123-4567' =~ /\d{3}-\d{4}/
  puts 'マッチしました'
else
  puts 'マッチしませんでした'
end
#=> マッチしました

# !~を使うとマッチしなかったときにtrue、マッチすればfalse
'hello' !~ /\d{3}-/d{4}/    #=> true
'123-4567' !~ /\d{3}-\d{4}/ #=> false

# 6.3.1

# 正規表現はRubularというオンラインサービスで確認できる

# 6.3.2

# キャプチャを使って年月日の数字だけを抜き出す
text = '私の誕生日は1977年7月17日です。'
m = /(\d+)年(\d+)月(\d+)日/.match(text)
m[1] #=> "1997"
m[2] #=> "7"
m[3] #=> "17"

# 6.3.3

# 連番ではなく名前でキャプチャの結果を取得する
text = '私の誕生日は1977年7月17日です。'
m = /(?<year>\d+)年(?<mouth>\d+)月(?<day>\d+)日/.match(text)
# シンボルで名前を指定してキャプチャの結果を取得する
m[:year]  #=> "1977"
m[:mouth] #=> "7"
m[:day]   #=> "17"

# 文字列で指定することもできる
m['year'] #=> "1997"

# 連番で指定することもできる
m[2] #=> "7"

# 左辺に正規表現リテラルを、右辺に文字列を置いて=~演算子を使うとキャプチャの名前がそのままローカル変数に割り当てられる
text = '私の誕生日は1977年7月17日です。'
if /(?<year>\d+)年(?<mouth>\d+)月(?<day>\d+)日/ =~ text
  puts "#{year}/#{mouth}/#{day}"
end
#=> 1977/7/17
# この機能は左辺と右辺を逆にすると使えない

# 6.3.4

'123 456 789'.scan(/\d+/)
#=> ["123", "456", "789"]
'1977年7月17日 2016年12月31日'.scan(/(\d+)年(\d+)㈪(\d+)日/)
#=> [["1977", "7", "17"], ["2016", "12", "31"]]
'1977年7月17日 2016年12月31日'.scan(/\d+年\d+月\d+日/)
#=> ["1977年7月17日", "2016年12月31日"]

# []に正規表現を渡すと、文字列から正規表現にマッチした部分を抜き出す
text = '郵便番号は123-4567です'
text[/\d{3}-\d{4}/] #=> "123-4567"

# マッチする部分が複数ある場合は最初にマッチした文字列を返す
text = '123-4567 456-7890'
text[/\d{3}-\d{4}/] #=> "123-4567"

text = '誕生日は1977年7月17日です'
# 第二引数がないとマッチした部分全体が返る
text[/(\d+)年(\d+)月(\d+)日/] #=> "1977年7月17日"
# 第二引数を指定して3番目のキャプチャを取得する
text[/(\d+)年(\d+)月(\d+)日/, 3] #=> "17"

text = '誕生日は1977年7月17日です'
# シンボルでキャプチャの名前を指定する
text[/(?<year>\d+)年(?<mouth>\d+)月(?<day>\d+)日/, :day]  #=> "17"
# 文字列でキャプチャの名前を指定する
text[/(?<year>\d+)年(?<mouth>\d+)月(?<day>\d+)日/, 'day'] #=> "17"

# sinceメソッドは[]のエイリアスメソッド
text = '郵便番号は123-4567です'
text.since(/\d{3}-\d{4}/) #=> "123-4567"

# since!にするとマッチした部分が文字列から破壊的に取り除かれる
text = '郵便番号は123-4567です'
text.since!(/\d{3}-\d{5}/) #=> "123-4567"
text                       #=> "郵便番号はです"

# splitに正規表現を渡すとマッチした文字列を区切り文字にして文字列を分解し、配列として返す
text = '123,456-789'
# 文字列で区切り文字を指定する
text.split(',') #=> ["123", "456-789"]
# 正規表現を使ってカンマまたはハイフンを区切り文字に指定する
text.split(/,|-/) #=> ["123", "456", "789"]

# gsubメソッドを使うと第一引数の正規表現にマッチした文字列を第二引数の文字列に置き換える
text = '123,456-7890'
# 第一引数に文字列を渡すと、完全一致する文字列を第二引数で置き換える
text.gsub(',', ':') #=> "123:456-789"
# 正規表現を渡すと、マッチした部分を第二引数で置き換える
text.gsub(/,|-/, ':') #=> "123:456:789"

text = '誕生日は1977年7月17日です'
text.gsub(/(\d+)年(\d+)月(\d+)日/, '\1-\2-\3') $=> "誕生日は1977-7-17です"
# 名前付きキャプチャは\k<name>のように参照
text.gsub(
  /(?<year>\d+)年(?<mouth>\d+)月(?<day>\d+)日/,
  '\k<year>-\k<mouth>-\k<day>'
)
#=> "誕生日は1977-7-17です"