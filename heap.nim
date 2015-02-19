# Module Heap

proc siftdown(heapy : var seq[int], i,n : int) =
  var i = i
  var child : int
  var temp : int
  while 2*i < n:
    if 2*i+1 < n:
      child = if heapy[2*i] < heapy[2*i+1]: 2*i else: 2*i+1
    else:
      child = 2*i
    if heapy[i] > heapy[child]:
      temp = heapy[i]
      heapy[i] = heapy[child]
      heapy[child] = temp
      i = child
    else:
      return

proc createheap*(heap : var seq[int]) =
  var bound = (heap.len +1) div 2
  var laenge = heap.len
  for i in countdown(bound,0):
    siftdown(heap,i,laenge)

proc revheapsort*(heap: var seq[int]) =
  createheap(heap)
  var n = heap.len
  var temp : int
  for k in countdown(n-1,1):
    temp = heap[0]
    heap[0] = heap[k]
    heap[k] = temp
    siftdown(heap,0,k)

when isMainModule:
  var
    myheap : seq[int]


  myheap = @[6,3,4,2,8,5,1]
  createheap(myheap)
  assert(@[1, 2, 4, 3, 8, 5, 6] == myheap)

  myheap = @[6,3,4,2,8,5,1]
  revheapsort(myheap)
  assert(@[8,6,5,4,3,2,1] == myheap)


# proc accessmin*(heap : seq[int])
# proc insert*(heap : seq[int])