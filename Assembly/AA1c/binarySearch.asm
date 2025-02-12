          .data 
            ok_message: .asciiz "Ok\n"
            not_passing_message: .asciiz "Testcase not passing.\n"

      # Here are two example testcases:
      test1_target: .word 25 5
      test1_array: .word 0 10 20 30 40
      test1_output: .word -1 # 25 is not in the array

      test2_target: .word 20 4
      test2_array: .word 0 10 20 30
      test2_output: .word 2 # 20 is in the array at index 2

      # Add your testcases here.
      
      # Test Case 1 - Ascending
      test5_target: .word 15 5
      test5_array: .word 5 10 15 20 25
      test5_output: .word 2

      # Test Case 2 - Ascending
      test6_target: .word 35 5
      test6_array: .word 5 10 15 20 25
      test6_output: .word -1

      # Test Case 3 - Descending
      test7_target: .word 15 5
      test7_array: .word 25 20 15 10 5
      test7_output: .word 2

      # Test Case 4 - Descending
      test8_target: .word 0 5
      test8_array: .word 25 20 15 10 5
      test8_output: .word -1

      # Test Case 5 - Single element
      test9_target: .word 10 1
      test9_array: .word 10
      test9_output: .word 0

      # Test Case 6 - Single element
      test10_target: .word 5 1
      test10_array: .word 10
      test10_output: .word -1

      # first element and last testcase

      # Test Case 7 - Ascending, First Element
      test11_target: .word 5 5
      test11_array: .word 5 10 15 20 25
      test11_output: .word 0

      # Test Case 8 - Descending, First Element
      test12_target: .word 25 5
      test12_array: .word 25 20 15 10 5
      test12_output: .word 0

      # Test Case 9 - Ascending, Last Element
      test13_target: .word 20 4
      test13_array: .word 5 10 15 20 
      test13_output: .word 3

      # Test Case 10 - Descending, Last Element
      test14_target: .word 10 4
      test14_array: .word 25 20 15 10
      test14_output: .word 3

    

          .text
          .align 2
          .globl main 

main:
    #   How to run testcases:
      la $a0, test1_target
      addi $a1, $a0, 4
      la $a2, test1_array
      la $a3, test1_output
      jal test_binary_search

      la $a0, test2_target
      addi $a1, $a0, 4
      la $a2, test2_array
      la $a3, test2_output
      jal test_binary_search

      # Run your additional testcases here.

      # Running Test Case 1
      la $a0, test5_target
      addi $a1, $a0, 4
      la $a2, test5_array
      la $a3, test5_output
      jal test_binary_search

      # Running Test Case 2
      la $a0, test6_target
      addi $a1, $a0, 4
      la $a2, test6_array
      la $a3, test6_output
      jal test_binary_search

      # Running Test Case 3
      la $a0, test7_target
      addi $a1, $a0, 4
      la $a2, test7_array
      la $a3, test7_output
      jal test_binary_search

      # Running Test Case 4
      la $a0, test8_target
      addi $a1, $a0, 4
      la $a2, test8_array
      la $a3, test8_output
      jal test_binary_search

      # Running Test Case 5
      la $a0, test9_target
      addi $a1, $a0, 4
      la $a2, test9_array
      la $a3, test9_output
      jal test_binary_search

      # Running Test Case 6
      la $a0, test10_target
      addi $a1, $a0, 4
      la $a2, test10_array
      la $a3, test10_output
      jal test_binary_search

      # Running Test Case 7
      la $a0, test11_target
      addi $a1, $a0, 4
      la $a2, test11_array
      la $a3, test11_output
      jal test_binary_search

      # Running Test Case 8
      la $a0, test12_target
      addi $a1, $a0, 4
      la $a2, test12_array
      la $a3, test12_output
      jal test_binary_search

      # Running Test Case 9
      la $a0, test13_target
      addi $a1, $a0, 4
      la $a2, test13_array
      la $a3, test13_output
      jal test_binary_search

      # Running Test Case 10
      la $a0, test14_target
      addi $a1, $a0, 4
      la $a2, test14_array
      la $a3, test14_output
      jal test_binary_search

j end

# a0 - target 
# a1 - pointer to the array 
# a2 - start index
# a3 - end index 
ascending_recursive_binary_search:
  addi $sp, $sp, -20
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)
  sw $a2, 12($sp)
  sw $a3, 16($sp)

  # if start >= end -> return -1
  slt $t0, $a3, $a2
  bne $t0, $0, not_found_asc

  # finding the middle ind ($t1)
  add $t1, $a2, $a3
  srl $t1, $t1, 1 # sum // 2

  # finding the array[mid] val
  # calculating offset ($t2)
  sll $t2, $t1, 2 # mid ind * 4
  add $t3, $a1, $t2 # new address with offset
  lw $t4, 0($t3) # array[mid] value ($t4)

  # if target == array[mid]:
  bne $a0, $t4, mid_not_equal_target_asc
  # FOUND VALUE
  add $v0, $0, $t1 # return mid
  j end_ascending_recursive_binary_search

