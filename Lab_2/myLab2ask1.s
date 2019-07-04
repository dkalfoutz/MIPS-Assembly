#######orizw ta mynhmata...ta strings....######
.data
newLine: .asciiz	"\n"
Limit1: .asciiz		"please define the first limit of ur interval: "
Limit2: .asciiz		"please define the second limit of ur interval: "
readInt: .asciiz	"please give an integer: "





#read prwto orio...
addi $v0, $0, 5
syscall
add $s0, $0, $v0	#s0 = v0 = N1 prwtos akeraios

#read deftero orio...
addi $v0, $0, 5
syscall
add $s1, $0, $v0	# s0 = v0 = N2 defteros akeraios


####mesa se epanaliptiki diadikasia...########



#print string gia zhthma int apo ton xrhsth..
la $a0, readInt
addi $v0, $0, 4
syscall		#print  "please give an integer"

#read int..
addi $v0, $0, 5	
syscall
add $t0, $v0, $0	#t0 = v0 = akeraios

#







