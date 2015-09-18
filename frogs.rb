require 'byebug'
#In progress... O(n) ???
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
		if !mid.empty?
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




p frog_hop([3,1,4,5,2,6], 7, 3) #=> 2
p frog_hop([1,1,5,2,3], 7, 3) #=> 3
p frog_hop([5,2,4,8,1], 9, 3) #=> 3
p frog_hop([6,1,4,3,1,2], 7, 2) #=> 3
p frog_hop([8,7,5,1,4,3,6], 9, 2) #=> 5
