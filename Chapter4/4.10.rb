# 4.10.1

# shuffleメソッドで配列の要素をランダムに並び替える
numbers = [1, 2, 3, 4, 5].shuffle
numbers.each do |n|
  puts n
  # ５が出たら繰り返しを脱出する
  break if n == 5
end

# 繰り返し処理が入れ子になっている場合は、一番内側の処理を脱出する

# 4.10.2

# 外側のループまで脱出したい場合はcatchとthrowを使う
# タグには通常シンボルを使用する
fruits = ['apple', 'melon', 'orange']
numbers = [1, 2, 3]
catch :done do
  fruits.shuffle.each do |fruit|
    numbers.shuffle.each do |n|
      puts "#{fruit}, #{n}"
      if fruit == 'orange' && n == 3
        # すべての繰り返し処理を脱出する
        throw :done
      end
    end
  end
end

# 4.10.3

# returnは「メソッドからの脱出」なので繰り返し処理からの脱出にはbreakのほうがよい

# 4.10.4

numbers = [1, 2, 3, 4, 5]
numbers.each do |n|
  # 偶数であれば中断して次の繰り返し処理に進む
  next if n.even?
  puts n
end
#=> 1
#   3
#   5

# 4.10.5

# redoは条件を満たすまでその繰り返し処理の最初に戻る
foods = ['ピーマン', 'トマト', 'セロリ']
foods.each do |food|
  print "#{food}は好きですか？ => "
  # sampleは配列からランダムに1要素を取得する
  answer = ['はい', 'いいえ'].sample
  puts answer

  # はいと答えなければもう一度聞き返す
  #無限ループ防止のためにやり直しは2回までにする
  redo if answer != 'はい' && count < 2
  # カウントをリセット
  count = 0
end
