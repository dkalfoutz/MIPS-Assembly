# This program finds the position of a given number in an array of integers with binary search and prints it to the terminal

.data
# Constant strings to be output to the terminal and arrays
Input_N:		.asciiz "Please give a positive integer (size of the array): "
Wrong_Number:	.asciiz "Wrong number. Try again.\n"
Input_Array:	.asciiz "Please give integers to fill the array (must be sorted from higher to lower integer):\n"
Input_X:		.asciiz "Please give an integer to search the array for its position: "
Result_1:		.asciiz "The position of the number "
Result_2:		.asciiz " in the sorted array is: "
Change_Line:	.asciiz "\n"

.align 2								# Size of the elements of the array = 4 bytes
SortedArray:	.space 400					# Max size of the array "SortedArray" 400 bytes = 100
								#	elements

# The instructions always follow the .text directive
.text
.globl main							# Label "main" must be global
main:
	# Ask the user to input the info needed by the program
	AskIntegerN:	addi $v0, $0, 4
			la $a0, Input_N
			syscall

			addi $v0, $0, 5
			syscall
			add $s0, $v0, $0

			bgtz $s0, Continue

			addi $v0, $0, 4
			la $a0, Wrong_Number
			syscall

			j AskIntegerN

	Continue:		addi $v0, $0, 4
			la $a0, Input_Array
			syscall

			add $t0, $0, $0				# Shows the first element of the array

	FillArray:		sll $t1, $t0, 2

			addi $v0, $0, 5
			syscall
			sw $v0, SortedArray($t1)

			addi $t0, $t0, 1

			bne $t0, $s0, FillArray

	addi $v0, $0, 4
	la $a0, Input_X
	syscall

	addi $v0, $0, 5
	syscall
	add $s1, $v0, $0

	add $a0, $s0, $0
	add $a1, $s1, $0

	jal BinarySearch

	add $s2, $v0, $0

	# Print the result to the terminal
	addi $v0, $0, 4
	la $a0, Result_1
	syscall

	addi $v0, $0, 1
	add $a0, $s1, $0
	syscall

	addi $v0, $0, 4
	la $a0, Result_2
	syscall

	addi $v0, $0, 1
	add $a0, $s2, $0
	syscall

	addi $v0, $0, 4
	la $a0, Change_Line
	syscall

	# Exit program
	li $v0, 10
	syscall


#############################################################################################################
####################### This function finds the position of an integer in an array with binary search. ########################
#############################################################################################################
BinarySearch:	add $t0, $0, $0					# Left bound = 0
		addi $t1, $a0, -1					# Right bound = N - 1

		Loop:	blt $t1, $t0, Exit

			add $t2, $t0, $t1
			srl $t2, $t2, 1

			sll $t3, $t2, 2
			lw $t4, SortedArray($t3)

			bgt $t4, $a1, LowerHalf
			blt $t4, $a1, UpperHalf

			add $v0, $t2, $0				# Number found at the position stored in register $t2

			jr $ra					# Exit funct "BinarySearch"

			LowerHalf:	addi $t1, $t2, -1

					j Loop

			UpperHalf:	addi $t0, $t2, 1

					j Loop

		Exit:
			# Number not found in the array, so return -1
			addi $v0, $0, -1

			jr $ra