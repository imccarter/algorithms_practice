require 'byebug'

class Array
	def merge_sort
		return self if self.length <= 1
		mid = self.length / 2
		left = self.take(mid)
		right = self.drop(mid)
		Array.merge(left.merge_sort, right.merge_sort)
	end

	def self.merge(left, right)
		sorted = []
		until left.empty? || right.empty?
			if left.first <= right.first
				sorted << left.shift
			else
				sorted << right.shift
			end
		end
		sorted.concat(left).concat(right)
		sorted
	end

  ##########

	def swap!(id1, id2)
		self[id1], self[id2] = self[id2], self[id1]
	end

	def quick_sort!(start = 0, len = self.length)
		return self if len <= 1
		swap!(start, rand(len) + start)
		pivot = partition!(start, len)
		quick_sort!(start, pivot - start)
		quick_sort!(pivot + 1, len - pivot + start - 1)
	end

	def partition!(start, len)
		pivot = start
		i = pivot.next
		while i < start + len
			if self[i] < self[pivot]
				swap!(i, pivot.next)
				swap!(pivot, pivot.next)
				pivot += 1
			end
			i += 1
		end
		pivot
	end
end


#In progress... O(n) ???
def frog_hop(arr, x, d)
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
				elsif el2 > left.last && el2 - left.last <= d
					left << el2
				end
			end
		end
	end
	return false
end


p frog_hop([3,1,4,5,2,6], 7, 3) #=> 2
p frog_hop([1,1,5,2,3], 7, 3) #=> 3
p frog_hop([5,2,4,8,1], 9, 3) #=> 3
p frog_hop([6,1,4,3,1,2], 7, 2) #=> 3

