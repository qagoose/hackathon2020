# Goggles is really like reverse goggles.  They're protecting us from Eyes!
class Goggles

  # Handles making sure that Eyes isn't staying open under unexepected exceptions
  # It's really confusing when Eyes just won't let anything else happen because it hasn't closed properly
  def self.protect(test_name:, eyes:, webdriver:, &block)
    begin
      puts "Goggles on"
      eyes.configure do |conf|
        conf.test_name = test_name
      end

      eyes.open(driver: webdriver)

      yield
      puts "Goggles off"
    ensure
      puts "Goggles is ensuring eyes is closed"
      eyes.close_async
      eyes.visual_grid_manager.get_all_test_results

      puts "Goggles ensured eyes is closed"
    end
  end
end