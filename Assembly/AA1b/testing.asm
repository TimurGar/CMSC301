          .data #This is boilerplate stuff to get QTSPIM to read this file the right way
    end_str: .asciiz "End of inventory report." # This is to print later.
          .text
          .align 2
          .globl main 

main:
# Write your code here.

# Head pointer
addi $a0, $0, 16
addi $v0, $0, 9
syscall
add $s0, $zero, $v0

# Tail pointer
addi $a0, $0, 16
addi $v0, $0, 9
syscall
add $s1, $zero, $v0

sw $s1, 8($s0) # head->next = tail
sw $s0, 12($s1) # tail->prev = head

  # Now allocate memory for the first inventory node (node1)
    addi $a0, $zero, 16   # 16 bytes (4 words)
    addi $v0, $zero, 9    # syscall for sbrk
    syscall
    add $t0, $zero, $v0   # $t0 = node1

    # Set data for node1 (itemNumber = 100, count = 5)
    addi $t1, $zero, 100  # $t1 = itemNumber
    sw $t1, 0($t0)        # node1->itemNumber = 100
    addi $t1, $zero, 5    # $t1 = count
    sw $t1, 4($t0)        # node1->count = 5

    # Link node1 between head and tail
    sw $t0, 8($s0)       # head->next = node1
    sw $s0, 12($t0)      # node1->prev = head
    sw $s1, 8($t0)       # node1->next = tail
    sw $t0, 12($s1)      # tail->prev = node1

    # Allocate memory for the second inventory node (node2)
    addi $a0, $zero, 16   # 16 bytes (4 words)
    addi $v0, $zero, 9    # syscall for sbrk
    syscall
    add $t2, $zero, $v0   # $t2 = node2

    # Set data for node2 (itemNumber = 200, count = 10)
    addi $t1, $zero, 200  # $t1 = itemNumber
    sw $t1, 0($t2)        # node2->itemNumber = 200
    addi $t1, $zero, 10   # $t1 = count
    sw $t1, 4($t2)        # node2->count = 10

    # Insert node2 after node1 and before tail
    sw $t2, 8($t0)       # node1->next = node2
    sw $t0, 12($t2)      # node2->prev = node1
    sw $s1, 8($t2)       # node2->next = tail
    sw $t2, 12($s1)      # tail->prev = node2

    # Print the inventory list to confirm setup
    jal print_list



# Reading User Input
# jal read_input

# read_input:
# # Read item number
# addi $v0, $0, 5
# syscall
# add $t0, $zero, $v0

# # If itemNumber is 0, print the inventory and stop
# beq $t0, $zero, print_list


# # Read count
# addi $v0, $0, 5
# syscall
# add $t1, $zero, $v0

# # Create new node
# jal add_node

# # Checking if the item is already in the list
# jal find_item
# # if the item can't be found (return val 0), add it to the list
# beq $v0, 0, add_item

# # if the item is found, update the count
# jal update_count
# j read_input



# add_item:
# # Allocate memory for new node
# addi $a0, $0, 16
# addi $v0, $0, 9
# syscall





########## Helper code provided for you. Do not change! ########## 
print_list:
# Assumes head is in $s0, tail is in $s1, and data is organized
# as in the InventoryListNode struct from the assignment (hint:
# if it's not printing, check your offsets)

# Current node = head->next
lw $t2, 8($s0)            # t2 = current node
print_while:
# If current == tail, end the loop.
beq $t2, $s1, end_print_while 
    # Get and print item_num
    lw $a0, 0($t2)
    addi $v0, $0, 1
    syscall

    # print space
    addi $a0, $0, 32
    addi $v0, $0, 11
    syscall

    # Get and print count
    lw $a0, 4($t2)
    addi $v0, $0, 1
    syscall

    # print newline
    addi $a0, $0, 10
    addi $v0, $0, 11
    syscall

    # current = current->next
    lw $t2, 8($t2)
    j print_while

end_print_while:
# Print end message
la $a0, end_str # This is a pseudoinstruction
addi $v0, $0, 4
syscall

end:
    addi $v0, $0, 10
    syscall