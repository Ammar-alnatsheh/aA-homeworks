class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14){[:stone,:stone,:stone,:stone]}
    @cups[13] = []
    @cups[6] = []

  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 12
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)

    num_stones = @cups[start_pos]
    @cups[start_pos] = []

    idx = start_pos
    until num_stones.empty?
      idx += 1
      idx = 0 if idx > 13

      if idx == 6
        @cups[6] << num_stones.pop if current_player_name == @name1
      elsif idx == 13
        @cups[13] << num_stones.pop if current_player_name == @name2
      else
        @cups[idx] << num_stones.pop
      end
    end
    render
    next_turn(idx)

  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].count == 1
      :switch
    else
      ending_cup_idx
    end

  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].any?{|cup| cup.empty?} || @cups[7..12].any?{|cup| cup.empty?}
  end

  def winner

    return :draw if @cups[13] == @cups[6]

    if @cups[6].count > @cups[13].count
      return @name1
    else
      return @name2
    end

  end
end
