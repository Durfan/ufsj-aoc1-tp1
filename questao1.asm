.data	

msg1: .asciiz "\nDigite um angulo em radianos: "	
msg2: .asciiz "\nDigite a quantidade de termos: "
msg3: .asciiz "\nO cosseno do angulo e: "	

.text	
	.globl main
j main

cosseno:
	#codigo para salvar o valor das variaveis
	addi $sp, $sp, -12	#Ajusta a pilha para receber 3 itens
	sw $ra,8($sp)		#Salva o endereco de retorno
	sw $a1,4($sp) 		#Salva o argumento n 
	sw $a0,0($sp) 		#Salva o argumento n
	
	#laco para determinar o sinal de -1
	li $t0,-1
	addi $t1,$a1,-1
	whileSinal:
		slt $t2,$zero,$t1
		beq $t2,$zero,exitWhileSinal
		mul $t0,$t0,-1
		addi $t1,$t1,-1
	
		j whileSinal
		exitWhileSinal:
		#$t0 contem o valor final da expressao (-1)^n
	
	#chamada da funcao potencia
	jal potencia
	mul $v0,$v0,$t0	#$v0 = ((-1)^n) * (x^2n)
	
	#chamada da funcao fatorial
	mul $a1,$a1,2
	jal fatorial
	
	#operacao final do cosseno [((-1)^n) * (x^2n)]/(2n)!
	#div $v0,$v0,$v1
	
	#codigo para restaurar o valor das variaveis
	lw $a0,0($sp)
	lw $a1,4($sp)
	lw $ra,8($sp)	
	addi $sp,$sp,12
	
	#retorno para o chamador (funcao main)
	jr $ra
	
potencia:
	#codigo para salvar o valor das variaveis
	addi $sp, $sp, -12	#Ajusta a pilha para receber 3 itens
	sw $ra,8($sp)		#Salva o endereco de retorno
	sw $a1,4($sp) 		#Salva o argumento n 
	sw $a0,0($sp) 		#Salva o argumento n
	
	#laco para determinar a expressao (x^2n)
	mul $a1,$a1,2	#$a1 = n*2 (expoente de x multiplicado por 2)
	addi $a1,$a1,-1
	add $t3,$zero,$a0
	whilePotencia:
		beq $a1,$zero,exitWhilePotencia
		mul $t3,$t3,$a0
		addi $a1,$a1,-1
	
		j whilePotencia
		exitWhilePotencia:
		#$t3 contem o valor final da expressao (x^2n)
		
	#retorno
	add $v0,$zero,$t3
	
	#codigo para restaurar o valor das variaveis
	lw $a0,0($sp)
	lw $a1,4($sp)
	lw $ra,8($sp)	
	addi $sp,$sp,12
	
	#retorno para o chamador (funcao cosseno)
	jr $ra

fatorial:
	addi $sp, $sp, -8#Ajusta a pilha para receber 2 itens
	sw $ra, 4($sp) #Salva o endereco de retorno
	sw $a1, 0($sp) #Salva o argumento n
	addi $t1, $zero, 1 # $t1 recebe 1
	slt $t0, $a1, $t1 #Testa se n < 1
	beq $t0, $zero, L1 #Se n >= 1, desvia para L1
	addi $v1, $zero, 1 #Retorna o valor 1
	addi $sp, $sp, 8 #Elimina 2 itens da pilha
	jr $ra #Retorna para depois da instrucao jal
	L1: addi $a1, $a1, -1 # n >= 1: argumento recebe (n-1)
	jal fatorial # chama fatorial com argumento (n-1)
	lw $a1, 0($sp) # retorna de jal: restaura argumento n
	lw $ra, 4($sp) # restaura o endere�o de retorno
	addi $sp, $sp, 8 # ajusta o stack pointer para eliminar 2 itens
	mul $v1, $a1, $v1 #retorna n*fact(n-1)
	jr $ra #retorna para o chamador 

main:
	#instrucoes para ler os valores do angulo
	li $v0, 4		# Codigo SysCall p/ escrever strings
	la $a0, msg1	# Parametro (string a ser escrita)
	syscall
	#li $v0, 5		# Codigo SysCall p/ ler inteiros
	#syscall		# Inteiro lido vai ficar em $v0
	#add $s0, $v0, $zero  # Armazena em $s0 o n?mero digitado
	li $s0,2
	
	#instrucoes para ler a quantidade de termos
	li $v0, 4		# Codigo SysCall p/ escrever strings
	la $a0, msg2	# Parametro (string a ser escrita)
	syscall
	#li $v0, 5		# Codigo SysCall p/ ler inteiros
	#syscall		# Inteiro lido vai ficar em $v0
	#add $s0, $v0, $zero  # Armazena em $s0 o n?mero digitado
	li $s1,3	#qtde de termos (valor de n)

	
	whileSomatorio:
		slt $t0,$zero,$s1
		beq $t0,$zero,exitWhileSomatorio
		#chamada da funcao cosseno/passagem de parametros
		add $a0,$zero,$s0
		add $a1,$zero,$s1
		jal cosseno
		
		#salvamento retorno
		add $s7,$s7,$v0
		
		addi $s1,$s1,-1
		j whileSomatorio
		exitWhileSomatorio:
	
	#soma 1 para n=0
	addi $s7,$s7,1
	
	#instrucoes para mostrar o cosseno do angulo na tela
	li $v0, 4		# Codigo SysCall p/ escrever strings
	la $a0, msg3	# Parametro (string a ser escrita)
	syscall
	li $v0, 1 # Codigo syscall p/ escrever um inteiro
	add $a0, $s7, $zero # Parametro
	syscall