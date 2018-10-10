.data
prompt: .asciiz "\n\nEnter an string of characters: "
result: .asciiz "\n\nHere is the string you entered: "
after_sort: .asciiz "\n\nHere is the string after the case sorting: "
buffer: .space 80
.text

main:

#Prints the prompt string
li $v0, 4
la $a0, prompt 
syscall 

#reads string from user and saves in $a0
li $v0, 8
la $a0, buffer
li $a1, 80
syscall

#Prints the result string
li $v0, 4 
la $a0, result 
syscall

#Prints the string entered by the user
la $a0, buffer 
li $v0, 4
syscall


li $t0, 0 # t0 = i = 0
for_loop:
slti $t1, $t0, 80 # t1 = 1 if and only if t0 < 80
beq $t1, $0, for_loop_done

lb $t4, 0($a0)
beqz $t4, for_loop_done
beq $t4, 10, for_loop_done
slti $t2, $t4, 91
li $t3, 1
beq $t2, $t3, upper #if the character value is less than 91 branch to upper      addition
bne $t2, $t3, lower

upper:
addi $t4, $t4, 32 #adds 32 to the character value to lowercase it
j done

lower:
addi $t4, $t4, -32 #subtracts 32 from the character value to capitalize it
done:

addi $t0, $t0, 1

sb $t4, 0($a0)
addi $a0, $a0, 1

j for_loop
for_loop_done:

#Prints the result string
li $v0, 4 
la $a0, after_sort 
syscall

#Prints the string entered by the user
la $a0, buffer 
li $v0, 4
syscall

exitProgram:    li $v0, 10  # system call to
syscall         # terminate program