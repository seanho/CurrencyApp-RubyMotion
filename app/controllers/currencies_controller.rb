class CurrenciesController < UIViewController
  def viewDidLoad
    self.title = "Currency"
    
    @infos = []
    
    @tableView = UITableView.alloc.initWithFrame(CGRectZero, style:UITableViewStylePlain)
    @tableView.frame = self.content_frame
    @tableView.dataSource = self
    @tableView.delegate = self
    self.view.addSubview @tableView
    
    loadData
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
          self.title = update.timestamp.strftime("Last Update: %H:%M")
          @infos = update.infos
          @tableView.reloadData
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