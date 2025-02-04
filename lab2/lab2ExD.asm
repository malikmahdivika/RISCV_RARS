# lab2ExD.asm
# ENCM 369 Winter 2025 Lab 2
# This program has complete start-up and clean-up code, and a "stub"
# main function.

#Utilizing this stub for Exercise D

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

#global arrays to operate on
	.data
	.globl alpha
alpha:	.word 0xb1, 0xe1, 0x91, 0xc1, 0x81, 0xa1, 0xf1, 0xd1
	.globl beta
beta: 	.word 0x0, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70

# Below is the stub for main. Edit it to give main the desired behaviour.

# variables for organization
#	int *p = s0
#	int *guard =  s1s0 + 32 (8*4 = 32)
#	int min = s2
#	int i = s3
#	int j = s4

	.text
	.globl	main
main:
	la	s0, alpha		#p = alpha
	addi	s1, s0, 32		#guard = p + 8
	lw 	s2, (s0)		#min = *p
	addi	s0, s0, 4		#p++
	la	t4, alpha		#t4 = alpha (base address)
	la	t5, beta		#t5 = beta (base address)
	
do_loop_start:
	lw 	t0, (s0)		#temp = *p for blt comparison
	blt 	t0, s2, update_min	#if *p < min goto update_min
update_min_end:
	addi 	s0, s0, 4		#p++
	beq	s0, s1, do_loop_end	#if p == guard goto do_loop_end
	j 	do_loop_start		#goto do_loop_start
update_min:
	add	s2, zero, t0		#min = *p
	j	update_min_end		#goto update_min_end
do_loop_end:

	addi	s3, zero, 0		#i = 0
	addi	s4, zero, 7		#j = 7
	addi	t0, zero, 8		#t0 = 8 (for comparison)
for_loop_start:
	bge	s3, t0, for_loop_end	#if i >=8 goto for_loop_end
	
	#calculate address of beta[j] using t1 register and load into t2
	slli	t1, s4, 2		#t1 = j * 4
	add	t1, t5, t1		#t1 = &beta[j]
	lw	t2, (t1)		#t2 = beta[j]
	
	#address of alpha[i]
	slli 	t3, s3, 2		#t3 = i * 4
	add	t3, t4, t3		#t3 = &alpha[i]
	
	#store into alpha[i]
	sw	t2, (t3)

	addi	s3, s3, 1		#i++	
	addi	s4, s4, -1		#j--
	j	for_loop_start		#goto for_loop_start
for_loop_end:

	li      a0, 0   # return value from main = 0
	jr	ra
