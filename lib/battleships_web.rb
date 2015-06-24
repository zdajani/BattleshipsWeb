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

  post '/new_game' do

    $game.player_1.place_ship Ship.battleship, params[:battleshipcoords], params[:battleshipdir]

    $game.player_1.place_ship Ship.submarine, params[:subcoords], params[:subdir]
    # @board  = $game.own_board_view $game.player_1
    # # redirect '/player1_board'
    
    # @board2 = $game.opponent_board_view $game.player_2
    redirect '/player1_game'


  end

  get '/player1_game' do
    @board  = $game.own_board_view $game.player_1
    @board2 = $game.opponent_board_view $game.player_1
    erb :player1_game
  end

  get '/player1_game' do
    @board  = $game.own_board_view $game.player_1
    @board2 = $game.opponent_board_view $game.player_1
    $game.player_1.shoot params[:shootcoords]
    
  end




end
