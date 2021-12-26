main:
	la   $a0, octalNo
	la $s0, octalNo
	
	# call convertToDec 
	
	jal   convertToDec
	
	# result comes in $v0	
	
	# print result
	addi $a0, $v0, 0
	li  $v0, 1
	syscall
	
	
	# stop execution here by syscall
	li  $v0, 10
	syscall
	
	

convertToDec:
	
	# find the length of string
	
	
	li $s1, 0 
	
	countChr:  
	lb $s2, 0($s0) 
	beqz $s2, endChr
	add $s0, $s0, 1
	add $s1, $s1, 1
	j countChr        
	endChr:
	
	addi $s5, $s1, 0
	
	
	# $s0 = 8^n to multiply
	# $s1 = result
	# $s2 = loop counter
	# $s3 = current value to add
	# $s4 = lb register
	# $s5 = string length
	
	# set initial values to registers
	
	addi $s0, $zero, 1
	addi $s1, $zero, 0
	addi $s2, $zero, 0
	
	add $a0, $a0, $s5
	addi $a0, $a0, -1
	
	# set one digit of octal number
	
	
	loop:
		beq $s2, $s5, exitLoop
		
		lb $s4, 0($a0)
		addi $s4, $s4, -48
		mul $s3, $s0, $s4
		add $s1, $s1, $s3
		
		addi $s2, $s2, 1
		addi $a0, $a0, -1
		mul $s0, $s0, 8
		
		j loop
		
	exitLoop:
	
	add $v0, $zero, $s1
	
	jr   $ra
	
.data
	octalNo: .asciiz "20"
