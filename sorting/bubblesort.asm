# Bubble sort: https://www.geeksforgeeks.org/bubble-sort/

.data
array: .word 90, 80, 7, 6, 5, 4, 3
arraySize: .word 6

.globl main
.text
main: 

    la $a0, array
    la $a1, arraySize
    lw $a1, 0($a1)
    jal bubbleSort

    li $t0, 0
    la $t1, arraySize
    lw $t1, 0($t1)

print_loop:
    beq $t0, $t1, print_loop_end 

    la $t2, array
    sll $t3, $t0, 2
    add $t3, $t2, $t3
    lw $a0, 0($t3)
    li $v0, 1
    syscall

    li $a0, ' '
    li $v0, 11
    syscall

    addi $t0, $t0, 1
    j print_loop
print_loop_end:

    j exit

# $a0: array, $a1: size
bubbleSort: 
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

    move $s0, $a0
    move $s1, $a1

    # --------------------------------------------
    # $s0: address of array
    # $s1: n - 1 
    # $t2: i 
    # $t3: j
    # $t4: swapped
    # --------------------------------------------
    addi $t2, $zero, 0
    addi $t3, $zero, 0
    addi $t4, $zero, 0

bubbleSort_i_for_loop_start:

    # if i < n - 1
    move $t0, $s1
    sub $t0, $t0, 1
    beq $t2, $t0, bubbleSort_i_for_loop_end

    addi $t3, $zero, 0
    addi $t4, $zero, 0

bubbleSort_j_for_loop_start:
    
    # if j < n - 1 - i
    move $t0, $s1
    sub $t0, $t0, 1
    sub $t0, $t0, $t2
    beq $t3, $t0, bubbleSort_j_for_loop_end

    # --------------------------------------------
    # $t5: address arr[j]
    # $t6: address arr[j + 1]
    # $t7: value arr[j]
    # $t8: value arr[j + 1]
    # [ $t9 ]
    # --------------------------------------------
    sll $t5, $t3, 2
    add $t5, $t5, $s0
    lw $t7, 0($t5)

    lw $t8, 4($t5)

    blt $t7, $t8, bubbleSort_j_for_loop_swap_end
    # swapped the value of two address
    sw $t7, 4($t5)
    sw $t8, 0($t5)
    li $t4, 1 # indicate true

bubbleSort_j_for_loop_swap_end:

    li $t9, 0
    beq $t4, $t9, bubbleSort_end

    # j++
    addi $t3, $t3, 1
    j bubbleSort_j_for_loop_start
bubbleSort_j_for_loop_end:

    # i++
    addi $t2, $t2, 1
    j bubbleSort_i_for_loop_start

bubbleSort_i_for_loop_end:
bubbleSort_end:

    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12

    jr $ra

exit:
   
