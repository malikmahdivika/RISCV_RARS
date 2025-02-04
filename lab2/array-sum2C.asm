# array-sum2C.asm
# ENCM 369 Winter 2025 Lab 2 Exercise C Part 3

# Start-up and clean-up code copied from stub1.asm

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

# Global variables
	.data
	# int abc[ ] = {-32, -8, -64, -2, -4, -96}
	.globl	abc	
abc:	.word	-32, -8, -64, -2, -4, -96

# Hint for checking that the original program works:
# The sum of the six array elements is -206, which will be represented
# as 0xffffff32 in a RISC-V GPR.

# Hint for checking that your final version of the program works:
# The maximum of the six array elements is -2, which will be represented
# as 0xfffffffe in a RISC-V GPR.


# int main(void)
#
# local variable	register
#   int *p		s0
#   int *end		s1
#   int sum		s2
#   int max		s3  (to be used when students enhance the program)

	.text
	.globl	main
main:
	la	s0, abc	        	# p = abc
	addi	s1, s0, 24		# end = p + 6
	add	s2, zero, zero	        # sum = 0
	lw	s3, (s0)		# max = abc[0]
L1:
	lw	t0, (s0)		# t0 = *p
	beq	s0, s1, L2		# if (p == end) goto L2
	bgt	t0, s3, L3		# if (*p > max) goto L3
L4:
	add	s2, s2, t0		# sum += t0
	addi	s0, s0, 4		# p++
	j	L1
L2:		
	add	a0, zero, zero	        # return value from main = 0
	jr	ra
L3:
	add	s3, zero, t0 		#max = 0 + *p
	j	L4
