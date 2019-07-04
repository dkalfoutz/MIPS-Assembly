# This program converts a decimal integer to binary and after to octal

.data
# Constant strings to be output to the terminal and arrays
Input_Integer:	.asciiz "Please give a positive decimal integer <1024: "
Wrong_Number:	.asciiz "Wrong number. Try again.\n"
Result:		.asciiz "The given decimal integer number is: "
Bin_Number:	.asciiz "The binary number is: "
Oct_Number:	.asciiz "The octal number is: "
Change_Line:	.asciiz "\n"

.align 2									# Size of the elements of the array = 4 bytes
Bin:	.space 40								# Size of the array "Bin" 40 bytes = 10 elements,
									#	as the numbers from 1 to 1023 use max 10
									#	binary digits

Oct:	.space 16								# Size of the array "Oct" 16 bytes = 4 elements,
									# 	as the numbers from 1 to 1023 use max 4
									#	octal digits

# The instructions always follow the .text directive
.text
.globl main								# Label "main" must be global
main:
	AskInteger:	addi $v0, $0, 4					# Label "AskInteger"
			la $a0, Input_Integer				# asks the user to input an integer ans keeps doing
			syscall						# 	this till a valid one is given

			addi $v0, $0, 5
			syscall
			add $s0, $v0, $0

			bgtz $s0, Cond2

			Error:	addi $v0, $0, 4
				la $a0, Wrong_Number
				syscall

				j AskInteger

			Cond2:	slti $t0, $s0, 1024
				beqz $t0, Error

	add $a0, $s0, $0

	jal Dec2bin2oct

	# Print the results to the terminal
	addi $v0, $0, 4
	la $a0, Result
	syscall

	addi $v0, $0, 1
	add $a0, $s0, $0
	syscall

	addi $v0, $0, 4
	la $a0, Change_Line
	syscall

	addi $v0, $0, 4
	la $a0, Bin_Number
	syscall

	addi $v0, $0, 4
	la $a0, Bin
	syscall

	addi $v0, $0, 4
	la $a0, Change_Line
	syscall

	addi $v0, $0, 4
	la $a0, Oct_Number
	syscall

	addi $v0, $0, 4
	la $a0, Oct
	syscall

	addi $v0, $0, 4
	la $a0, Change_Line
	syscall

	# Exit program
	li $v0, 10
	syscall


#######################################################################################################################
############################ This function converts an integer decimal number to binary and then to octal. ###########################
#######################################################################################################################
Dec2bin2oct:	# Convert the decimal to binary number
		add $t0, $a0, $0

		addi $t1, $0, 10
		sb $0, Bin($t1)						# The end of a string is always a NULL byte

		addi $t1, $t1, -1

		CalculateBin:	andi $t2, $t0, 1				# Mask out the least significan bit of the number
				addi $t2, $t2, 48				# ASCII translation

				sb $t2, Bin($t1)

				srl $t0, $t0, 1
				addi $t1, $t1, -1

				bgez $t1, CalculateBin

		# Convert the binary to octal number
		add $t0, $a0, $0

		addi $t1, $0, 4
		sb $0, Oct($t1)						# The end of a string is always a NULL byte

		addi $t1, $t1, -1

		CalculateOct:	andi $t2, $t0, 7				# Mask out the 3 least significant bit of the number
				addi $t2, $t2, 48				# ASCII translation

				sb $t2, Oct($t1)

				srl $t0, $t0, 3
				addi $t1, $t1, -1

				bgez $t1, CalculateOct

		# Exit funct "Dec2bin2oct"
		jr $ra