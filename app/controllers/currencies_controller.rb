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

    UI::Layouts.setup(view, controller: self) do
      search_bar name: "search_bar", placeholder: "Find Currency", showsCancelButton: true, keyboardType: UIKeyboardTypeAlphabet do
        @view.sizeToFit
      end
      table_view name: "table_view", right: 0, bottom: 0, dataSource: @controller, delegate: @controller, rowHeight: 60 do
        @view.tableHeaderView = @view.superview.subview("search_bar")
      end
    end
    
    @search_controller = UISearchDisplayController.alloc.initWithSearchBar(view.subview("search_bar"), contentsController:self)
    @search_controller.delegate = self
    @search_controller.searchResultsDataSource = self
    @search_controller.searchResultsDelegate = self
    @search_controller.searchResultsTableView.rowHeight = 60
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
          view.subview("table_view").reloadData
          self.title = update.timestamp.strftime("Last Update: %H:%M")
        end
      end
    end
  end
  
  # UISearchDisplayDelegate dataSource and delegate
  def searchDisplayController(controller, shouldReloadTableForSearchScope:searchOption)
    true
  end
  
  def searchDisplayController(controller, shouldReloadTableForSearchString:searchOption)
    search_text = controller.searchBar.text.upcase
    if search_text.length > 0
      @search_infos = @infos.select {|info| info.code.start_with?(search_text) || info.name.upcase.start_with?(search_text) }
      view.subview("table_view").reloadData
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
  
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated:true)
  end
end