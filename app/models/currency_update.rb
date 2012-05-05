class CurrencyUpdate
  URL = 'http://openexchangerates.org/latest.json'
  
  attr_accessor :timestamp, :base, :infos, :error
  
  def assign(hash)
    @timestamp = Time.at(hash['timestamp'])
    @base = hash['base']
    @infos = []
    hash['rates'].each do |k,v|
      @infos << CurrencyInfo.new(k, v)
    end
  end
  
  def self.latest
    update = CurrencyUpdate.new
    
    error_ptr = Pointer.new(:object)
    data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(URL), options:NSDataReadingUncached, error:error_ptr)
    if data
      json = NSJSONSerialization.JSONObjectWithData(data, options:0, error:error_ptr)
      if json
        update.assign(json)
      else
        update.error = error_ptr[0]
      end
    else
      update.error = error_ptr[0]
    end
    
    update
  end
end