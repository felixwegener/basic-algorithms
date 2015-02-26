# Module Heap

# from sequtils import delete

# from iterutils import map

type
  Element[T] = tuple
    priority : int
    content : T
  Heap[T] = seq[Element[T]]

proc siftdown[T](heap : var Heap[T], i,n : int) =
  ## Helperfunc for Heapconstruction. O(log n)
  var i = i
  var child : int
  var temp : Element[T]
  while 2*i+1 < n:
    if 2*i+2 < n:
      child = if heap[2*i+1] < heap[2*i+2]: 2*i+1 else: 2*i+2
    else:
      child = 2*i+1
    if heap[i].priority > heap[child].priority:
      temp = heap[i]
      heap[i] = heap[child]
      heap[child] = temp
      i = child
    else:
      return

proc siftup[T](heap : var Heap[T], i : int) =
  ## Helperfunc for Heapconstruction. O(log n)
  var i = i
  var parent = (i-1) div 2
  var temp : Element[T]
  while i > 0:
    if heap[parent].priority > heap[i].priority:
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

proc revheapsort*[T](heap: var Heap[T]) =
  createheap(heap)
  var n = heap.len
  var temp : Element[T]
  for k in countdown(n-1,1):
    temp = heap[0]
    heap[0] = heap[k]
    heap[k] = temp
    siftdown(heap,0,k)

proc accessMin*[T](heap : Heap[T]) : Element[T] =
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
  heap.siftup(position)
  heap.siftdown(position,n-1)

proc insertHeap*[T](heap : var Heap, element : Element[T]) =
  heap.add(element)
  siftup(heap,heap.len-1)

proc decreasePriority*(heap : var Heap, position : int, priority: int) =
  if heap[position].priority < priority:
    var ePriorityTooHigh: ref ValueError
    new(ePriorityTooHigh)
    ePriorityTooHigh.msg = "Error: priority cannot be increased"
    raise(ePriorityTooHigh)
  else:
    heap[position].priority = priority
    siftup(heap,position)


when isMainModule:
  var
    myheap : Heap[string]

  iterator priomapper[T](heap : Heap[T]) : int =
    var i = 0
    while i < heap.len:
      yield heap[i].priority
      inc(i)

  #Test: createheap, accessMin
  myheap = @[(6,"Schwimmen"),(3,"Sit-Ups"),(4,"Laufen"),(2,"Gehen"),(8,"Schlafen"),(5,"Skaten"),(1,"Rennen")]
  createheap(myheap)
  var testheap : seq[int] = @[]
  for a in myheap.priomapper():
    testheap.add(a)
  assert(@[1, 2, 4, 3, 8, 5, 6] == testheap)
  assert(myheap.accessMin() == (1,"Rennen"))

  #Test: revheapsort
  myheap = @[(6,"Schwimmen"),(3,"Sit-Ups"),(4,"Laufen"),(2,"Gehen"),(8,"Schlafen"),(5,"Skaten"),(1,"Rennen")]
  revheapsort(myheap)
  testheap = @[]
  for a in myheap.priomapper():
    testheap.add(a)
  assert(@[8,6,5,4,3,2,1] == testheap)

  #Test: deleteMin, decreasePriority, insertHeap, deleteElement
  myheap = @[(6,"Schwimmen"),(3,"Sit-Ups"),(4,"Laufen"),(2,"Gehen"),(8,"Schlafen"),(5,"Skaten"),(1,"Rennen")]
  createheap(myheap)
  myheap.deleteMin()
  testheap = @[]
  for a in myheap.priomapper():
    testheap.add(a)
  assert(@[2,3,4,6,8,5] == testheap)
  myheap.decreasePriority(2,1)
  testheap = @[]
  for a in myheap.priomapper():
    testheap.add(a)
  assert(@[1,3,2,6,8,5] == testheap)
  myheap.insertHeap((1,"Fliegen"))
  testheap = @[]
  for a in myheap.priomapper():
    testheap.add(a)
  assert(@[1,3,1,6,8,5,2] == testheap)
  myheap.deleteElement(3)
  testheap = @[]
  for a in myheap.priomapper():
    testheap.add(a)
  assert(@[1,2,1,3,8,5] == testheap)




