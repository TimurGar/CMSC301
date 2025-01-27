          .data #This is boilerplate stuff to get QTSPIM to read this file the right way
          .text
          .align 2
          .globl main 
# Code goes here

init:
    # Setup initial values of variables
    # This is where you should define your testcases.
    # Comment out all but the one you are using,
    # but include them all in your submission. 

    # initializing input variables

    # # Test case 1, A = 0 PASSED
    # addi $s0, $0, 1 # a
    # addi $s1, $0, 3 # b
    # addi $s2, $0, 5 # c
    # addi $s3, $0, 6 # d

    # # Test case 2, A = 0 PASSED
    # addi $s0, $0, 8 # a
    # addi $s1, $0, 9 # b
    # addi $s2, $0, 3 # c
    # addi $s3, $0, 4 # d

    # # Test case 3, A = 1 PASSED
    # addi $s0, $0, 2 # a
    # addi $s1, $0, 5 # b
    # addi $s2, $0, 3 # c
    # addi $s3, $0, 8 # d

    # # Test case 4, A = 1 PASSED
     addi $s0, $0, 4 # a
     addi $s1, $0, 5 # b
     addi $s2, $0, 3 # c
     addi $s3, $0, 4 # d



main:
   # This is where you write the code that 
   # solves the problem you were given.
    addi $s4, $0, 0 # e

    slt $t0, $s1, $s2 # t0 = 1: b < c
    bne $t0, $0, endif

    slt $t1, $s3, $s0 # t0 = 1: d < a
    bne $t1, $0, endif

    addi $s4, $s4, 1 # e += 1

    endif:

   

end:
#This is how to end your program gracefully. We will learn what this is doing later.
    addi $v0, $0, 10
    syscall