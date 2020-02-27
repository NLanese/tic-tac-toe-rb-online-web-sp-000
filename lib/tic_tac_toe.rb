def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end


def valid_move?(board, index)
  if (position_taken)
    return false
  else
    if (index > 8 || index < 0)
      return false
    else
      return true
    end
  end
end

def move(board, input, player)
  board[input] = player
end

def turn(board, turn_count)
  puts "Please enter 1-9: "
  index = gets.strip
  index = input_to_index(index)
  if (valid_move?(board, index))
    if (turn_count % 2 == 0)
      player = "X"
    else
      player = "O"
    end
    move(board, index, player)
  else
    puts "Invalid move!"
    turn(board)
  end
end

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
end


def full?(board)
  full = board.all? do |space|
    (space == "X" || space == "O")
  end
  return full
end

def draw?(board)
  if (full?(board))
    if (won?(board))
      return false
    else
      return true
    end
  else
    return false
  end
end

def over?(board)
  if (draw?(board) || won?(board))
    return true
  else
    return false
  end
end


def winner(board)
  winning_array = won?(board)
  if winning_array == nil
    return nil
  end
  space = winning_array[0]
  return board[space]
end

def play(board)
  until (over?(board))
    turn_count = 0
    turn(board, turn_count)
    turn_count += 1
  end
  if (draw?(board))
    puts "Cat's Game!"
  elsif (won?(board))
    puts "The game has been won by player #{winner(board)}!"
  end
end
