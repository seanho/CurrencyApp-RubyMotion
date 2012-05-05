describe 'CurrenciesController' do
  before do
    @app = UIApplication.sharedApplication
    @currencies_controller = @app.windows.first.rootViewController.topViewController
  end
  
  it "should retrieve and display latest exchange rates" do
    wait_for_change @currencies_controller, 'title', timeout = 10 do
      @currencies_controller.title.should.match /Last Update: \d\d:\d\d/
      @currencies_controller.table_view.visibleCells.should.not.be.empty
      @currencies_controller.table_view.visibleCells.first.name_label.text.should == @currencies_controller.infos.first.name
      @currencies_controller.table_view.visibleCells.first.code_label.text.should == @currencies_controller.infos.first.code
      @currencies_controller.table_view.visibleCells.first.rate_label.text.should == ('%.4f' % @currencies_controller.infos.first.rate)
    end
  end
end