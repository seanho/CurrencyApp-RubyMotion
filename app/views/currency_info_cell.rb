class CurrencyInfoCell < UITableViewCell
  include SimpleView::Layout

  CellID = 'CurrencyCellIdentifier'

  def initWithStyle(style, reuseIdentifier:reuseIdentifier)
    if super
      setup self do
        label name: "name_label", width: 160, height: 22, left: 36, top: 10, adjustsFontSizeToFitWidth: true
        label name: "code_label", width: 160, height: 22, left: 36, top: 32, textColor: "#aaa", font: "12"
        label name: "rate_label", width: 100, height: 22, right: 10, anchors: [:right],
              textAlignment: UITextAlignmentRight, adjustsFontSizeToFitWidth: true
      end
    end
    self
  end

  def self.cellForInfo(info, inTableView: tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(CellID) || CurrencyInfoCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CellID)
    cell.find("name_label").text = info.name
    cell.find("code_label").text = info.code
    cell.find("rate_label").text = '%.4f' % info.rate
    cell.imageView.image = "flags/#{info.country_code.downcase}.png".to_image unless info.country_code.nil?
    cell
  end
end