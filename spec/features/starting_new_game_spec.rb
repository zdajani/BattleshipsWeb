require 'spec_helper'

feature 'Starting a new game' do
  scenario 'setting up ships on a board' do
    visit '/new_game'
    expect(page).to have_selector('board')
  end
end
