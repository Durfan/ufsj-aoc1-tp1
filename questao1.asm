.data

msg1: .asciiz "Digite um angulo em radianos: "
msg2: .asciiz "Digite a quantidade de termos: "
msg3: .asciiz "O cosseno do angulo e: "

.text
	.globl main
j main

cosseno:
	# codigo para salvar o valor das variaveis
	addi $sp, $sp, -12  # Ajusta a pilha para receber 3 itens
	sw $ra,8($sp)       # Salva o endereco de retorno
	sw $a1,4($sp)       # Salva o argumento n 
	sw $a0,0($sp)       # Salva o argumento n

	# laco para determinar o sinal de -1
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

	# chamada da funcao potencia
	jal potencia
	mul $v0,$v0,$t0 #$v0 = ((-1)^n) * (x^2n)

	# chamada da funcao fatorial
	mul $a1,$a1,2
	jal fatorial

	# operacao final do cosseno [((-1)^n) * (x^2n)]/(2n)!
	mtc1 $v0, $f1
  	cvt.s.w $f1, $f1

  	mtc1 $v1, $f2
  	cvt.s.w $f2, $f2

	div.s $f0, $f1, $f2


	# codigo para restaurar o valor das variaveis
	lw $a0,0($sp)
	lw $a1,4($sp)
	lw $ra,8($sp)	
	addi $sp,$sp,12

	# retorno para o chamador (funcao main)
	jr $ra

potencia:
	# codigo para salvar o valor das variaveis
	addi $sp, $sp, -12  # Ajusta a pilha para receber 3 itens
	sw $ra,8($sp)       # Salva o endereco de retorno
	sw $a1,4($sp)       # Salva o argumento n
	sw $a0,0($sp)       # Salva o argumento n

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
		# $t3 contem o valor final da expressao (x^2n)

	# retorno
	add $v0,$zero,$t3
	
	#codigo para restaurar o valor das variaveis
	lw $a0,0($sp)
	lw $a1,4($sp)
	lw $ra,8($sp)
	addi $sp,$sp,12

	#retorno para o chamador (funcao cosseno)
	jr $ra

fatorial:
	addi $sp,$sp,-8     # Ajusta a pilha para receber 2 itens
	sw $ra,4($sp)       # Salva o endereco de retorno
	sw $a1,0($sp)       # Salva o argumento n
	addi $t1,$zero,1    # $t1 recebe 1
	slt $t0,$a1,$t1     # Testa se n < 1
	beq $t0,$zero,L1    # Se n >= 1, desvia para L1
	addi $v1,$zero,1    # Retorna o valor 1
	addi $sp,$sp,8      # Elimina 2 itens da pilha
	jr $ra              # Retorna para depois da instrucao jal
	L1: addi $a1,$a1,-1 # n >= 1: argumento recebe (n-1)
	jal fatorial        # chama fatorial com argumento (n-1)
	lw $a1,0($sp)       # retorna de jal: restaura argumento n
	lw $ra,4($sp)       # restaura o endereco de retorno
	addi $sp,$sp,8      # ajusta o stack pointer para eliminar 2 itens
	mul $v1,$a1,$v1     # retorna n*fact(n-1)
	jr $ra              # retorna para o chamador

main:
	#instrucoes para ler os valores do angulo
	li $v0,51           # Codigo SysCall p/ ler inteiros
	la $a0,msg1
	syscall             # Inteiro lido vai ficar em $a0
	add $s0,$s0,$a0     # Armazena em $s0 o numero digitado
	#li $s0,2

	# instrucoes para ler a quantidade de termos
	la $a0,msg2
	syscall               # Inteiro lido vai ficar em $a0
	add $s1,$s1,$a0       # Armazena em $s1 o numero digitado
	#li $s1,3............. # qtde de termos (valor de n)

	whileSomatorio:
		slt $t0,$zero,$s1
		beq $t0,$zero,exitWhileSomatorio
		# chamada da funcao cosseno/passagem de parametros
		add $a0,$zero,$s0
		add $a1,$zero,$s1
		jal cosseno

		# salvamento retorno
		# add $s7,$s7,$v0

		add.s $f4, $f4, $f0

		addi $s1,$s1,-1
		j whileSomatorio
		exitWhileSomatorio:

	# soma 1 para n=0
	li $t7,1
	mtc1 $t7, $f5
	cvt.s.w $f5, $f5

	add.s $f4, $f4, $f5

	# instrucoes para mostrar o cosseno do angulo na tela
	li $v0,57           # Codigo SysCall p/ escrever strings
	la $a0,msg3         # Parametro (string a ser escrita)
	add.s $f12,$f31,$f4 # Parametro
	syscall

	li $v0,10           # system call: Saia do programa
	syscall             # Saia!
