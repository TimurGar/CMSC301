          .data 
            ok_message: .asciiz "Ok\n"
            not_passing_message: .asciiz "Testcase not passing.\n"

      # Here are two example testcases:
      test1_target: .word 25 5
      test1_array: .word 0 10 20 30 40
      test1_output: .word -1 # 25 is not in the array

      # test1_target: .word 25 5
      # test1_array: .word 40 30 20 10 0
      # test1_output: .word -1 # 25 is not in the array

      # test2_target: .word 20 4
      # test2_array: .word 0 10 20 30
      # test2_output: .word 2 # 20 is in the array at index 2

      # test2_target: .word 20 4
      # test2_array: .word 40 30 20 10 0
      # test2_output: .word 2 # 20 is in the array at index 2


      # Add your testcases here.


      # Add anything else you would like to include in static memory.


          .text
          .align 2
          .globl main 

main:
      # How to run testcases:
      la $a0, test1_target
      addi $a1, $a0, 4
      la $a2, test1_array
      la $a3, test1_output
      jal test_binary_search

      # la $a0, test2_target
      # addi $a1, $a0, 4
      # la $a2, test2_array
      # la $a3, test2_output
      # jal test_binary_search
      # add $t7, $0, $v0 

      # Run your additional testcases here.

j end

# Implement your functions here.

# a2 - pointer to the array
# a1 - pointer to the array size

# For the func
# a0 - target 
# a1 - pointer to the array 
# a2 - start index
# a3 - end index 
recursive_binary_search:

  # if start > end -> return -1
  slt $t0, $a2, $a3
  beq $t0, $0, not_found

  # finding the middle ind ($t1)
  add $t1, $a2, $a3
  srl $t1, $t1, 1 # sum // 2

  # finding the array[mid] val
  # calculating offset ($t2)
  sll $t2, $t1, 2 # mid ind * 4
  add $t3, $a1, $t2 # new address with offset
  lw $t4, 0($t3) # array[mid] value ($t4)

  # if target == array[mid]:
  bne $a0, $t4, mid_not_equal_target
  add $v0, $0, $t1 # return mid
  j end_recursive_binary_search

mid_not_equal_target:
  slt $t5, $a0, $t4
  # beq $t5, $0, target_smaller_mid
  beq $t5, $0, target_bigger_mid

# target < array[mid]
target_smaller_mid:
  
  # For the func
  # a0 - target 
  # a1 - pointer to the array 
  # a2 - start index
  # a3 - end index 
  addi $sp, $sp, -16
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)
  sw $a2, 12($sp)
  sw $a3, 16($sp)


  # Calling the func to check if it's descending array
  jal largest_to_smallest
  
  # temporally output to t7
  add $t7, $0, $v0


  beq $v0, $0, small_to_large_target_smaller_mid

  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  lw $a2, 12($sp)
  lw $a3, 16($sp)
  addi $sp, $sp, 16

  # # larger to smaller
  # large_to_small_target_smaller_mid:
  #   addi $sp, $sp, -4
  #   sw $ra, 0($sp)

  #   addi $a2, $t1, 1 # start = mid+1
  #   addi $a3, $a3, 0 # end = end
  #   # recursively calling the func
  #   jal recursive_binary_search

  #   lw $ra, 0($sp)
  #   addi $sp, $sp, 4
  #   j end_recursive_binary_search

  # smaller to larger
  small_to_large_target_smaller_mid:
    # addi $sp, $sp, -16
    # sw $ra, 0($sp)
    # sw $a0, 4($sp)
    # sw $a1, 8($sp)
    # sw $a2, 12($sp)
    # sw $a3, 16($sp)
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    addi $a2, $a2, 0 # start = start
    addi $a3, $t1, -1 # end = mid-1
    # recursively calling the func
    jal recursive_binary_search

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    # lw $a0, 4($sp)
    # lw $a1, 8($sp)
    # lw $a2, 12($sp)
    # lw $a3, 16($sp)
    # addi $sp, $sp, 16
    j end_recursive_binary_search

