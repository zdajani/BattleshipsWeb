require 'battleships'
require 'sinatra/base'

class BattleshipsWeb < Sinatra::Base
  enable :sessions
  set :views, proc { File.join(root, '..', 'views') }
  run! if app_file == $0

  PLAYERS = ['player_2', 'player_1']

  get '/' do
    name = params[:name]
    erb :index
  end


  post '/new_game' do
      $game ||= Game.new Player, Board
       assign_player unless PLAYERS.empty?


    # $game  ||= Game.new Player, Board

    @board = $game.own_board_view $game.send(session[:player])
    erb :new_game
  end

  post '/placing_ships' do

    ships_hash = {'battleship'          => Ship.battleship,
                  'submarine'           => Ship.submarine,
                  'cruiser'             => Ship.cruiser,
                  'aircraft_carrier'    => Ship.aircraft_carrier,
                  'destroyer'           => Ship.destroyer}
    begin
    $game.send(session[:player]).place_ship ships_hash[params[:shiptypes]], params[:coords], params[:orientation]
    rescue
    @error = "Invalid Coordinate Try Again!"
    end
    @board = $game.own_board_view $game.send(session[:player])

    erb :new_game
  end

  get '/stage_two' do
    @board  = $game.own_board_view $game.send(session[:player])
    @board2 = $game.opponent_board_view $game.send(session[:player])
    erb :player1_game
  end

  post '/shooting' do
      begin
        coordinate = params[:coords]
        @shoot_target = $game.send(session[:player]).shoot coordinate.to_sym
      rescue
      @error = "Invalid coordinate Try Again!"
      end

      @board  = $game.own_board_view $game.send(session[:player])
      @board2 = $game.opponent_board_view $game.send(session[:player])

      if !$game.has_winner?
        erb :player1_game
      else
        erb :winner
      end
  
  end

  get '/winner' do
    erb :winner
  end

  helpers do
    def assign_player
      session[:player] = PLAYERS.pop
    end
  end
end
