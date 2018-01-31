	.file	"base.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.globl	mullInternalMatrix
	.type	mullInternalMatrix, @function
mullInternalMatrix:
.LFB43:
	.cfi_startproc
	leaq	1048576(%rdx), %r10
	leaq	1048576(%rsi), %r8
	movq	%rdi, %r9
.L2:
	movq	%rsi, %rcx
	movq	%r9, %rdi
	.p2align 4,,10
	.p2align 3
.L6:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L3:
	movss	(%rdi), %xmm0
	mulss	(%rcx,%rax), %xmm0
	addss	(%rdx,%rax), %xmm0
	movss	%xmm0, (%rdx,%rax)
	addq	$4, %rax
	cmpq	$2048, %rax
	jne	.L3
	addq	$2048, %rcx
	addq	$4, %rdi
	cmpq	%rcx, %r8
	jne	.L6
	addq	$2048, %rdx
	addq	$2048, %r9
	cmpq	%rdx, %r10
	jne	.L2
	rep ret
	.cfi_endproc
.LFE43:
	.size	mullInternalMatrix, .-mullInternalMatrix
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	mullExternalMatrix
	.type	mullExternalMatrix, @function
mullExternalMatrix:
.LFB42:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rdi, %r14
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rsi, %r13
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdx, %r12
	xorl	%ebp, %ebp
.L10:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L14:
	xorl	%r11d, %r11d
	.p2align 4,,10
	.p2align 3
.L11:
	movq	(%r12,%rbp), %rax
	movq	(%rax,%rbx), %rdx
	movq	0(%r13,%r11), %rax
	movq	(%rax,%rbx), %rsi
	movq	(%r14,%rbp), %rax
	movq	(%rax,%r11), %rdi
	call	mullInternalMatrix
	addq	$8, %r11
	cmpq	$4096, %r11
	jne	.L11
	addq	$8, %rbx
	cmpq	$4096, %rbx
	jne	.L14
	addq	$8, %rbp
	cmpq	$4096, %rbp
	jne	.L10
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE42:
	.size	mullExternalMatrix, .-mullExternalMatrix
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.globl	fillMatrixRandElem
	.type	fillMatrixRandElem, @function
fillMatrixRandElem:
.LFB44:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdi, %r15
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	leaq	4096(%rdi), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
.L18:
	xorl	%ebp, %ebp
.L24:
	movl	$2048, %ebx
	.p2align 4,,10
	.p2align 3
.L22:
	leaq	-2048(%rbx), %r13
	.p2align 4,,10
	.p2align 3
.L19:
	movq	(%r15), %rax
	movq	%r13, %r14
	addq	(%rax,%rbp), %r14
	call	rand
	leal	127(%rax), %edx
	testl	%eax, %eax
	pxor	%xmm0, %xmm0
	cmovs	%edx, %eax
	addq	$4, %r13
	sarl	$7, %eax
	addl	$1, %eax
	cmpq	%r13, %rbx
	cvtsi2ss	%eax, %xmm0
	movss	%xmm0, (%r14)
	jne	.L19
	addq	$2048, %rbx
	cmpq	$1050624, %rbx
	jne	.L22
	addq	$8, %rbp
	cmpq	$4096, %rbp
	jne	.L24
	addq	$8, %r15
	cmpq	%r15, %r12
	jne	.L18
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE44:
	.size	fillMatrixRandElem, .-fillMatrixRandElem
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.p2align 4,,15
	.globl	allocMemMatrix
	.type	allocMemMatrix, @function
allocMemMatrix:
.LFB45:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movl	$512, %esi
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movl	$8, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	call	calloc
	leaq	4096(%rax), %r13
	movq	%rax, %r14
	movq	%rax, %r12
	movq	%rax, %rbx
	.p2align 4,,10
	.p2align 3
.L28:
	movl	$512, %esi
	movl	$8, %edi
	addq	$8, %rbx
	call	calloc
	movq	%rax, -8(%rbx)
	cmpq	%rbx, %r13
	jne	.L28
	.p2align 4,,10
	.p2align 3
