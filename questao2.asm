	.file	1 ""
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"r\000"
	.align	2
$LC1:
	.ascii	"entrada.txt\000"
	.text
	.align	2
	.globl	leArquivo
	.set	nomips16
	.set	nomicromips
	.ent	leArquivo
	.type	leArquivo, @function
leArquivo:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	.cprestore	16
	movz	$31,$31,$0
	sw	$4,40($fp)
	lw	$2,%got($LC0)($28)
	nop
	addiu	$5,$2,%lo($LC0)
	lw	$2,%got($LC1)($28)
	nop
	addiu	$4,$2,%lo($LC1)
	lw	$2,%call16(fopen)($28)
	nop
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fopen
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,24($fp)
	lw	$6,24($fp)
	li	$5,50			# 0x32
	lw	$4,40($fp)
	lw	$2,%call16(fgets)($28)
	nop
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fgets
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$4,24($fp)
	lw	$2,%call16(fclose)($28)
	nop
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fclose
1:	jalr	$25
	nop

	lw	$28,16($fp)
	nop
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	leArquivo
	.size	leArquivo, .-leArquivo
	.align	2
	.globl	manipulaString
	.set	nomips16
	.set	nomicromips
	.ent	manipulaString
	.type	manipulaString, @function
manipulaString:
	.frame	$fp,24,$31		# vars= 8, regs= 1/0, args= 0, gp= 8
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$fp,20($sp)
	move	$fp,$sp
	sw	$4,24($fp)
	sw	$0,8($fp)
	movz	$31,$31,$0
	b	$L3
	nop

$L6:
	lw	$2,8($fp)
	lw	$3,24($fp)
	nop
	addu	$2,$3,$2
	lb	$2,0($2)
	nop
	slt	$2,$2,97
	beq	$2,$0,$L4
	nop

	lw	$2,8($fp)
	lw	$3,24($fp)
	nop
	addu	$2,$3,$2
	lw	$3,8($fp)
	lw	$4,24($fp)
	nop
	addu	$3,$4,$3
	lb	$3,0($3)
	nop
	andi	$3,$3,0x00ff
	addiu	$3,$3,32
	andi	$3,$3,0x00ff
	sll	$3,$3,24
	sra	$3,$3,24
	sb	$3,0($2)
	b	$L5
	nop

$L4:
	lw	$2,8($fp)
	lw	$3,24($fp)
	nop
	addu	$2,$3,$2
	lw	$3,8($fp)
	lw	$4,24($fp)
	nop
	addu	$3,$4,$3
	lb	$3,0($3)
	nop
	andi	$3,$3,0x00ff
	addiu	$3,$3,-32
	andi	$3,$3,0x00ff
	sll	$3,$3,24
	sra	$3,$3,24
	sb	$3,0($2)
$L5:
	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L3:
	lw	$2,8($fp)
	lw	$3,24($fp)
	nop
	addu	$2,$3,$2
	lb	$2,0($2)
	nop
	bne	$2,$0,$L6
	nop

	nop
	move	$sp,$fp
	lw	$fp,20($sp)
	addiu	$sp,$sp,24
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	manipulaString
	.size	manipulaString, .-manipulaString
	.rdata
	.align	2
$LC2:
	.ascii	"w\000"
	.align	2
$LC3:
	.ascii	"saida.txt\000"
	.text
	.align	2
	.globl	salvaArquivo
	.set	nomips16
	.set	nomicromips
	.ent	salvaArquivo
	.type	salvaArquivo, @function
salvaArquivo:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	.cprestore	16
	movz	$31,$31,$0
	sw	$4,40($fp)
	lw	$2,%got($LC2)($28)
	nop
	addiu	$5,$2,%lo($LC2)
	lw	$2,%got($LC3)($28)
	nop
	addiu	$4,$2,%lo($LC3)
	lw	$2,%call16(fopen)($28)
	nop
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fopen
1:	jalr	$25
	nop

	lw	$28,16($fp)
	sw	$2,24($fp)
	lw	$5,24($fp)
	lw	$4,40($fp)
	lw	$2,%call16(fputs)($28)
	nop
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fputs
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$4,24($fp)
	lw	$2,%call16(fclose)($28)
	nop
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,fclose
1:	jalr	$25
	nop

	lw	$28,16($fp)
	nop
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	salvaArquivo
	.size	salvaArquivo, .-salvaArquivo
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,88,$31		# vars= 56, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-88
	sw	$31,84($sp)
	sw	$fp,80($sp)
	move	$fp,$sp
	.cprestore	16
	movz	$31,$31,$0
	addiu	$2,$fp,24
	move	$4,$2
	lw	$2,%got(leArquivo)($28)
	nop
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,leArquivo
1:	jalr	$25
	nop

	lw	$28,16($fp)
	addiu	$2,$fp,24
	move	$4,$2
	lw	$2,%got(manipulaString)($28)
	nop
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,manipulaString
1:	jalr	$25
	nop

	lw	$28,16($fp)
	addiu	$2,$fp,24
	move	$4,$2
	lw	$2,%got(salvaArquivo)($28)
	nop
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,salvaArquivo
1:	jalr	$25
	nop

	lw	$28,16($fp)
	move	$2,$0
	move	$sp,$fp
	lw	$31,84($sp)
	lw	$fp,80($sp)
	addiu	$sp,$sp,88
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"