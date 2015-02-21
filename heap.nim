# Module Heap

# from sequtils import delete

type
  Heap = seq[int]

proc siftdown(heap : var Heap, i,n : int) =
  ## Helperfunc for Heapconstruction. O(log n)
  var i = i
  var child : int
  var temp : int
  while 2*i+1 < n:
    if 2*i+2 < n:
      child = if heap[2*i+1] < heap[2*i+2]: 2*i+1 else: 2*i+2
    else:
      child = 2*i+1
    if heap[i] > heap[child]:
      temp = heap[i]
      heap[i] = heap[child]
      heap[child] = temp
      i = child
    else:
      return

proc siftup(heap : var Heap, i : int) =
  ## Helperfunc for Heapconstruction. O(log n)
  var i = i
  var parent = (i-1) div 2
  var temp :int
  while i > 0:
    if heap[parent] > heap[i]:
      temp = heap[i]
      heap[i] = heap[parent]
      heap[parent] = temp
      i = parent
      parent = (i-1) div 2
    else:
      return

proc createheap*(heap : var Heap) =
  var bound = heap.len div 2
  var laenge = heap.len
  for i in countdown(bound,0):
    siftdown(heap,i,laenge)

proc revheapsort*(heap: var Heap) =
  createheap(heap)
  var n = heap.len
  var temp : int
  for k in countdown(n-1,1):
    temp = heap[0]
    heap[0] = heap[k]
    heap[k] = temp
    siftdown(heap,0,k)

proc accessMin*(heap : Heap) : int =
  return heap[0]

proc deleteMin*(heap : var Heap) =
  var n = heap.len
  heap[0] = heap[n-1]
  discard pop(heap)
  siftdown(heap,0,n-1)

proc deleteElement*(heap : var Heap, position : int) =
  var n = heap.len
  heap[position] = heap[n-1]
  discard pop(heap)

proc insert*(heap : var Heap, element : int) =
  heap.add(element)
  siftup(heap,heap.len-1)

proc decreasePriority*(heap : var Heap, position : int, priority: int) =
  if heap[position] < priority:
    var ePriorityTooHigh: ref ValueError
    new(ePriorityTooHigh) # need to be allocated *before* OOM really happened!
    ePriorityTooHigh.msg = "Error: priority cannot be increased"
    raise(ePriorityTooHigh)
  else:
    heap[position] = priority
    siftup(heap,position)


when isMainModule:
  var
    myheap : Heap

  myheap = @[6,3,4,2,8,5,1]
  createheap(myheap)
  assert(@[1, 2, 4, 3, 8, 5, 6] == myheap)

  myheap = @[6,3,4,2,8,5,1]
  revheapsort(myheap)
  assert(@[8,6,5,4,3,2,1] == myheap)

  myheap = @[6,3,4,2,8,5,1]
  createheap(myheap)
  myheap.deleteMin()
  assert(@[2,3,4,6,8,5] == myheap)
  myheap.decreasePriority(2,1)
  assert(@[1,3,2,6,8,5] == myheap)



