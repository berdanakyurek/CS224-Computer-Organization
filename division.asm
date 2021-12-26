.data
	askdivident: .asciiz "Enter divident: " 
	askdivisor: .asciiz "Enter divisor: " 
	quot: .asciiz "Quotient: "
	rema: .asciiz "Remainder: "
	newline: .asciiz "\n"
	
.text

# $s0 = divident
# $s1 = divisor
# $s2 = quotient
# $s3 = remainder

# ask for divident

li $v0, 4
la $a0, askdivident
syscall

# store divident in $s0

li $v0, 5

syscall
move $s0, $v0

# ask for divisor

li $v0, 4
la $a0, askdivisor
syscall

# store divisor in $s1

li $v0, 5

syscall
move $s1, $v0

# copy divident to $t0 to change

addi $t0, $s0, 0

# set quotient to 0

addi $s2, $zero, 0

# division

loop:

slt $t1, $t0, $s1 # if divident > divisor, $t1 = 0
beq $t1, 1, exit  # if divident < divisor, exit

addi $s2, $s2, 1
sub $t0, $t0, $s1

j loop

exit:

addi $s3, $t0, 0


# print the quotient

li $v0, 4
la $a0, quot
syscall

li $v0, 1
move $a0, $s2
syscall

# print new line 

li $v0, 4
la $a0, newline
syscall

# print the remainder 

li $v0, 4
la $a0, rema
syscall

li $v0, 1
move $a0, $s3
syscall
