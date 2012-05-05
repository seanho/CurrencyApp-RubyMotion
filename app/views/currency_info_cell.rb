class CurrencyInfoCell < UITableViewCell
  CellID = 'CurrencyCellIdentifier'

  def self.cellForInfo(info, inTableView:tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(CellID) || CurrencyInfoCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:CellID)
    cell.textLabel.text = info.code
    cell.detailTextLabel.text = '%.4f' % info.rate
    cell
  end
end