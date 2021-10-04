# 空のハッシュを作る
{}

# 空のハッシュ作成し、そのクラス名を確認する
{}.class #=> Hash

# 国ごとの通貨の単位を格納したハッシュ
{ 'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }

# 5.2.1

currencies = { 'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }

# イタリアの通貨を追加する
currencies['italy'] = 'euro'
currencies #=> {"japan"=>"yen", "us"=>"dollar", "india"=>"rupee", "italy"=>"euro"}

# 既存の値を上書きする
currencies['japan'] = '円'
puts currencies #=> {"japan"=>"円", "us"=>"dollar", "india"=>"rupee", "italy"=>"euro"}

# 指定したキーに対応する値を取り出す
currencies['india'] #=> 'rupee'

# 存在しないキーを指定するとnilが返る
currencies['brazil'] #=> nil

# 5.2.2

currencies = { 'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }

# eachメソッドでキーと値の組み合わせを順に取り出すことができる
# ブロック引数がキーと値で二つになる
currencies.each do |key, value|
  puts "#{key} : #{value}"
end
#=> japan : yen
#   us : dollar
#   india : rupee


# ブロック引数を一つにするとキーと値が配列で格納される
currencies.each do |key_value|
  key = key_value[0]
  value = key_value[1]
  puts "#{key} : #{value}"
end
#=> japan : yen
#   us : dollar
#   india : rupee

# 5.2.3

a = { 'x' => 1, 'y' => 2, 'z' => 3 }

# すべてのキーと値がお内であればtrue
b = { 'x' => 1, 'y' => 2, 'z' => 3 }
a == b #=> true

# 並び順が異なっていてもキーと値がすべて同じならtrue
c = { 'z' => 3, 'y' => 2, 'x' => 1 }
a == c #=> true

# キー'x'の値が異なるのでfalse
d = { 'x' => 10, 'y' => 2, 'z' => 3 }
a == d #=> false

# sizeメソッドを使うとハッシュの要素の個数を調べられる
{}.size #=> 0
{ 'x' => 1, 'y' => 2, 'z' => 3 }.size #=> 3

# deleteメソッドを使うと指定したキーに対応する要素を削除する
currencies = { 'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }
currencies.delete('japan') #=> "yen"
currencies                 #=> {"us"=>"dollar", "india"=>"rupee"}

# 削除しようとしたキーがなければnilが返る
currencies = { 'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }
currencies.delete('italy') #=> nil
# bブロックを渡すとキーが見つからないときの戻り値を作成できる
currencies.delete('italy') {|key| "Not found: #{key}" } #=> "Not found: italy"