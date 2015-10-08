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
