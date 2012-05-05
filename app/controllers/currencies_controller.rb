class CurrenciesController < UIViewController
  attr_reader :infos, :table_view
  
  def init
    if super
      self.title = "Currency"
      @infos = []
    end
    self
  end
  
  def loadView
    super
    
    @table_view = UITableView.alloc.initWithFrame(CGRectZero, style:UITableViewStylePlain)
    @table_view.frame = self.content_frame
    @table_view.dataSource = self
    @table_view.delegate = self
    self.view.addSubview @table_view
  end
  
  def viewDidLoad
    loadData
  end
  
  def viewDidUnload
    @table_view = nil
  end
  
  def loadData
    Dispatch::Queue.concurrent.async do
      update = CurrencyUpdate.latest
      
      Dispatch::Queue.main.sync do
        if update.error
          alert = UIAlertView.new
          alert.message = error.description
          alert.addButtonWithTitle "OK"
          alert.show
        else
          @infos = update.infos
          @table_view.reloadData
          self.title = update.timestamp.strftime("Last Update: %H:%M")
        end
      end
    end
  end
  
  def numberOfSectionsInTableView(tableView)
    1
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    @infos.size
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    info = @infos[indexPath.row]
    CurrencyInfoCell.cellForInfo(info, inTableView:tableView)
  end
end