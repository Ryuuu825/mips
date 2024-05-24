.data
inputMsgSize: .asciiz "Enter the size of the array(<=100): "
inputMsgError: .asciiz "You need to enter the size less than or equal to 100"
inputMsg: .asciiz "Enter the "
inputMsg1: .asciiz " number: "
newLine: .asciiz "\n"
space: .asciiz " "

.text

.globl __main

__main:
	addi $sp, $sp, -808
	la $s0, 0($sp) #inputArray address
	la $s1, 400($sp) #size address
	la $s3, 404($sp) #outputArray address
	la $s4, 804($sp) #outputArray size address
	
	move $a0, $s0
	move $a1, $s1
	jal EnterInputArray
	
	lw $s2, 0($s1)
	
	move $a0, $s0
	move $a1, $s2
	jal PrintArray
	
	move $a0, $s0
	move $a1, $s2
	jal MergeSort
	
	move $s4, $v1
	move $a0, $v0
	move $a1, $s3
	move $a2, $v1
	jal CopyArrayByValue
	
	
	move $a0, $s3
	move $a1, $s4
	jal PrintArray
	
	
	li $v0, 10
	syscall



EnterInputArray:
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $a0, 8($sp)
	sw $a1, 12($sp)

SizeLoop:
	li $v0, 4
	la $a0, inputMsgSize
	syscall
	
	li $v0, 5
	syscall
	
	sgeu $t0, $v0, 101 #1
	slti $t1, $v0, 1 #1
	
	or $t0, $t0, $t1
	bne $t0, $zero, WrongSize
	j SizeOK
	
WrongSize:
	li $v0, 4
	la $a0, inputMsgError
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	j SizeLoop
	
SizeOK:	
	lw $a0, 8($sp)
	lw $a1, 12($sp)
	
	sw $v0, 0($a1)
	
	move $s0, $v0 #size
	li $t0, 0 #i
	
EnterInputStartLoop:
	beq $t0, $s0, EnterInputEndLoop
	
	li $v0, 4
	la $a0, inputMsg
	syscall
	
	addi $t1, $t0, 1
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, inputMsg1
	syscall
	
	li $v0, 5
	syscall
	
	lw $a0, 8($sp)
	lw $a1, 12($sp)
	
	sll $t1, $t0, 2
	add $t1, $a0, $t1
	sw $v0, 0($t1)

	addi $t0, $t0, 1
	j EnterInputStartLoop
	
EnterInputEndLoop:

	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $a0, 8($sp)
	lw $a1, 12($sp)
	addi $sp, $sp, 16

	jr $ra
	
PrintArray:

	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $a0, 12($sp)
	sw $a1, 16($sp)
	
	li $t0, 0 #i
PrintStartLoop:
	beq $t0, $a1, PrintEndLoop
	
	lw $a0, 12($sp)
	lw $a1, 16($sp)
	
	sll $t1, $t0, 2
	add $t1, $a0, $t1
	lw $a0, 0($t1)
	
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall
	
	
	addi $t0, $t0, 1
	j PrintStartLoop
	
	

PrintEndLoop:
	la $a0, newLine
	li $v0, 4
	syscall
	
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addi $sp, $sp, 20
	jr $ra
	
CopyArrayByValue:
	#a0: source
	#a1: destination
	#a2: size
	
	li $t0, 0 #i

CopyLoop:
	beq $t0, $a2, EndCopyLoop
	sll $t1, $t0, 2
	add $t2, $a0, $t1 #source[i]
	add $t3, $a1, $t1 #destination[i]
	lw $t2, 0($t2)
	sw $t2, 0($t3)
	addi $t0, $t0, 1
	j CopyLoop

EndCopyLoop:
	jr $ra
	
