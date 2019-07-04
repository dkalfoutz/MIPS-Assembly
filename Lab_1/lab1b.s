# This is a test lab to get used to the PCSPIM simulator

# The instructions always follow the .text directive
.text
.globl main				# Label "main" must be global
main:
	add $t0, $0, $0			# Reset register $t0 (counter)
	addi $t1, $0, 10			# Put value 10 in register $t1 (number of loops)

	loop:
		addi $t0, $t0, 1		# $t0 = $t0 + 1
		bne $t0, $t1, loop		# if ($t0 != $t1) go to "loop"

	#exit program
	li $v0, 10
	syscall