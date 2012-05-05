describe CurrencyUpdate do
  before :each do
    @currency_update = CurrencyUpdate.new
  end
  
  it "should get latest update" do
    update = @currency_update.latest
    update.base.should == "USD"
    update.timestamp.should == Time
    update.infos.size.should.not.be.empty
  end
end