require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  context 'Success' do
    
    context 'GET index' do
      it 'should show all members successfully' do
        member1 = FactoryGirl.create(:member, phone_no:"746574658745")
        member2 = FactoryGirl.create(:member, phone_no:"746574658745")
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show member with given id successfully' do
        member = FactoryGirl.create(:member, phone_no:"746574658745")
        get :show, id: member.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should create a valid member' do
        member = FactoryGirl.build(:member, phone_no:"746574658745")
        post :create, member: {name: member.name, phone_no:member.phone_no, library_id:member.library_id},format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should update a valid member' do
        member = FactoryGirl.create(:member, phone_no:"746574658745")
        put :update, id:member.id, member: {name: "abc", phone_no:"746574658745", library_id:member.library_id}, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should destroy a valid member' do
        member = FactoryGirl.create(:member, phone_no:"746574658745")
        delete :destroy, id:member.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context'Failure' do

    context 'GET show' do
      it 'should not show member with invalid id' do
        member = FactoryGirl.create(:member, phone_no:"746574658745")
        a = Member.last
        get :show, id:a.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a member with invalid input' do
        member = FactoryGirl.build(:member, phone_no:"746574658745")
        post :create, member: {name: member.name, phone_no:"1323"},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a member with nil entries' do
        member = FactoryGirl.build(:member, phone_no:"746574658745")
        post :create, member: {name: nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a member with invalid library id' do
        member = FactoryGirl.build(:member, phone_no:"746574658745")
        post :create, member: {library_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not update the member with invalid id' do
        member = FactoryGirl.create(:member, phone_no:"746574658745")
        a = Member.last
        put :update, id:a.id+1, member: {name: "abc"}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not update the member with invalid input' do
        member = FactoryGirl.create(:member, phone_no:"746574658745")
        put :update, id:member.id, member: {name: "abc", phone_no:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end 
      it 'should not update the member with invalid library id' do
        member = FactoryGirl.create(:member, phone_no:"746574658745")
        library = FactoryGirl.create(:library, phone_no:"6667777799")
        a = Library.last
        put :update, id:member.id, member: {name: "abc", library_id:a.id+1}, format: 'json'
        response.should have_http_status(:not_found)
      end 
    end 
    context 'DELETE destroy' do
      it 'should not delete the member with invalid id' do
        member = FactoryGirl.create(:member)
        a = Member.last
        delete :destroy, id:a.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end