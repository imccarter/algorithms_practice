class Link
	attr_accessor :val, :next, :prev
	
	def initialize(val)
		@val = val
	end

	def insert_left(link)
		if link.next || link.prev
			raise "There's already a link there!"
		end
		
		link.next = self
		link.prev = self.prev
		self.prev.next = link if self.prev
		self.prev = link
	end

	def insert_right(link)
		if link.next || link.prev
			raise "There's already a link there!"
		end

		link.prev = self
		link.next = self.next
		self.next.prev = link if self.next
		self.next = link
	end

end

class SentinelLink < Link
	def initialize(side)
		raise "wrong side" unless [:first, :last].include?(side)
		@side = side
	end
end

class LinkedList

	def initialize
		@first = SentinelLink.new(:first)
		@first.insert_right(SentinelLink.new(:last))
		@last = @first.next
	end

	def []

	end

	def empty?

	end

	def pop

	end

	def push

	end

	def shift

	end

	def unshift

	end

end