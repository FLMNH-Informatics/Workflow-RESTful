require 'test_helper'

class WtasksControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Wtask.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Wtask.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Wtask.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to wtask_url(assigns(:wtask))
  end

  def test_edit
    get :edit, :id => Wtask.first
    assert_template 'edit'
  end

  def test_update_invalid
    Wtask.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Wtask.first
    assert_template 'edit'
  end

  def test_update_valid
    Wtask.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Wtask.first
    assert_redirected_to wtask_url(assigns(:wtask))
  end

  def test_destroy
    wtask = Wtask.first
    delete :destroy, :id => wtask
    assert_redirected_to wtasks_url
    assert !Wtask.exists?(wtask.id)
  end
end
