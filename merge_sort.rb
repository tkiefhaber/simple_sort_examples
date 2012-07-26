module MergeSort
  def self.sort(list)
    return list if list.length <= 1

    middle = list.length / 2
    left   = list[0, middle]
    right  = list[middle, list.length - middle]

    left  = sort(left)
    right = sort(right)

    return merge(left, right)
  end

  def self.merge(left, right)
    result = []
    while (left.length > 0 || right.length > 0)
      if (left.length > 0 && right.length > 0)
        if (left.first < right.first)
          result << left.shift
        else
          result << right.shift
        end
      elsif (left.length > 0)
        while (left.any?)
          result << left.shift
        end
      elsif (right.length > 0)
        while (right.any?)
          result << right.shift
        end
      end
    end

    return result
  end
end
