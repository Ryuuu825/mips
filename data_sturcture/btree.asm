# a binary tree structure

.data
# --------------------------------------------
# node (12 bytes)
# --------------------------------------------
# left - 4 bytes         
#   address of left child   
# right - 4 bytes
#   address of right child
# value - 4 bytes
#   value of the node
# --------------------------------------------
.eqv NODE_SIZE 12
.eqv LEFT_OFFSET 0
.eqv RIGHT_OFFSET 4
.eqv VALUE_OFFSET 8

.eqv NODE_NUM 10
.eqv TREE_SIZE 120

.eqv NULL 0x7FFFFFFF
tree: .word 0x7FFFFFFF:TREE_SIZE # NULL (value field) is reserved

.text
.globl _start
_start:
    
    la $a0, tree
    jal print_tree
    j end


print_tree:
# print the tree in inorder
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    # --------------------------------------------
    # $a0: root
    # --------------------------------------------
    # check is nullptr
    li $t0, NULL
    lw $t1, 0($a0)
    beq $t0, $t1, print_tree_end
    
    # left
    li $t0, LEFT_OFFSET
    lw $a0, 4($sp)
    add $a0, $a0, $t0
    jal print_tree

    # middle
    lw $a0, 4($sp)
    lw $a0, VALUE_OFFSET($a0)
    li $v0, 1
    syscall

    li $t0, RIGHT_OFFSET
    lw $a0, 4($sp)
    add $a0, $a0, $t0
    jal print_tree

print_tree_end:
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    addi $sp, $sp, 8
    jr $ra


end: