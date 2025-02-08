# exE.asm
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
	
# int aaa[] = {11, 11, 3, -11, 11)
# int bbb[] = {200, -300, 400, 500)
# int ccc[] = {-3, -4, 3, 2, 3, 4)
	.data
	.globl aaa, bbb, ccc
aaa:	.word 11, 11, 3, -11, 11
bbb:	.word 200, -300, 400, 500
ccc:	.word -3, -4, 3, 2, 3, 4

# int sum_of_sats(const int *a, int n, int max_mag)
	.text
	.globl	sum_of_sats
sum_of_sats:
	#prologue
	addi	sp, sp, -32		# allocate 8 words to the stack
	sw	ra, (sp)		# store return address at 0(sp)
	sw	s0, 4(sp)		# save alpha before using for array address
	sw	s1, 8(sp)		# save beta before using register for n
	sw	s2, 12(sp)		# save gamma before using register for max_mag
	
	mv	s0, a0			# s0 = a0 = int[]
	mv	s1, a1			# s1 = a1 = int n
	mv	s2, a2			# s2 = a2 = int max_mag
	addi	s3, zero, 0		# result = 0
	
	
	#body
	if_start:
	ble	s1, zero, if_end	# if (n <= 0) goto if_end
	addi 	s1, s1, -1		# n--
	
	while_start:
	mv	a0, s2			# a0 = max_mag
	slli	t0, s1, 2		# t0 = n * 4
	add	t0, s0, t0		# t0 = address of nth entry in the array
	lw	a1, (t0)		# a1 = a[n]
	jal	sat			# sat call
	add	s3, s3, a0		# result += sat(max_mag, a[n])
	addi	s1, s1, -1		# n--
	blt	s1, zero, if_end	# break while loop if (n < 0)
	j	while_start
	
	if_end:
	mv	a0, s3
	
	#epilogue
	lw 	ra, (sp)		# load return address back to main
	lw	s0, 4(sp)		# restore alpha
	lw	s1, 8(sp)		# restore beta
	lw	s2, 12(sp)		# restore gamma
	addi	sp, sp, 32		# deallocate stack

	jr	ra			# return to address

# int sat(int b, int x)
	.text
	.globl 	sat
sat:
	#leaf function w/ no s-register values, no need for stack
	sub	t0, zero, a0		# t0 = -b
	
	bge	a1, t0, else_if		# if (x >= -b) goto else_if ; check other if
	mv	a0, t0			# if true, return -b
	j	return
	
	else_if:			
	ble	a1, a0, else		# if (x <= b) goto else ; execute neither
	j	return			# return b ; a0 is already b, just jump to return

	else:
	mv	a0, a1			# return x
	
	return:
	jr 	ra			# return to sum_of_sats
	
# Below is the stub for main. Edit it to give main the desired behaviour.
	.text
	.globl	main
main:
	#prologue
	addi 	sp, sp, -32		# allocate 8 words to stack
	sw 	ra, (sp)		# store return address at 0(sp)
	addi	s2, zero, 2000		# gamma = 2000
	
	
	#body
	la	a0, aaa			# a0 = aaa[]
	addi	a1, zero, 5		# a1 = 5
	addi	a2, zero, 10		# a2 = 10
	jal	sum_of_sats		
	mv	s0, a0			# alpha (s0) = sum_of_sats(aaa, 5, 10)
	
	la	a0, bbb			# a0 = bbb[]
	addi	a1, zero, 4		# a1 = 4
	addi	a2, zero, 300		# a2 = 300
	jal	sum_of_sats
	mv	s1, a0			# beta (s1) = sum_of_sats(bbb, 4, 300)
	
	la	a0, ccc			# a0 = ccc[]
	addi	a1, zero, 6		# a1 = 6
	addi	a2, zero, 3		# a2 = 3
	jal 	sum_of_sats
	add	s2, s2, a0		# gamma += sum_of_sats(ccc, 6, 3)
	add	s2, s2, s0		# gamma += alpha
	add	s2, s2, s1		# gamma += beta
	
	
	#epilogue
	lw	ra, (sp)		# load ra from 0(sp)
	addi	sp, sp, 32		# deallocate stack
	li      a0, 0   		# return value from main = 0
	jr	ra
