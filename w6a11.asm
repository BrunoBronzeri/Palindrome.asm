.data
input_str: .space 1024
output_1: .asciiz "� Pal�ndromo.\n"
output_0: .asciiz "N�o � Pal�ndromo.\n"

.text
	la $a0, input_str	#socorram me subi no onibus em marrocos
	li $a1, 1024		#socorram me subi no onibus em marrocos
	li $v0, 8
	syscall
	
	add $t6, $t6, 32
	la $s0, input_str
	
while_not_zero:			 #percorrer str at� o final
	lb $t1, 0($s0)		 #para saber o endere�o final
	beqz $t1, if_equal_zero  #fim da string
	add $s0, $s0, 1 
	lb $t1, 0($s0)         
	bnez $t1, while_not_zero
	
if_equal_zero:
	sub $s0, $s0, 2   #remover o enter e o null do final do ENDERE�O
	
start_loop:
	lb $t2, 0($a0)    #abrir endere�o por endere�o para fazer a compara��o
	lb $t1, 0($s0)
	beq $t1, $t2, test_palin
	
	bne $t1, $t2, return_0

test_palin:
continue_test:
	beq $t2, $t6, fuck_space_1
	beq $t1, $t6, fuck_space
	beqz $t3, return_1 #yes
	
	bne $t1, $t2, return_0 #no
	b continue_test
	beqz $t2, return_1
	
fuck_space_1:
	add $a0, $a0, 1
	lb $t2, 0($a0)
	b test_palin
fuck_space:
	sub $v0, $v0, 2 #sub
	lb $t1, 0($v0)
	b test_palin
	
return_0:
	la $a0, output_0
	li $v0, 4
	syscall
	b exit
return_1:
	la $a0, output_1 
	li $v0, 4
	syscall
	
exit:
	li $v0, 10
	syscall
