require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create :user }
  let(:tasks) { create_list :task, 5, user: user }
  before { sign_in(user)}

  describe 'GET #new' do

    it 'new task' do
      get :new
      expect(assigns(:task)).to be_a_new Task
      expect(response).to render_template :new
    end

  end

  describe 'GET #index' do

    it 'user tasks' do
      get :index
      expect(assigns(:tasks)).to match_array(tasks)
      expect(response).to render_template :index
    end

  end

  describe 'POST #create' do

    context 'with valid attributes' do
      let(:subject) {post :create, params: {task: attributes_for(:task)}}

      it 'save the task' do
        expect { subject}.to change(Task, :count).by(1)
        expect(subject).to redirect_to(action: :show, id: assigns(:task))
      end

    end

    context 'with invalid attributes' do

      it 'does not save the task' do
        expect { post :create, params: {task: {name: nil, user_id: nil}} }.to_not change(Task, :count)
        expect(assigns(:task).errors).to_not be_empty
      end

    end

  end

  describe 'DELETE #destroy' do
    let(:user2) { create :user }
    let(:task1) { create :task, user: user }
    let(:task2) { create :task, user: user2 }


    it 'task other user' do
      expect{ delete :destroy, params: {id: task2} }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'delete user task' do
      expect { delete :destroy, params: {id: task1} }.to change(Task, :count).by(0)
      expect(response).to be_redirect
    end

  end


  describe 'PATCH #update' do
    let(:user2) { create :user }
    let(:task1) { create :task, user: user }
    let(:task2) { create :task, user: user2 }

    it 'task other user' do
      expect{ patch :update,params: {id: task2, task: {name: '1'} } }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'update task' do
      patch :update,params: {id: task1, task: {name: '1', description: '2'} }
      task1.reload
      expect(task1.name).to eq '1'
      expect(task1.description).to eq '2'
    end

    it 'update task with invalid params' do
      patch :update,params: {id: task1, task: {name: '', user_id: ''} }
      expect(assigns(:task).errors).to_not be_empty
      expect(response).to render_template :edit
    end

  end

  describe 'PUT #start' do
    let(:task) { create :task, user: user }

    it 'start' do
      put :start, params: {id: task}
      task.reload
      expect(task.state).to eq 'started'
      expect(response).to be_redirect
    end
  end

  describe 'PUT #finish' do
    let(:task) { create :task, state: :started, user: user }

    it 'finish' do
      put :finish, params: {id: task}
      task.reload
      expect(task.state).to eq 'finished'
      expect(response).to be_redirect
    end

  end

end
