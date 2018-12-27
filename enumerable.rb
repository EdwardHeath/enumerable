module Enumerable
    def my_each
        self.length.times { |i| yield(self[i]) }
        self
    end

    def my_each_with_index
        self.length.times { |i| yield(self[i], i)}
    end

    def my_select
        arr = []
        self.my_each do |i|
            if yield(i)
                arr.push(i)
            end
        end
        return arr
    end

    def my_all?
        self.my_each do |i|
            if !yield(i)
                return false
            end
        end
        return true
    end

    def my_any?
        self.my_each do |i|
            if yield(i)
                return true
            end
        end
        return false
    end

    def my_none?
        self.my_each do |i|
            if yield(i)
                return false
            end
        end
        return true
    end

    def my_count
        count = 0
        self.my_each do |i|
            if yield(i)
                count += 1
            end
        end
        return count
    end

    def my_map(proc = nil)
        map = Array.new(self)
        map.my_each_with_index do |x, i|
            if proc
                map[i] = proc.call(i)
            else
                map[i] = yield(x)
            end
        end
        return map
    end

    def my_inject total
        self.my_each do |i|
            total = yield(total, i)
        end
        return total
    end
end

def multiply_els arr
    return arr.my_inject(1) { |product, x| product * x }
end

arr = [4,8,15,16,23,42]
puts
puts "arr = #{arr.inspect}"
puts
puts "arr.my_each -> print x, ' -- '"
arr.my_each { |x| print x, " -- " }
puts
puts
puts "arr.my_each_with_index -> print '{index => value}'" 
arr.my_each_with_index { |value, index| print "{#{index} => #{value}} " }
puts
puts 
puts "arr.my_select -> x.even?"
print arr.my_select { |x| x.even? }
puts
puts 
puts "arr.my_all? -> x > 42"
print arr.my_all? { |x| x > 42 }
puts
puts "arr.my_all? -> x > 3"
print arr.my_all? { |x| x > 3 }
puts
puts
puts "arr.my_any? -> x < 42"
print arr.my_any? { |x| x < 42 }
puts
puts "arr.my_any? -> x < 3"
print arr.my_any? { |x| x < 3 }
puts
puts
puts "arr.my_none? -> x == 42"
print arr.my_none? { |x| x == 42 }
puts
puts "arr.my_none? -> x == 3"
print arr.my_none? { |x| x == 3 }
puts
puts
puts "arr.my_count -> Math.sqrt(x) % 1 == 0"
print arr.my_count { |x| Math.sqrt(x) % 1 == 0 }
puts 
puts
puts "arr.my_map -> print '{x * x = x^2}'"
arr.my_map { |x| print "{#{x} * #{x} = #{x * x}} "}
puts
puts
puts "arr.my_inject -> sum + n"
print arr.my_inject(0) { |sum, n| sum + n }
puts
puts
puts "multiply_els([2,4,5])"
print multiply_els([2,4,5])
puts