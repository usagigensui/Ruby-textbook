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
fruits.each_with_index(1) { |fruit, i| puts "#{i}: #{fruit}" }
# 添え字は引数で渡した数字から開始する
#=> 1: apple
#   2: orange
#   3: melon