# This program finds how many odd numbers are between 0 and a given one and prints them to the terminal

.data
# Constant strings to be output to the terminal
Input_Integer:	.asciiz "Please give an integer: "
Amount:		.asciiz "Amount of odd numbers: "

# The instructions always follow the .text directive
.text
.globl main				# Label "main" must be global
main:
	addi  $v0, $0, 4			# Print string "Input_Integer"
	la $a0, Input_Integer
	syscall

	addi $v0, $0, 5			# Read an integer from the user (n)
	syscall
	add $s0, $v0, $0			# Store its value in register $s0 ($s0 = n)

	add $s1, $0, $0			# Reset register $s1 ($s1 = amount)
	addi $t0, $0, 1			# $t0 = 1 (counter for the loop: i)

	Loop:	bgt $t0, $s0, Exit		# If ($t0 > $s0) {i > n} go to label "Exit"

		addi $s1, $s1, 1		# $s1++ (amount++)
		addi $t0, $t0, 2		# $t0 = $t0 + 2 (i = i + 2)

		j Loop

	Exit:	addi $v0, $0, 4		# Print string "Amount"
		la $a0, Amount
		syscall

		addi $v0, $0, 1		# Print the value of the register $s1 (amount)
		add $a0, $s1, $0
		syscall

	# Exit program
	li $v0, 10
	syscall