.L29:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L30:
	movq	%rbx, %rbp
	addq	(%r12), %rbp
	movl	$262144, %esi
	movl	$4, %edi
	addq	$8, %rbx
	call	calloc
	cmpq	$4096, %rbx
	movq	%rax, 0(%rbp)
	jne	.L30
	addq	$8, %r12
	cmpq	%r12, %r13
	jne	.L29
	popq	%rbx
	.cfi_def_cfa_offset 40
	movq	%r14, %rax
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE45:
	.size	allocMemMatrix, .-allocMemMatrix
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.p2align 4,,15
	.globl	freeMemMatrix
	.type	freeMemMatrix, @function
freeMemMatrix:
.LFB46:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rdi, %r14
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	leaq	4096(%rdi), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %r13
	movq	%rdi, %rbp
	.p2align 4,,10
	.p2align 3
.L36:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L37:
	movq	(%r14), %rax
	movq	(%rax,%rbx), %rdi
	addq	$8, %rbx
	call	free
	cmpq	$4096, %rbx
	jne	.L37
	addq	$8, %r14
	cmpq	%r14, %r12
	jne	.L36
	.p2align 4,,10
	.p2align 3
.L39:
	movq	0(%rbp), %rdi
	addq	$8, %rbp
	call	free
	cmpq	%rbp, %r12
	jne	.L39
	popq	%rbx
	.cfi_def_cfa_offset 40
	movq	%r13, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	free
	.cfi_endproc
.LFE46:
	.size	freeMemMatrix, .-freeMemMatrix
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC6:
	.string	"Elapsed time: %.5f (seconds).\n"
	.section	.text.unlikely
.LCOLDB7:
	.section	.text.startup,"ax",@progbits
.LHOTB7:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB41:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	xorl	%eax, %eax
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	call	allocMemMatrix
	movq	%rax, %rbp
	xorl	%eax, %eax
	call	allocMemMatrix
	movq	%rax, %rbx
	xorl	%eax, %eax
	call	allocMemMatrix
	movq	%rbp, %rdi
	movq	%rax, %r12
	call	fillMatrixRandElem
	movq	%rbx, %rdi
	call	fillMatrixRandElem
#APP
# 88 "/home/howki/workspace/ASP/1lab/src/base.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	salq	$32, %rdx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	orq	%rax, %rdx
	movq	%rdx, %r13
	movq	%r12, %rdx
	call	mullExternalMatrix
#APP
# 88 "/home/howki/workspace/ASP/1lab/src/base.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	salq	$32, %rdx
	orq	%rdx, %rax
	subq	%r13, %rax
	js	.L44
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
.L45:
	mulsd	.LC5(%rip), %xmm0
	movl	$.LC6, %esi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk
	movq	%rbp, %rdi
	call	freeMemMatrix
	movq	%rbx, %rdi
	call	freeMemMatrix
	movq	%r12, %rdi
	call	freeMemMatrix
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L44:
	.cfi_restore_state
	movq	%rax, %rdx
	pxor	%xmm0, %xmm0
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
	jmp	.L45
	.cfi_endproc
.LFE41:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE7:
	.section	.text.startup
.LHOTE7:
	.globl	MAX_RAND_DIV
	.section	.rodata
	.align 4
	.type	MAX_RAND_DIV, @object
	.size	MAX_RAND_DIV, 4
MAX_RAND_DIV:
	.long	128
	.globl	SIZE_INT_MATRIX
	.align 4
	.type	SIZE_INT_MATRIX, @object
	.size	SIZE_INT_MATRIX, 4
SIZE_INT_MATRIX:
	.long	512
	.globl	SIZE_EXT_MATRIX
	.align 4
	.type	SIZE_EXT_MATRIX, @object
	.size	SIZE_EXT_MATRIX, 4
SIZE_EXT_MATRIX:
	.long	512
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC5:
	.long	0
	.long	1040187392
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.6) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
