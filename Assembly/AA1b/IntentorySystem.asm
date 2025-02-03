# AA2/IntentorySystem.asm
# By Timur 

          .data #This is boilerplate stuff to get QTSPIM to read this file the right way
    end_str: .asciiz "End of inventory report." # This is to print later.
          .text
          .align 2
          .globl main 

main:

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


# Reading User Input
jal read_input

read_input:
# Read item number
addi $v0, $0, 5
syscall
# Saving item number in $t0
add $t0, $zero, $v0

# If itemNumber is 0, print the inventory and stop
beq $t0, $zero, print_list


# Read count
addi $v0, $0, 5
syscall
# Saving count in $t1
add $t1, $zero, $v0

# # Create new node
# jal add_item

# Checking if the item is already in the list
jal find_item
# if the item can't be found (return val 0), add it to the list
beq $v0, $0, add_item

# saving the base address of the found node
addi $a0, $v0, 0
# if the item is found, update the count
jal update_count

after_add_item:
j read_input


find_item:
    lw $t2, 8($s0) # t2 = current node (head->next)
find_item_while:
    beq $t2, $s1, not_found # if current == tail, return 0
    lw $t3, 0($t2) # t3 = item_num
    beq $t3, $t0, found # if item_num == itemNumber, return 1

    lw $t2, 8($t2) # current = current->next
    j find_item_while

not_found:
    add $v0, $zero, $zero # return 0
    jr $ra

found:
    add $v0, $zero, $t2 # return the base address of the found node
    jr $ra

add_item:
# Allocating memory for new node
addi $a0, $zero, 16
addi $v0, $zero, 9
syscall
add $t2, $zero, $v0 # bass address of new node is in t2

# saving the item number and count
sw $t0, 0($t2) 
sw $t1, 4($t2) 

# Linking the new node to the list 
# !! t2 is the new node
lw $t3, 12($s1) # t3 is the last node 
sw $t2, 8($t3) # last node->next = new node
sw $t3, 12($t2) # new node->prev = last node
sw $s1, 8($t2) # new node->next = tail node
sw $t2, 12($s1)# tail->prev = new node

# jr $ra
j after_add_item

update_count:
# loading the found's node count 
lw $t3, 4($a0)  
add $t3, $t3, $t1 # adding the count change
sw $t3, 4($a0)        

# Checking if the count is <= 0
slt $t4, $t3, $0
bne $t4, $0, remove_item
beq $t3, $0, remove_item # removing item if current count == 0
jr $ra

# removing the item from the list
remove_item:
# $t3 - prev node
lw $t3, 12($a0)
# $t4 - next node
lw $t4, 8($a0)
sw $t4, 8($t3) # prev->next = next
sw $t3, 12($t4) # next->prev = prev
jr $ra

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