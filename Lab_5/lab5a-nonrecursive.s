# This program calculates non-recursively the Fibonacci number and prints the results to the terminal

.data
# Constant strings to be output to the terminal and arrays
Input_Integer:	.asciiz "Please given an integer number >= 0: "
Wrong_Number:	.asciiz "Wrong number. Try again.\n"
Result:		.asciiz "The Fibonacci number of the given one is: "
Change_Line:	.asciiz "\n"


# Instructions always follow the .text directive
.text
.globl main						# Label "main" must be global
main:
	addi $t0, $0, 1

	AskInteger:	addi $v0, $0, 4
			la $a0, Input_Integer
			syscall

			addi $v0, $0, 5
			syscall
			add $s0, $v0, $0

			bgt $s0, $t0, Continue

			addi $v0, $0, 4
			la $a0, Wrong_Number
			syscall

			j AskInteger

	Continue:		add $a0, $s0, $0

			jal Fibonacci

			add $t0, $v0, $0

			# Print the results to the terminal
			addi $v0, $0, 4
			la $a0, Result
			syscall

			addi $v0, $0, 1
			add $a0, $t0, $0
			syscall

			addi $v0, $0, 4
			la $a0, Change_Line
			syscall

			# Exit program
			li $v0, 10
			syscall


#############################################################################################################
############################### This function finds the Fibonacci number of the given one. ###############################
#############################################################################################################
Fibonacci:	addi $t0, $0, 2					# Counter for the Loop
		add $t1, $a0, $0

		addi $t2, $0, 1					# The previous fibonacci number of the given one
		add $t3, $0, $0					# The pre-previous fibonacci number of the given one

		add $t4, $0, $0					# The current fibonacci number

		Loop:	add $t4, $t2, $t3				# Calculate the current fibonacci number

			add $t3, $t2, $0
			add $t2, $t4, $0

			addi $t0, $t0, 1

			ble $t0, $t1, Loop

		add $v0, $t4, $0

		# Exit funct "Fibonacci"
		jr $ra