require 'rails_helper'

RSpec.describe LibrariesController, type: :controller do
  context 'Success' do
    
    context 'GET index' do
      it 'should show all libraries successfully' do
        library1 = FactoryGirl.create(:library, phone_no:"545665332234")
        library2 = FactoryGirl.create(:library, phone_no:"545665332234")
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show library with given id successfully' do
        library = FactoryGirl.create(:library, phone_no:"545665332234")
        get :show, id: library.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should create a valid library' do
        library = FactoryGirl.build(:library, phone_no:"44556677888")
        post :create, library: {name: library.name,address: library.address,phone_no: library.phone_no},format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should update a valid library' do
        library = FactoryGirl.create(:library, phone_no:"44556677888")
        put :update, id:library.id, library: {name: "abc", address:library.address, phone_no:library.phone_no}, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should destroy a valid library' do
        library = FactoryGirl.create(:library, phone_no:"44556677888")
        delete :destroy, id:library.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context'Failure' do

    context 'GET show' do
      it 'should not show library with given id' do
        library = FactoryGirl.create(:library, phone_no:"44556677888")
        a = Library.last
        get :show, id:a.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a library with invalid input' do
        library = FactoryGirl.build(:library, phone_no:"44556677888")
        post :create, library: {name: library.name,address: library.address,phone_no:"1346"},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a library with nil entries' do
        library = FactoryGirl.build(:library, phone_no:"44556677888")
        post :create, library: {name: nil,address: library.address,phone_no:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not update the library with invalid id' do
        library = FactoryGirl.create(:library, phone_no:"44556677888")
        a = Library.last
        put :update, id:a.id+1, library: {name: "abc", address:library.address, phone_no:library.phone_no}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not update the library with invalid input' do
        library = FactoryGirl.create(:library, phone_no:"44556677888")
        put :update, id:library.id, library: {name: "abc", address:library.address, phone_no:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end 
    end 
    context 'DELETE destroy' do
      it 'should not delete the library with invalid id' do
        library = FactoryGirl.create(:library, phone_no:"44556677888")
        a = Library.last
        delete :destroy, id:a.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end