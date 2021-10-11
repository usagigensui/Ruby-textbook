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

