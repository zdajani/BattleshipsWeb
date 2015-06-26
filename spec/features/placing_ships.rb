require 'spec_helper'
require 'helpers'

feature 'placing ships on a board' do
  senario 'placing ships on a board' do
  in_browser(:one) do
    begin_game_player1
    select 'Battleship', from: 'shiptypes'
    select 'Horizontal', from: 'orientation'
    fill_in('coords', :with => 'A1')
    click_on 'Place Ship'
  end
end
