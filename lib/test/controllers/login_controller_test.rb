require 'test_helper'

class LoginControllerTest < ActionController::TestCase

  setup do
    @admin = users(:one)
    @member = users(:two)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "admin should be able to sign in" do
    post :signin, {email: @admin.email, name: @admin.name, password: @admin.password, role: "Admin"}
    assert_response :success
    assert_template 'admin_landing'
  end

  test "member should be able to sign in" do
    post :signin, {email: @member.email, name: @member.name, password: @member.password, role: "Member"}
    assert_response :success
    assert_template 'member_landing'
  end

  test "should get signup_new" do
    get :signup_new
    assert_response :success
  end

  test "should be able to signup" do
    assert_difference('User.count', 1) do
      post :signup_create, {email: "member3@gmail.com", name: "member3", password: "test"}
    end

    assert_redirected_to action: 'member_landing'
  end

  test "should not be able to sign up" do
    assert_no_difference('User.count') do
      post :signup_create, {email: "member4@gmail.com", name: "member4"}
    end

    assert_redirected_to action: 'signup_new'
  end

  test "should be able to update both name and password" do
    session[:email]=@member.email
    assert_equal "member2", @member.name
    assert_equal "member2pwd", @member.password
    post :update_profile, {user: {name: "member2_edit", password: "member2pwd_edit"}}
    user = User.find_by_email(@member.email)
    assert_equal "member2_edit", user.name
    assert_equal "member2pwd_edit", user.password
  end

  test "should be able to update either name or password" do
    session[:email]=@member.email
    assert_equal "member2", @member.name
    assert_equal "member2pwd", @member.password
    post :update_profile, {user: {name: "member2_edit"}}
    user = User.find_by_email(@member.email)
    assert_equal "member2_edit", user.name
    assert_equal "member2pwd", user.password

    # Change just the password now
    post :update_profile, {user: {password: "member2pwd_edit"}}
    user= User.find_by_email(@member.email)
    assert_equal "member2_edit", user.name
    assert_equal "member2pwd_edit", user.password
  end

end
