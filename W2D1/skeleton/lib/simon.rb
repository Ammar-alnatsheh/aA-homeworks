class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize(sequence_length =1)
    @sequence_length = sequence_length
    @game_over = false
    @seq = []
  end

  def play
    until @game_over
      take_turn
      system("clear")
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    unless game_over
      @sequence_length +=1
      round_success_message
    end
  end

  def show_sequence
    add_random_color
    p @seq
    sleep 1.5
    system("clear")
  end

  def require_sequence
    p "type the color sequence with comma betwwn them from first to last"
    input = gets.chomp
    input = input.split(",")
    @game_over = true if @seq != input
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    p "Good choice will start the next round"
    sleep 1.5
  end

  def game_over_message
    p "Was a Wrong Guess Game over :("
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end


if __FILE__ == $PROGRAM_NAME
  g = Simon.new
  g.play
end
