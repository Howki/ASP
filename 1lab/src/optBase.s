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
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	16(%rdx), %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	leaq	64(%rdx), %r14
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	leaq	64(%rsi), %r12
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%r13, %r11
.L2:
	movq	%rsi, %rax
	movq	%rdi, %r8
	movq	%rdi, %rcx
.L10:
	movq	%rax, %r9
	addq	$16, %rax
	leaq	4(%rcx), %r10
	cmpq	%rax, %rdx
	setnb	%bpl
	cmpq	%r11, %r9
	setnb	%bl
	orb	%bl, %bpl
	je	.L11
	cmpq	%rcx, %r11
	setbe	%bl
	cmpq	%r10, %rdx
	setnb	%cl
	orb	%cl, %bl
	je	.L11
	movss	(%r8), %xmm0
	shufps	$0, %xmm0, %xmm0
	movups	(%r9), %xmm1
	mulps	%xmm1, %xmm0
	movups	(%rdx), %xmm1
	addps	%xmm1, %xmm0
	movups	%xmm0, (%rdx)
.L4:
	addq	$4, %r8
	cmpq	%r12, %rax
	movq	%r10, %rcx
	jne	.L10
	addq	$16, %rdi
	addq	$16, %r11
	cmpq	%r13, %r14
	movq	%r13, %rdx
	je	.L1
	addq	$16, %r13
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L11:
	xorl	%ecx, %ecx
.L3:
	movss	(%r8), %xmm0
	mulss	(%r9,%rcx), %xmm0
	addss	(%rdx,%rcx), %xmm0
	movss	%xmm0, (%rdx,%rcx)
	addq	$4, %rcx
	cmpq	$16, %rcx
	jne	.L3
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L1:
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
	movq	%rsi, %r14
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdx, %r13
	xorl	%r12d, %r12d
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
.L19:
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L23:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L20:
	movq	0(%r13,%r12), %rax
	movq	(%rax,%rbp), %rdx
	movq	(%r14,%rbx), %rax
	movq	(%rax,%rbp), %rsi
	movq	(%r15,%r12), %rax
	movq	(%rax,%rbx), %rdi
	addq	$8, %rbx
	call	mullInternalMatrix
	cmpq	$4096, %rbx
	jne	.L20
	addq	$8, %rbp
	cmpq	$4096, %rbp
	jne	.L23
	addq	$8, %r12
	cmpq	$4096, %r12
	jne	.L19
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
.L27:
	xorl	%ebp, %ebp
	.p2align 4,,10
	.p2align 3
.L33:
	movl	$16, %ebx
.L31:
	leaq	-16(%rbx), %r13
.L28:
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
	jne	.L28
	addq	$16, %rbx
	cmpq	$80, %rbx
	jne	.L31
	addq	$8, %rbp
	cmpq	$4096, %rbp
	jne	.L33
	addq	$8, %r15
	cmpq	%r15, %r12
	jne	.L27
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
.L37:
	movl	$512, %esi
	movl	$8, %edi
	addq	$8, %rbx
	call	calloc
	movq	%rax, -8(%rbx)
	cmpq	%rbx, %r13
	jne	.L37
	.p2align 4,,10
	.p2align 3
.L38:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L39:
	movq	%rbx, %rbp
	addq	(%r12), %rbp
	movl	$16, %esi
	movl	$4, %edi
	addq	$8, %rbx
	call	calloc
	cmpq	$4096, %rbx
	movq	%rax, 0(%rbp)
	jne	.L39
	addq	$8, %r12
	cmpq	%r12, %r13
	jne	.L38
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
.L45:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L46:
	movq	(%r14), %rax
	movq	(%rax,%rbx), %rdi
	addq	$8, %rbx
	call	free
	cmpq	$4096, %rbx
	jne	.L46
	addq	$8, %r14
	cmpq	%r14, %r12
	jne	.L45
	.p2align 4,,10
	.p2align 3
.L48:
	movq	0(%rbp), %rdi
	addq	$8, %rbp
	call	free
	cmpq	%rbp, %r12
	jne	.L48
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
# 86 "/home/howki/workspace/ASP/1lab/src/base.c" 1
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
# 86 "/home/howki/workspace/ASP/1lab/src/base.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	salq	$32, %rdx
	orq	%rdx, %rax
	subq	%r13, %rax
	js	.L53
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
.L54:
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
.L53:
	.cfi_restore_state
	movq	%rax, %rdx
	pxor	%xmm0, %xmm0
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
	jmp	.L54
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
	.long	4
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