mid_not_equal_target_asc:
  # target < array[mid] -> 1
  slt $t5, $a0, $t4
  bne $t5, $0, target_smaller_mid_asc

  # target > array[mid] 
  target_bigger_mid_asc:
  
  addi $a2, $t1, 1 # start = mid+1
  addi $a3, $a3, 0 # end = end
  # recursively calling the func
  jal ascending_recursive_binary_search

  j end_ascending_recursive_binary_search

  target_smaller_mid_asc:

  addi $a2, $a2, 0 # start = start
  addi $a3, $t1, -1 # end = mid-1
  # recursively calling the func
  jal ascending_recursive_binary_search

  j end_ascending_recursive_binary_search


not_found_asc:
  addi $v0, $0, -1
  j end_ascending_recursive_binary_search

end_ascending_recursive_binary_search:
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  lw $a2, 12($sp)
  lw $a3, 16($sp)
  addi $sp, $sp, 20
  jr $ra


descending_recursive_binary_search:
addi $sp, $sp, -20
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)
  sw $a2, 12($sp)
  sw $a3, 16($sp)

  # if start < end -> return -1
  slt $t0, $a3, $a2
  bne $t0, $0, not_found_des

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


# a0 - target 
# a1 - pointer to the array 
# a2 - start index
# a3 - end index 
recursive_binary_search:
# saving everything on the stack
addi $sp, $sp, -20
sw $ra, 0($sp)
sw $a0, 4($sp)
sw $a1, 8($sp)
sw $a2, 12($sp)
sw $a3, 16($sp)


add $t0, $a2, $0 # 0
add $t1, $a3, $0 # 3

# get the address of the first and last items
add $t0, $a1, $t0 # address of the first item
sll $t1, $t1, 2 # end * 4
add $t1, $a1, $t1 # address of the last item

lw $t0, 0($t0) # array[start] - $t0
lw $t1, 0($t1) # array[end]  - $t1

# # Checking if array has only one element
# beq $t0, $t1, one_element

# Checking if the array if the first item is less than the last item
slt $t4, $t0, $t1 # 0 < 3 -> 1 
beq $t4, $0, Descending


# calling ascending function
Ascending:
jal ascending_recursive_binary_search  

# # temp printing output
# addi $a0, $v0, 0
# add $a0, $0, $v0
# addi $v0, $0, 1
# syscall 

j end_search

# calling descending function
Descending:
jal descending_recursive_binary_search

# # temp printing output
# addi $a0, $v0, 0
# add $a0, $0, $v0
# addi $v0, $0, 1
# syscall 

j end_search


end_search:
lw $ra, 0($sp)
lw $a0, 4($sp)
lw $a1, 8($sp)
lw $a2, 12($sp)
lw $a3, 16($sp)
addi $sp, $sp, 20
jr $ra



# a0 - pointer to the target 
# a1 - pointer to the size
# a2 - pointer to the array base address 
# a3 - pointer to the correct val
test_binary_search:
  # checking if the array is ascending or descending
  addi $sp, $sp, -20
  sw $ra, 0($sp)
  sw $a0, 4($sp) 
  sw $a1, 8($sp) # - pointer to the size
  sw $a2, 12($sp) # - pointer to the array base address
  sw $a3, 16($sp)
  

  # Adjusting parameters for the RBS function
  lw $t0, 0($a1) # size
  addi $t0, $t0, -1
  add $a3, $0, $t0 # end index

  lw $a0, 0($a0) # target
  add $a1, $0, $a2 # pointer to the base address
  addi $a2, $0, 0 # start index
  
  jal recursive_binary_search
  
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  lw $a2, 12($sp)
  lw $a3, 16($sp)
  addi $sp, $sp, 20

  # PRINGTING TEXT OUTPUT
  addi $t1, $0, 0 
  lw $t1, 0($a3) # loading correct value
  bne $v0, $t1, not_passing

  passing:
  la $a0, ok_message
  addi $v0, $0, 4
  syscall
  j end_test_binary_search

  not_passing:
  la $a0, not_passing_message
  addi $v0, $0, 4
  syscall

  end_test_binary_search:
    jr $ra
  
end:
    addi $v0, $0, 10
    syscall