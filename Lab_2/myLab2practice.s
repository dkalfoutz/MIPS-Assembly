# read int
addi $v0, $0, 5 	#code for read int
syscall			#pleon o v0 exei ton int pou thellw..ton edwsa kai t pire aftos
add $t0, $v0, $0	#afton ton int pou einai ston v0 pleon ton vazw ston t0


#print int
add $a0, $0, $t0	#vazw t int p einai st t0 mesa ston a0..orisma diladi gia print
addi $v0, $0, 1		#code for print int
syscall			#ara edw den xreiazetai na valw ston v0 ton int pou itane
			#ston t0, PREPEI NA TON EIXA VALEI ARXIKA STON a0 ws orisma
			#wste meta dinontas t code_for_print_int n kalesw tin syscall
			#kai na ektypwthei o akeraios pou kataxwrithike ston a0..


#print string	NUMBER 1
			#prwta to dhlwnw sto .data kai san Label tou dinw enan titlo
			#perigrafiko
.data
Kalwsorisma: .asciiz	"hello world"
Newline: .asciiz	"\n"


#print string NUMBER 2
la $a0, Kalwsorisma	#opws k m t int..prwta vazw tin diefthinsi tou string st a0..
addi $v0, $0, 4		#code_for_print_string
syscall			#tha ginei print tou string ekeinou, tou opoiou  diefthinsi 
			#perasthke ston $a0...
			
la, $a0, NewLine
addi, $v0, $0, 4	
syscall

#exit program
addi $v0, $0, 10
syscall


# if (x == 0)
# {
#	.....//case true	
# }
# else
# { 
# 	......//case false
# }
#
#			
#
#
#
#
#
#
#
#			
#ektesh epanalhptikis diadikasias...
for (i = 0; i < 10; i++)		# i = $t3, 10 = $t4, 
{
	//body of for loop
}
ypoloipoProgrammatos...


#arxikopoihsh twn t3 = 0 kai t4 = 10
addi $t3, $0, 0
addi $t4, $0, 10

Loop:
	#body of Loop		#xreiazomai ena label wste katw katw pou tha kanw ton elegxo an xreiastei na kanw diakladwsh se afto to 
 				#label...wste etsi na ylopoieitai h loop
	addi $t0 $0, 1
	blt $t0, $s0, Loop
	
afterLoop:
		#ypoloipos kwdikas....