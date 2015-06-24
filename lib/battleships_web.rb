require 'battleships'
require 'sinatra/base'

class BattleshipsWeb < Sinatra::Base

  set :views, proc { File.join(root, '..', 'views') }
  run! if app_file == $0
  
  get '/' do
    'Hello BattleshipsWeb!'
  end

  get '/new_game' do 
    $game  = Game.new Player, Board

    @board = $game.own_board_view $game.player_1

    erb :new_game
  end

end
