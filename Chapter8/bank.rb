require './deep_freezable'

class Bank
  extend DeepFreezable
  
  CURRRENCIES = deep_freeze({ 'Japan' => 'yen', 'US' => 'dollar', 'India' => 'rupee' })
end