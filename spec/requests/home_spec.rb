require 'rails_helper'

RSpec.describe 'home page', type: :request do
  describe 'GET /' do
    it 'have header' do
      visit root_path
      expect(page).to have_css('#header a', text: 'Task manager')
    end
  end
end