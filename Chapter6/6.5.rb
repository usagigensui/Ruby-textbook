# 6.5.1

# / /以外にも、Regexp.new(エイリアスメソッドはRegexp.compile)の引数にパターンの文字列を渡すと正規表現になる
Regexp.new('\d{3}-\d{4}')

# %記法による正規表現
%r!http://example\.com!
%r{http://example\.com}

pattern = '\d{3}-\d{4}'
# 変数が展開されるので/\d{3}-/d{4}/と書いたことと同じになる
'123-4567' =~ /#{pattern}/ #=> 0

# 6.5.2

text = '03-1234-5678'

case text
when /^\d{3}-\d{4}$/
  puts '郵便番号です'
when /^\d{4}\/\d{1,2}\/\d{2,3}$/
  puts '日付です'
when /^d+-\d+-\d+$/
  puts '電話番号です'
end
#=> 電話番号です

# 6.5.3

# iオプションを付けると大文字小文字を区別しない
'HELLO' =~ /hello/i   #=> 0
'HELLO' =~ %r{hello}i #=> 0

# Regexp.newを使う場合はRegexp::IGNORECASEという定数を渡す
regexp = Regexp.new('hello', Regexp::IGNORECASE)
'HELLO' =~ regexp #=> 0

# 6.5.4

text = '私の誕生日は1977年7月17日です。'

# =~やmatchメソッドを使うとマッチした結果が組み込み変数に代入される
text =~ /(\d+)年(\d+)月(\d+)日/

# MatchDataオブジェクトを取得する
$~ #=> #<MaychData "1977年7月17日" 1:"1997" 2:"7" 3:"17">

# マッチした部分全体を取得する
$& #=> "1977年7月17日"

# 1番目～3番目のキャプチャを取得する
$1 #=> "1977"
$2 #=> "7"
$3 #=> "17"

# 最後のキャプチャ文字列を取得する
$+ #=> "17"

# 6.5.5

text = '私の誕生日は1977年7月17日です。'

# =~演算子などを使うと、マッチした結果をRegexp.last_matchで取得する
text = /(\d+)年(\d+)月(\d+)日/

# MatchDataオブジェクトを取得する
Regexp.last_match #=> #<MatchData "1977年7月17日" 1:"1977" 2:"7" 3:"17">

# マッチした部分全体を取得する
Regexp.last_match(0) #=> "1977年7月17日"

# 1番目～3番目のキャプチャを取得する
Regexp.last_match(1) #=> "1977"
Regexp.last_match(2) #=> "7"
Regexp.last_match(3) #=> "17"

# 最後のキャプチャ文字列を取得する
Regexp.last_match(-1) #=> "17"

# 6.5.6

# マッチすればtrueを返す
\/d{3}-\d{4}/.match?('123-4567') #=> true

# マッチしても組み込み変数やRegexp.last_matchを書き換えない
# (すでにどこかで=~を使っていた場合はその時に設定された値になります)
$~                #=> nil
Regexp.last_match #=> nil

# 文字列を正規表現を入れ替えてもOK
'123-4567'.match(/\d{3}-\d{4}/) #=> true