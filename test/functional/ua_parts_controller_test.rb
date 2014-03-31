require 'test_helper'

class UaPartsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ua_parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ua_part" do
    assert_difference('UaPart.count') do
      post :create, :ua_part => { }
    end

    assert_redirected_to ua_part_path(assigns(:ua_part))
  end

  test "should show ua_part" do
    get :show, :id => ua_parts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ua_parts(:one).to_param
    assert_response :success
  end

  test "should update ua_part" do
    put :update, :id => ua_parts(:one).to_param, :ua_part => { }
    assert_redirected_to ua_part_path(assigns(:ua_part))
  end

  test "should destroy ua_part" do
    assert_difference('UaPart.count', -1) do
      delete :destroy, :id => ua_parts(:one).to_param
    end

    assert_redirected_to ua_parts_path
  end
end
