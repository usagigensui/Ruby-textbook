# 配列とは複数のデータをまとめて格納できるオブジェクトのこと
# 配列内のデータは順番に並んでおり、添え字(インデックス)を指定することで取り出すことができる

# 空の配列を作る(配列は[]と,で作成する)
[]

# 三つの要素が格納された配列を作る
[要素1, 要素2, 要素3]

# 配列はArrayクラスのオブジェクト
[].class #=> Array

# 変数に代入できる
# 配列はデータ型が混在していてもよい
a = [1, 2, 3]
a = ['apple', 'orange', 'melon']
a = [1,'apple', 2, 'orange', 3, 'melon']

# 配列の中に配列を含めることもできる
a = [[10, 20, 30], [40, 50, 60], [70, 80, 90]]

# 配列の各要素を取得するには[]と添え字を使う。最初の要素の添え字は0
  a = [1, 2, 3]
  # ひとつめの要素を取得
  a[0] #=> 1
  # ふたつめの要素を取得
  a[1] #=> 2
  # みっつめの要素を取得
  a[2] #=> 3
  # 存在しない要素を指定するとnilが返る(エラーしない)
  a[100] #=> nil
  # sizeメソッド(エイリアスメソッドはlength)は配列の長さを取得できる
  a.size   #=> 3
  a.length #=> 3

# 4.2.1

# 配列[添え字] = 新しい値
# 添え字を指定して値を代入すると、指定した要素を変更する
a = [1, 2, 3]
a[1] = 20
a #=> [1, 20, 3]

# 元の大きさよりの大きい添え字を指定すると、間の値がnilで埋まる
a = [1, 2, 3]
a[4] = 50
a #=> [1, 2, 3, nil, 50]

# <<を使うと配列の最後に要素を追加する
a = []
a << 1
a << 2
a << 3
a #=> [1, 2, 3]

# 配列内の要素を削除するにはdelete_atメソッドを使う
a = [1, 2, 3]
# 2番目の要素を削除する
a.delete_at(1) #=> 2
a #=> [1, 3]
# 存在しない添え字を削除するとnilが返る
a.delete_at(100) #=> nil
a #=> [1, 3]

# 4.2.2

# 配列に多重代入する
a, b = [1, 2]
a #=> 1
b #=> 2

# 右辺の数が少ないとnilが入る
c, d = [10]
c #=> 10
d #=> nil

# 右辺の数が多いとはみ出した値は切り捨てられる
e, f = [100, 200, 300]
e #=> 100
f #=> 200

# divmodメソッドは割り算の商と余りを配列として返す
14.divmod(3) #=> [4, 2]

# 戻り値を配列のまま受け取る
quo_rem = 14.divmod(3)
"商=#{quo_rem[0]}, 余り=#{quo_rem[1]}" #=> "商=4, 余り=2"

# 多重代入で別々の変数として受け取るほうがわかりやすいコードになる
quotient, remainder = 14.divmod(3)
"商=#{quotient}, 余り=#{remainder}" #=> "商=4, 余り=2"
