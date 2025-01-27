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

    # Testcase 1, e = 0 PASSED
    # addi $s0, $0, 0 # a
    # addi $s1, $0, 100 # b 
    # addi $s2, $0, 2 # c 
    # addi $s3, $0, 5 # d 

    # # Testcase 2, e = 10 PASSED
    # addi $s0, $0, 1 # a
    # addi $s1, $0, 100 # b 
    # addi $s2, $0, 2 # c 
    # addi $s3, $0, 5 # d 

    # # Testcase 3, e = 4 PASSED
    # addi $s0, $0, 2 # a
    # addi $s1, $0, 3 # b 
    # addi $s2, $0, 2 # c 
    # addi $s3, $0, 5 # d 

    # Testcase 4, e = 6 PASSED
    # addi $s0, $0, 4 # a
    # addi $s1, $0, 8 # b 
    # addi $s2, $0, 3 # c 
    # addi $s3, $0, 6 # d 

    # Testcase 5, e = 5 PASSED
    addi $s0, $0, 2 # a
    addi $s1, $0, 4 # b 
    addi $s2, $0, 2 # c 
    addi $s3, $0, 4 # d 


main:
    # This is where you write the code that 
    # solves the problem you were given.

    addi $s4, $0, 0 # e = 0
    add $t0, $0, $s0 # i = a

    # while i < b
    while:
    slt $t1, $t0, $s1 # i < b -> 1
    beq $t1, $0, endWhile # 1 != 0 -> stay

        # t2 = i % c
        div $t0, $s2
        mfhi $t2
        # t3 = i % d
        div $t0, $s3
        mfhi $t3

        bne $t2, $0, endIf # if t2 == 0
            bne $t3, $0, endIf # if t3 == 0
                add $s4, $s4, $t0 # e = i
                j after

        endIf:
        addi $t0, $t0, 1
        j while

    endWhile:
    addi $s4, $s1, 1

    after:

   

end:
#This is how to end your program gracefully. We will learn what this is doing later.
    addi $v0, $0, 10
    syscall