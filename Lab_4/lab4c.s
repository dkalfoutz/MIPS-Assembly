# This program merges two sorted integer arrays and prints the result to the terminal

.data
# Constant strings to be output to the terminal and arrays
Input_N:		.asciiz "Please give an integer to specify the size of the first array (In1): "
Input_Array_1:	.asciiz "Please give "
Input_In1_2:	.asciiz " integers to fill the first array In1 (must be sorted from higher to lower integer):\n"
Input_M:		.asciiz "Please give an integer to specify the size of the second array (In2): "
Input_In2_2:	.asciiz " integers to fill the second array In2 (must be sorted from higher to lower integer):\n"
Wrong_Number:	.asciiz "Wrong number. Ôry again.\n"
Result:		.asciiz "The merged array Out is:\n"
Space:		.asciiz "  "
Change_Line:	.asciiz "\n"

.align 2								# Size of the elements of the arrays = 4 bytes
In1:	.space 200						# Max size of the array "In1" 200 bytes = 50 elements
In2:	.space 200						# Max size of the array "In2" 200 bytes = 50 elements
Out:	.space 400						# Max size of the array "Out" 400 bytes = 100 elements

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

			bgez $s0, Continue1

			addi $v0, $0, 4
			la $a0, Wrong_Number
			syscall

			j AskIntegerN

	Continue1:	addi $v0, $0, 4
			la $a0, Input_Array_1
			syscall

			addi $v0, $0, 1
			add $a0, $s0, $0
			syscall

			addi $v0, $0, 4
			la $a0, Input_In1_2
			syscall

			add $t0, $0, $0

	FillArrayIn1:	sll $t1, $t0, 2

			addi $v0, $0, 5
			syscall
			sw $v0, In1($t1)

			addi $t0, $t0, 1

			bne $t0, $s0, FillArrayIn1

	AskIntegerM:	addi $v0, $0, 4
			la $a0, Input_M
			syscall

			addi $v0, $0, 5
			syscall
			add $s1, $v0, $0

			bgez $s1, Continue2

			addi $v0, $0, 4
			la $a0, Wrong_Number
			syscall

			j AskIntegerM

	Continue2:	addi $v0, $0, 4
			la $a0, Input_Array_1
			syscall

			addi $v0, $0, 1
			add $a0, $s1, $0
			syscall

			addi $v0, $0, 4
			la $a0, Input_In2_2
			syscall

			add $t0, $0, $0

	FillArrayIn2:	sll $t1, $t0, 2

			addi $v0, $0, 5
			syscall
			sw $v0, In2($t1)

			addi $t0, $t0, 1

			bne $t0, $s1, FillArrayIn2

	la $a0, In1
	add $a1, $s0, $0
	la $a2, In2
	add $a3, $s1, $0

	la $t0, Out
	addi $sp, $sp, -4
	sw $t0, 0($sp)

	jal Merge

	# Print the merged array to the terminal
	addi $v0, $0, 4
	la $a0, Result
	syscall

	add $t0, $0, $0
	add $t1, $s0, $s1

	PrintArrayOut:	beq $t0, $t1, Exit

			sll $t2, $t0, 2

			lw $t3, Out($t2)

			addi $v0, $0, 1
			add $a0, $t3, $0
			syscall

			addi $v0, $0, 4
			la $a0, Space
			syscall

			addi $t0, $t0, 1

			j PrintArrayOut

	Exit:		addi $v0, $0, 4
			la $a0, Change_Line
			syscall

	# Exit program
	li $v0, 10
	syscall



#############################################################################################################
####### This function merges 2 sorted arrays, the final array is also sorted and its size is the sum of the sizes of the two initials #######
#############################################################################################################
Merge:	lw $t2, 0($sp)						# Register $t2 stores the address of the begging of Out
	addi $sp, $sp, 4

	add $t0, $a0, $0						# Register $t0 stores the address of the beggining of In1
	add $t1, $a2, $0						# Register $t1 stores the address of the beggining of In2

	sll $t3, $a1, 2
	add $t3, $t0, $t3						# Register $t3 stores the address of the last element of In1

	sll $t4, $a3, 2
	add $t4, $t1, $t4						# Register $t4 stores the address of the last element of In2

	# Merge the two arrays in the final sorted array Out
	Loop:	bge $t0, $t3, ExitLoop
		bge $t1, $t4, ExitLoop

		lw $t5, 0($t0)
		lw $t6, 0($t1)

		bgt $t5, $t6, Label

		sw $t5, 0($t2)

		addi $t0, $t0, 4
		addi $t2, $t2, 4

		j Loop

		Label:	sw $t6, 0($t2)

			addi $t1, $t1, 4
			addi $t2, $t2, 4

			j Loop

	ExitLoop:	bge $t0, $t3 Continue

		Loop1:	lw $t5, 0($t0)

			sw $t5, 0($t2)

			addi $t0, $t0, 4
			addi $t2, $t2, 4

			blt $t0, $t3, Loop1

	Continue:	bge $t1, $t4, Exit1

		Loop2:	lw $t5, 0($t1)

			sw $t5, 0($t2)

			addi $t1, $t1, 4
			addi $t2, $t2, 4

			blt $t1, $t4, Loop2

	# Exit funct "Merge"
	Exit1:	jr $ra