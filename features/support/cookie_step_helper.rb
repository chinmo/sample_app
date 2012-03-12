module CookieStepHelper
  def announce_rack_test_cookies(cookie_jar)
    puts "Current cookies: #{cookie_jar.instance_variable_get( \
                                 :@cookies).map(&:inspect).join("\n")}"
  end

  def get_rack_test_cookie_jar
    rack_test_driver = Capybara.current_session.driver
    cookie_jar = rack_test_driver.browser.current_session.instance_variable_get(:@rack_mock_session).cookie_jar
  end

  def expire_rack_test_cookie(cookie_jar, cookie_name)
    cookie_jar.instance_variable_get(:@cookies).reject! do |existing_cookies|
      existing_cookies.expired? != false
    end
  end
 
  def delete_rack_test_cookie(cookie_jar, cookie_name)
    cookie_jar.instance_variable_get(:@cookies).reject! do |existing_cookies|
      existing_cookies.name.downcase == cookie_name
    end
  end
end

World(CookieStepHelper)

