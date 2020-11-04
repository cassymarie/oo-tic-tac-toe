require 'pry'

class TicTacToe
attr_accessor :board
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
   
  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end

  def display_board
    puts "-----------"
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "---|---|---"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "---|---|---"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "    
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(location,player_icon)
    if @board[location] == " "
        @board[location] = player_icon.strip
    end
  end

  def position_taken?(location_index)
    @board[location_index] != " "
  end

  def valid_move?(location_index)
    @board[location_index] == " " && location_index.between?(0,8)
  end

  def turn_count
    count = 0
    @board.each{|position|count += 1 if position != " " }
    count
  end  

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Please select position 1-9"
    turn_choice = input_to_index(gets.chomp)

    until valid_move?(turn_choice)do
        puts "Invalid choice, choose again"
        turn_choice = input_to_index(gets.chomp)
    end

    move(turn_choice,current_player)
    display_board
  end

  def won?
    did_ya_win = false
    winning_combo = []

    WIN_COMBINATIONS.collect do |win_combo|
      verify_combo = []
      win_combo.collect {|idx|verify_combo << @board[idx]}

      if verify_combo.all?{|ele| ele == "X"} || verify_combo.all?{|ele| ele == "O"}
        did_ya_win = true 
        winning_combo = win_combo
      end
    end

    did_ya_win ? winning_combo : false
  end

  def full?
    turn_count == 9 && !won? ? true : false
  end

  def draw?
    turn_count == 9 && !won? ? true : false
  end

  def over?
    draw? || won? ? true : false
  end
    
  def winner
    @board[won?[0]] if won? != false 
  end

  def play

    until over? do
      turn
      display_board
    end

    puts "Cat's Game!" if draw?
    puts "Congratulations #{winner}!" if won?

  end
  
end

game = TicTacToe.new

# binding.pry

game2 = TicTacToe.new
