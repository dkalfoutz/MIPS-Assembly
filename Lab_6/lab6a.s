# This program implements the algoritm of "Hanoi Towers" and prints the steps to the terminal

.data
# Constant strings to be output to the terminal and arrays
Input_Integer:	.asciiz "Please give the number of the disks on Tower A: "
No_Disks:		.asciiz "No disks to be moved.\n"
Result_1:		.asciiz "Move disk "
Result_2:		.asciiz " from peg "
Result_3:		.asciiz " to peg "
Change_Line:	.asciiz "\n"


# Instructions always follow the .text directive
.text
.globl main					# Label "main" must be global
main:
	# Asks the user to input the info needed to proceed
	addi $v0, $0, 4
	la $a0, Input_Integer
	syscall

	addi $v0, $0, 5
	syscall
	add $s3, $v0, $0

	slti $t0, $s3, 1
	beqz $t0, Continue

	addi $v0, $0, 4
	la $a0, No_Disks
	syscall

	j Exit

	Continue:	add $a0, $s3, $0				# $a0 = N disks to be moved to tower C
		addi $a1, $0, 'A'				# $a1 = 'A' (the starting tower)
		addi $a2, $0, 'B'				# $a2 = 'B' (the helping tower)
		addi $a3, $0, 'C'				# $a3 = 'C' (the finishing tower)

		jal HanoiTowers

	# Exit program
	Exit:	li $v0, 10
		syscall


#############################################################################################################
############################### This functions implements the algorithm of "Hanoi Towers" ###############################
#############################################################################################################
HanoiTowers:	beqz $a0, Exit1

		addi $sp, $sp, -20
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		sw $a2, 12($sp)
		sw $a3, 16($sp)

		# First recursive calling of "HanoiTowers" to move n-1 disks from tower A to tower B, using tower C
		addi $a0, $a0, -1
		add $t0, $a2, $0				# $t0 = $a2 = 'B'
		add $a2, $a3, $0				# $a2 = $a3 = 'C' (the helping tower)
		add $a3, $t0, $0				# $a3 = $t0 = 'B' (the finishing tower)

		jal HanoiTowers

		addi $v0, $0, 4
		la $a0, Result_1
		syscall

		addi $v0, $0, 1
		lw $a0, 4($sp)
		syscall

		addi $v0, $0, 4
		la $a0, Result_2
		syscall

		addi $v0, $0, 11
		lw $a0, 8($sp)
		syscall

		addi $v0, $0, 4
		la $a0, Result_3
		syscall

		addi $v0, $0, 11
		lw $a0, 16($sp)
		syscall

		addi $v0, $0, 4
		la $a0, Change_Line
		syscall

		# Second recursive calling of "HanoiTowers" to move n-1 disks from tower B to tower C, using tower A
		lw $a0, 4($sp)
		lw $a1, 12($sp)				# $a1 = 'B' (the starting tower)
		lw $a2, 8($sp)				# $a2 = 'A' (the helping tower)
		lw $a3, 16($sp)				# $a3 = 'C' (the finishing tower)

		addi $a0, $a0, -1

		jal HanoiTowers

		lw $ra, 0($sp)
		addi $sp, $sp, 20

	# Exit funct "HanoiTowers"
	Exit1:	jr $ra