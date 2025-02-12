'''
# Calculating the middle index ($t2)
add $t2, $a2, $a3 # start + end
srl $t2, $t2, 1 # sum // 2

# finding the array[mid] val
# calculating offset
sll $t3, $t2, 2 # mid ind * 4
add $t3, $a1, $t3 # new address with offset
lw $t4, 0($t3) # array[mid] value ($t4)


  # if target == array[mid]:
  beq $a0, $t4, found
'''  

'''
  # If target > array[mid], search in the right half (start = mid + 1)
  slt $t5, $a0, $t4
  beq $t5, $0, search_right_asc

  # Else search in the left half (end = mid - 1)
  j search_left_asc


search_left_asc:
  addi $a3, $t2, -1 # end = mid - 1
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  jal recursive_binary_search

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

search_right_asc:
  addi $a2, $t2, 1 # start = mid + 1
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  jal recursive_binary_search

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
'''

addi $sp, $sp, -20
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)
  sw $a2, 12($sp)
  sw $a3, 16($sp)

  # if start > end -> return -1
  slt $t0, $a2, $a3
  beq $t0, $0, not_found_des

  # finding the middle ind ($t1)
  add $t1, $a2, $a3
  srl $t1, $t1, 1 # sum // 2

  # finding the array[mid] val
  # calculating offset ($t2)
  sll $t2, $t1, 2 # mid ind * 4
  add $t3, $a1, $t2 # new address with offset
  lw $t4, 0($t3) # array[mid] value ($t4)

  # if target == array[mid]:
  bne $a0, $t4, mid_not_equal_target_des
  # FOUND VALUE
  add $v0, $0, $t1 # return mid
  j end_descending_recursive_binary_search

mid_not_equal_target_des:
  # target < array[mid] -> 1
  slt $t5, $a0, $t4
  bne $t5, $0, target_smaller_mid_des

  # target > array[mid] 
  target_bigger_mid_des:
  addi $a2, $a2, 0 # start = start
  addi $a3, $t1, -1 # end = mid-1
  # recursively calling the func
  jal descending_recursive_binary_search

  j end_descending_recursive_binary_search

  target_smaller_mid_des:

  addi $a2, $t1, 1 # start = mid+1
  addi $a3, $a3, 0 # end = end
  # recursively calling the func
  jal descending_recursive_binary_search

  j end_descending_recursive_binary_search


not_found_des:
  addi $v0, $0, -1
  j end_descending_recursive_binary_search

end_descending_recursive_binary_search:
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  lw $a2, 12($sp)
  lw $a3, 16($sp)
  addi $sp, $sp, 20
  jr $ra