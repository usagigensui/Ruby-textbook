# 2.3.1

# ダブルクオートで囲むと\nが改行文字として機能する
puts "こんにちは\nさようなら"
#=> こんにちは
#   さようなら

# シングルクオートで囲むと\nはただの文字列になる
puts 'こんにちは\nさようなら'
#=> こんにちは\nさようなら

# "#{}"で式展開が行える
name = 'Alice'
puts "Hello, #{name}!" #=> Hello, Alice!
# シングルクオートだと式展開されない
puts 'Hello, #{name}!' #=> Hello, #{name}!

# 式展開の中で変数や式を書き込むと結果が文字列に埋め込まれる
i = 10
puts "#{i}は16進数にすると#{i.to_s(16)}です" #=> 10は16進数にするとaです

# 式展開を使わずに+演算子で文字列の連結を行うこともできる
name = 'Alice'
puts 'Hello, ' + name + '!' #=> Hello, Alice!

# ダブルクオートを使う文字列で改行文字や式展開を打ち消すにはバックスラッシュを付ける
puts "こんにちは\\nさようなら" #=> こんにちは\nさようなら

name = 'Alice'
puts "Hello, \#{name}!" #=> Hello, #{name}!
# シングルクオート文字列にダブルクオート文字列を含めたい場合
puts 'He said, "Don\'t speak."' #=> He said, "Don't speak."
# ダブルクオート文字列にシングルクオート文字列を含めたい場合
puts "He said, \"Don't speak.\"" #=> He said, "Don't speak."

# 2.3.2

# 文字列が同じか調べる場合は==を、異なるか調べる場合は!=を使う
'ruby' == 'ruby' #=> true
'ruby' == 'Ruby' #=> false
'ruby' != 'perl' #=> true
'ruby' == 'ruby' #=> false

# <、<=、>、>=を使って大小関係を比較する(文字コードが比較基準になる)
'a' < 'b' #=> true
'a' < 'A' #=> false
'a' < 'A' #=> true
'あいうえお' < 'かきくけこ' #=> true