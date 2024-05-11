# perform mutlply operation
.data
msg1: .asciiz  "Enter the first number: "
msg2: .asciiz "Enter the second number: "
msg3: .asciiz "The result is: \n"

.globl main
.text
main:
    la $a0, msg1
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s0, $v0 

    la $a0, msg2
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $s1, $v0 

    la $a0, msg3
    li $v0, 4
    syscall
    

    # --------------------------------------------
    # $t0: i
    # $t1: the interation needed
    # $t2: hi register
    # $t3: lo register
    # --------------------------------------------
    addi $t0, $zero, 0 
    addi $t1, $zero, 32 
    add $t2, $zero, $zero
    add $t3, $zero, $s1

i_for_loop_start:
    beq $t0, $t1, i_for_loop_end

    and $t4, $t3, 1
    beq $t4, $zero, addition_end

    add $t2, $s0, $t2

addition_end:
    and $t4, $t2, 1 # used to shift this bit to lo register
    srl $t2, $t2, 1
    srl $t3, $t3, 1

    sll $t4, $t4, 31
    or $t3, $t3, $t4

    addi $t0, $t0, 1 # i+= 1
    j i_for_loop_start
i_for_loop_end:




    

   


