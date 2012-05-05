class CurrenciesController < UIViewController
  attr_reader :infos, :table_view
  
  def init
    if super
      self.title = "Currency"
      @infos = []
      @search_infos = []
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
    
    searchBar = UISearchBar.alloc.initWithFrame(CGRectZero)
    searchBar.showsCancelButton = true;
    searchBar.placeholder = "Enter Currency Code"
    searchBar.keyboardType = UIKeyboardTypeAlphabet
    searchBar.sizeToFit
    @table_view.tableHeaderView = searchBar
    
    @search_controller = UISearchDisplayController.alloc.initWithSearchBar(searchBar, contentsController:self)
    @search_controller.delegate = self
    @search_controller.searchResultsDataSource = self
    @search_controller.searchResultsDelegate = self
  end
  
  def viewDidLoad
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
  
  def viewDidUnload
    @table_view = nil
  end
  
  # UISearchDisplayDelegate dataSource and delegate
  def searchDisplayController(controller, shouldReloadTableForSearchScope:searchOption)
    true
  end
  
  def searchDisplayController(controller, shouldReloadTableForSearchString:searchOption)
    search_text = controller.searchBar.text.upcase
    if search_text.length > 0
      @search_infos = @infos.select {|info| info.code.start_with?(search_text) }
      @table_view.reloadData
    end
    true
  end
  
  # UITableView dataSource and delegate
  def numberOfSectionsInTableView(tableView)
    1
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    if (@search_controller && tableView == @search_controller.searchResultsTableView)
      @search_infos.size
    else
      @infos.size
    end
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    if (@search_controller && tableView == @search_controller.searchResultsTableView)
      info = @search_infos[indexPath.row]
      CurrencyInfoCell.cellForInfo(info, inTableView:tableView)
    else
      info = @infos[indexPath.row]
      CurrencyInfoCell.cellForInfo(info, inTableView:tableView)
    end
  end
end