require 'rails_helper'

RSpec.describe 'Task', type: :request do
  let(:task) { create(:task) }
  let(:user) { task.user }
  before(:each) { sign_in user }

  context 'create' do
    let(:task) { build(:task) }

    it 'without name' do
      find_link('New Task').click
      within("#new_task") do
        fill_in 'task_name', with: nil
        click_button 'Create Task'
      end

      expect(page).to have_css('.alert-danger', text: I18n.t('simple_form.error_notification.default_message'))
    end

    it 'with image' do
      find_link('New Task').click
      within("#new_task") do
        fill_in 'task_name', with: task.name
        fill_in 'task_description', with: task.description
        attach_file 'task_file', attachment_path
        click_button 'Create Task'
      end
      expect(page).to have_css("img[src*='apples.png']")
    end

    it 'with file' do
      find_link('New Task').click
      within("#new_task") do
        fill_in 'task_name', with: task.name
        fill_in 'task_description', with: task.description
        attach_file 'task_file', attachment_path('test.txt')
        click_button 'Create Task'
      end
      expect(page).to have_css('a', text: 'Download')
    end

  end

  context 'create' do

    it 'destroy' do
      visit task_path(task)
      click_link 'Destroy'
      expect(page).to have_css('.alert', text: 'Tasks not found')
    end

    it 'edit' do
      visit edit_task_path(task)
      description = 'Update tast'
      within("#edit_task_#{task.id}") do
        fill_in 'Description', with: description
        click_button 'Update Task'
      end

      expect(page).to have_content(description)
    end
  end


  it 'change state' do

    find_link('start').click

    expect(page).to have_css('a', text: 'finish')

    find_link('finish').click

    expect(page).to have_css('span', text: 'finished')

  end

end
