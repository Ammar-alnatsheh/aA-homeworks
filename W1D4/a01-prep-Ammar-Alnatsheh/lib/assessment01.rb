class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil,&prc)
    i = 0
    accumulator = self.shift  if accumulator.nil?
    while i < self.length
      accumulator = prc.call(accumulator,self[i])
      i+=1
    end
    accumulator
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  i = num -1
  while i > 1
    return false if num % i == 0
    i-=1
  end
  return true
end

def primes(num)
  result = []
  i = 2
  while result.length < num
    result.push(i) if is_prime?(i)
    i+=1
  end
  result
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num <= 1
  pre = factorials_rec(num-1)
  pre + [[*1..factorials_rec(num-1).length].inject(:*)]
end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    result = Hash.new(){|k,v| v=[]}
    self.each_with_index do |el,idx|
    result[el] = result[el] << idx
  end
  result.select(){|keys| result[keys].length > 1}
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    result = sub_string(self.downcase).select(){|word| word.length > 1}
    result.select(){|word| word == word.reverse}
  end

  def sub_string(str)
    result = []
    i = 0
    while i < str.length-1
      j = i
      while j < str.length
        result.push(str[i..j])
        j+=1
      end
      i+=1
    end
    result
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    arr = self.dup
    return [] if arr == []
    return arr if arr.length == 1
    mid = arr.length/2
    left = arr[0...mid].merge_sort(&prc)
    right = arr[mid..-1].merge_sort(&prc)
    Array.merge(left,right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    prc ||= Proc.new{|l,r| l<r}
    result = []
    while left.length !=0 && right.length != 0 do
      if prc.call(left.first, right.first)
        result.push(left.shift)
      else
        result.push(right.shift)
      end
    end
    result + left + right
  end
end
