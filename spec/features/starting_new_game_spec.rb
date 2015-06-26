require 'spec_helper'
require 'helpers'

feature 'Starting a new game' do
  scenario 'asks user for their name' do
    visit '/'
    expect(page).to have_content 'Welcome to Battleship!'
    expect(page).to have_content 'What is your name?'
  end

  scenario 'setting a name to a player and the place ship form' do
    in_browser(:one) do
      visit '/'
      fill_in('name', with: 'Zeina')
      click_on 'Begin Game'
      expect(current_path).to eq('/new_game')
    end
    
    in_browser(:one) do
      expect(page).to have_selector '.board'
      expect(page).to have_select 'shiptypes'
      expect(page).to have_select 'orientation'
      expect(page).to have_field 'coords'
      expect(page).to have_button "Place Ship"
      expect(page).to have_button "Stage Two"
    end
  end
end
