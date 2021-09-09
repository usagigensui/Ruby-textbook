# 2.5.1

# Rubyの真偽値では、falseとnilは偽、それ以外は真になる
data = find_data
if data
  'データがあります'
else
  'データはありません'
end

# 2.5.2

# 条件1 && 条件2 => 条件1も条件2も真であれば真、それ以外は偽
t1 = true
t2 = true
f1 = false
t1 && t2 #=> ture
t1 && f1 #=> false

# 条件1 || 条件2 => 条件1も条件2のいずれかが真であれば真、両方偽であれば偽
t1 = true
f1 = false
f2 = false
t1 && f1 #=> ture
f1 && f2 #=> false

# &&と||を組み合わせて使うこともできる
t1 = true
t2 = true
f1 = false
f2 = false
t1 && t2 || f1 && f2 #=> ture
# 上の式と下の式は同じ意味
(t1 && t2) || (f1 && f2) #=> ture
# ||より&&のほうが優先順位が高いので、()を使って記述したほうがわかりやすい
# 優先順位を変えたい場合は()の位置を変える
t1 && (t2 || f1) && f2 #=> false

# !演算子を使うと真偽値が反転する
t1 = true
f1 = false
!t1 #=> false
!f1 #=> ture
# ()と組み合わせると()内の真偽値を反転させる
t1 && f1 #=> false
!(t1 && f1) #=> ture

# 2.5.3

# if文
country = 'italy'
if country == 'japan'
  puts 'こんにちは'
elsif country == 'us'
  pust 'Hello'
elsif country == 'italy'
  puts 'ciao'
else
  puts '???'
end
#=> ciao

# Rubyのif文は最後に評価された戻り値を返すので、if文の戻り値を変数に代入することもできる
greeting =
  country = 'italy'
  if country == 'japan'
    puts 'こんにちは'
  elsif country == 'us'
    pust 'Hello'
  elsif country == 'italy'
    puts 'ciao'
  else
    puts '???'
  end
greeting #=> ciao

# if文は修飾子として後ろに置くこともできる(後置if)
point = 7
day = 1
# 1日であればポイント5倍
point *= 5 if day == 1
point #=> 35

# ifやelsifの後ろにthenを入れると、その条件が真だった場合の処理を1行で書ける
country = 'italy'
if country == 'japan' then 'こんにちは'
elsif country == 'us' then 'Hello'
elsif country == 'italy' then 'ciao'
else '???'
end
#=> "ciao"



