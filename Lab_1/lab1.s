# This program prints all the integers from -10 to 10

.data
# Constant strings to be output to the terminal
Space:		.asciiz ", "

# The instructions always follow the .text directive
.text
.globl main				# Label "main" must be global
main:
	addi $s0, $0, -10			# Put value -10 in register $s0 (starting value)
	addi $s1, $0, 10			# Put value 10 in register $s1 (ending value)

	move $a0, $s0			# Print the first integer (value of register $s0 = -10)
	li $v0, 1
	syscall

	Loop:	li $v0, 4			# Print string "Space"
		la $a0, Space
		syscall

		addi $s0, $s0, 1		# Raise the value of register $s0 to print the next integer

		move $a0, $s0		# Print the integer value of register $s0
		li $v0, 1
		syscall

		bne $s1, $s0, Loop		# If($s1 >= $s0) go to Loop

	# Exit Program
	li $v0, 10
	syscall
