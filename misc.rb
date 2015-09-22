require 'byebug'
#In progress... O(n + d) ???
def frog_hop_v1(arr, x, d)
	right = [x]
	left = [0]
	mid = []
	arr.each_with_index do |el, id|
		if right.last - el <= d && el - left.last <= d
			return id
		elsif el < right.last && right.last - el <= d
			right << el
		elsif el > left.last && el - left.last <= d
			left << el
		else
			mid << el
		end
		unless mid.empty?
			mid.each do |el2|
				if el2 < right.last && right.last - el2 <= d
					right << el2
					mid.delete(el2)
				elsif el2 > left.last && el2 - left.last <= d
					left << el2
					mid.delete(el2)
				end
			end
		end
	end
	return false
end

def frog_hop_v2(arr, x, d)
	hash = Hash.new
	(0..x).each do |n|
		if n == 0 || n == x
			hash[n] = true
		else
			hash[n] = false
		end
	end

	current = 0
	arr.each_with_index do |el, id|
		hash[el] = true
		# debugger
		if el - current <= d && el > current
			current = el
		end
		old_curr = current
		d.times do #Not ideal...
			((current + 1)..(current + d)).each do |j|
				if hash[j]
					current = j
					#Try loop again?!
				end
			end
			break if old_curr == current
		end
		return id if x - current <= d
	end
end

def frog_hop(arr, x, d)
	hash = Hash.new
	(0..x).each do |n|
		if n == 0 || n == x
			hash[n] = true
		else
			hash[n] = false
		end
	end
	current = 0
	arr.each_with_index do |el, id|
		current = el if el - current <= d
		hash[el] = true
		hash.each do |k, v|
			if v && k - current <= d && k > current
				current = k
				return id if current == x
			end
		end
	end
	return -1
end

# p frog_hop([3,1,4,5,2,6], 7, 3) #=> 2
# p frog_hop([1,1,5,2,3], 7, 3) #=> 3
# p frog_hop([5,2,4,8,1], 9, 3) #=> 3
# p frog_hop([6,1,4,3,1,2], 7, 2) #=> 3
# p frog_hop([8,7,5,1,4,3,6], 9, 2) #=> 5
# p frog_hop([7,4,9,8,11,12,3,10,5], 15, 3) #=> 6

# rand7 using only rand(5):
def rand7
	while true 
		n = 5 * (rand(5)) + rand(5)
		if n < 21
			return n % 7
		end
	end
end

# h = Hash.new
# (0..6).each { |n| h[n] = 0 }
# 100000.times { h[rand7] += 1 }
# p h

def print_spiral(matrix)
	a = matrix.dup
	res = []

	until a.flatten.empty?
		#top row
		res.concat(a.shift)

		#right side
		a.count.times do |i|
			cur = a[i]
			res << a[i].pop
		end

		#bottom row
		res.concat(a.pop.reverse)

		#left side
		(a.count - 1).downto(0) do |i|
			res << a[i].shift
		end
	end

	res

end


matrix = [ [1, 2, 3, 4],
					 [14, 15, 16, 5],
					 [13, 20, 17, 6],
					 [12, 19, 18, 7],
					 [11, 10, 9, 8]
					]

matrix2 = [ [1, 2, 3, 4, 5],
						[14, 15, 16, 17, 6],
						[13, 20, 19, 18, 7],
						[12, 11, 10, 9, 8]
					]

matrix3 = [[1, 2],
					 [10, 3],
					 [9, 4],
					 [8, 5],
					 [7, 6]
					]

p print_spiral(matrix3)

