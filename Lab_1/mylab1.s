	
#askhsh 2
.text
.globl main
main:


	addi $t0, $0, 1			#arxikopoihsh tou $t0 = 1 ....apo to 1 tha ksekinaw k tha prepei na
				#afksanw tous arithmous pou einai perittoi..ara prepei kai na tous
				#vriskw..
	addi $t1, $0, 211		#mexri to 211 prepei na ftasw...kai oxi parapanw..
	addi $t2, $0, 1			#arxikopoihsh athroismatos = 1..


	Loop:
		addi $t0, $0, 2		#prosthese ston t0, 1, gia na eksetaseis ton epomeno peritto
	
		add $t2, $t2, $t0	#ananewse to t2(=athroisma), simfwna me mexri twra athroisma+next_perittos(=t0) 
	
		blt $t0, $t1, Loop	#an o t0 = perittos arithmos einai < t1 = max timi pros eksetasin, 
					#go to Loop 	
	
	add $a0, $0, $t2		#vale to athroisma(=t2) mesa ston a0 wste meta pou tha dwsw to code 
					#gia ektypwsh...na to ektypwsei..
	addi $v0, $0, 1			#code gia print int
	syscall

	#exit program
	addi $v0, $0, 10		# code gia exit program
	syscall
