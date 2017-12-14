require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    @base_user_info = { name: "Tester Test",
                       email: "email@email.com",
                       password: "foobar",
                       password_confirmation: "foobar"}
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar" }}
    end

    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "error messages received" do
    get signup_path

    user_info = @base_user_info.dup
    user_info[:name] = ""

    assert_no_difference 'User.count' do
      post users_path, params: { user: user_info }
    end
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: @base_user_info }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
