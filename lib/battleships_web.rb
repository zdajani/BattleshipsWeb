require 'battleships'
require 'sinatra/base'

class BattleshipsWeb < Sinatra::Base
  enable :sessions
  set :views, proc { File.join(root, '..', 'views') }
  run! if app_file == $0

  get '/' do
    name = params[:name]
    # session[:session]= name
    erb :index
  end

  get '/new_game' do
    $game  = Game.new Player, Board
    @board = $game.own_board_view $game.player_1
    erb :new_game
  end

  post '/new_game' do

    ships_hash = {'battleship'          => Ship.battleship,
                  'submarine'           => Ship.submarine,
                  'cruiser'             => Ship.cruiser,
                  'aircraft_carrier'    => Ship.aircraft_carrier,
                  'destroyer'           => Ship.destroyer}
    begin
    $game.player_1.place_ship ships_hash[params[:shiptypes]], params[:coords], params[:orientation]
    rescue
    @error = "Invalid Coordinate Try Again!"
    end
    @board = $game.own_board_view $game.player_1

    erb :new_game
  end

  get '/player1_game' do
    @board  = $game.own_board_view $game.player_1
    @board2 = $game.opponent_board_view $game.player_1
    erb :player1_game
  end

  post '/player1_game' do
    begin
      coordinate = params[:coords]
      $game.player_1.shoot coordinate.to_sym
    rescue
      @error = "Invalid coordinate Try Again!"
    end

    @board  = $game.own_board_view $game.player_1
    @board2 = $game.opponent_board_view $game.player_1
    erb :player1_game
  end
end
