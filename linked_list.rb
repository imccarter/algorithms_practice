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

	def remove
		self.next.prev = self.prev unless self.next.nil?
		self.prev.next = self.next unless self.prev.nil?
		self.prev, self.next = nil, nil
	end

	def inspect
		"Value: #{@val}, Previous: #{self.prev}, Next: #{self.next}"
	end
end

class SentinelLink < Link
	def initialize(side)
		raise "wrong side" unless [:first, :last].include?(side)
		@side = side
	end

	def val
		raise "Sentinel Link; no value"
	end

	def val=
		raise "Sentinel Link; no value"
	end

	def prev=(link)
		if @side == :last
			return super(link)
		elsif link.nil?
		else
			raise "Can't insert left of first link"
		end
	end

	def next=(link)
		if @side == :first
			return super(link)
		elsif link.nil?
		else
			raise "Can't insert right of last link"
		end
	end

	def remove
		raise "Can't remove Sentinel Link"
	end

	def inspect
		"Sentinel Link; #{side}"
	end
end

class LinkedList
	attr_reader :first, :last

	def initialize
		@first = SentinelLink.new(:first)
		@first.insert_right(SentinelLink.new(:last))
		@last = @first.next
	end

	def empty?
		first.next == last
	end

	def pop
		pop_link.val
	end

	def pop_link
		raise "List is empty, cannot pop!" if empty?
		link = last.prev
		link.remove
		link
	end

	def push(val)
		push_link(Link.new(val))
	end

	def push_link(link)
		last.insert_left(link)
		link
	end

	def shift
		shift_link.val
	end

	def shift_link
		raise "List is empty, cannot unshift!" if empty?
		link = first.next
		link.remove
		link
	end

	def unshift(val)
		unshift_link(Link.new(val))
	end

	def unshift_link(link)
		first.insert_right(link)
		link
	end

end