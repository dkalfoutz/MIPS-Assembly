# This program calculates recursively the Fibonacci sequence and prints the results to the terminal

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
	AskInteger:	addi $v0, $0, 4
			la $a0, Input_Integer
			syscall

			addi $v0, $0, 5
			syscall
			add $s0, $v0, $0

			bgez $s0, Continue

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
################################ This function finds the fibonacci number of a given one. ###############################
#############################################################################################################
Fibonacci:	addi $sp, $sp, -12
		sw $ra, 0($sp)
		sw $a0, 4($sp)

		slti $t0, $a0, 2
		beqz $t0, Recurse

		# If the number is < 2 return the number as it is
		add $v0, $a0, $0

		addi $sp, $sp, 12

		# Exit funct "Fibonacci"
		jr $ra

		Recurse:	addi $a0, $a0, -1

			jal Fibonacci

			sw $v0, 8($sp)

			lw $a0, 4($sp)
			addi $a0, $a0, -2

			jal Fibonacci

			lw $t0, 8($sp)

			add $v0, $v0, $t0

			lw $ra, 0($sp)
			addi $sp, $sp, 12

			# Exit funct "Fibonacci"
			jr $ra