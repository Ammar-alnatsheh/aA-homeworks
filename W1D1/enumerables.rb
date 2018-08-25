# require "byebug"
class Array

  def my_each(&prc)
    result = []
    i = 0
    while i < self.length
      result << prc.call(self[i])
      i+=1
    end
    self
  end

  def my_select(&prc)
    result = []
    i =0
    while i < self.length
      result << self[i] if prc.call(self[i]) == true
      i+=1
    end
    result
  end

  def my_reject(&prc)
    result = []
    i =0
    while i < self.length
      result << self[i] if prc.call(self[i]) != true
      i+=1
    end
    result
  end

  def my_any?(&prc)
    i = 0
    while i<self.length
      return true if prc.call(self[i]) == true
      i+=1
    end
    return false
  end

  def my_all?(&prc)
    i = 0
    while i<self.length
      return false if prc.call(self[i]) == false
      i+=1
    end
    return true
  end

  def my_flatten()
    result = []
    i = 0
    while i<self.length
      if self[i].class.to_s != "Array"
        result.push( self[i] )
      else
        result+= self[i].my_flatten
      end
      i+=1
    end
    result
  end

  def my_zip(*arg)
    result = []
    i = 0
    while i < self.length
      sub_arr = []
      sub_arr << self[i]
      arg.each do |arr|
        sub_arr << arr[i]
      end
      result << sub_arr
      i+=1
    end
    result
  end

  def my_rotate(num = 1)
    result = self.dup
    if num > 0
      i = 0
      while i < num
        result.push(result[0])
        result.shift
        i+=1
      end
    elsif num < 0
      i = 0
      while i > num
        result.unshift(result[-1])
        result.pop
        i-=1
      end
    end
    result
  end

  def my_join(seperator = "")
    result = ""
    i = 0
    while i < self.length-1
        result += self[i].to_s + seperator
      i+=1
    end
    result += self[i].to_s
  end

  def my_reverse()
    result = []
    i = 1
    while i <= self.length
      result.push(self[-i])
      i+=1
    end
    result
  end

  def factors(num)
    result = []
    i = num
    while i>0
      result.push(i) if num % i == 0
      i-=1
    end
    result.sort
  end

  def bubble_sort!(&prc)
    if prc.nil?
      i = 0
          while i < self.length-1
            n = 0
            while n < self.length-1
              if self[n]>self[n+1]
                  self[n],self[n+1] = self[n+1],self[n]
              end
              n+=1
            end
            i+=1
          end
    else
        i = 0
        while i<self.length-1
          n = 0
          while n<self.length-1
            if prc.call(self[n],self[n+1]) == 1
                self[n],self[n+1] = self[n+1],self[n]
            end
            n+=1
          end
          i+=1
        end
    end
    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end

  def substrings(string)
    result = []
    i = 0
    while i < string.length
      n = i
      while n < string.length
        result.push(string[i..n])
        n+=1
      end
      i+=1
    end
  end

  def subwords(word, dictionary)
    substrings(word).select {|w| dictionary.include?(w)}
  end

end
