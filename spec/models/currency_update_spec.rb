describe "CurrencyUpdate" do
  before do
    @currency_update = CurrencyUpdate.new
  end
  
  it "should assign attributes by hash" do
    update = CurrencyUpdate.new
    update.assign({ "timestamp" => 1336197653, "base" => "USD", "rates" => { "AED" => 3.6732, "AFN" => 48.279999 } })
    update.base.should == "USD"
    update.timestamp.to_s.should == '2012-05-05 16:00:53 +1000'
    update.infos.size.should == 2
    update.infos.first.code.should == "AED"
    update.infos.first.rate.should == 3.6732
  end
  
  it "should get latest update" do
    update = CurrencyUpdate.latest
    update.base.should == "USD"
    update.timestamp.class.should == Time
    update.infos.should.not.be.empty
  end
end