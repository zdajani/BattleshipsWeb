require 'spec_helper'

feature 'Starting a new game' do
  scenario 'setting up ships on a board' do
    
    visit '/new_game'
    
    expect(page).to have_selector '.board'
    
    expect(page).to have_content 'submarine'
    expect(page).to have_content 'coords'
    expect(page).to have_content 'direction'
    fill_in('coords', :with => 'A1')
    fill_in('direction', :with => 'Hortizonal')
    click_on 'Place Ship'

  end
  
end
