def in_browser(name)
  old_session = Capybara.session_name

  Capybara.session_name = name
  yield

  Capybara.session_name = old_session
end

def begin_game_player1
  visit '/'
  fill_in('name', with: 'Zeina')
  click_on 'Begin Game'
  expect(current_path).to eq('/new_game')
end

def begin_game_player2
  visit '/'
  fill_in('name', with: 'Player2')
  click_on 'Begin Game'
  expect(current_path).to eq('/new_game')
end
