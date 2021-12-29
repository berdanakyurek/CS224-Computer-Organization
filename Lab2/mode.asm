main:
	jal readArray
	# $v0 = address of array
	# $v1 = size of array
	move $a0, $v0
	move $a1, $v1
	
	jal mode
	
	#print mode 
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	# stop execution here by syscall
	li  $v0, 10
	syscall

mode:	# returns mode in $v0

	#this part of the code sorts array from small to big
	
	# $s0 = starting address of array
	# $s1 = length of array
	# $s2 = loop counter 1
	# $s3 = loop counter 2
	# $s4 = address counter
	# $s5 = register to hold one value during swap
	# $s6 = value 1
	# $s7 = value 2
	
	# store length and starting address
	move $s0, $a0
	move $s1, $a1
	
	# set loop counters to 1
	li $s2, 1
	li $s3, 1
	
	
	
	# loops for sort
	
	sortloop1:
		beq $s2, $s1, exitsortloop1
		
		# set addres counter to starting address
		move $s4, $s0
		
		# set loop counter 2 to 1
		li $s3, 1
		
		sortloop2:
			beq $s3, $s1, exitsortloop2
			
			# load integers to registers
			lw $s6, 0($s4)
			lw $s7, 4($s4)
			
			# compare integers
			blt $s6, $s7, noSwap
			
			#swap
			
			move $s5, $s6
			move  $s6, $s7
			move $s7, $s5
			
			noSwap:
			
			# store new values in array
			sw $s6, 0($s4)
			sw $s7, 4($s4)
			
			# increase loop counter 2
			addi $s3, $s3, 1
			
			# increase address counter
			addi $s4, $s4, 4
						
			j sortloop2
		exitsortloop2:
		
		# increase loop counter 1
		addi $s2, $s2, 1
		j sortloop1
		
	exitsortloop1:
	
	# finished sorting
	
	# now we have a sorted array
	
	# mode counting starts here
	
	# $s0 = starting address of array
	# $s1 = length of array
	# $s2 = index
	# $s3 = max
	# $s4 = current
	# $s5 = loop counter
	# $s6 = address counter
	# $t0 = o[i-1]
	# $t1 = o[i]
	
	
	li $s2, 0
	li $s3, 1
	li $s4, 1
	li $s5, 0 
	move $s6, $s0
	
	loopmode:		
	addi $s5, $s5, 1
	beq $s5, $s1, endloopmode
		lw $t0, 0($s6)
		addi $s6, $s6, 4
		lw $t1, 0($s6)
		bne $t0, $t1, noqq
		addi $s4, $s4, 1
		j loopmode
		noqq: 
		beq $s3, $s4, grt
		bgt $s3, $s4, grt
		move $s3, $s4
		addi $s2, $s5, -1
		grt:
		li $s4, 1 
	j loopmode
	endloopmode:
	
	# return o[index] in $v0
	mul $s2, $s2, 4
	move $s6, $s0
	add $s6, $s6, $s2
	lw $v0, 0($s6)
	
	#finish subprogram
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