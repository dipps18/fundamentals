def fibs(n)
  return n if n == 0 || n == 1
  prev_elem = 0
  cur_elem = 1
  (2..n).each do |i|
    temp = prev_elem
    prev_elem = cur_elem
    cur_elem = temp + prev_elem
  end
  return cur_elem
end


def fibs_rec(n)
  n == 0 || n == 1 ? (return n) : fibs_rec(n-1) + fibs_rec(n-2)
end

fibs(3)
fibs(5)
fibs(7)
fibs_rec(3)
fibs_rec(5)
fibs_rec(7)
