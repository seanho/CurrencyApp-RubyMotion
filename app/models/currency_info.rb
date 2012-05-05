class CurrencyInfo
  attr_accessor :code, :rate
  
  def initialize(code, rate)
    @code = code
    @rate = rate
  end
end