# target > array[mid]:
target_bigger_mid:

  addi $sp, $sp, -16
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)
  sw $a2, 12($sp)
  sw $a3, 16($sp)

  # # Calling the func to check if it's descending array
  # addi $sp, $sp, -4
  # sw $ra, 0($sp)
  jal largest_to_smallest
  
  # # temporally output to t7

  # add $t7, $0, $v0

  beq $v0, $0, small_to_large_target_bigger_mid

  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  lw $a2, 12($sp)
  lw $a3, 16($sp)
  addi $sp, $sp, 16
  
  # # larger to smaller
  # large_to_small_target_bigger_mid:
  #   addi $sp, $sp, -4
  #   sw $ra, 0($sp)

  #   addi $a2, $a2, 0 # start = start
  #   addi $a3, $t1, -1 # end = mid-1
  #   # recursively calling the func
  #   jal recursive_binary_search

  #   lw $ra, 0($sp)
  #   addi $sp, $sp, 4
  #   j end_recursive_binary_search

  # smaller to larger
  small_to_large_target_bigger_mid:
    # addi $sp, $sp, -16
    # sw $ra, 0($sp)
    # sw $a0, 4($sp)
    # sw $a1, 8($sp)
    # sw $a2, 12($sp)
    # sw $a3, 16($sp)
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    addi $a2, $t1, 1 # start = mid+1
    addi $a3, $a3, 0 # end = end
    # recursively calling the func
    jal recursive_binary_search

    # lw $ra, 0($sp)
    # lw $a0, 4($sp)
    # lw $a1, 8($sp)
    # lw $a2, 12($sp)
    # lw $a3, 16($sp)
    # addi $sp, $sp, 16
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    j end_recursive_binary_search

not_found:
  addi $v0, $0, -1
  j end_recursive_binary_search


end_recursive_binary_search:
  jr $ra

# Testing the recursive binary search 

# For the func
# a0 - pointer to the target 
# a1 - pointer to the size
# a2 - pointer to the array base address 
# a3 - pointer to the correct val
test_binary_search:

lw $t0, 0($a0) # t0 - target
lw $t1, 0($a1) # t1 - size
add $t2, $0, $a2 # t2 - pointer to the base address
lw $s0, 0($a3) # t3 - correct val

# a0 - target 
# a1 - pointer to the array 
# a2 - start index
# a3 - end index 
add $a0, $0, $t0
add $a1, $0, $t2
addi $a2, $0, 0
addi $t4, $t1, -1 # t4 - end ind
add $a3, $0, $t4

addi $sp, $sp, -4
sw $ra, 0($sp)
jal recursive_binary_search
lw $ra, 0($sp)

# temp output to t6
add $t6, $0, $v0

# Printing the message 
bne $v0, $s0, not_passing

la $a0, ok_message
addi $v0, $0, 4
syscall
j end_test_binary_search

not_passing:
  la $a0, not_passing_message
  addi $v0, $0, 4
  syscall

end_test_binary_search:
  addi $sp, $sp, 4
  jr $ra

# TESTING largest_to_smallest
# addi $sp, $sp, -4
# sw $ra, 0($sp)
# jal largest_to_smallest
# lw $ra, 0($sp)
# add $t6, $0, $v0
# addi $sp, $sp, 4
# jr $ra

# DO NOT FORGET TO SAVE $ra before calling func


# testing if the input array is largest to smallest
# if it is, return 1
# a2 - pointer to the array
# a1 - pointer to the array size
largest_to_smallest:

  # what we get from recursive_bs
  # a0 - target 
  # a1 - pointer to the array 
  # a2 - start index
  # a3 - end index 


    # calculating offset 4*(size-1)

    add $t0, $0, $a3 # array size
    addi $t2, $0, 4
    mult $t0, $t2 
    mflo $t0 # t0 is now the offset of the last element in the array

    # new address with offset
    add $t3, $a1, $t0

    lw $t0, 0($a1) # first element
    lw $t2, 0($t3) # last 

    slt $t4, $t0, $t2
    beq $t4, $0, largest_first
    # smallest first
    addi $v0, $0, 0
    j end_largest_to_smallest

    largest_first:
    addi $v0, $0, 1

    end_largest_to_smallest:
    jr $ra

end:
    addi $v0, $0, 10
    syscall