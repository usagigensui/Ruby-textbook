# 8.6.1

# モジュール構文の中にクラス定義を書くと「そのモジュールに属するクラス」という意味になる
# 「名前空間(ネームスペース)」としてのモジュールの使い方
module Baseboll
  # これはBasebollモジュールに属するSecondクラス
  class Second
    def intialize(player, uniform_number)
      @player = player
      @uniform_number = uniform_number
    end
  end
end

module Clock
  # これはClockモジュールに属するSecondクラス
  class Second
    def initialize(digits)
      @digits = digits
    end
  end
end

# 二塁手のAliceを作成する
Baseboll::Second.new('Alice', 13)

# 時計の13秒を作成する
Clock::Second,new(13)

# 8.6.2

# 名前空間は名前の衝突を防ぐためだけでなく、クラスのグループ/カテゴリわけをする目的でも使用する

# 8.6.3

# 名前空間として使うモジュールはネストさせなくても、クラス名を"モジュール名::クラス名で定義する形でも記述できる
module Baseboll
end

class Baseboll::Second
  def intialize(player, uniform_number)
    @player = player
    @uniform_number = uniform_number
  end
end

# Column

# トップレベルのクラスやモジュールを指定するためには、クラス名やモジュール名の前に::をつける
class Second
  def intialize(player, uniform_number)
    @player = player
    @uniform_number = uniform_number
  end
end


module Clock
  class Second
    def initialize(digits)
      @digits = digits
      # トップレベルのSecondクラスをnewしたい
      @baseboll_second = ::Second.new('Clock', 10)
    end
  end
end