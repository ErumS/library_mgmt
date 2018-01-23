require 'rails_helper'

RSpec.describe IssueHistoriesController, type: :controller do
  context 'Success' do
    
    context 'GET index' do
      it 'should show all issue_histories successfully' do
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show issue_history with given id successfully' do
        issue_history = FactoryGirl.create(:issue_history)
        get :show, id: issue_history.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should create a valid issue_history' do
        member = FactoryGirl.create(:member)
        post :create, issue_history: {return_date: Faker::Date.between(9.days.ago, Date.today), issue_date: Faker::Date.between(19.days.ago, Date.today), copies:Faker::Number.between(1,3), member_id:member.id }, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should update a valid issue_history' do
        issue_history = FactoryGirl.create(:issue_history)
        put :update, id:issue_history.id, issue_history: {return_date:issue_history.return_date, copies:1, issue_date:issue_history.issue_date}, format: 'json'
        new_issue_history = IssueHistory.last
        new_issue_history.copies.should eq 1
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should destroy a valid issue_history' do
        issue_history = FactoryGirl.create(:issue_history)
        delete :destroy, id:issue_history.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context'Failure' do

    context 'GET show' do
      it 'should not show a valid issue_history' do
        issue_history = FactoryGirl.create(:issue_history)
        new_issue_history = IssueHistory.last
        get :show, id:new_issue_history.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a issue_history with invalid input' do
        post :create, issue_history: {issue_date:"abc"},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a issue_history with nil entries' do
        post :create, issue_history: {return_date:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a issue_history with nil entries' do
        post :create, issue_history: {issue_date:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a issue_history with invalid member_id' do
        post :create, issue_history: {member_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not update the issue_history with invalid id' do
        issue_history = FactoryGirl.create(:issue_history)
        new_issue_history = IssueHistory.last
        put :update, id:new_issue_history.id+1, issue_history: {return_date:issue_history.return_date, issue_date:issue_history.issue_date}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not update the issue_history with invalid input' do
        issue_history = FactoryGirl.create(:issue_history)
        put :update, id:issue_history.id, issue_history: {return_date:issue_history.return_date, issue_date:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end 
      it 'should not update the issue_history with invalid member id' do
        issue_history = FactoryGirl.create(:issue_history)
        new_issue_history = IssueHistory.last
        member = FactoryGirl.create(:member, phone_no:"6566666788")
        new_member = Member.last
        put :update, id:new_issue_history.id+1, issue_history: {return_date:issue_history.return_date, issue_date:issue_history.issue_date, member_id:new_member.id+1}, format: 'json'
        response.should have_http_status(:not_found)
      end
    end 
    context 'DELETE destroy' do
      it 'should not destroy the issue_history with invalid id' do
        issue_history = FactoryGirl.create(:issue_history)
        new_issue_history = IssueHistory.last
        delete :destroy, id:new_issue_history.id+1, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end