# raiseで意図的にエラーを起こすことができる
def currency_of(country)
  case country
  when :japan
    'yen'
  when :us
    'dollur'
  when :india
    'rupee'
  else
    # 意図的に例外を発生させる
    raise "無効な国名です。#{country}"
  end
end

currency_of(:japan) #=> "yen"
currency_of(:italy) #=> 無効な国名です。italy (RuntimeError)

# raiseメソッドに文字列のみを渡すとRuntimeError、第一引数に例外を渡すとエラーのクラスを指定できる
def currency_of(country)
  case country
  when :japan
    'yen'
  when :us
    'dollur'
  when :india
    'rupee'
  else
    # 意図的に例外を発生させる
    raise ArgumentError, "無効な国名です。#{country}"
  end
end

currency_of(:italy) #=> 無効な国名です。italy (ArgumentError)

# raiseメソッドに例外クラスのインスタンスを渡す方法もある
def currency_of(country)
  case country
  when :japan
    'yen'
  when :us
    'dollur'
  when :india
    'rupee'
  else
    # 意図的に例外を発生させる
    raise ArgumentError.new, "無効な国名です。#{country}"
  end
end

currency_of(:italy) #=> 無効な国名です。italy (ArgumentError)

# 引数を渡さずエラーメッセージを省略することもできるが、デバッグがしにくいので通常は避ける