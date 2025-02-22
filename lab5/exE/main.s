	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 15, 0	sdk_version 15, 2
	.globl	_timespec2ns                    ; -- Begin function timespec2ns
	.p2align	2
_timespec2ns:                           ; @timespec2ns
	.cfi_startproc
; %bb.0:
	ldp	d0, d1, [x0]
	scvtf	d0, d0
	scvtf	d1, d1
	mov	x8, #225833675390976            ; =0xcd6500000000
	movk	x8, #16845, lsl #48
	fmov	d2, x8
	fmadd	d0, d0, d2, d1
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #160
	stp	d9, d8, [sp, #48]               ; 16-byte Folded Spill
	stp	x28, x27, [sp, #64]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #80]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #96]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #112]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #128]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #144]            ; 16-byte Folded Spill
	add	x29, sp, #144
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	.cfi_offset b8, -104
	.cfi_offset b9, -112
	mov	x8, #0                          ; =0x0
Lloh0:
	adrp	x9, _arr@GOTPAGE
Lloh1:
	ldr	x9, [x9, _arr@GOTPAGEOFF]
	mov	w10, #34464                     ; =0x86a0
	movk	w10, #1, lsl #16
LBB1_1:                                 ; =>This Inner Loop Header: Depth=1
	str	w8, [x9, x8, lsl #2]
	add	x8, x8, #1
	cmp	x8, x10
	b.ne	LBB1_1
; %bb.2:
Lloh2:
	adrp	x19, l_.str@PAGE
Lloh3:
	add	x19, x19, l_.str@PAGEOFF
	mov	w26, #1                         ; =0x1
Lloh4:
	adrp	x20, _arr@GOTPAGE
Lloh5:
	ldr	x20, [x20, _arr@GOTPAGEOFF]
Lloh6:
	adrp	x21, l_.str.1@PAGE
Lloh7:
	add	x21, x21, l_.str.1@PAGEOFF
	mov	x27, #225833675390976           ; =0xcd6500000000
	movk	x27, #16845, lsl #48
Lloh8:
	adrp	x22, l_.str.2@PAGE
Lloh9:
	add	x22, x22, l_.str.2@PAGEOFF
Lloh10:
	adrp	x23, l_.str.3@PAGE
Lloh11:
	add	x23, x23, l_.str.3@PAGEOFF
Lloh12:
	adrp	x24, l_.str.4@PAGE
Lloh13:
	add	x24, x24, l_.str.4@PAGEOFF
LBB1_3:                                 ; =>This Inner Loop Header: Depth=1
	str	x26, [sp]
	mov	x0, x19
	bl	_printf
	add	x1, sp, #32
	mov	w0, #16                         ; =0x10
	bl	_clock_gettime
	mov	x0, x20
	mov	w1, #34464                      ; =0x86a0
	movk	w1, #1, lsl #16
	bl	_use_pointers
	mov	x25, x0
	add	x1, sp, #16
	mov	w0, #16                         ; =0x10
	bl	_clock_gettime
	str	x25, [sp]
	mov	x0, x21
	bl	_printf
	ldp	d0, d1, [sp, #16]
	scvtf	d0, d0
	scvtf	d1, d1
	fmov	d8, x27
	fmadd	d0, d0, d8, d1
	ldp	d1, d2, [sp, #32]
	scvtf	d1, d1
	scvtf	d2, d2
	fmadd	d1, d1, d8, d2
	fsub	d0, d0, d1
	str	d0, [sp]
	mov	x0, x22
	bl	_printf
	add	x1, sp, #32
	mov	w0, #16                         ; =0x10
	bl	_clock_gettime
	mov	x0, x20
	mov	w1, #34464                      ; =0x86a0
	movk	w1, #1, lsl #16
	bl	_use_indexes
	mov	x25, x0
	add	x1, sp, #16
	mov	w0, #16                         ; =0x10
	bl	_clock_gettime
	str	x25, [sp]
	mov	x0, x23
	bl	_printf
	ldp	d0, d1, [sp, #16]
	scvtf	d0, d0
	scvtf	d1, d1
	fmadd	d0, d0, d8, d1
	ldp	d1, d2, [sp, #32]
	scvtf	d1, d1
	scvtf	d2, d2
	fmadd	d1, d1, d8, d2
	fsub	d0, d0, d1
	str	d0, [sp]
	mov	x0, x24
	bl	_printf
	add	w26, w26, #1
	cmp	w26, #11
	b.ne	LBB1_3
; %bb.4:
	mov	w0, #0                          ; =0x0
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	ldp	d9, d8, [sp, #48]               ; 16-byte Folded Reload
	add	sp, sp, #160
	ret
	.loh AdrpLdrGot	Lloh0, Lloh1
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpAdd	Lloh6, Lloh7
	.loh AdrpLdrGot	Lloh4, Lloh5
	.loh AdrpAdd	Lloh2, Lloh3
	.cfi_endproc
                                        ; -- End function
	.comm	_arr,400000,2                   ; @arr
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"run %d\n"

l_.str.1:                               ; @.str.1
	.asciz	"    max from use_pointers: %d\n"

l_.str.2:                               ; @.str.2
	.asciz	"    time for use_pointers, in ns: %.2f\n"

l_.str.3:                               ; @.str.3
	.asciz	"    max from use_indexes: %d\n"

l_.str.4:                               ; @.str.4
	.asciz	"    time for use_indexes, in ns: %.2f\n"

.subsections_via_symbols
