# Not about sorting, but sorting is a rich
# and well-plumbed subset of algorithms technology
# and is foundational for many powerful and specialized
# techniques. Stable sorting is a sort procedure that
# maintains the relative order of equally valued elements.
module QuickSort
  module Simple
    def self.sort(list)
      # An empty list or a list of
      # one element is already sorted.
      return list if list.length <= 1

      # Pick a random index in the list
      # and remove that element as a pivot
      index = rand(list.length)
      pivot = list.delete_at(index)

      less, more = [], []

      # Sort the remaining list elements
      # based on the value of the pivot
      for element in list do
        if element <= pivot
          less << element
        else
          more << element
        end
      end
      # Easier in Ruby as:
      # less, more = list.partition {|e| e <= pivot }

      # Recursively sort less and more and
      # return their concatenation with pivot
      return sort(less) + [pivot] + sort(more)
    end
  end

  module InPlace
    # .sort takes a list to sort and a starting and ending
    # index within which, inclusively, the sort will be performed.
    # The default indices correspond to sorting the entire list.
    #
    # By specifying indices inside the list, we effectively create
    # sublists for later sorts. In this case, we choose a random
    # pivot element then partition the list into elements less than
    # or equal to that element and elements larger than it, but we
    # do so in place by swapping the elements.
    #
    # We then recursively sort in place the two "new" lists.
    def self.sort(list, left_index=0, right_index=list.length-1)
      return unless right_index > left_index

      # Randomly determine a pivot for partitioning, then
      # partition the "whole" list
      pivot_index     = [left_index, rand(right_index + 1)].max
      new_pivot_index = partition(list, left_index, right_index, pivot_index)

      # Recursively sort the elements in the left sublist
      # and the right sublist.
      sort(list, left_index, new_pivot_index - 1)
      sort(list, new_pivot_index + 1, right_index)

      # We don't care about a return value, which will be
      # nil, because the list is sorted in-place.
    end


    def self.partition(list, left_index, right_index, pivot_index)
      # First, grab the pivot element and place it at the end
      # of the list so all other elements can be partitioned.
      pivot_value = list[pivot_index]
      swap_elements(list, pivot_index, right_index)

      # Track the index of the most recently moved element.
      # All elements to its left will be less than it; all
      # those to its right will be greater.
      moved_index = left_index

      # `...` means to exclude the right end of the range,
      # so from the left end up to
      for index in (left_index...right_index)
        if list[index] < pivot_value
          swap_elements(list, index, moved_index)
          moved_index += 1
        end
      end

      swap_elements(list, moved_index, right_index)
      return moved_index
    end

    # Swap the elements at the given indexes
    def self.swap_elements(list, i1, i2)
      v1 = list[i1]
      list[i1] = list[i2]
      list[i2] = v1
    end
  end
end
