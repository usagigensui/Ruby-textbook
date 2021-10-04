# 5.4.1

# シンボルがキーの場合、=>を使わずにハッシュを作成できる
currencies = { japan: 'yen', us: 'dollar', india: 'rupee' }
# 値を取り出すときは同じ
currencies[:us] #=> 'dollar'

# キーも値もシンボルの場合
{ japan: :yen, us: :dollar, india: :rupee }

# 5.4.2

# ハッシュに格納する値は異なるデータ型が混在するケースもある
person = {
  # 値が文字列
  name: 'Alice',
  # 値が数値
  age: 20,
  # 値が配列
  friends: ['Bob', 'Carol'],
  # 値がハッシュ
  phones: { home: '1234-0000', mobile: '5678-0000' }
}

person[:age]             #=> 20
person[:friends]         #=> ["Bob", "Carol"]
person[:phones][:mobile] #=> "5678-0000"

# 5.4.3

# メソッドに引数を渡すとき、キーワード引数を定義することができる

# def メソッド名(キーワード引数1: デフォルト値1, キーワード引数2: デフォルト値2)
#   メソッドの定義
# end

def buy_burger(menu, drink: true, potato: true)
  # ハンバーガーを購入
  if drink
    # ドリンクを購入
  end
  if potato
    # ポテトを購入
  end
end

# チーズバーガーとポテトを購入する
buy_burger('cheese', drink: true, potato: true)
# フィッシュバーガーとドリンクを購入する
buy_burger('fish', drink: true, potato: false)

# キーワード引数と一致するハッシュであればメソッドの引数として渡すことができる
params = { drink: true, potato: false}
buy_burger('fish', params)