require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'layout links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', signup_path
  end

  test "titles are correct when changing paths" do
    get root_path
    assert_select 'title', full_title
    get about_path
    assert_select 'title', full_title('About')
    get contact_path
    assert_select 'title', full_title('Contact')
    get help_path
    assert_select 'title', full_title('Help')
  end

  test "signup page has correct layouts" do
    get signup_path
    assert_select 'title', full_title('Sign Up')
  end
end
