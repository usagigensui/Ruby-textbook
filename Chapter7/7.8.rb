# クラス名::定数名　でクラスの外部から定数を参照する
class Product
  DEFAULT_PRICE = 0
end

Product::DEFAULT_PRICE #=> 0

# private_constantで外部から参照できなくなる
class Product
  DEFAULT_PRICE = 0
  # 定数をprivateにする
  private_constant :DEFAULT_PRICE
end

# 定数はメソッドの内部で作成するとエラーする
# 必ずクラス構文直下で作成すること

# 7.8.1

# Rubyの定数は後から書き換えることができるが、普通はしない

class Product
  DEFAULT_PRICE = 0
  # 再代入して定数を書き換える
  DEFAULT_PRICE = 1000
end

# クラスの外部からでも再代入できる
Product::DEFAULT_PRICE = 2000

# 防止するにはクラスをfreeze(凍結)する
Product.freeze

# クラス内部にfreezeと記述して再代入を防ぐこともできるが、メソッドの定義もできなくなるので、freezeを呼ぶことはまずない

# 7.8.2

# ミュータブルなオブジェクトであれば、再代入しなくても定数の値を変えることができてしまう
class Prosuct
  # 配列を凍結する
  SOME_NAMES = ['Foo', 'Bar', 'Baz'].freeze
end
# 上記だと配列やハッシュそのものへの変更は防止できるが、各要素まではfreezeしない
# 例えば破壊的に要素を変更すると...
Product::SOME_NAMES[0].upcase!
# １番目の要素が変更される
Product::SOME_NAMES #=> ["FOO", "Bar", "Baz"]

# 各要素の値もfreezeすれば防止できる
class Prosuct
  # mapメソッドで各要素をfreezeし、最後にmapメソッドの戻り値の配列もfreezeする
  SOME_NAMES = ['Foo', 'Bar', 'Baz'].map(&:freeze).freeze
end

# インミュータブルなオブジェクト(数値やシンボル、true/false)はfreezeしなくてももともと変更することができない