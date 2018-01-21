require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  context 'Success' do
    
    context 'GET index' do
      it 'should show all categories successfully' do
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show category with given id successfully' do
        category = FactoryGirl.create(:category)
        get :show, id: category.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should create a valid category' do
        library = FactoryGirl.create(:library)
        post :create, category: {department:"Geology", library_id:library.id},format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should update a valid category' do
        category = FactoryGirl.create(:category)
        put :update, id:category.id, category: {department:"Botany"}, format: 'json'
        new_category = Category.last
        new_category.department.should eq "Botany"
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should destroy a valid category' do
        category = FactoryGirl.create(:category)
        delete :destroy, id:category.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context'Failure' do

    context 'GET show' do
      it 'should not show category with invalid id' do
        category = FactoryGirl.create(:category)
        new_category = Category.last
        get :show, id:new_category.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a category with nil entries' do
        post :create, category: {department: nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a category with invalid library id' do
        post :create, category: {library_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not update the category with invalid id' do
        category = FactoryGirl.create(:category)
        new_category = Category.last
        put :update, id:new_category.id+1, category: {department:"Biology"}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not update the category with invalid input' do
        category = FactoryGirl.create(:category)
        put :update, id:category.id, category: {department:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end 
      it 'should not update the category with invalid library id' do
        category = FactoryGirl.create(:category)
        library = FactoryGirl.create(:library)
        new_category = Library.last
        put :update, id:category.id, category: {department:"Geology", library_id:new_category.id+1}, format: 'json'
        response.should have_http_status(:not_found)
      end 
    end 
    context 'DELETE destroy' do
      it 'should not delete the category with invalid id' do
        category = FactoryGirl.create(:category)
        new_category = Category.last
        delete :destroy, id:new_category.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end