module TestLogHelper
  def log_test_result(file:,
                      task:,
                      test_name:,
                      browser_name:,
                      browser_viewport:,
                      device:,
                      status:)

    open "../#{file}", 'a' do |f|
      log = "Task: #{task}, "
      log << "Test name: #{test_name}, "
      log << "Browser: #{browser_name}, "
      log << "Viewport: #{browser_viewport[:width]} x #{browser_viewport[:height]}, "
      log << "Device: #{device}, "
      log << "Status: #{status}"

      f.puts log
    end

  end
end