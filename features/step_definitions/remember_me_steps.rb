# coding: utf-8

前提 /^登録済みのユーザが$/ do
  @user = User.create(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
end

もし /^ログインページでログイン情報を入力する$/ do
  visit signin_path
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
end

もし /^「ログイン状態を保持する」をチェックする$/ do
  check('remember_me')
end

もし /^ログインボタンを押す$/ do
  click_button "Sign in"
end

ならば /^ログインに成功する（ログアウトリンクが見える）$/ do
  page.should have_link('Sign out', href: signout_path)
end

前提 /^一旦ブラウザを閉じる（セッションをクリアする）$/ do
  session_name = 'remember_token'

  driver = Capybara.current_session.driver
  case driver
  when Capybara::RackTest::Driver
    announce_rack_test_cookies(get_rack_test_cookie_jar) if @announce
#    delete_rack_test_cookie(get_rack_test_cookie_jar, session_name)
    expire_rack_test_cookie(get_rack_test_cookie_jar, session_name)
#    puts "Deleted cookie: #{session_name}" if @announce
    puts "Expired cookie: #{session_name}" if @announce
    announce_rack_test_cookies(get_rack_test_cookie_jar) if @announce
  else
    raise "unsupported driver #{driver.class}. use rack::test."
  end
end

もし /^再度ブラウザを立ち上げ$/ do

end

もし /^トップページにアクセスする$/ do
  visit root_path
end

ならば /^ログインに成功している（ログアウトリンクが見える）$/ do
  step "ログインに成功する（ログアウトリンクが見える）"
end

もし /^「ログイン状態を保持する」をチェックしない$/ do
  uncheck('remember_me')
end

ならば /^ログインしていない（ログインリンクが見える）$/ do
  page.should have_link('Sign in', href: signin_path)
end

Before('@announce') do
  @announce = true
end

