.data
fin:     .asciiz "/home/cecilio/git/ufsj-aoc1-tp1/entrada.txt"
fout:    .asciiz "/home/cecilio/git/ufsj-aoc1-tp1/saida.txt"
string:  .space 1024

.text
leArquivo:
    # Open (for reading) a file
    li   $v0, 13	# system call for open file
    la   $a0, fin	# input file name
    li   $a1, 0		# flag for reading
    li   $a2, 0		# mode is ignored
    syscall		    # open a file
    move $s0, $v0	# save the file descriptor
   
    # reading from file
    li   $v0, 14        # system call for reading from file
    move $a0, $s0       # file descriptor 
    la   $a1, string    # address of buffer from which to read
    li   $a2, 255       # hardcoded buffer length
    syscall             # read from file
    
    # Close the file
    li   $v0, 16        # system call for close file
    move $a0, $s0       # file descriptor to close
    syscall             # close file

manipulaString:  
  la $t0, string            # Load here the string
  
  Loop:  
    lb   $t2, ($t0)         # We do as always, get the first byte pointed by the address
    beq  $t2, $zero, End    # if is equal to zero, the string is terminated
    
    # if 'A-Z'
    slti $t1, $t2, 90
    bne  $t1, $zero, Upper
    
    # if 'a-z'
    slti $t1, $t2, 122
    bne  $t1, $zero, Lower
    
    j Continue
    
    Upper:
    slti $t1, $t2, 65
    bne  $t1, $zero, Continue
    addi $t2, $t2, 32  
    sb   $t2, ($t0)         # store it in the string
    j Continue
    
    Lower:
    slti $t1, $t2, 97
    bne  $t1, $zero, Continue
    addi $t2, $t2, -32  
    sb   $t2, ($t0)         # store it in the string
    j Continue

  Continue:  
  # Continue the iteration  
    addi $t0, $t0, 1        # Increment the address
    addi $t3, $t3, 1        # strlen
    j Loop

  End:    
    li $v0, 4               # Print the string  
    la $a0, string  
    syscall
    
salvaArquivo:
  # Open (for writing) a file that does not exist
  li   $v0, 13       # system call for open file
  la   $a0, fout     # output file name
  li   $a1, 1        # Open for writing (flags are 0: read, 1: write)
  li   $a2, 0        # mode is ignored
  syscall            # open a file (file descriptor returned in $v0)
  move $s6, $v0      # save the file descriptor 

  # Write to file just opened
  li   $v0, 15       # system call for write to file
  move $a0, $s6      # file descriptor 
  la   $a1, string   # address of buffer from which to write
  add  $a2, $a2, $t3 # hardcoded buffer length
  syscall            # write to file

  # Close the file 
  li   $v0, 16       # system call for close file
  move $a0, $s6      # file descriptor to close
  syscall            # close file

# Exit != dropped off bottom
li $v0, 10
syscall