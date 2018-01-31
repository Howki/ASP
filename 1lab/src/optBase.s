	.file	"base.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.globl	mullExternalMatrix
	.type	mullExternalMatrix, @function
mullExternalMatrix:
.LFB51:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	xorl	%ebx, %ebx
.L2:
	movq	0(%rbp,%rbx), %r13
	movq	(%r12,%rbx), %rdi
	xorl	%r11d, %r11d
.L7:
	movq	0(%r13,%r11), %rdx
	xorl	%r9d, %r9d
	leaq	64(%rdx), %r10
	.p2align 4,,10
	.p2align 3
.L4:
	movq	(%rsi,%r9), %rax
	movq	(%rdi,%r9), %rcx
	movq	(%rax,%r11), %r8
	movq	%rdx, %rax
.L3:
	movss	(%rcx), %xmm1
	addq	$16, %rax
	addq	$16, %rcx
	mulss	(%r8), %xmm1
	movss	-16(%rax), %xmm2
	addss	%xmm1, %xmm2
	movss	%xmm2, -16(%rax)
	movss	16(%r8), %xmm0
	mulss	-12(%rcx), %xmm0
	movaps	%xmm0, %xmm1
	addss	%xmm2, %xmm1
	movss	-12(%rax), %xmm2
	movss	%xmm1, -16(%rax)
	movss	-8(%rcx), %xmm0
	mulss	32(%r8), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -16(%rax)
	movss	-4(%rcx), %xmm1
	mulss	48(%r8), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -16(%rax)
	movss	-16(%rcx), %xmm1
	mulss	4(%r8), %xmm1
	addss	%xmm1, %xmm2
	movss	%xmm2, -12(%rax)
	movss	-12(%rcx), %xmm0
	mulss	20(%r8), %xmm0
	movaps	%xmm0, %xmm1
	addss	%xmm2, %xmm1
	movss	-8(%rax), %xmm2
	movss	%xmm1, -12(%rax)
	movss	-8(%rcx), %xmm0
	mulss	36(%r8), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -12(%rax)
	movss	-4(%rcx), %xmm1
	mulss	52(%r8), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -12(%rax)
	movss	-16(%rcx), %xmm1
	mulss	8(%r8), %xmm1
	addss	%xmm1, %xmm2
	movss	%xmm2, -8(%rax)
	movss	-12(%rcx), %xmm0
	mulss	24(%r8), %xmm0
	movaps	%xmm0, %xmm1
	addss	%xmm2, %xmm1
	movss	%xmm1, -8(%rax)
	movss	-8(%rcx), %xmm0
	mulss	40(%r8), %xmm0
	movss	-4(%rax), %xmm2
	addss	%xmm1, %xmm0
	movss	%xmm0, -8(%rax)
	movss	-4(%rcx), %xmm1
	mulss	56(%r8), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -8(%rax)
	movss	-16(%rcx), %xmm1
	mulss	12(%r8), %xmm1
	addss	%xmm1, %xmm2
	movss	%xmm2, -4(%rax)
	movss	-12(%rcx), %xmm0
	mulss	28(%r8), %xmm0
	addss	%xmm2, %xmm0
	movss	%xmm0, -4(%rax)
	movaps	%xmm0, %xmm1
	movss	-8(%rcx), %xmm0
	mulss	44(%r8), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -4(%rax)
	movss	-4(%rcx), %xmm1
	mulss	60(%r8), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -4(%rax)
	cmpq	%rax, %r10
	jne	.L3
	addq	$8, %r9
	cmpq	$4096, %r9
	jne	.L4
	addq	$8, %r11
	cmpq	$4096, %r11
	jne	.L7
	addq	$8, %rbx
	cmpq	$4096, %rbx
	jne	.L2
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE51:
	.size	mullExternalMatrix, .-mullExternalMatrix
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	mullInternalMatrix
	.type	mullInternalMatrix, @function
mullInternalMatrix:
.LFB52:
	.cfi_startproc
	leaq	64(%rdx), %rax
