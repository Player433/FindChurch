require 'test_helper'

class DenominationsControllerTest < ActionController::TestCase
  setup do
    @denomination = denominations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:denominations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create denomination" do
    assert_difference('Denomination.count') do
      post :create, denomination: { name: @denomination.name }
    end

    assert_redirected_to denomination_path(assigns(:denomination))
  end

  test "should show denomination" do
    get :show, id: @denomination
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @denomination
    assert_response :success
  end

  test "should update denomination" do
    patch :update, id: @denomination, denomination: { name: @denomination.name }
    assert_redirected_to denomination_path(assigns(:denomination))
  end

  test "should destroy denomination" do
    assert_difference('Denomination.count', -1) do
      delete :destroy, id: @denomination
    end

    assert_redirected_to denominations_path
  end
end
