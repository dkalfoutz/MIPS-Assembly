# This program asks the user to input a null-terminated string and reverses it

.data
# Constant strings to be output to the terminal
Input_String:	.asciiz "Please input the string: "
Result:		.asciiz "The given string after reverce is: "
Change_Line:	.asciiz "\n"

.align 0							# Size ot the elements of the string = 1 byte
String:	.space 50						# Max size of the string 50 bytes = 50 elements


# The istructions always follow the .text directive
.text
.globl main						# Label "main" must be global
main:
	# Input string from the terminal
	addi $v0, $0, 4
	la $a0, Input_String
	syscall

	addi $v0, $0, 8
	la $a0, String
	addi $a1, $0, 50
	syscall

	addi $v0, $0, 4
	la $a0, Result
	syscall

	la $a0, String

	jal Reverse

	addi $v0, $0, 4
	la $a0, Change_Line
	syscall

	# Exit program
	li $v0, 10
	syscall


#############################################################################################################
############################ This function reverses a given string and prints it to the terminal. ############################
#############################################################################################################
Reverse:		addi $sp, $sp, -8
		sw $ra, 0($sp)
		sw $a0, 4($sp)

		lb $t0, 0($a0)

		beqz $t0, PrintString				# If *s = 0, this is the end of the string so go to label "PrintString"

		addi $a0, $a0, 1

		jal Reverse

PrintString:	lw $a0, 4($sp)
		lw $ra, 0($sp)
		addi $sp, $sp, 8

		lb $t0, 0($a0)

		addi $v0, $0, 11
		add $a0, $t0, $0
		syscall

		# Exit funct "Reverse"
		jr $ra