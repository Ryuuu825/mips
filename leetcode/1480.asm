# https://leetcode.com/problems/running-sum-of-1d-array/description/

.data 
nums: .word 1,2,3,4
numsSize: .word 4



.globl main
.text 

main:
    # --------------------------------------------
    # $t0, for loop i-index
    # $t1, base address of nums
    # --------------------------------------------
    addi $t0, $zero, 1
    la $s0, numsSize
    lw $s0, 0($s0)
    la $t1, nums

    i_for_loop_start:
        # --------------------------------------------
        # $t2, address of nums[i]
        # $t3, address of nums[i-1]
        # $t4, content of nums[i]
        # $t5, content of nums[i-1]
        # --------------------------------------------
        beq $t0, $s0, i_for_loop_end
        
        sll $t2, $t0, 2
        subi $t3, $t2, 4

        add $t2, $t2, $t1
        add $t3, $t3, $t1

        lw $t4, 0($t2)
        lw $t5, 0($t3)

        add $t4, $t4, $t5

        sw $t4, 0($t2)


        addi $t0, $t0, 1
        j i_for_loop_start
    
    i_for_loop_end:


