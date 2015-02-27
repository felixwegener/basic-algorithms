# Module FibonacciHeap

type
  FibNode = ref FibNodeObj

  FibNodeObj = object
    elter : FibNode
    children : seq[FibNode]
    prev : FibNode
    next : FibNode
    mark : bool
    key : int
    value : string

proc fibmerge*(tree1, tree2 : var FibNode) : FibNode =
  var temp = tree1.prev
  tree1.prev = tree2.prev
  tree2.prev.next = tree1
  tree2.prev = temp
  temp.next = tree2
  if tree1.key < tree2.key:
    return tree1
  else:
    return tree2


#proc `$`(node : FibNode) : string =
#  return($node.key & node.value)



when isMainModule:
  var t1 = FibNode(elter : nil, children: nil, prev: nil, next : nil, mark: false, key: 2, value: "Hello")
  t1.prev = t1
  t1.next = t1
  var t2 = FibNode(elter : nil, children : nil, prev : nil, next : nil, mark : false, key : 1, value: "Bye")
  t2.prev = t2
  t2.next = t2
  assert($fibmerge(t1,t2).value == "Bye")