class Vertex
	attr_reader :val, :out_edges, :in_edges

	def initialize(val)
		@val = val
		@out_edges = []
		@in_edges = []
	end

	def BFS(dest = nil)
		return 0 if self == dest
		queue = [[self, 0]]
		visited = {}
		until queue.empty?
			vertex, cost = queue.shift
			vertex.out_edges each do |edge|
				out_vertex = edge.to
				next if visited[out_vertex]
				return cost + 1 if out_vertex == dest
				queue << [out_vertex, cost + 1]
			end
			visited[vertex] = cost
		end
		visited
	end
end


class Edge
	attr_reader :to, :from, :weight

	def initialize(to = nil, from = nil, weight = nil)
		@to = to
		@from = from
		@weight = weight

		@to.in_edges << self
		@from.out_edges << self
	end
end


def topo_sort(vertices)
	dependencies = {}
	queue = []
	ordering = []
	vertices.each do |vertex|
		dependencies[vertex] = vertex.in_edges.count
		queue << vertex if dependencies[vertex] == 0
	end
	until queue.empty?
		vertex = queue.shift
		ordering << vertex
		vertex.out_edges.each do |edge|
			dependency = edge.to
			dependencies[dependency] -= 1
			queue << dependency if dependencies[dependency] == 0
		end
	end
	ordering
end