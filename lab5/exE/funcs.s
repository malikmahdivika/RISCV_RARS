	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 15, 0	sdk_version 15, 2
	.globl	_use_pointers                   ; -- Begin function use_pointers
	.p2align	2
_use_pointers:                          ; @use_pointers
	.cfi_startproc
; %bb.0:
	mov	x8, x0
	ldr	w0, [x0]
	cmp	w1, #1
	b.lt	LBB0_3
; %bb.1:
	add	x9, x8, w1, sxtw #2
LBB0_2:                                 ; =>This Inner Loop Header: Depth=1
	ldr	w10, [x8], #4
	cmp	w10, w0
	csel	w0, w10, w0, gt
	cmp	x8, x9
	b.lo	LBB0_2
LBB0_3:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_use_indexes                    ; -- Begin function use_indexes
	.p2align	2
_use_indexes:                           ; @use_indexes
	.cfi_startproc
; %bb.0:
	mov	x8, x0
	ldr	w0, [x0]
	cmp	w1, #1
	b.lt	LBB1_3
; %bb.1:
	mov	w9, w1
LBB1_2:                                 ; =>This Inner Loop Header: Depth=1
	ldr	w10, [x8], #4
	cmp	w10, w0
	csel	w0, w10, w0, gt
	subs	x9, x9, #1
	b.ne	LBB1_2
LBB1_3:
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
