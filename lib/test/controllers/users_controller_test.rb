require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    @admin = users(:one)
    @user1 = users(:two)
    @superadmin = users(:three)
    @new_member = User.new(name: "new_user", email: "xyz@gmail.com", password: "test122", isDeleted: false, role: User::IS_MEMBER);
    @new_admin = User.new(name: "new_admin", email: "admin2@gmail.com", password: "test122", isDeleted: false, role: User::IS_ADMIN);
    session[:email] = @superadmin.email
    session[:role] = @superadmin.role
  end

  test "should get view_members" do
    get :view_members
    assert_response :success
  end

  test "should get new admin" do
    get :new_admin
    assert_response :success
  end

  test "should create admin" do
    assert_difference('User.count') do
      post :create_admin, {name: @new_admin.name, email: @new_admin.email, password: @new_admin.email,isDeleted: @new_admin.isDeleted,role: @new_admin.role}
    end
  end

  test "should list admins" do
    get :view_admins
    assert_response :success
  end

  test "should delete admins" do
    assert_equal FALSE,@admin.isDeleted
    delete :delete_admins, to_be_deleted_admins: @admin
    admin = User.find(@admin.id)
    assert_equal TRUE,admin.isDeleted
  end

  test "should list members" do
    get :view_members
    assert_response :success
  end

  test "should delete members" do
    assert_equal FALSE,@user1.isDeleted
    delete :delete_members, to_be_deleted_members: @user1.id
    user = User.find(@user1.id)
    assert_equal TRUE,user.isDeleted
  end
end
