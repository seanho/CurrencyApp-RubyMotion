class UIView
  def width=(width)
    frame = self.frame
    frame.size.width = width
    self.frame = frame
  end
end