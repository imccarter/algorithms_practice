# for representing a heap as an array
class MinHeap

	def initialize(arr = [], len = arr.length)
		@store = []
		@len = len
		arr.each { |el| insert(el) }
	end

	def min
		@store[0]
	end

	def count
		@store.length
	end

	def empty?
		count == 0
	end

	def pop_min
		min = self.min
		return nil if @store.empty?
		return @store.pop if @store.length == 1
		@store[0] = @store.pop
		heapify_down!
		min
	end

	def children(id, len = @len)
		[((id * 2) + 1), ((id * 2) + 2)].select { |child_id| child_id < len }
	end

	def parent(id)
		(id - 1) / 2
	end

	def insert(val)
		@store.push(val)
		heapify_up!
		val
	end

	private
	
	def swap(id1, id2)
		@store[id1], @store[id2] = @store[id2], @store[id1]
	end

	def heapify_up!
		current = @store.length - 1
		while current > 0
			parent_id = parent(current)
			if @store[parent_id] > @store[current]
				swap(parent_id, current)
				current = parent_id
			else
				break
			end
		end
	end

	def heapify_down!
		current = 0
		while current < @store.length - 1
			children_ids = children(current)
			children.select! { |n| n.between?(0, @store.length - 1) }
			break if children.empty?
			min_child = children.min_by { |i| @store[i] }
			if @store[current] > @store[min_child]
				swap(current, min_child)
			else
				break
			end
		end
	end
end


#Still need to test...
class Array
	def heap_sort!
		2.upto(count).each do |heap_size|
			MinHeap.heapify_up!()
		end

		count.downto(2).each do |heap_size|
			self[heap_size - 1], self[0] = self[0], self[heap_size - 1]
			MinHeap.heapify_down!
		end

		self.reverse!

	end
end