# swap.asm
# ENCM 369 Winter 2025 Lab 3 Exercise F

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

# int foo[] =  0x600, 0x500, 0x400, 0x300, 0x200, 0x100}
	.data
        .globl	foo
foo:	.word	0x600, 0x500, 0x400, 0x300, 0x200, 0x100

# int main(void)
#
        .text
        .globl  main
main:
	#prologue
	addi	sp, sp, -32
 	sw 	ra, 0(sp)

	#body
	la	t0, foo	        # t0 = &foo[0]
	mv      a0, t0  	# a0 = &foo[0]
	addi	a1, t0, 20	# a1 = &foo[5]
	jal	swap

	addi	a0, t0, 4	# a0 = &foo[1]
	addi	a1, t0, 16	# a0 = &foo[4] (8*2 = 16 = &foo[4])
	jal	swap
	
	addi	a0, t0, 8	# a0 = &foo[2]
	addi	a1, t0, 12	# a0 = &foo[3] (8*2 = 16 = &foo[4])
	jal	swap

	#epilogue
	add	a0, zero, zero		
	lw	ra, 0(sp)
	addi	sp, sp, 32
	jr	ra

# void swap(int *p, int *q)
#
	.text
	.globl  swap
swap:
	lw	s0, (a0)	# get value of a0 (*p)
	lw	s1, (a1)	# get value of a1 (*q)
	
	mv	t1, s1		# int old_star_q = *q
	
	mv	s1, s0		# *q = *p
	sw	s1, (a1)	# store new *q into &q
	
	mv	s0, t1		# *p = old_star_q
	sw	s0, (a0)	# store new *p into &p

	jr	ra
