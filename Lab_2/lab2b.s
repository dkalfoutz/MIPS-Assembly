# This program needs a positive integer from the user and then prints the sum of the integers from 1 to the given number

.data
# Constant strings to be output to the terminal
Input_Integer:	.asciiz "Please give a positive integer >0: "
Sum:		.asciiz "Sum = "
Change_line:	.asciiz "\n"

# The instructions always follow the .text directive
.text
.globl main					# Label "main" must be global
main:
	Give_PosInt:	addi $v0, $0, 4		# Print string "Input_Integer"
			la $a0, Input_Integer
			syscall
			
			addi $v0, $0, 5		# Read an integer from the user
			syscall
			add $s0, $v0, $0		# Store its value in register $s0

			blez $s0, Give_PosInt	# If ($s0 <= 0) go to label "Give_PosInt"

	addi $t0, $0, 1				# $t0 = 1 (counter for the loop: i)
	add $s1, $0, $0				# Reset register $s1 (sum)

	Loop:		add $s1, $s1, $t0		# $s1 = $s1 + $t0 (sum = sum +i)

			addi $t0, $t0, 1		# $t0++ (i++)
			ble $t0, $s0, Loop		# If ($t0 <= $s0) {i <= n} go to label "Loop"

	addi $v0, $0, 4				# Print string "Sum"
	la $a0, Sum
	syscall

	addi $v0, $0, 1				# Print the value of the register $s1 (sum)
	add $a0, $s1, $0
	syscall

	addi $v0, $0, 4				# Print String "Change_Line"
	la $a0, Change_Line
	syscall

	# Exit program
	li $v0, 10
	syscall