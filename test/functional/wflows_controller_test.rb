require 'test_helper'

class WflowsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Wflow.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Wflow.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Wflow.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to wflow_url(assigns(:wflow))
  end

  def test_edit
    get :edit, :id => Wflow.first
    assert_template 'edit'
  end

  def test_update_invalid
    Wflow.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Wflow.first
    assert_template 'edit'
  end

  def test_update_valid
    Wflow.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Wflow.first
    assert_redirected_to wflow_url(assigns(:wflow))
  end

  def test_destroy
    wflow = Wflow.first
    delete :destroy, :id => wflow
    assert_redirected_to wflows_url
    assert !Wflow.exists?(wflow.id)
  end
end
