module Enumerable
  def my_each()
    return to_enum(:my_each) unless block_given?
    for k,v in self
      yield k,v
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?
    self.is_a?(Hash) ? arr = self.to_a : arr = self
    (0...arr.length).my_each {|index| yield arr[index], index}
    self
  end

  def my_select
    self.is_a?(Hash) ? hash = Hash.new : arr = Array.new
    return to_enum(:my_each) unless block_given?
    for k, v in self
      next unless yield k,v
      self.is_a?(Hash) ? hash[k] = v : arr.push(k)
    end
    hash || arr 
  end

  def my_all?(&block)
    self.my_select(&block) == self ? true : false
  end

  def my_any?(&block)
    self.my_select(&block).empty? ? false : true
  end

  def my_none?(&block)
    self.my_select(&block).empty? ? true : false
  end

  def my_count(element = nil)
    (return self.my_select(&proc).length) if block_given? && element == nil
    (return self.length) if element == nil
    (return self.my_select{|val| val == element}.length) if element
  end

  def my_map proc = nil
    arr = []
    for k,v in self
      if block_given?
        arr.push(yield k, v)
      else
        arr.push(proc.call(k,v))
      end
    end
    arr
  end

  def my_inject(initial = nil, sym = nil)
    # throws local jump error (like inject) when no block arguments or blocks are given
    yield if !block_given? && !initial 

    arr = self.to_a # In the event that a range is passed as argument, 
    if initial.is_a?(Numeric)
      acc = initial
      start = 0
    else
      acc = arr[0]
      start = 1
    end

    sym = initial if initial.is_a?(Symbol) # when only symbol is passed
    if block_given?
      (start...arr.length).my_each{|index| acc = yield acc, arr[index]}
    else
      (start...arr.length).my_each{|index| acc = acc.public_send(sym,arr[index])}
    end
    acc
  end

  
end


# numbers = [1,2,3,4,5]
# hashes = {first: 1, second: 2}
# # numbers.my_each{|item| puts item}
# # numbers.each{|item| puts item}
# # numbers.my_each{|item| puts item*2}
# # numbers.each{|item| puts item*2}

# # hashes.each{|key,value| puts "#{key}: #{value}"}
# # hashes.my_each{|key,value| puts "#{key}: #{value}"}

# # numbers.my_each_with_index{|value, index| puts "#{index} #{value}"}
# # numbers.each_with_index{|value, index| puts "#{index} #{value}"}

# # hashes.my_each_with_index{|value, index| puts "#{index} #{value}"}
# # hashes.each_with_index{|value, index| puts "#{index} #{value}"}

# # numbers.each_with_index{|value, index| puts value *= 2}
# # numbers.my_each_with_index{|value, index| puts value *= 2}

# # numbers.my_select{|element| element > 6}
# # numbers.select{|element| element > 6}
# # numbers.my_all?{|element| element < 6}
# # numbers.my_any?{|element| element < 6}
# # numbers.my_none?{|element| element > 6}

# # hashes.my_all?{|key, value| value < 2}
# # hashes.my_any?{|key, value| value < 2}
# # hashes.my_none?{|key, value| value < 2}

# # [1,2,3].my_count
# # [1,2,3,2].my_count(2)
# # [1,2,3,4].my_count{|element| element % 2 == 0}
# # [1,2,3,4].count{|element| element % 2 == 0}
# # [1,2,3,4].my_count(2){|element| element % 2 == 0}
# # [1,2,3,4].count(2){|element| element % 2 == 0}

# # [1,2,3].my_map{|element| element += 2}
# # [1,2,3].map{|element| element += 2}

# # {a:1, b:2}.my_map{|key,value| key = :d if key == :a}
# # {a:1, b:2}.map{|key,value| key = :d if key == :a}

# [1,2,3].my_inject(:+)

# [1,2,3].my_inject
# [1,2,3].inject

# [1,2,3].my_inject(2,:*)
# [1,2,3].my_inject{|sum,n| sum + n}
# [2,4,5].my_inject(:*)
# (5..10).my_inject(2) {|product,n| product * n}



puts "my_each vs. each"
[1,2,3,4,5].my_each  { |item| print item * 2 }
puts ""
[1,2,3,4,5].each  { |item| print item * 2 }
puts ""

puts "my_each_with_index vs. each_with_index"
[1,2,3,4,5].my_each_with_index   { |item, index| print [item, index] }
puts ""
[1,2,3,4,5].each_with_index  { |item, index| print [item, index] }
puts ""

puts "my_select vs. select"
print [1,2,3,4,5].my_select { |num|  num.even?  }
puts ""
print [1,2,3,4,5].select { |num|  num.even?  }
puts ""

puts "my_all? vs. all?"
puts [1,2,3,4,5].my_all? { |num| num < 10 }
puts [1,2,3,4,5].all? { |num| num < 10 }

puts "my_any? vs. any?"
puts [1,2,3,4,5].my_any? { |num| num > 3 }
puts [1,2,3,4,5].any? { |num| num > 3 }

puts "my_none? vs. none?"
puts [1,2,3,4,5].my_none? { |num| num < 10 }
puts [1,2,3,4,5].none? { |num| num < 10 }

puts "my_count vs. count"
puts [1,2,3,4,5].my_count {|x| x % 2 == 0}
puts [1,2,3,4,5].my_count
puts [1,2,3,4,5].count {|num| num % 2 == 0}
puts [1,2,3,4,5].count

puts "my_map vs. map"
print [1,2,3,4,5].my_map { |num| num * 2 }
puts ""
print [1,2,3,4,5].map { |num| num * 2 }
puts ""
puts "my_map with my_proc"
my_proc = Proc.new {|num| num * 3 } 
print [1,2,3,4,5].my_map my_proc
puts ""
puts "my_map with a block and my_proc"
print [1,2,3,4,5].my_map {|num| num * 4 }.my_map my_proc
puts ""

puts "my_inject vs. inject"
puts [1,2,3,4,5].my_inject { |sum, num| sum + num }
puts [1,2,3,4,5].inject { |sum, num| sum + num }
puts "initial = 2"
puts [1,2,3,4,5].my_inject(2) { |sum, num| sum + num }
puts [1,2,3,4,5].inject(2) { |sum, num| sum + num }
puts "multiplication"
puts [1,2,3,4,5].my_inject { |sum, num| sum * num }
puts [1,2,3,4,5].inject { |sum, num| sum * num }
puts "initial = 2"
puts [1,2,3,4,5].my_inject(2) { |sum, num| sum * num }
puts [1,2,3,4,5].inject(2) { |sum, num| sum * num }
