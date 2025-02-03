
class InventoryListNode:
    def __init__(self, itemNumber, count):
        self.itemNumber = itemNumber
        self.count = count
        self.prev = None
        self.next = None

class InventorySystemLL:
    def __init__(self):
        self.head = None
        self.tail = None

    def addItem(self, itemNumber, count):
        newItem = InventoryListNode(itemNumber=itemNumber, count=count)

        if self.head is None:
            self.head = newItem
            self.tail = newItem
        else:
            newItem.prev = self.tail
            self.tail.next = newItem
            self.tail = newItem

    def itemInSystem(self, searchNumber):
        curr = self.head
        while curr:
            if curr.itemNumber == searchNumber:
                return True
            curr = curr.next
        return False
    
    def updateCount(self, itemNumber, countChange):
        curr = self.head

        while curr:
            if curr.itemNumber == itemNumber:
                break
            curr = curr.next
        
        curr.count += countChange
        if curr.count <= 0:
            self.deleteItem(curr)

        # print(f"Element {curr.itemNumber} has new count {curr.count}")
        return

    def deleteItem(self, elementNumToDelete):
        curr = elementNumToDelete

        # If there is only one item
        if self.head == self.tail:
            # print("one element")
            self.head = None
            self.tail = None

        # If there are multiple items and the element is the head
        elif self.head == curr:
            # print("beginning")
            self.head = curr.next
            self.head.prev = None

        # If the element is in the middle
        elif curr != self.head and curr != self.tail:
            # print("middle")
            curr.prev.next = curr.next
            curr.next.prev = curr.prev

        # If the element is the tail
        else:
            # print("end")
            self.tail = curr.prev
            self.tail.next = None

        # Disconnect the node completely
        curr.prev = None
        curr.next = None
        # print('deleted')
        return

    def displayLL(self):
        curr = self.head
        while curr:
            print(f"Item Number: {curr.itemNumber}, Count: {curr.count}")
            curr = curr.next
        print("Done diplaying")
        return


system = InventorySystemLL()
while True:
    itemNumber = int(input("Enter item: "))
    if itemNumber == 0:
        break

    count = int(input("Enter count: "))
    # if count == 0:
    #     break
    
    if system.itemInSystem(itemNumber):
        system.updateCount(itemNumber, count)
    else:
        system.addItem(itemNumber, count)

system.displayLL()


# system = InventorySystemLL()
# system.addItem(128, 3)
# system.addItem(4, 60)
# system.addItem(30, 1)
# system.displayLL()

# system.deleteItem(30)
# system.deleteItem(4)

# print(system.itemInSystem(128))
# print(system.itemInSystem(127))
# system.updateCount(128, 2)
# system.updateCount(4, -61)
# system.displayLL()

# print("updating count")
# system.updateCount(4, -61)
# system.displayLL()

# print("updating count")
# system.updateCount(30, -2)
# system.displayLL()

# print("updating count")
# system.updateCount(128, -4)
# system.displayLL()