.L13:
	movss	(%rdi), %xmm1
	addq	$16, %rdx
	addq	$16, %rdi
	mulss	(%rsi), %xmm1
	movss	-16(%rdx), %xmm2
	addss	%xmm1, %xmm2
	movss	%xmm2, -16(%rdx)
	movss	16(%rsi), %xmm0
	mulss	-12(%rdi), %xmm0
	movaps	%xmm0, %xmm1
	addss	%xmm2, %xmm1
	movss	-12(%rdx), %xmm2
	movss	%xmm1, -16(%rdx)
	movss	-8(%rdi), %xmm0
	mulss	32(%rsi), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -16(%rdx)
	movss	-4(%rdi), %xmm1
	mulss	48(%rsi), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -16(%rdx)
	movss	-16(%rdi), %xmm1
	mulss	4(%rsi), %xmm1
	addss	%xmm1, %xmm2
	movss	%xmm2, -12(%rdx)
	movss	-12(%rdi), %xmm0
	mulss	20(%rsi), %xmm0
	movaps	%xmm0, %xmm1
	addss	%xmm2, %xmm1
	movss	-8(%rdx), %xmm2
	movss	%xmm1, -12(%rdx)
	movss	-8(%rdi), %xmm0
	mulss	36(%rsi), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -12(%rdx)
	movss	-4(%rdi), %xmm1
	mulss	52(%rsi), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -12(%rdx)
	movss	-16(%rdi), %xmm1
	mulss	8(%rsi), %xmm1
	addss	%xmm1, %xmm2
	movss	%xmm2, -8(%rdx)
	movss	-12(%rdi), %xmm0
	mulss	24(%rsi), %xmm0
	movaps	%xmm0, %xmm1
	addss	%xmm2, %xmm1
	movss	%xmm1, -8(%rdx)
	movss	-8(%rdi), %xmm0
	mulss	40(%rsi), %xmm0
	movss	-4(%rdx), %xmm2
	addss	%xmm1, %xmm0
	movss	%xmm0, -8(%rdx)
	movss	-4(%rdi), %xmm1
	mulss	56(%rsi), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -8(%rdx)
	movss	-16(%rdi), %xmm1
	mulss	12(%rsi), %xmm1
	addss	%xmm1, %xmm2
	movss	%xmm2, -4(%rdx)
	movss	-12(%rdi), %xmm0
	mulss	28(%rsi), %xmm0
	addss	%xmm2, %xmm0
	movss	%xmm0, -4(%rdx)
	movaps	%xmm0, %xmm1
	movss	-8(%rdi), %xmm0
	mulss	44(%rsi), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -4(%rdx)
	movss	-4(%rdi), %xmm1
	mulss	60(%rsi), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -4(%rdx)
	cmpq	%rdx, %rax
	jne	.L13
	rep ret
	.cfi_endproc
.LFE52:
	.size	mullInternalMatrix, .-mullInternalMatrix
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
.LFB53:
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
.L16:
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L22:
	movl	$16, %ebx
.L20:
	leaq	-16(%rbx), %r13
.L17:
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
	jne	.L17
	addq	$16, %rbx
	cmpq	$80, %rbx
	jne	.L20
	addq	$8, %rbp
	cmpq	$4096, %rbp
	jne	.L22
	addq	$8, %r15
	cmpq	%r15, %r12
	jne	.L16
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
.LFE53:
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
.LFB54:
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
.L26:
	movl	$512, %esi
	movl	$8, %edi
	addq	$8, %rbx
	call	calloc
	movq	%rax, -8(%rbx)
	cmpq	%rbx, %r13
	jne	.L26
	.p2align 4,,10
	.p2align 3
.L27:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L28:
	movq	%rbx, %rbp
	addq	(%r12), %rbp
	movl	$16, %esi
	movl	$4, %edi
	addq	$8, %rbx
	call	calloc
	cmpq	$4096, %rbx
	movq	%rax, 0(%rbp)
	jne	.L28
	addq	$8, %r12
	cmpq	%r12, %r13
	jne	.L27
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
.LFE54:
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
.LFB55:
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
.L34:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L35:
	movq	(%r14), %rax
	movq	(%rax,%rbx), %rdi
	addq	$8, %rbx
	call	free
	cmpq	$4096, %rbx
	jne	.L35
	addq	$8, %r14
	cmpq	%r14, %r12
	jne	.L34
	.p2align 4,,10
	.p2align 3
.L37:
	movq	0(%rbp), %rdi
	addq	$8, %rbp
	call	free
	cmpq	%rbp, %r12
	jne	.L37
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
.LFE55:
	.size	freeMemMatrix, .-freeMemMatrix
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.text.unlikely
.LCOLDB5:
	.section	.text.startup,"ax",@progbits
.LHOTB5:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB50:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	xorl	%eax, %eax
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
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
# 86 "/home/howki/workspace/ASP/1lab/src/base.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	movq	%r12, %rdx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	mullExternalMatrix
	movq	%rbp, %rdi
	call	freeMemMatrix
	movq	%rbx, %rdi
	call	freeMemMatrix
	movq	%r12, %rdi
	call	freeMemMatrix
	popq	%rbx
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE50:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE5:
	.section	.text.startup
.LHOTE5:
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
	.long	4
	.globl	SIZE_EXT_MATRIX
	.align 4
	.type	SIZE_EXT_MATRIX, @object
	.size	SIZE_EXT_MATRIX, 4
SIZE_EXT_MATRIX:
	.long	512
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.6) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
