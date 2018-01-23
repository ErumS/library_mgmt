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
        library = FactoryGirl.create(:library)
        category = FactoryGirl.create(:category)
        member = FactoryGirl.create(:member)
        post :create, book: {name: Faker::Book.title, library_id:library.id, category_id:category.id, member_id:member.id},format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should update a valid book' do
        book = FactoryGirl.create(:book)
        put :update, id:book.id, book: {name: "abc", library_id:book.library_id}, format: 'json'
        new_book = Book.last
        new_book.name.should eq "abc"
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
        new_book = Book.last
        get :show, id:new_book.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a book with nil entries' do
        post :create, book: {name: nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a book with invalid library id' do
        post :create, book: {library_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a book with invalid category id' do
        post :create, book: {category_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a book with invalid member id' do
        post :create, book: {member_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not update the book with invalid id' do
        book = FactoryGirl.create(:book)
        new_book = Book.last
        put :update, id:new_book.id+1, book: {name: "abc"}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not update the book with invalid input' do
        book = FactoryGirl.create(:book)
        put :update, id:book.id, book: {name:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end 
      it 'should not update the book with invalid library id' do
        book = FactoryGirl.create(:book)
        library = FactoryGirl.create(:library)
        new_library = Library.last
        put :update, id:book.id, book: {name: "abc", library_id:new_library.id+1}, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not update the book with invalid category id' do
        book = FactoryGirl.create(:book)
        category = FactoryGirl.create(:category)
        new_category = Category.last
        put :update, id:book.id, book: {name: "abc", category_id:new_category.id+1}, format: 'json'
        response.should have_http_status(:not_found)
      end
      it 'should not update the book with invalid member id' do
        book = FactoryGirl.create(:book)
        member = FactoryGirl.create(:member)
        new_member = Member.last
        put :update, id:book.id, book: {name: "abc", member_id:new_member.id+1}, format: 'json'
        response.should have_http_status(:not_found)
      end
    end 
    context 'DELETE destroy' do
      it 'should not delete the book with invalid id' do
        book = FactoryGirl.create(:book)
        new_book = Book.last
        delete :destroy, id:new_book.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end