require 'io/console'
require 'benchmark'

class Big_O_ctopus

  def initialize
    @tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
    @tiles_hash = {
                    "up" => 0,
                    "right-up" => 1,
                    "right" => 2,
                    "right-down"=> 3,
                    "down"=> 4,
                    "left-down"=> 5,
                    "left"=> 6,
                    "left-up"=> 7  }
  end

  def sluggish_octopus(fish)
    i = 0
    while i < fish.length
      j=0
      while j< fish.length-1
          fish[j],fish[j+1] = fish[j+1],fish[j] if fish[j].length > fish[j+1].length
        j+=1
      end
      i+=1
    end
    fish.last
  end

  def dominant_octopus(fish)
    return "" if fish.length < 1
    return fish.first if fish.length == 1
    mid = fish.length / 2
    left = dominant_octopus(fish.take(mid))
    right = dominant_octopus(fish.drop(mid))
    return left if left.length >= right.length
    return right if left.length < right.length
  end

  def clever_octopus(fish)
    biggest_fish = fish.first
    fish.each do |el|
      biggest_fish = el if el.length > biggest_fish.length
    end
    biggest_fish
  end

  def slow_dance(move)
    @tiles_array.each_with_index do |tile, index|
      return index if tile == move
    end
  end

  def fast_dance(move)
    @tiles_hash[move]
  end

end

if __FILE__ == $PROGRAM_NAME

  fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
  10.times do
    fish+=fish
  end
  octopus = Big_O_ctopus.new()

    Benchmark.benchmark(Benchmark::CAPTION, 9, Benchmark::FORMAT,
                        "Avg. sluggish  : ", "Avg. dominant  : ", "Avg. clever    : ","Avg fast dance : ","Avg slow dance : ") do |b|
      s = b.report("Tot. sluggish  : ") { octopus.sluggish_octopus(fish) }
      d = b.report("Tot. dominant  : ") { octopus.dominant_octopus(fish) }
      c = b.report("Tot. clever    : ") { octopus.clever_octopus(fish) }
      f = b.report("Tot. fast_dance: ") { octopus.fast_dance("left-up") }
      sl = b.report("Tot. slow_dance: ") { octopus.slow_dance("left-up") }
      [s/fish.count, d/fish.count,c/fish.count,f/8,sl/8]
    end

end
