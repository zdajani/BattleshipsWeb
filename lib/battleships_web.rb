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

    @board = $game.own_board_view $game.send(session[:player])

    erb :new_game
  end

  post '/placing_ships' do
    begin
      $game.send(session[:player]).place_ship Ship.send(params[:shiptypes]), params[:coords], params[:orientation]
    rescue RuntimeError => @error

    end

    @board = $game.own_board_view $game.send(session[:player])
    erb :new_game
  end

  get '/stage_two' do
    @board  = $game.own_board_view $game.send(session[:player])
    @board2 = $game.opponent_board_view $game.send(session[:player])
    erb :stage_two
  end

  post '/shooting' do
    begin
      coordinate = params[:coords]
      @shoot_target = $game.send(session[:player]).shoot coordinate.to_sym
    rescue RuntimeError => @error
      
    end

    @board  = $game.own_board_view $game.send(session[:player])
    @board2 = $game.opponent_board_view $game.send(session[:player])

    if $game.has_winner?
      erb :winner
    else
      erb :stage_two
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
