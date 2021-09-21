# 4.4.1

# mapメソッドは各要素に対してブロックを評価した結果を新しい配列にして返す(エイリアスメソッドはcollect)
numbers = [1, 2, 3, 4, 5]
# ブロックの戻り値が新しい配列の各要素になる
new_numbers = numbers.map { |n| n * 10 }
new_numbers #=> [10, 20, 30, 40, 50]

# 4.4.2

# selectメソッド(エイリアスメソッドはfind_all)は各要素に対してブロックを評価し、その戻り値が真の要素だけの配列を返す
numbers = [1, 2, 3, 4, 5, 6]
# ブロックの戻り値が真になった要素だけが集められる
even_numbers = numbers.select { |n| n.even? }
even_numbers #=> [2, 4, 6]

# rejectメソッドはselectの反対で、戻り値が真になった要素を除外した配列を返す
numbers = [1, 2, 3, 4, 5, 6]
# 3の倍数を除外する
non_multiples_three = numbers.reject { |n| n % 3 == 0 }
non_multiples_three #=> [1, 2, 4, 5]

# 4.4.3

# findメソッド(エイリアスメソッドはdetect)はブロックの戻り値が真になった最初の要素を返す
numbers = [1, 2, 3, 4, 5, 6]
# ブロックの戻り値が最初に真になった要素を返す
even_numbers = numbers.find { |n| n.even? }
even_numbers #=> 2

# 4.4.4