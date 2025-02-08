# stub1.asm
# ENCM 369 Winter 2025
# This program has complete start-up and clean-up code, and a "stub"
# main function.

# BEGINNING of start-up & clean-up code.  Do NOT edit this code.
	.data
exit_msg_1:
	.asciz	"***About to exit. main returned "
exit_msg_2:
	.asciz	".***\n"
main_rv:
	.word	0
	
	.text
	# adjust sp, then call main
	andi	sp, sp, -32		# round sp down to multiple of 32
	jal	main
	
	# when main is done, print its return value, then halt the program
	sw	a0, main_rv, t0	
	la	a0, exit_msg_1
	li      a7, 4
	ecall
	lw	a0, main_rv
	li	a7, 1
	ecall
	la	a0, exit_msg_2
	li	a7, 4
	ecall
        lw      a0, main_rv
	addi	a7, zero, 93	# call for program exit with exit status that is in a0
	ecall
# END of start-up & clean-up code.

# int banana = 0x20000
	.data
	.globl banana
banana:	0x20000

# int funcA(int first, int second, int third, int fourth)
	.text
	.globl funcA
funcA:
	#prologue
	addi	sp, sp, -32		# allocate another 8 words to stack
	sw	ra, (sp)		# store ra in (sp)
	mv	s0, a0			# store first at s0
	mv	s1, a1			# store second at s1
	mv	s2, a2			# store third at s2
	mv	s3, a3			# store fourth at s3
	
	#body
	mv	a0, s3			# a0 = fourth
	mv	a1, s2			# a1 = third
	jal	funcB			# funcB(fourth, third)
	mv	s4, a0			# car = funcB(fourth, third)
	
	mv	a0, s1			# a0 = second
	mv	a1, s0			# a1 = first
	jal	funcB			# funcB(second, first)
	mv	s6, a0			# bus = funcB(second, first)
	
	mv	a0, s2			# a0 = third
	mv	a1, s3			# a1 = fourth
	jal	funcB			# funcB(third, fourth)
	mv	s5, a0			# truck = funcB(third, fourth)
	
	add	t0, s4, s5		# t0 = car + truck
	add	a0, t0, s6		# a0 = t0 + bus (where a0 is return arg)
	
	#epilogue
	lw	ra, (sp)		# load return address in main to ra
	addi	sp, sp, 32		# deallocate stack
	lw	s0, 4(sp)		# restore value of apple to s0
	lw	s1, 8(sp)		# restore value of orange to s1
	jr	ra			# return to main

# int funcB(int y, int z)
	.text
	.globl funcB
funcB:
	slli	t0, a1, 6		# t0 = z * 64
	add	t1, a0, t0		# t1 = y + (t0 = z*64)
	mv	a0, t1			# a0 = t1; giving a0 the return value
	
	jr	ra			#return to where funcB was called

# Below is the stub for main. Edit it to give main the desired behaviour.
	.text
	.globl	main
main:
	#prologue
	addi 	sp, sp, -32		#allocate 8 words to stack
	sw	ra, (sp)		#store ra at 0(sp)
	addi	s0, zero, 0x700		#int apple = 0x700
	li	s1, 0x800		#int orange = 0x800
	sw	s0, 4(sp)		#store apple in stack
	sw	s1, 8(sp)		#store orange in stack
	
	#body
	addi	a0, zero, 5			#a0 = 5
	addi	a1, zero, 4			#a1 = 4
	addi	a2, zero, 3			#a2 = 3
	addi	a3, zero, 2			#a3 = 2
	jal	funcA
	add	s1, s1, a0			# orange = orange + funcA(5, 4, 3, 2)
	la	t1, banana			# store address of int banana at t1
	sub	t0, s0, s1			# t0 = apple - orange
	lw	t2, (t1)			# load value of banana into t2
	add	t2, t2, t0			# banana = banana + t0
	sw	t2, (t1)
	
	#epilogue
	lw	ra, (sp)			# load address back to cleanup code
	addi	sp, sp, 32			# deallocate stack
	li      a0, 0   			# return value from main = 0
	jr	ra
