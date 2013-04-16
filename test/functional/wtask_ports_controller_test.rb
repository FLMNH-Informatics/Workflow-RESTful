require 'test_helper'

class WtaskPortsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => WtaskPort.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    WtaskPort.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    WtaskPort.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to wtask_port_url(assigns(:wtask_port))
  end

  def test_edit
    get :edit, :id => WtaskPort.first
    assert_template 'edit'
  end

  def test_update_invalid
    WtaskPort.any_instance.stubs(:valid?).returns(false)
    put :update, :id => WtaskPort.first
    assert_template 'edit'
  end

  def test_update_valid
    WtaskPort.any_instance.stubs(:valid?).returns(true)
    put :update, :id => WtaskPort.first
    assert_redirected_to wtask_port_url(assigns(:wtask_port))
  end

  def test_destroy
    wtask_port = WtaskPort.first
    delete :destroy, :id => wtask_port
    assert_redirected_to wtask_ports_url
    assert !WtaskPort.exists?(wtask_port.id)
  end
end
