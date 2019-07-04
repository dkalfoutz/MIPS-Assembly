# This program counts the occurences of the numbers 0 till 15 that are given by the user and stores in an array

.data
# Constant strings to be output to the terminal and arrays
Input_Integer:	.asciiz "Please given an integer >0: "
Error:		.asciiz "Wrong number. Try again.\n"
FillArray1:	.asciiz "Please give "
FillArray2:	.asciiz " integers:\n"
Result:		.asciiz "The array with the occurences is:\n"
Array1:		.asciiz "OCC["
Array2:		.asciiz "] = "
Change_Line:	.asciiz "\n"

.align 2								# Size of the elements of the array = 4 bytes
Stream:	.space 100						# Max size of the array "Stream" 100 bytes = 25 elements
OCC:	.space 64							# Max size of the array "OCC" 64 bytes = 16 elements

# The instructions always follow the .text directive
.text
.globl main							# Label "main" must be global
main:
	AskInteger:	addi $v0, $0, 4				# Label "AskInteger" :
			la $a0, Input_Integer			# asks the user to input an integer and keeps doing this
			syscall					# 	till a positive one is given

			addi $v0, $0, 5
			syscall
			add $s0, $v0, $0

			bgtz $s0, Continue

			addi $v0, $0, 4
			la $a0, Error
			syscall

			j AskInteger

	Continue:		addi $v0, $0, 4
			la $a0, FillArray1
			syscall

			addi $v0, $0, 1
			add $a0, $s0, $0
			syscall

			addi $v0, $0, 4
			la $a0, FillArray2
			syscall

			add $t0, $0, $0

	ReadIntegers:	sll $t1, $t0, 2				# Label "ReadIntegers" :
								# asks the user to input integers and if they are valid stores them in
			addi $v0, $0, 5				#	the array "Stream"
			syscall
			bltz $v0, ReadIntegers
			slti $t2, $v0, 16
			beqz $t2, ReadIntegers

			sw $v0, Stream($t1)

			addi $t0, $t0, 1
			blt $t0, $s0, ReadIntegers

	add $t0, $0, $0
	addi $s1, $0, 16

	Clear_OCC:	sll $t1, $t0, 2				# Label "Clear_OCC" :
								# fill the array "OCC" with zeros
			sw $0, OCC($t1)

			addi $t0, $t0, 1
			bne $t0, $s1, Clear_OCC

	add $t0, $0, $0

	CalculateOcc:	sll $t1, $t0, 2				# Label "CalculateOcc" :
								# calculates the occurences of the integers that are stored
			lw $t2, Stream($t1)				# 	in the array "Stream"

			add $t3, $t2, $0
			sll $t3, $t3, 2

			lw $t4, OCC($t3)

			addi $t4, $t4, 1
			sw $t4, OCC($t3)

			addi $t0, $t0, 1
			blt $t0, $s0, CalculateOcc

	# Print the array "OCC" to the terminal
	addi $v0, $0, 4
	la $a0, Result
	syscall

	add $t0, $0, $0

	PrintOcc:		addi $v0, $0, 4
			la $a0, Array1
			syscall

			addi $v0, $0, 1
			add $a0, $t0, $0
			syscall

			addi $v0, $0, 4
			la $a0, Array2
			syscall

			sll $t1, $t0, 2

			lw $a0, OCC($t1)

			addi $v0, $0, 1
			syscall

			addi $v0, $0, 4
			la $a0, Change_Line
			syscall

			addi $t0, $t0, 1
			bne $t0, $s1, PrintOcc

	# Exit program
	li $v0, 10
	syscall