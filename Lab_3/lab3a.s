# This program asks the user to input 5 integers from -21 to 17 and prints the sum of the integers that are >0

.data
# Constant strings to be output to the terminal and arrays 
Input_Integer:	.asciiz "Please give an integer >=-21 and <=17: "
Error:		.asciiz "Wrong number. Try again.\n"
Summary:	.asciiz "The sum of the integers that are >0 is: "

.align 2								# Size of the elements of the array = 4 bytes
Vector:	.space 20							# Size of the array "Vector" 20 bytes =  5 elements

# The instructions always follow the .text directive
.text
.globl main							# Label "main" must be global
main:
	add $s0, $0, $0						# Reset register $s0 ($s0 = sum)
	addi $t0, $0, -21						# $t0 = -21 (the lower limit for the given integers)
	addi $t1, $0, 17						# $t1 = 17 (the upper limit for the given integers)
	add $t3, $0, $0						# Reset register $t3 (used to show the elements of the array, values = 0, 4, 8, 12, 16)
	addi $t4, $0, 20						# $t4 = 20 (while $t3 < $t4 we keep filling the array with integers)

	AskInteger:	addi $v0, $0, 4				# Print string "Input_Integer"
			la $a0, Input_Integer
			syscall

			addi $v0, $0, 5				# Read an integer from the user
			syscall
			add $t2, $v0, $0				# Store its value in register $t2

			blt $t2, $t0, WrongNumber			# If ($t2 < $t0) {$t2 < -21} go to label "WrongNumber"
			bgt $t2, $t1, WrongNumber			# If ($t2 > $t1) {$t2 > 17} go to label "WrongNumber"

			sw $t2, Vector ($t3)				# Store the value of the register $t2 in the first position of the array "Vector"

			addi $t3, $t3, 4				# $t3 = $t3 + 4 (move to the next element of the array)

			bne $t3, $t4, AskInteger			# If ($t3 != $t4) the array is not full so go to label "AskInteger"
			j Exit					# The array is full, go to label "Exit"

			WrongNumber:	addi $v0, $0, 4		# Print string "Error"
					la $a0, Error
					syscall

					j AskInteger		# The array is not full, go to label "AskInteger"

	Exit:		add $t3, $0, $0				# Reset register $t3 to show again the first element of the array "Vector"

		CountSum:	lw $t2, Vector ($t3)			# Load the values of the array in register $t2

				blez $t2, Continue			# If ($t2 <= 0) go to label "Continue", if not calculate the new sum

				add $s0, $s0, $t2			# $s0 = $s0 + $t2 (the new sum of the positive elements of the array "Vector"

				Continue:	addi $t3, $t3, 4		# $t3 = $t3 + 4 (move to the next element of the array)

					bne $t3, $t4, CountSum	# If ($t3 != $t4) this was not the last element of the array so go to label "CountSum"

	addi $v0, $0, 4						# Print string "Summary"
	la $a0, Summary
	syscall

	addi $v0, $0, 1						# Print the value of the register $s0 (sum)
	add $a0, $s0, $0
	syscall

	# Exit program
	li $v0, 10
	syscall