MergeSort:
	addi $sp, $sp, -856
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)
	sw $a0, 36($sp)
	sw $a1, 40($sp)
	la $s0, 44($sp) #left array
	la $s1, 244($sp) #left array size
	la $s2, 248($sp) #right array
	la $s3, 448($sp) #right array size
	la $s5, 452($sp) #merge array
	la $s6, 852($sp) #merge array size
	
	slti $t0, $a1, 2
	bne $t0, $zero, ArraySizeLessThan2
	
	li $t0, 2
	div $a1, $t0 
	mflo $s4 #mid
	
	move $a1, $s4
	jal MergeSort
	
	sw $v1, 0($s1)
	
	move $a0, $v0
	move $a1, $s0
	move $a2, $v1
	jal CopyArrayByValue
	
	lw $a0, 36($sp)
	lw $a1, 40($sp)
	
	sll $t0, $s4, 2
	add $a0, $a0, $t0
	sub $a1, $a1, $s4
	jal MergeSort
	
	sw $v1, 0($s3)
	
	move $a0, $v0
	move $a1, $s2
	move $a2, $v1
	jal CopyArrayByValue
	
	
	move $a0, $s0
	lw $a1, 0($s1)
	move $a2, $s2
	lw $a3, 0($s3)
	jal Merge
	
	sw $v1, 0($s6)

	move $a0, $v0
	move $a1, $s5
	move $a2, $v1
	jal CopyArrayByValue
	
	
	#li $v0, 1
	#move $a0, $s6
	#syscall
	#move $a0, $s5
	#move $a1, $s6
	#jal PrintArray
	
	move $v0, $s5
	lw $v1, 0($s6)
	
	j MergeSortEnd

ArraySizeLessThan2: 
	move $v0, $a0
	move $v1, $a1

MergeSortEnd:	
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	lw $a0, 36($sp)
	lw $a1, 40($sp)
	addi $sp, $sp, 856
	jr $ra
	
Merge:
	addi $sp, $sp, -636
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)
	sw $a0, 36($sp)
	sw $a1, 40($sp)
	sw $a2, 44($sp)
	sw $a3, 48($sp)
	la $s0, 52($sp) #result array
	la $s1, 452($sp) #result array size
	sw $zero, 0($s1)
	
	li $t0, 0 #i
	li $t1, 0 #j
	
MergeFirstStartLoop:
	slt $t2, $t0, $a1
	slt $t3, $t1, $a3
	and $t2, $t2, $t3
	beq $t2, $zero, MergeFirstEndLoop
	
MergeFirstLoopStartIf:
	sll $t2, $t1, 2
	add $t2, $a2, $t2
	lw $t2, 0($t2) #arr2[j]
	sll $t3, $t0, 2
	add $t3, $a0, $t3
	lw $t3, 0($t3) #arr1[i]
	slt $t4, $t3, $t2
	beq $t4, $zero, MergeFirstLoopElseIf
	
	lw $t4, 0($s1)
	sll $t5, $t4, 2
	add $t5, $s0, $t5
	sw $t3, 0($t5)
	addi $t4, $t4, 1
	sw $t4, 0($s1)
	
	addi $t0, $t0, 1
	j MergeFirstLoopEndIf
	
MergeFirstLoopElseIf:
	lw $t4, 0($s1)
	sll $t5, $t4, 2
	add $t5, $s0, $t5
	sw $t2, 0($t5)
	addi $t4, $t4, 1
	sw $t4, 0($s1)
	
	addi $t1, $t1, 1

MergeFirstLoopEndIf:
	j MergeFirstStartLoop
	
	
MergeFirstEndLoop:

MergeSecondStartLoop:

	slt $t2, $t0, $a1
	beq $t2, $zero, MergeSecondEndLoop
	
	sll $t3, $t0, 2
	add $t3, $a0, $t3
	lw $t3, 0($t3) #arr1[i]
	
	lw $t4, 0($s1)
	sll $t5, $t4, 2
	add $t5, $s0, $t5
	sw $t3, 0($t5)
	addi $t4, $t4, 1
	sw $t4, 0($s1)
	
	addi $t0, $t0, 1
	j MergeSecondStartLoop

MergeSecondEndLoop:

MergeThirdStartLoop:
	slt $t3, $t1, $a3
	beq $t3, $zero, MergeThirdEndLoop
	
	sll $t2, $t1, 2
	add $t2, $a2, $t2
	lw $t2, 0($t2) #arr2[j]
	
	lw $t4, 0($s1)
	sll $t5, $t4, 2
	add $t5, $s0, $t5
	sw $t2, 0($t5)
	addi $t4, $t4, 1
	sw $t4, 0($s1)
	
	addi $t1, $t1, 1
	j MergeThirdStartLoop

MergeThirdEndLoop:
	move $v0, $s0 #result array
	lw $t2, 0($s1)
	move $v1, $t2
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
	lw $a0, 36($sp)
	lw $a1, 40($sp)
	lw $a2, 44($sp)
	lw $a3, 48($sp)
	
	addi $sp, $sp, 636
	
	jr $ra







