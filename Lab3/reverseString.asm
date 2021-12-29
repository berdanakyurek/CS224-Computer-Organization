.data
	string1: .asciiz "cs2240"
	string2: .asciiz "abced"
.text

main:

# set subprogram inputs
la  $a0, string1 
la  $a1, string2
li $a2, 0

# call subprogram
jal reverseString

# print reversed string
la $a0, string2
li $v0, 4
syscall

#finish program
li $v0,10
syscall	







# $a0 = string1
# $a1 = string2
reverseString: # TODO

# store values
addi $sp,$sp,-8
sw $ra, 0 ($sp)
sw $a0, 4 ($sp)

lb $s0, 0($a0)
beq $s0, 0, end

addi $a0, $a0, 1
addi $a2, $a2, 1
jal reverseString

lw $a0, 4 ($sp)
lb $t2, 0($a0)
sb $t2, 0($a1)
addi $a1, $a1, 1
end:
lw $ra, 0 ($sp)
addi $sp,$sp,8
jr $ra



