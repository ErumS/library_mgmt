require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  context 'Success' do
    
    context 'GET index' do
      it 'should show all members successfully' do
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show member with given id successfully' do
        member = FactoryGirl.create(:member)
        get :show, id: member.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should create a valid member' do
        library = FactoryGirl.create(:library)
        post :create, member: {name: "Raahi", phone_no:"5677889890", library_id:library.id},format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should update a valid member' do
        member = FactoryGirl.create(:member)
        put :update, id:member.id, member: {name: "abc", phone_no:"5556667778", library_id:member.library_id}, format: 'json'
        new_member = Member.last
        new_member.name.should eq "abc"
        new_member.phone_no.should eq "5556667778"
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should destroy a valid member' do
        member = FactoryGirl.create(:member)
        delete :destroy, id:member.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context'Failure' do

    context 'GET show' do
      it 'should not show member with invalid id' do
        member = FactoryGirl.create(:member)
        new_member = Member.last
        get :show, id:new_member.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a member with invalid input' do
        post :create, member: { phone_no:"1323"},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a member with nil entries' do
        post :create, member: {name: nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a member with invalid library id' do
        post :create, member: {library_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not update the member with invalid id' do
        member = FactoryGirl.create(:member)
        new_member = Member.last
        put :update, id:new_member.id+1, member: {name: "abc"}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not update the member with invalid input' do
        member = FactoryGirl.create(:member)
        put :update, id:member.id, member: {name: "abc", phone_no:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end 
      it 'should not update the member with invalid library id' do
        member = FactoryGirl.create(:member)
        library = FactoryGirl.create(:library)
        new_library = Library.last
        put :update, id:member.id, member: {name: "abc", library_id:new_library.id+1}, format: 'json'
        response.should have_http_status(:not_found)
      end 
    end 
    context 'DELETE destroy' do
      it 'should not delete the member with invalid id' do
        member = FactoryGirl.create(:member)
        new_member = Member.last
        delete :destroy, id:new_member.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end