require 'test_helper'

class WexecsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Wexec.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Wexec.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Wexec.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to wexec_url(assigns(:wexec))
  end

  def test_edit
    get :edit, :id => Wexec.first
    assert_template 'edit'
  end

  def test_update_invalid
    Wexec.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Wexec.first
    assert_template 'edit'
  end

  def test_update_valid
    Wexec.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Wexec.first
    assert_redirected_to wexec_url(assigns(:wexec))
  end

  def test_destroy
    wexec = Wexec.first
    delete :destroy, :id => wexec
    assert_redirected_to wexecs_url
    assert !Wexec.exists?(wexec.id)
  end
end
