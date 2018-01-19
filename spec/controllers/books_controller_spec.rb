require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  context 'Success' do
    
    context 'GET index' do
      it 'should show all books successfully' do
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show book with given id successfully' do
        book = FactoryGirl.create(:book)
        get :show, id: book.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should create a valid book' do
        book = FactoryGirl.build(:book)
        post :create, book: {name: book.name, library_id:book.library_id, category_id:book.category_id, member_id:book.member_id},format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should update a valid book' do
        book = FactoryGirl.create(:book)
        put :update, id:book.id, book: {name: "abc", library_id:book.library_id}, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should destroy a valid book' do
        book = FactoryGirl.create(:book)
        delete :destroy, id:book.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context'Failure' do

    context 'GET show' do
      it 'should not show book with invalid id' do
        book = FactoryGirl.create(:book)
        a = Book.last
        get :show, id:a.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a book with nil entries' do
        book = FactoryGirl.build(:book)
        post :create, book: {name: nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a book with invalid library id' do
        book = FactoryGirl.build(:book)
        post :create, book: {library_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a book with invalid category id' do
        book = FactoryGirl.build(:book)
        post :create, book: {category_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a book with invalid member id' do
        book = FactoryGirl.build(:book)
        post :create, book: {member_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not update the book with invalid id' do
        book = FactoryGirl.create(:book)
        a = Book.last
        put :update, id:a.id+1, book: {name: "abc"}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not update the book with invalid input' do
        book = FactoryGirl.create(:book)
        put :update, id:book.id, book: {name:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end 
      it 'should not update the book with invalid library id' do
        book = FactoryGirl.create(:book)
        library = FactoryGirl.create(:library, phone_no:"6667777799")
        a = Library.last
        put :update, id:book.id, book: {name: "abc", library_id:a.id+1}, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not update the book with invalid category id' do
        book = FactoryGirl.create(:book)
        category = FactoryGirl.create(:category)
        a = Category.last
        put :update, id:book.id, book: {name: "abc", category_id:a.id+1}, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not update the book with invalid member id' do
        book = FactoryGirl.create(:book)
        member = FactoryGirl.create(:member, phone_no:"6667777799")
        a = Member.last
        put :update, id:book.id, book: {name: "abc", member_id:a.id+1}, format: 'json'
        response.should have_http_status(:not_found)
      end
    end 
    context 'DELETE destroy' do
      it 'should not delete the book with invalid id' do
        book = FactoryGirl.create(:book)
        a = Book.last
        delete :destroy, id:a.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end