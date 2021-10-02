# 4.8.1

# each_with_indexメソッドは、第2引数に添え字を渡す
fruits = ['apple', 'orange', 'melon']
fruits.each_with_index { |fruit, i| puts "#{i}: #{fruit}" }
#=> 0: apple
#   1: orange
#   2: melon

# eachメソッド以外で同じような動作をしたい場合は、with_indexメソッドを組み合わせることで実現できる
fruits = ['apple', 'orange', 'melon']
# mapとして処理しつつ、添え字を受け取る
fruits.map.with_index { |fruit, i| "#{i}: #{fruit}" }
#=> ["0: apple", "1: orange", "2: melon"]

fruits = ['apple', 'orange', 'melon']
# 名前にaを含み、なおかつ添え字が奇数である要素を削除する
fruits.delete_if.with_index { |fruit, i| fruits.include?('a') && i.odd? }
#=> ["apple", "melon"]

# 4.8.3

fruits = ['apple', 'orange', 'melon']
# eachで繰り返しつつ、1から始まる添え字を取得する
fruits.each.with_index(1) { |fruit, i| puts "#{i}: #{fruit}" }
# 添え字は引数で渡した数字から開始する
#=> 1: apple
#   2: orange
#   3: melon

# 4.8.4

dimensions = [
  # [縦, 横]
  [10, 20],
  [30, 40],
  [50, 60],
]
# 面積の計算結果を格納する配列
areas = []
# 配列の要素分だけブロック引数を用意すると、各要素の値が別々の変数に格納される
dimensions.each do |length, width|
  areas << length * width
end
areas #=> [200, 1200, 3000]

# ブロック引数が複数あるメソッドの場合
dimensions = [
  [10, 20],
  [30, 40],
  [50, 60],
]
# ブロック引数を()で囲んで、配列の要素を別々の引数として受け取る
dimensions.each_with_index do |(length, width), i|
  puts "length: #{length}, width: #{width}, i: #{i}"
end
#=> length: 10, width: 20, i: 0
#   length: 30, width: 40, i: 0
#   length: 50, width: 60, i: 0

# 4.8.5

# ブロックローカル変数
numbers = [1, 2, 3, 4]
sum = 0
# ブロックの外にあるsumとは別物の変数sumを用意する
numbers.each do |n; sum|
  # 別物のsumを10で初期化し、ブロック変数の値を加算する
  sum = 10
  sum += n
  p sum
end
#=> 11
#   12
#   13
#   14

# ブロックの中で使っていたsumは別物なので、ブロックの外のsumには変化がない
sum #=> 0

# 4.8.6

# sumple.txtを開いて文字列を書き込む(クローズ処理は自動で行われる)
File.open("./sample.txt", "w") do |file|
  file.puts("1行目のテキストです。")
  file.puts("2行目のテキストです。")
  file.puts("3行目のテキストです。")
end
# File.openメソッドとブロックを組み合わせると、記述しなくてもクローズ処理まで行われる

# 4.8.7

a = [1, 2, 3]

# deleteメソッドはブロックを渡さないとき、指定した値が見つからないとnilが返る
a.delete(100) #=> nil

# ブロックを渡すと戻り値が指定した値が見つからないときの戻り値になる
a.delete(100) do
  'NG'
end
#=> "NG"

a.delete(100) { 'NG' }
#=> "NG"

# 4.8.8

# ブロックを使うメソッドは自分で定義できる

# Column

# ブロックの後ろにメソッドを書く
names = ['田中', '鈴木', '佐藤']

names.map { |name| "#{name}さん" }.join('と') #=> "田中さんと鈴木さんと佐藤さん"

names.map do |name|
  "#{name}さん"
end.join('と') #=> "田中さんと鈴木さんと佐藤さん"