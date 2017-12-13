require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User",
                     email: "user@example.com",
                     password: "foobar",
                     password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "       "
    assert_not @user.valid?

    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
    @user.email = ""
    assert_not @user.valid?
  end

  test "name should be less than or equal to 50 characters" do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test "email should be less than or equal to 100 characters" do
    @user.email = "foo" * 50 + "@test.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com
                         USER@foo.COM
                         A_US-ER@foo.bar.org
                         first.las@foo.jp
                         alice+bob@baz.com
                      ]

    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email is unique" do
    dup_user = @user.dup
    dup_user.email.upcase!
    @user.save
    assert_not dup_user.valid?
  end

  test "email is downcased when saving" do
    email = "TesTUser@pRiVatEEmail.com"
    @user.email = email
    @user.save
    assert_equal email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
end
