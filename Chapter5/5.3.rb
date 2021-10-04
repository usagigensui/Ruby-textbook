# シンボルはコロン(:)に続けて任意の名前を定義する
:apple
:japan
:ruby_is_fun

# 5.3.1

# シンボルはSymbolクラスのオブジェクト
:apple.class #=> Symbol

# シンボルはRubyの内部で整数として管理されるため、2つの値が同じかどうか調べる場合、文字列より高速で処理できる
:apple == :apple

# シンボルは「同じシンボルであれば同じオブジェクト」になり、大量の同じ文字列より大量の同じシンボルのほうがメモリの使用効率がいい
:apple.object_id #=> 1101148
:apple.object_id #=> 1101148
:apple.object_id #=> 1101148
'apple'.object_id #=> 60
'apple'.object_id #=> 80
'apple'.object_id #=> 100

# シンボルはインミュータブルなオブジェクトなので、破壊的な変更はできない

# 5.3.2

# シンボルをハッシュのキーにする
currencies = { :japan => 'yen', :us => 'duller', :india => 'rupee' }
# シンボルを使って値を取り出す(文字列より高速)
currencies[:japan] #=> "yen"