require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "user should be valid" do
    user = User.new(:name => "testUser", :email => "test@gmail.com", :password=> "test1",:isDeleted=>FALSE,:role => User::IS_MEMBER)
    assert user.save
  end

  test "validation checks should fail" do
    # No name
    user = User.new(:email => "test@gmail.com", :password=> "test1",:isDeleted=>FALSE,:role => User::IS_MEMBER)
    assert_not user.valid?

    # No email ID
    user = User.new(:name => "testUser", :password=> "test1",:isDeleted=>FALSE,:role => User::IS_MEMBER)
    assert_not user.valid?

    # No password
    user = User.new(:name => "testUser", :email => "test@gmail.com", :isDeleted=>FALSE,:role => User::IS_MEMBER)
    assert_not user.valid?

    # No role
    user = User.new(:name => "testUser", :email => "test@gmail.com", :password=> "test1", :isDeleted=>FALSE)
    assert_not user.valid?
  end

  test "duplicate emailID accounts should not get created" do
    userA = User.new(:name => "testUserA", :email => "test@gmail.com", :password=> "testA",:isDeleted=>FALSE,:role => User::IS_MEMBER)
    userA.save
    userB = User.new(:name => "testUserB", :email => "test@gmail.com", :password=> "testB",:isDeleted=>FALSE,:role => User::IS_MEMBER)
    assert_not userB.save
  end
end
