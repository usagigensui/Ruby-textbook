# 4.9.1

sum = 0
# 処理を5回繰り返す。nには0, 1, 2, 3, 4が入る
5.times { |n| sum += n }
sum #=> 10

# ブロック引数は省略してもよい
sum = 0
# sumに1を加算する処理を5回繰り返す
5.times { sum += 1 }
sum #=> 10

# 4.9.2

# uptoメソッド、引数まで数値を増やす
a = []
10.upto(14) { |n| a << n }
a #=> [10, 11, 12, 13, 14]

# downtoメソッド、引数まで数値を減らす
a = []
14.downto(10) { |n| a << n }
a #=> [14, 13, 12, 11, 10]

# 4.9.3

# stepメソッド、数値をx個ずつ増やす処理をする
# 開始値.step(上限値, 1度に増減する大きさ
a = []
1.step(10, 2) { |n| a << n }
a #=> [1, 3, 5, 7, 9]

a = []
10.step(1, -2) { |n| a << n }
a #=> [10, 8, 6, 4, 2]

# while分は指定した条件が真である場合に処理を繰り返す
a = []
while a.size < 5
  a << 1
end
a #=> [1, 1, 1, 1, 1]

a = []
a << 1 while s.size < 5
a #=> [1, 1, 1, 1, 1]

# brgin ... endで囲むと最低1回は実行される
begin
  a << 1
end while false
a => [1]

# while文の反対で、条件が偽である間、処理を繰り返すuntil文
a = [10, 20, 30, 40, 50]
until a.size <= 3
  a.delete_at(-1)
end
a #=> [10, 20, 30]

# while文もuntil文もずっと結果が変わらない条件を入れると無限ループが発生するので注意する

# 4.9.5

# for ... in ... endで繰り返し処理
numbers = [1, 2, 3, 4]
num = 0
for n in numbers
  sum += n
end
sum #=> 10

# 4.9.6

# loopメソッドで無限ループを起こす
numbers = [1, 2, 3, 4, 5]
loop do
  # sampleメソッドでランダムに要素をひとつ取得する
  n = numbers.sample
  puts n
  # breakの条件で無限ループｗｐ脱出する
  break uf n == 5
end