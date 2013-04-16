require 'test_helper'

class WexecParasControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => WexecPara.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    WexecPara.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    WexecPara.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to wexec_para_url(assigns(:wexec_para))
  end

  def test_edit
    get :edit, :id => WexecPara.first
    assert_template 'edit'
  end

  def test_update_invalid
    WexecPara.any_instance.stubs(:valid?).returns(false)
    put :update, :id => WexecPara.first
    assert_template 'edit'
  end

  def test_update_valid
    WexecPara.any_instance.stubs(:valid?).returns(true)
    put :update, :id => WexecPara.first
    assert_redirected_to wexec_para_url(assigns(:wexec_para))
  end

  def test_destroy
    wexec_para = WexecPara.first
    delete :destroy, :id => wexec_para
    assert_redirected_to wexec_paras_url
    assert !WexecPara.exists?(wexec_para.id)
  end
end
