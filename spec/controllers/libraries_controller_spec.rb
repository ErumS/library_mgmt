require 'rails_helper'

RSpec.describe LibrariesController, type: :controller do
  context 'Success' do
    
    context 'GET index' do
      it 'should show all libraries successfully' do
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show library with given id successfully' do
        library = FactoryGirl.create(:library)
        get :show, id: library.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should create a valid library' do
        post :create, library: {name: "High school",address: "Canada",phone_no: "76565474574"},format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should update a valid library' do
        library = FactoryGirl.create(:library)
        put :update, id:library.id, library: {name: "abc", address:library.address, phone_no:library.phone_no}, format: 'json'
        new_library = Library.last
        new_library.name.should eq "abc"
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should destroy a valid library' do
        library = FactoryGirl.create(:library)
        delete :destroy, id:library.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context'Failure' do

    context 'GET show' do
      it 'should not show library with given id' do
        library = FactoryGirl.create(:library)
        new_library = Library.last
        get :show, id:new_library.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a library with invalid input' do
        post :create, library: {name: "Peak",address: "UK",phone_no:"1346"},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a library with nil entries' do
        post :create, library: {name: nil,phone_no: nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not update the library with invalid id' do
        library = FactoryGirl.create(:library)
        new_library = Library.last
        put :update, id:new_library.id+1, library: {name: "abc", address:library.address, phone_no:library.phone_no}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not update the library with invalid input' do
        library = FactoryGirl.create(:library)
        put :update, id:library.id, library: {name: "abc", address:library.address, phone_no:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end 
    end 
    context 'DELETE destroy' do
      it 'should not delete the library with invalid id' do
        library = FactoryGirl.create(:library)
        new_library = Library.last
        delete :destroy, id:new_library.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end