# this is a test lab to get used to the mars simulator

.text
.globl main		# label "main" must be global 

main:
add $s0, $0, $0		# reset register $s0 me timi = 0

addi $t0, $s0, 1 	# put the value 1 in $t0...alliws
			# li $t0, 0

add $s1, $t0, $s0	# $s1 = $t0 + $s0... diladi s1 = 1 + 0

addi $s1, $s1, -6	# $s1 = $s1 + (-6)

addi $s0, $s0, 2	# $s0 = $s0 + 2 ..o s0 eixe 0 eks arxis ton ethesa

sub $t4, $s1, $s0	#$t4 = $s1 - $s0

# print the integer value of $t4
move $a0, $t4		#thellw na ektypwsw ton t4..kai gia afto ton vazw
			#ston a0, o opoios pairnei orismata...wste meta 
			#fortwnontas ton swsto kwdiko (1) -pou einai gia 
			#ektypwsh akeraiou- ston v0	na kanw thn ektypwsh.
			#Dhladh o a0 tha parei tin timi.... kai analoga me to
			#ti valw ston v0...vazw afto gia ektypwsh... Tha ektypwthei
			#afto pou enai mesa ston a0...
li $v0, 1		# 1 is the code for print..ton vazw ston v0..
syscall			# callw tin syscall..

#exit program
li $v0, 10		# 10 is the code for exit.. ton vazw sto v0...
syscall			# kallw thn syscall gia na ektelesei tin leitourgia
			#analoga me ton code pou edwsa ston v0..	
			
				
					
	


#this is a test lab toget used to the pcspim simulator

.text
.globl main		#label "main" must be global

main:
add $s0, $0, $0		# arxikopoiw ton s0 me $0 + $0 = 0...
addi $t0, $0, 1		# prosthetw tin 16- bit stathera 1 + to periexomeno tou kataxwrhth $0, pou
			# einai mhden fisika...kai to apotelesma to vazw sto t0...

addi $s1, $s1, -6	# s1 = s1 - 6
sub $s0, $s1, $s0	# s0 = s1 - s0

#print the integer value of $t4....
add $a0, $0, $t4	#vazw ton t4 mesa ston a0, pou pairnei ta orismata....
addi $v0, $0, 1		#vazw ton code = 1 mesa ston v0, kathws h timi-code tou v0 kathorizei thn
			#leitoyrgia pou tha epitefxthei... o code = 1 mesa ston v0 shmainei oti
			#tha ginei print int..kai sigekrimena ekeinon ton int pou evala mesa ston
			#a0...
syscall

#exit program
li $v0, 10		#o code = 10 prodiathetei gia termatismo programmatos..

syscall




#kwdikas gia loop

#this is again a text lab to get used to the MARS simulator...

.text
.globl main		#label main must be global

main:
	add $t0, $0, $0 	# t0 = 0 + 0
	addi $t1, $0, 10	#number of loops = 10...
	
Loop:	addi $t0, $0, 1		#se kathe epanalipsi kai sigekrimena sto telos kathe epanalipsis
				#tha afksanw +1 ton t0,pou arxika einai 0,wste
	bne $t0, $t1, Loop	#na ftasei mexri 10, pou einai o arithmos twn epanalipsewn pou
				#thellw...etsi, i synthiki termatismou tha einai to an o t0 = t1
				#epomenws, an den einai isos, simainei oti mporw na kanw k
				#kai allh epanalhpsh, ara an den einai isos, peta me ksana sthn 
				#arxh tou loop..
	
	
	
	
#askhsh 2

addi $t0, $0, 1			#arxikopoihsh tou $t0 = 1 ....apo to 1 tha ksekinaw k tha prepei na
				#afksanw tous arithmous pou einai perittoi..ara prepei kai na tous
				#vriskw..
addi $t1, $0, 211		#mexri to 211 prepei na ftasw...kai oxi parapanw..
addi $t2, $0, 1			#arxikopoihsh athroismatos = 1..


Loop:
	addi $t0, $0, 2		#prosthese ston t0, 1, gia na eksetaseis ton epomeno peritto
	
	addi $t2, $t2, $t0	#ananewse to t2(=athroisma), simfwna me mexri twra athroisma+next_perittos(=t0) 
	
	blt $t0, $t1, Loop	#an o t0 = perittos arithmos einai < t1 = max timi pros eksetasin, 
				#go to Loop 	
	
	
	