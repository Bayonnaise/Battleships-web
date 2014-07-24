require 'sinatra/base'
require_relative 'player'
require_relative 'board'
require_relative 'cell'
require_relative 'coordinates'
require_relative 'ship'
require_relative 'water'
require_relative 'game'

class Battleships < Sinatra::Base
	enable :sessions
  set :views, Proc.new { File.join(root, '/../', "views") }
	set :public_dir, Proc.new { File.join(root, '/../', "public") }
	set :session_secret, "something"

  GAME = Game.new

  get '/' do
  	erb :index
  end

  get '/name' do
  	erb :name
  end

  post '/name' do
    redirect '/name' if params[:name] == ""
    session[:player1] = params[:name]
    GAME.add(Player.new(name: params[:name], board: Board.new(content: Water.new)))
    redirect '/waiting'
  end

  get '/waiting' do
    if GAME.start?
      redirect '/place_ships'
    else
      erb :waiting
    end
  end

  get '/place_ships' do
    erb :place_ships
  end

  post '/place_ships' do
    @player = GAME.return_player(session[:player1])
    @opponent = GAME.return_opponent(session[:player1])

    if params[:direction] == 'horizontal'
      coords = Coordinates.new(@player.board.get_horizontal_coords(@player.ships_to_deploy.last, params[:coord]))
    else
      coords = Coordinates.new(@player.board.get_vertical_coords(@player.ships_to_deploy.last, params[:coord]))
    end
      
    if !coords.valid? || coords.locations.any?{|location| @player.board.grid[location].part_of_ship_here? }
      redirect '/place_ships'
    else
      ship = @player.ships_to_deploy.pop
      @player.board.place(ship, coords)
    end

    if @player.ships_to_deploy.count == 0
      redirect '/play_game'
    else
      erb :place_ships
    end
  end

  get '/play_game' do
    erb :play_game
  end

  post '/fire' do
    redirect '/play_game' if params[:coord] == ""
    @player = GAME.return_player(session[:player1])
    @opponent = GAME.return_opponent(session[:player1])

    coords = Coordinates.new([params[:coord]])
      
    if !coords.valid?
      redirect '/play_game'
    else
      @player.shoot_at(@opponent.board, params[:coord])
    end

    redirect '/game_over' if !GAME.has_ships_floating?(@player) || !GAME.has_ships_floating?(@opponent)
    erb :play_game
  end

  get '/game_over' do
    erb :game_over
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
