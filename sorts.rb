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

############

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



a = [4, 5, 1, 9, -2, 0, 4, -5, 7]
p a.quick_sort!