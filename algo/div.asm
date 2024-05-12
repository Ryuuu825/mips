# perform division
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
    add $t3, $zero, $s0

    li $t4, 1
    sll $t4, $t4, 31
    and $t4, $t4, $t3
    srl $t4, $t4, 31 # carry bit

    sll $t2, $t2, 1
    sll $t3, $t3, 1


i_for_loop_start:
    beq $t0, $t1, i_for_loop_end

    sub $t4, $t2, $s1 

    # check if the number negative
    srl $t5, $t4, 31
    bne $t5, $zero, subtraction_end

    move $t2, $t4

subtraction_end:
    li $t4, 1
    sll $t4, $t4, 31
    and $t4, $t4, $t3
    srl $t4, $t4, 31 # carry bit

    sll $t2, $t2, 1
    sll $t3, $t3, 1

    or $t2, $t2, $t4 

    bne $t5, $zero, setlsb_end

    # set least signifant bit to 1
    addi $t3, $t3, 1

setlsb_end:

    addi $t0, $t0, 1 # i+= 1
    j i_for_loop_start
i_for_loop_end:

    # adjust reminder
    srl $t2, $t2, 1

   


