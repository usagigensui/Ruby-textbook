# 7.9.1

# クラスインスタンス変数とは、インスタンスの作成(クラス名.new)とは無関係に、クラス自身が保持している@から始まる変数
# クラス構文直下や、クラスメソッドの内部で@で始まる変数を操作するとクラスインスタンス変数にアクセスしていることになる
class Product
  # クラスインスタンス変数
  @name = 'Product'

  def self.name
    # クラスインスタンス変数
    @name
  end

  def initialize(name)
    # インスタンス変数
    @name = name
  end

  def name
    # インスタンス変数
    @name
  end
end

class DVD < Product
  @name = 'DVD'

  def self.name
    # クラスインスタンス変数を参照
    @name
  end

  def upcase_name
    # インスタンス変数を参照
    @name.upcase
  end
end

# クラスインスタンス変数はインスタンス変数とは異なり、スーパークラスとサブクラスでは同じ名前でも別の変数を保持する
Product.name #=> "Product"
DVD.name     #=> "DVD"

product = Product.new('A great movie')
product.name #=> "A great movie"

dvd = DVD.new('An awesome film')
dvd.name        #=> "An awesome film"
dvd.upcase_name #=> "AN AWESOME FILM"

Product.name #=> "Product"
DVD.name     #=> "DVD"

# 7.9.2

# クラス変数はクラスメソッド内でもインスタンスメソッド内でも共有され、なおかつスーパークラスとサブクラスでも共有される
# クラス変数は@@same_valueのように変数名の最初に@を二つ重ねる

class Product
  @@name = 'Product'
  
  def self.name
    @@name
  end

  def initialize(name)
    @@name = name
  end

  def name
    @@name
  end
end

class DVD < Product
  @@name = 'DVD'

  def self.name
    @@name
  end

  def upcase_name
    @@name.upcase
  end
end

# DVDクラスを定義したタイミングで@@nameが"DVD"に変更される
Product.name #=> "DVD"
DVD.name     #=> "DVD"

product = Product.new('A great movie')
product.name #=> "A great movie"

# Product.newのタイミングで@@nameが"A great movie"に変更される
Product.name #=> "A great movie"
DVD.name     #=> "A great movie"

dvd = DVD.new('An awesome film')
dvd.name        #=> "An awesome film"
dvd.upcase_name #=> "AN AWESOME FILM"

# Product.newのタイミングで@@nameが"An awesome film"に変更される
product.name #=> "An awesome film"
Product.name #=> "An awesome film"
DVD.name     #=> "An awesome film"

# 7.9.3

# グローバル変数はクラスの内部、外部を問わずにプログラムのどこからでも変更、参照できる
# グローバル変数は$same_valueのよに$で変数名を始める

# グローバル変数の宣言と値の代入
$program_name = 'Awesome program'

# グローバル変数に依存するクラス
class Program
  def initialize(name)
    $program_name = name
  end

  def self.name
    $program_name
  end

  def name
    $program_name
  end
end

# $program_nameにはすでに名前が代入されている
Program.name #=> "Awesome program"

program = Program.new('Super program')
program.name #=> "Super program"

# Program.newのタイミングで$program_nameが"Super program"に変更される
Program.name  #=> "Super program"
$program_name #=> "Super program"

