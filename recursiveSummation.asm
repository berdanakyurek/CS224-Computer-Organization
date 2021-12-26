
.data
	string: .asciiz   "123"
.text

main:
	# set input for subprogram
	
	la $a0, string
	li $v0, 0
	# call the subprogram
	jal recursiveSummation
	
	# store result in $s7
	move $s7, $v0
	
	# print result
	move $a0, $s7
	li $v0, 1
	syscall
	
	# end program
	li $v0, 10
	syscall
	
	
#-------------------------------------------------------------------------------------------
		
# This subprogram takes a string address in $s0, 
# calculates and returns the sum of all digits in $v0

# Registers used in this subprogram:

# $a0 = starting address of str
# $s1 = length of str
# $s2 = first value

recursiveSummation:
	
	addi $sp, $sp, -8
        sw   $ra, 0($sp)
        sw $a0, 4($sp)
        
	lb $t0, 0($a0)
	
	beq $t0, 0, end
	
	addi $t0, $t0, -48
	add $v0, $v0, $t0
	addi $a0, $a0, 1
	
	jal recursiveSummation		
	end:
	
	lw $ra, 0($sp)
	lw $a0, 4($sp)
        addi $sp, $sp, 8
        
        # end subprogram
	jr $ra




	
