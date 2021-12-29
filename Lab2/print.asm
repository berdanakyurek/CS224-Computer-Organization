
main:
	jal readArray
	
	# $v0 = starting address
	# $v1 = array length
	
	move $a0, $v0
	move $a1, $v1
	
	jal print
	
	# stop execution here by syscall
	li  $v0, 10
	syscall
print: 
	
	# $s0 = start address
	# $s1 = length
	# $s2 = value to print
	# $s3 = address to iterate
	
	move $s0, $a0
	move $s1, $a1
	
	move $s3, $s0
	
	li $s3, 0
	
	ploop:
	beq $s3, $s1, pend
		lw $s2, 0($s0)
		move $a0, $s2
		li  $v0, 1
		syscall
		
		la $a0, space
        	li $v0, 4
        	syscall
        	
        	addi $s3, $s3, 1
        	addi $s0, $s0, 4
        	j ploop
	pend:
	la $a0, newl
        li $v0, 4
       	syscall
	
	jr $ra

readArray:
	
	# $s0 = length of array
	# $s1 = array data
	# $s2 = array starting address
	# $s3 = loop counter
	# $s4 = array element
	# $s5 = iterating address
	
	# Ask for array lenght
	la $a0, enterLprompt
        li $v0, 4
        syscall
        
        # Read array length
        li $v0, 5
        syscall
        
        # Store array length in $s0
        move $s0, $v0
        
        # Multiply array length with 4 and store in a0
        mul $a0, $s0, 4
        
        # Allocate memory for array
	li $v0, 9
	syscall
	
	# Store starting address of array in $s2
        move $s2, $v0
        
        # Ask for array elements using loop
        
        # $s3 = loop counter
        
        li $s3, 0
        
        addi $s5, $s2, 0
        
        loop:
        beq $s3, $s0, end
        	# Ask for array element
		la $a0, enterintprompt
        	li $v0, 4
        	syscall
        	
        	# Read element
        	li $v0, 5
        	syscall
        	
        	# Store element in $s4
        	move $s4, $v0
        	
        	
        	# store word in array
        	
        	sw $s4, 0($s5)
        	addi $s3, $s3, 1
        	addi $s5, $s5, 4
        	
        	j loop
        end:
        
        # return size and starting address
        move $v0, $s2
        move $v1, $s0
        
        # finish subprogram 
	jr $ra
	
	
.data
	enterLprompt: .asciiz "Enter array length: "
	enterintprompt: .asciiz "Enter an integer for array: "
	newl: .asciiz "\n"
	space: .asciiz " "