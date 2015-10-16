class AVLNode
  attr_accessor :val, :parent, :left, :right, :depth

  def initialize(val)
    @val = val
    @depth = 1
  end

  def balance
    if right.depth && left.depth
      right.depth - left.depth
    elsif right.depth
      right.depth
    elsif left.depth
      left.depth
    else
      0
    end
  end

  def balanced?
    balance < 2
  end

  def parent_side
    return nil if parent.nil?
    parent.left == self ? :left : :right
  end

  def recalculate_depth!
    if right.depth && left.depth
      @depth = [left.depth, right.depth].max + 1
    elsif right.depth
      @depth = [0, right.depth].max + 1
    elsif left.depth
      @depth = [left.depth, 0].max + 1
    else
      1
    end
  end
end

class AVLTree
  def initialize
    @root = nil
  end

  def empty?
    @root.nil?
  end

  def include?(val)
    vertex, parent = find(val)
    !!vertex
  end

  def insert(val)
    if self.empty?
      @root = AVLNode.new(val)
      return true
    end

    vertex, parent = find(val)
    return false if vertex

    vertex = AVLNode.new(val)
    if val < parent.val
      parent.left = vertex
    else
      parent.right = vertex
    end
    vertex.parent = parent

    update(parent)

    true
  end

  def find(val)
    vertex, parent = @root, nil

    until vertex.nil?
      break if vertex.val == val

      parent = vertex
      if val < vertex.val
        vertex = vertex.left
      else
        vertex = vertex.right
      end
    end

    [vertex, parent]
  end

  def update(vertex)
    return if vertex.nil?

    if vertex.balance == -2
      if vertex.left.balance == 1
        left_rotate!(vertex.left) #TODO
      end

      right_rotate!(vertex) #TODO

    elsif vertex.balance == 2
      if vertex.right.balance == -1
        right_rotate!(vertex.right) #TODO
      end

      left_rotate!(vertex) #TODO

    elsif vertex.balance.abs < 2
      # Do nothing, already balanced
    end

    vertex.recalculate_depth!
    update(vertex.parent)
  end

  def left_rotate!(parent)
    #TODO
  end

  def right_rotate!(parent)
    #TODO
  end

end

