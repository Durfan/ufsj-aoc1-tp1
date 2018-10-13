.data
fin:     .asciiz "/home/cecilio/git/ufsj-aoc1-tp1/entrada.txt"
fout:    .asciiz "/home/cecilio/git/ufsj-aoc1-tp1/saida.txt"
string:  .space 1024

.text
main:
  la  $a0, fin
  jal leArquivo
  
  la  $a0, string
  jal manipulaString
  
  la  $a0, fout
  jal salvaArquivo
  
  li $v0, 10          # system call: Saia do programa
  syscall             # Saia!

leArquivo:
  li   $v0, 13        # system call: Abre o arquivo
  li   $a1, 0         # flag para somente leitura
  li   $a2, 0         # modo ignorado
  syscall             # Abra o arquivo!
  move $t0, $v0       # Salva o descriptor em $t0

  li   $v0, 14        # system call: Lendo o arquivo
  move $a0, $t0       # Carrega o descriptor do arquivo
  la   $a1, string    # endereço do buffer
  li   $a2, 255       # hardcoded buffer length
  syscall             # Leia o arquivo!
  move $s0, $v0       # Salva strlen em $s0

  li   $v0, 16        # system call: Fecha o arquivo
  syscall             # Feche o arquivo!
  
  jr $ra

manipulaString:
  Loop:  
    lb   $t2, ($a0)         # We do as always, get the first byte pointed by the address
    beq  $t2, $zero, End    # if is equal to zero, the string is terminated
    
    slti $t1, $t2, 90       # if 'A-Z'
    bne  $t1, $zero, Upper
      
    slti $t1, $t2, 122      # if 'a-z'
    bne  $t1, $zero, Lower
    
    j Continue
    
    Upper:
    slti $t1, $t2, 65
    bne  $t1, $zero, Continue
    addi $t2, $t2, 32  
    sb   $t2, ($a0)         # store it in the string
    j Continue
    
    Lower:
    slti $t1, $t2, 97
    bne  $t1, $zero, Continue
    addi $t2, $t2, -32  
    sb   $t2, ($a0)         # store it in the string
    j Continue

  Continue:                 # Continue the iteration
    addi $a0, $a0, 1        # Increment the address
    j Loop

  End:    
    # li $v0, 4
    # la $a0, string
    # syscall
    jr $ra
    
salvaArquivo:
  li   $v0, 13        # system call: Abre o arquivo
  li   $a1, 1         # flag para escrita
  li   $a2, 0         # modo ignorado
  syscall             # Abra o arquivo!
  move $t0, $v0       # Salva o descriptor em $t0 

  li   $v0, 15        # system call: Escrevendo no arquivo
  move $a0, $t0       # Carrega o descriptor do arquivo 
  la   $a1, string    # endereço do buffer
  move $a2, $s0       # carrega strlen de $s0
  syscall             # Escreva no arquivo!

  li   $v0, 16        # system call: Fecha o arquivo
  syscall             # Feche o arquivo!
  jr $ra