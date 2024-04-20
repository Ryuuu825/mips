# Two sum
.data
nums: .word 2, 7, 11, 15
numsSize: .word 4
target: .word 9
returnSize: .word 0

comment: .asciiz "Two sum: \n"

.globl main
.text 

main:

    la $a0, nums
    lw $a1, numsSize
    lw $a2, target
    la $a3, returnSize
    jal TwoSum
    move $t0, $v0

    la $a0, comment
    li $v0, 4
    syscall

    lw $a0, 0($t0)
    li $v0, 1
    syscall

    li $a0, ' '
    li $v0, 11
    syscall

    lw $a0, 4($t0)
    li $v0, 1
    syscall

    j exit



# O(n^2) solution
# int* twoSum(int* nums, int numsSize, int target, int* returnSize)
# $a0: nums (int*), $a1: numsSize(int), $a2: target(int), $a3: returnSize(int*)
# $v0: return value(int*)
TwoSum:
    addi $sp, $sp, -20
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $a2, 12($sp)
    sw $a3, 16($sp)

    # allocate memory for return value
    # int* ret = (int*)malloc(2 * sizeof(int));
    # --------------------------------------------
    # $v0: int array pointer
    # --------------------------------------------
    addi $a0, $zero, 8  # 2 elements
    li $v0, 9
    syscall
    sw $v0, 20($sp)  # store the return value

    li $t0, 0  # i
i_for_loop_start:
    beq $t0, $a1, i_for_loop_end

    li $t1, 0  # j
j_for_loop_start:
    beq $t1, $a1, j_for_loop_end

    # --------------------------------------------
    # $t2: address of nums
    # $t3: address of nums[i] / value
    # $t4: address of nums[j] / value
    # --------------------------------------------
    lw $t2, 4($sp)          # nums
    sll $t3, $t0, 2  
    add $t3, $t3, $t2       # address of nums[i]
    lw $t3, 0($t3)          # value of nums[i]

    sll $t4, $t1, 2         # j * 4
    add $t4, $t4, $t2       # address of nums[j]
    lw $t4, 0($t4)          # value of nums[j]

    add $t5, $t3, $t4       # nums[i] + nums[j]

    bne $t5, $a2, two_sum_not_found

    lw $t6, 20($sp)         # result array
    sw $t0, 0($t6)          # array[0] = i
    sw $t1, 4($t6)          # array[1] = j
    j two_sum_found

two_sum_not_found:        
    addi $t1, $t1, 1
    j j_for_loop_start

j_for_loop_end:
    addi $t0, $t0, 1
    j i_for_loop_start    

i_for_loop_end:
two_sum_found:
    # restore the stack
    lw $ra, 0($sp)
    lw $v0, 20($sp)
    addi $sp, $sp, 20
    jr $ra

exit:
