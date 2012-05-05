class UIViewController
  def content_frame
    app_frame = UIScreen.mainScreen.applicationFrame
    navbar_height = self.navigationController.navigationBar.frame.size.height
    CGRectMake(0, 0, app_frame.size.width, app_frame.size.height - navbar_height)
    #[[0, 0] [app_frame.size.width, app_frame.size.height]] # not working, bug?
  end
end