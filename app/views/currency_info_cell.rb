class CurrencyInfoCell < UITableViewCell
  CellID = 'CurrencyCellIdentifier'
  
  attr_reader :name_label, :code_label, :rate_label
  
  def initWithStyle(style, reuseIdentifier:reuseIdentifier)
    if super
      @name_label = UILabel.alloc.initWithFrame(CGRectMake(36, 10, 160, 22))
      @name_label.adjustsFontSizeToFitWidth = true
      self.addSubview(@name_label)
      
      @code_label = UILabel.alloc.initWithFrame(CGRectMake(36, 32, 100, 22))
      @code_label.color = UIColor.grayColor
      @code_label.font = UIFont.systemFontOfSize(12)
      self.addSubview(@code_label)
      
      @rate_label = UILabel.alloc.initWithFrame(CGRectMake(210, 18, 100, 22))
      @rate_label.textAlignment = UITextAlignmentRight
      @rate_label.adjustsFontSizeToFitWidth = true
      self.addSubview(@rate_label)
    end
    self
  end

  def self.cellForInfo(info, inTableView:tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(CellID) || CurrencyInfoCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CellID)
    cell.name_label.text = info.name
    cell.code_label.text = info.code
    cell.rate_label.text = '%.4f' % info.rate
    cell.imageView.image = UIImage.imageNamed("flags/#{info.country_code.downcase}.png") unless info.country_code.nil?
    cell
  end
end