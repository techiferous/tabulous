require 'test_helper'

class GalaxiesControllerTest < ActionController::TestCase
  setup do
    @galaxy = galaxies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:galaxies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create galaxy" do
    assert_difference('Galaxy.count') do
      post :create, :galaxy => @galaxy.attributes
    end

    assert_redirected_to galaxy_path(assigns(:galaxy))
  end

  test "should show galaxy" do
    get :show, :id => @galaxy.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @galaxy.to_param
    assert_response :success
  end

  test "should update galaxy" do
    put :update, :id => @galaxy.to_param, :galaxy => @galaxy.attributes
    assert_redirected_to galaxy_path(assigns(:galaxy))
  end

  test "should destroy galaxy" do
    assert_difference('Galaxy.count', -1) do
      delete :destroy, :id => @galaxy.to_param
    end

    assert_redirected_to galaxies_path
  end
end
