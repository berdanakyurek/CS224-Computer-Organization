#create array
.data
	prompt: .asciiz "Enter no of elements: " 
	promptarr: .asciiz "Enter input for array: "	
	space: .asciiz " "
	newline: .asciiz "\n"
	arr: .space 80
	arr2: .space 80
.text

# array base address = $s0
# index = $t0
# number of elements = $s1
# current element = $t1



# print enter numbers

li $v0, 4
la $a0, prompt
syscall

# take input from user

li $v0, 5
syscall

# store input in $s0

move $s1, $v0

addi $t0, $zero, 0

# $s1 times take an input for array with loop and store results in array

loop:
beq $t0, $s1, exit

li $v0, 4
la $a0, promptarr
syscall

li $v0, 5
syscall

move $t1, $v0

sb $t1 arr($t0)

addi $t0, $t0, 1

j loop

exit:

# print array using loop

addi $t0, $zero, 0
 
loop2:

beq $t0, $s1, exit2

lb $t1, arr($t0)

li $v0, 1
move $a0, $t1
syscall

li $v0, 4
la $a0, space
syscall

addi $t0, $t0, 1

j loop2

exit2:

li $v0, 4
la $a0, newline
syscall

# reverse array

# $t0 = index for arr
# $t2 = temporary element while turning
# $t3 = index for arr2

addi $t0, $zero, 0
add $t3, $zero, $s1
addi $t3, $t3, -1

loop3:

beq $t0, $s1, exit3

lb $t1, arr($t0)
sb $t1, arr2($t3)

addi $t0, $t0, 1
addi $t3, $t3, -1
j loop3

exit3:



# print arr2 (reversed array)

addi $t0, $zero, 0
 
loop4:

beq $t0, $s1, exit4

lb $t1, arr2($t0)

li $v0, 1
move $a0, $t1
syscall

li $v0, 4
la $a0, space
syscall

addi $t0, $t0, 1

j loop4

exit4: