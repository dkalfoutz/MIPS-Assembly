# This is a test lab to get used to the PCSPIM simulator

# The instructions always follow the .text directive
.text
.globl main			# Label "main" must be global
main:

	add $s0, $0, $0		# Reset register $s0
	addi $t0, $0, 1		# Put the value 1 in register $t0

	add $s1, $t0, $s0		# $s1 = $t0 + $s0

	addi $s1, $s1, -6		# $s1 = $s1 - 6

	addi $s0, $s0, 2		# $s0 = $s0 + 2

	sub $t4, $s1, $s0		# $t4 = $s1 - $s0

	move $a0, $t4		# Print the integer value of $t4
	li $v0, 1
	syscall

	#exit program
	li $v0, 10
	syscall