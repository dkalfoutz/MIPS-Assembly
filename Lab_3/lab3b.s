# This program finds the max and the min integers of a given by the user array and their positions in the array and prints the results

.data
# Constant strings to be output to the terminal and arrays
Input_Integer:	.asciiz "Please give an integer >0: "
Error:		.asciiz "Wrong number. Try again.\n"
FillArray1:	.asciiz "Please give "
FillArray2:	.asciiz " integers:\n"
Max:		.asciiz "MAX = "
Min:		.asciiz "MIN = "
Pos_Max:		.asciiz "POS_MAX = "
Pos_Min:		.asciiz "POS_MIN = "
Change_Line:	.asciiz "\n"

.align 2								# Size of the elements of the array = 4 bytes
Input:	.space 100						# Max size of the array "Input" 100 bytes = 25 elements

# The instructions always follow the .text directive
.text
.globl main							# Label "main" must be global
main:
	AskInteger:	addi $v0, $0, 4				# Label "AskInteger" : 
			la $a0, Input_Integer			# asks the user to input an integer and keeps doing this till
			syscall					# 	a positive one is given

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

			add $t0, $0, $0				# This register is used to show the element of the array being used 

	ReadIntegers:	sll $t1, $t0, 2				# Label "ReadIntegers" :
								# asks the user to input integers and stores them in the
			addi $v0, $0, 5				#	array "Input"
			syscall
			sw $v0, Input($t1)

			addi $t0, $t0, 1
			blt $t0, $s0, ReadIntegers

	# Compares the 2 first elements of the array and finds the min and the max and their positions

	add $t0, $0, $0						# Reset register $t0 to show again the first element of the array "Input"
	lw $t2, Input($t0)

	addi $t0, $t0, 1
	sll $t1, $t0, 2
	lw $t3, Input($t1)

	bgt $t2, $t3, Case1

	move $s1, $t3						# Register $s1 stores the value of the max integer of the array
	addi $s2, $0, 1						# Register $s2 stores the position of the max integer in the array
	move $s3, $t2						# Register $s3 stores the value of the min integer of the array
	add $s4, $0, $0						# Register $s4 stores the position of the min integer in the array

	j Comparison

	Case1:		move $s1, $t2
			add $s2, $0, $0
			move $s3, $t3
			addi $s4, $0, 1

	Comparison:	addi $t0, $t0, 1				# Label "Comparison" :
			beq $t0, $s0, Exit				# runs the array element by element and finds the min and the max
								#	integer and their positions in the array	
			sll $t1, $t0, 2
			lw $t2, Input($t1)

			bgt $t2, $s1, MaxChange
			blt $t2, $s3, MinChange

			j Comparison

			MaxChange:	move $s1, $t2
					move $s2, $t0

					j Comparison

			MinChange:	move $s3, $t2
					move $s4, $t0

					j Comparison

	Exit:		addi $v0, $0, 4				# Label "Exit" :
			la $a0, Max				# prints the results to the terminal
			syscall

			addi $v0, $0, 1
			add $a0, $s1, $0
			syscall

			addi $v0, $0, 4
			la $a0, Change_Line
			syscall

			addi $v0, $0, 4
			la $a0, Pos_Max
			syscall

			addi $v0, $0, 1
			add $a0, $s2, $0
			syscall

			addi $v0, $0, 4
			la $a0, Change_Line
			syscall

			addi $v0, $0, 4
			la $a0, Min
			syscall

			addi $v0, $0, 1
			add $a0, $s3, $0
			syscall

			addi $v0, $0, 4
			la $a0, Change_Line
			syscall

			addi $v0, $0, 4
			la $a0, Pos_Min
			syscall

			addi $v0, $0, 1
			add $a0, $s4, $0
			syscall

			addi $v0, $0, 4
			la $a0, Change_Line
			syscall

	# Exit program
	li $v0, 10
	syscall