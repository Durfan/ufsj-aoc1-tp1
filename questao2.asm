.data
fin:     .asciiz "/home/cecilio/git/ufsj-aoc1-tp1/entrada.txt"
fout:    .asciiz "/home/cecilio/git/ufsj-aoc1-tp1/saida.txt"
string:  .space 1024

.text
main:                    # Escopo principal do programa
  la $a0,fin             # atribui o arquivo de entrada a $a0
  jal leArquivo          # inicia o procedimento
  la $a0,string          # atribui a string a $a0
  jal manipulaString     # inicia o procedimento
  la $a0,fout            # atribui o arquivo de saida a $a0
  jal salvaArquivo       # inicia o procedimento
  li $v0,10              # system call: Saia do programa
  syscall                # Saia!

leArquivo:               # procedimento para ler o arquivo
  li $v0,13              # system call: Abre o arquivo
  li $a1,0               # flag para somente leitura
  li $a2,0               # modo ignorado
  syscall                # Abra o arquivo!
  move $t0,$v0           # Salva o descriptor em $t0
  li $v0,14              # system call: Lendo o arquivo
  move $a0,$t0           # Carrega o descriptor do arquivo
  la $a1,string          # endereco do buffer
  li $a2,255             # hardcoded buffer length
  syscall                # Leia o arquivo!
  move $s0,$v0           # Salva strlen em $s0
  li $v0,16              # system call: Fecha o arquivo
  syscall                # Feche o arquivo!
  jr $ra                 # Retorna do procedimento

manipulaString:          # procedimento para alterar a string
  Loop:                  # loop para cada character da string
    lb $t2,($a0)         # Aponta $t2 para a posicao de endereco de $a0
    beq $t2,$zero,End    # Se $t2 conter NULL, a string terminou, End
    slti $t1,$t2, 90     # $t2 e menor que 90(Z)?
    bne $t1,$zero,Upper  # Se $t1 for 1 entao 1 != 0, vai pra Upper
    slti $t1,$t2,122     # $t2 e menor que 122(z)?
    bne $t1,$zero,Lower  # Se $t1 for 1 entao 1 != 0, vai pra Lower
    j Next               # Va pra Next
    
    Upper:               # rotina para uppercase
    slti $t1,$t2,65      # $t2 e menor que 65(A)?
    bne $t1,$zero,Next   # Se $t1 for 1 entao nao e uma letra, Next
    addi $t2,$t2,32      # Soma 32 a $t2
    sb $t2,($a0)         # armazena o valor na posicao em $a0
    j Next               # Va pra Next
    
    Lower:               # rotina para lowercase
    slti $t1,$t2,97      # $t2 e menor que 97(a)?
    bne $t1,$zero,Next   # Se $t1 for 1 entao nao e uma letra, Next
    addi $t2,$t2,-32     # Soma -32 a $t2
    sb $t2,($a0)         # armazena o valor na posicao em $a0

  Next:                  # Continua a interacao
    addi $a0,$a0,1       # Incrementa o endereco de $a0
    j Loop               # Va para Loop
  End:                   # Termino do Loop
    #li $v0,4              # system call: Imprimir string
    #la $a0,string         # endereco da string
    #syscall               # Imprima!
    jr $ra               # Retorna do procedimento

salvaArquivo:            # procedimento para salvar o arquivo
  li $v0,13              # system call: Abre o arquivo
  li $a1,1               # flag para escrita
  li $a2,0               # modo ignorado
  syscall                # Abra o arquivo!
  move $t0,$v0           # Salva o descriptor em $t0
  li $v0,15              # system call: Escrevendo no arquivo
  move $a0,$t0           # Carrega o descriptor do arquivo
  la $a1,string          # endereço do buffer
  move $a2,$s0           # carrega strlen de $s0
  syscall                # Escreva no arquivo!
  li $v0,16              # system call: Fecha o arquivo
  syscall                # Feche o arquivo!
  jr $ra                 # Retorna do procedimento
