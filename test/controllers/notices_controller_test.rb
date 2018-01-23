require 'test_helper'

class NoticesControllerTest < ActionController::TestCase
  
  # test example
  test "NoticesControllerTest example" do
    assert true
    assert_raises(NameError) do
       indexevaluations
    end
  end
  
  test "should PATCH new" do
    patch :new ,notice: { id: 2,theme: 'ceshi1',course_id: 2}
  end
  test "should PATCH create" do
    patch :create ,notice: { id: 2,theme: 'ceshi1',course_id: 2,save: true }
    assert_response :success
  end

  test "should PATCH create save false" do
    patch :create ,notice: { id: 2,theme: 'ceshi1',course_id: 2,save: false }
    assert_response :success
  end

  test "should get edit" do
    get :edit ,id: 2
    assert_response :success
  end

  test "should get update" do
    get :update ,id: 2,notice: { id: 2,theme: 'ceshi1',course_id: 2}
    assert_redirected_to notices_path, flash: flash
  end

  test "should get destory" do
    get :destroy ,id: 2
    assert_redirected_to notices_path
  end

  test "should get check" do
    get :check ,id: 1
    assert_response :success
  end

  test "should get index " do
     get :index,q:"计",teacher_logged_in:true
      assert_response :success
  end

  test "should get index null value" do
     get :index,q:""
     assert_response 302
  end
 

end
