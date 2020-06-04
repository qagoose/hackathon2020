module GenericHelpers
  def set_screen_details(size_name, report_name)
    size = @sizes[size_name.to_sym]
    @driver.manage.window.resize_to(size[:width], size[:height])
    @device_name = report_name
  end
end