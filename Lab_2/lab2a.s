# This program compares 2 integers and prints the results to the terminal

.data
# Constant strings to be output to the terminal
Input_Integer:	.asciiz "Please give an integer: "
Negative:		.asciiz "product negative\n"
Positive:		.asciiz "product positive\n"
Zero:		.asciiz "product zero\n"

# The instructions always follow the .text directive
.text
.globl main						# Label "main" must be global
main:
	addi $v0, $0, 4					# Print string "Input_Integer"
	la $a0, Input_Integer
	syscall

	addi $v0, $0, 5					# Read an integer from the user (x)
	syscall
	add $s0, $v0, $0					# Store its value in register $s0 ($s0 = x)

	addi $v0, $0, 4					# Print string "Input_Integer"
	la $a0, Input_Integer
	syscall

	addi $v0, $0, 5					# Read an integer from the user (y)
	syscall
	add $s1, $v0, $0					# Store its value in register $s1 ($s1 = y)

	beqz $s0, Product_Zero				# If ($s0 == 0) go to label "Product_Zero"
	beqz $s1, Product_Zero				# If ($s1 == 0) go to label "Product_Zero"

	bgtz $s0, Cond2_BothPos				# If ($s0 > 0) go to label "Cond2_BothPos"
	j Continue1					# If not, go to label "Continue1" unconditionally

	Cond2_BothPos:	bgtz $s1, Product_Positive		# If ($s1 > 0) go to label "Product_Positive"
			j Continue1			# If not, go to label "Continue1"

	Continue1:	bltz $s0, Cond2_BothNeg		# If ($s0 < 0) go to label "Cond2_BothNeg"
			j Continue2			# If not, go to label "Continue2" unconditionally

	Cond2_BothNeg:	bltz $s1, Product_Positive		# If ($s1 < 0) go to label "Product_Positive"
			j Continue2			# If not, go to label "Continue2" unconditionally

	Continue2:	addi $v0, $0, 4			# Print string "Negative"
			la $a0, Negative
			syscall

			j End_MultipleIf			# Go to label "End_MultipleIf" unconditionally

	Product_Zero:	addi $v0, $0, 4			# Print string "Zero"
			la $a0, Zero
			syscall

			j End_MultipleIf			# Go to label "End_MultipleIf" unconditionally

	Product_Positive:	addi $v0, $0, 4			# Print string "Positive"
			la $a0, Positive
			syscall

	End_MultipleIf:	# Exit program
			li $v0, 10
			syscall
