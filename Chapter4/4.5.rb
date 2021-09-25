# 範囲オブジェクトは..もしくは...で作成する
1..5
1...5
'a'..'e'
'a'...'e'

# 範囲オブジェクトはRangeクラスのオブジェクト
# 範囲を示す..や...は優先度が低いため、直接メソッドを呼び出す場合は、オブジェクトを()で囲む必要がある
(1..5).class #=> Range
(1...5).class #=> Range

# ..と...の違いは最後の値を範囲に含めるか含めないか
# ..を使うと5が範囲に含まれる(1異常5以下)
range = 1..5
range.include?(0) #=> false
range.include?(1) #=> true
range.include?(4.9) #=> true
range.include?(5) #=> true
range.include?(6) #=> false
# ...を使うと5が範囲に含まれない
range = 1...5
range.include?(0) #=> false
range.include?(1) #=> true
range.include?(4.9) #=> true
range.include?(5) #=> false
range.include?(6) #=> false

# 4.5.1

# 配列に対して添え字の代わりに範囲オブジェクトを渡すと、指定した範囲の要素を抜き出す
a = [1, 2, 3, 4, 5]
# 2番目から4番目までの要素を取得する
a[1..3] #=> [2, 3, 4]

a = 'abcdef'
# 2文字目から4文字目までを抜き出す
a[1..3] #=> "bcd"

# 4.5.2

# n以下m以上、n以上m未満の判定をする場合は、<や>=の記号より範囲オブジェクトのほうがシンプルな記述になる
def liquid?(temperature)
  # 0度以上100度未満であれば液体と判定したい
  (0...100).include?(temperature)
end
liquid?(-1) #=> false
liquid?(0) #=> true
liquid?(99) #=> true
liquid?(100) #=> false

# 4.5.3

# 範囲オブジェクトはcase文と組み合わせることができる
def change(age)
  case age
  # 0歳から5歳までの場合
  when 0..5
    0
  # 6歳から12歳までの場合
  when 6..12
    300
  # 13歳から18歳までの場合
  when 13..18
    600
  # それ以外
  else
    1000
  end
end
change(3)  #=> 0
change(12) #=> 300
change(16) #=> 600
change(25) #=> 1000

# 4.5.4

# 範囲オブジェクトに対してyo_aメソッドを呼び出すと値が連続する配列を作れる
(1..5).to_a #=> [1, 2, 3, 4, 5]
(1...5).to_a #=> [1, 2, 3, 4]

('a'..'e').to_a #=> ["a", "b", "c", "d", "e"]
('a'...'e').to_a #=> ["a", "b", "c", "d"]

('bad'..'bag').to_a #=> ["bad", "bae", "baf", "bag"]
('bad'...'bag').to_a #=> ["bad", "bae", "baf"]

# []の中に*と範囲オブジェクトを書いても同じように配列を作れる(*を使って複数の値を配列に展開することをsplat展開という)
[*1..5] #=> [1, 2, 3, 4, 5]
[*1...5] #=> [1, 2, 3, 4]

# 4.5.5

# 範囲オブジェクトを配列に変換してから繰り返し処理を行う
numbers = (1..4).to_a
sum = 0
numbers.each { |n| sum += n }
sum #=> 10

# 範囲オブジェクトに対して直接eachメソッドを呼び出すこともできる
sum = 0
(1..4).each { |n| sum += n }
sum #=> 10

# stepメソッドを呼び出すと、値を増やす間隔を指定できる
numbers = []
# 1から10まで2つ飛ばしで繰り返し処理を行う
(1..10).step(2) { |n| numbers << n }
numbers #=> [1, 3, 5, 7, 9]