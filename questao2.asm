.data
fin:    .asciiz "/home/cecilio/git/ufsj-aoc1-tp1/entrada.txt"
fout:   .asciiz "/home/cecilio/git/ufsj-aoc1-tp1/saida.txt"
buffer: .space 1024
.text

leArquivo:
    li   $v0, 13	# system call for open file
    la   $a0, fin	# input file name
    li   $a1, 0		# flag for reading
    li   $a2, 0		# mode is ignored
    syscall		# open a file 
   
    # reading from file just opened

    li   $v0, 14        # system call for reading from file
    la   $a1, buffer    # address of buffer from which to read
    li   $a2, 11        # hardcoded buffer length
    syscall             # read from file
    move $a0, $a1
    

manipulaString:

    li $t0, 0			# t0 = i = 0
 for_loop:
    slti $t1, $t0, 14 		# t1 = 1 if and only if t0 < 14
    beq  $t1, $0,  for_loop_done

    lb   $t4, 0($a0)
    beqz $t4, for_loop_done
    beq  $t4, 10, for_loop_done
    slti $t2, $t4, 91
    li   $t3, 1
    beq  $t2, $t3, upper 	# if the character value is less than 91 branch to upper addition
    bne  $t2, $t3, lower
    
  upper:
    addi $t4, $t4, 32 		# adds 32 to the character value to lowercase it
    j done

  lower:
    addi $t4, $t4, -32 		# subtracts 32 from the character value to capitalize it

  done:
    addi $t0, $t0, 1
    sb   $t4, 0($a0)
    addi $a0, $a0, 1
    j for_loop

  for_loop_done:

# Sai!
li $v0, 10
syscall