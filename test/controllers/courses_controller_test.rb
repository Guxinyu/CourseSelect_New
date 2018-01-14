require 'test_helper'

class CoursesControllerTest < ActionController::TestCase


  test "should get new" do
    get :new 
    assert_response :success
  end

  test "should get create" do
    @course = Course.all.first
    patch :create ,course: { id: 2,name: 'coursename1',open: true }
    assert_response :success
  end

  test "should get edit" do
    get :edit ,id: 2
    assert_response :success
  end


  test "should get update" do
    @course = Course.all.first
    patch :update ,id: @course,course: {id: 2,name: 'coursename1',open: true }
    assert_redirected_to courses_path
  end

test "should get destroy" do
  get :destroy ,id: 2
  assert_redirected_to courses_path
end

test "should open course" do
  get :open ,id: 2
  assert_redirected_to courses_path
end

test "should close course" do
  get :close ,id: 2
  assert_redirected_to courses_path
end


test "should studentlist" do
  get :studentlist ,id: 2
  assert_response :success
end


test "should list1" do
  get :list ,search: '123'
  assert_response :success
end
test "should list2" do
  get :list ,search: '123',status: "所有"
  assert_response :success
end
test "should list3" do
  get :list
  assert_response :success
end
test "should list4" do
  get :list ,status: "123"
  assert_response :success
end


test "should select" do
  get :select , id: 2
  assert_redirected_to courses_path
end

test "should coursedetails" do
  get :coursedetails ,id: 2
  assert_response :success
end

test "should quit" do
  get :quit , id: 2
  assert_redirected_to courses_path
end

  # test "should get edit" do
  #   get :edit, id: @course
  #   assert_response :success
  # end

  # test "should update course" do
  #   patch :update, id: @course, course: {  }
  #   assert_redirected_to course_path(assigns(:course))
  # end

  # test "should destroy course" do
  #   assert_difference('Course.count', -1) do
  #     delete :destroy, id: @course
  #   end

  #   assert_redirected_to courses_path
  # end

  
end
