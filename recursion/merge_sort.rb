
def merge(left, right)
  sorted_arr = []
  ct = 0
  while(!left.empty? || !right.empty?)
    left.empty? || !right.empty? && left[0] > right[0] ? sorted_arr[ct] = right.shift : sorted_arr[ct] = left.shift
    ct += 1
  end
  sorted_arr
end

def merge_sort(array)
  return array if array.length < 2
  merge(merge_sort(array[0...array.length/2]), merge_sort(array[array.length/2...array.length]))
end

merge_sort([3,5,2,6,9,8])
merge_sort([4,8,6,2,1,7,5,3,9])
