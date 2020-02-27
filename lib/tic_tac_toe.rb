WIN_COMBINATIONS = [
  [0, 1, 2], #WC[0]
  [3, 4, 5], #WC[1]
  [6, 7, 8], #WC[2]

  [0, 3, 6], #WC[3]
  [1, 4, 7], #WC[4]
  [2, 5, 8], #WC[5]

  [0, 4, 8], #WC[6]
  [6, 4, 2]  #WC[7]
]
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end #ends method
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end #ends method
def input_to_index(user_input)
  user_input.to_i - 1
end #end method
def valid_move?(board, index)
  if (position_taken?(board, index))
    return false
  else
    if (index > 8 || index < 0)
      return false
    else
      return true
    end #Ends check to see if index is on the board
  end #ends check to see if position_taken
end #ends methods
def move(board, input, player)
  board[input] = player
end #ends method
def turn(board)
  puts "Please enter 1-9: "
  index = gets.strip
  index = input_to_index(index)
  if (valid_move?(board, index))
    move(board, index, current_player(board))
  else
    puts "Invalid move!"
    turn(board)
  end #ends check to see if valid move
end #ends method
def won?(board)
  WIN_COMBINATIONS
  count = 0
  xCount = 0
  oCount = 0
  current_array = []
  until count >= 8
    winTest = WIN_COMBINATIONS[count]
    winTest.each do | space |
      current_array << board[space]
    end #ends the each loop, makes a new array of what was in the winning spots
    allX = current_array.all? do |character|
      character == "X"
    end #ends looking for X
    allO = current_array.all? do |character|
      character == "O"
    end #ends looking for O
    if (allX || allO)
      return winTest
    else
      current_array = []
      count += 1
    end # ends win or continue
  end # ends the until loop
  return nil
end #ends method
def full?(board)
  full = board.all? do |space|
    (space == "X" || space == "O")
  end #ends full check loop
  return full
end #ends method
def draw?(board)
  if (full?(board))
    if (won?(board))
      return false
    else
      return true
    end #ends to check if game was won
  else
    return false
  end #ends to see if board is full
end #ends method

def turn_count(board)
  turns = 0
  board.each do |spot|
    if (spot == "X" || spot == "O")
    turns += 1
    end #ends counting filled spots
  end
  return turns
end #ends method

def current_player(board)
  if (turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end #ends determining X or O
end #ends method
def over?(board)
  if (draw?(board) || won?(board))
    return true
  else
    return false
  end #ends seeing if won or draw
end #ends method

def winner(board)
  winning_array = won?(board)
  if winning_array == nil
    return nil
  end #ends checking winning array
  space = winning_array[0]
  return board[space]
end #ends method

def play(board)
  until (over?(board))
    turn(board)
  end #ends loop
  if (draw?(board))
    puts "Cat's Game!"
  elsif (won?(board))
    puts "Congratulations #{winner(board)}!"
  end #ends checking how game is won
end #ends method
