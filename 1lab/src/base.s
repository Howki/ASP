	.file	"base.c"
	.globl	SIZE_EXT_MATRIX
	.section	.rodata
	.align 4
	.type	SIZE_EXT_MATRIX, @object
	.size	SIZE_EXT_MATRIX, 4
SIZE_EXT_MATRIX:
	.long	512
	.globl	SIZE_INT_MATRIX
	.align 4
	.type	SIZE_INT_MATRIX, @object
	.size	SIZE_INT_MATRIX, 4
SIZE_INT_MATRIX:
	.long	4
	.globl	MAX_RAND_DIV
	.align 4
	.type	MAX_RAND_DIV, @object
	.size	MAX_RAND_DIV, 4
MAX_RAND_DIV:
	.long	128
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	movl	$0, %eax
	call	allocMemMatrix
	movq	%rax, -32(%rbp)
	movl	$0, %eax
	call	allocMemMatrix
	movq	%rax, -24(%rbp)
	movl	$0, %eax
	call	allocMemMatrix
	movq	%rax, -16(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	fillMatrixRandElem
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	fillMatrixRandElem
	call	rdtsc
	movq	%rax, -8(%rbp)
	movq	-16(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	mullExternalMatrix
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	freeMemMatrix
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	freeMemMatrix
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	freeMemMatrix
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.globl	mullExternalMatrix
	.type	mullExternalMatrix, @function
mullExternalMatrix:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L4
.L9:
	movl	$0, -8(%rbp)
	jmp	.L5
.L8:
	movl	$0, -4(%rbp)
	jmp	.L6
.L7:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movl	-8(%rbp), %ecx
	movslq	%ecx, %rcx
	salq	$3, %rcx
	addq	%rcx, %rax
	movq	(%rax), %rcx
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rsi
	movq	-24(%rbp), %rax
	addq	%rsi, %rax
	movq	(%rax), %rax
	movl	-4(%rbp), %esi
	movslq	%esi, %rsi
	salq	$3, %rsi
	addq	%rsi, %rax
	movq	(%rax), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	mullInternalMatrix
	addl	$1, -4(%rbp)
.L6:
	movl	$512, %eax
	cmpl	%eax, -4(%rbp)
	jl	.L7
	addl	$1, -8(%rbp)
.L5:
	movl	$512, %eax
	cmpl	%eax, -8(%rbp)
	jl	.L8
	addl	$1, -12(%rbp)
.L4:
	movl	$512, %eax
	cmpl	%eax, -12(%rbp)
	jl	.L9
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	mullExternalMatrix, .-mullExternalMatrix
	.globl	mullInternalMatrix
	.type	mullInternalMatrix, @function
mullInternalMatrix:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L11
.L16:
	movl	$0, -8(%rbp)
	jmp	.L12
.L15:
	movl	$0, -4(%rbp)
	jmp	.L13
.L14:
	movl	$4, %eax
	imull	-12(%rbp), %eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movl	$4, %edx
	movl	%edx, %ecx
	imull	-12(%rbp), %ecx
	movl	-8(%rbp), %edx
	addl	%ecx, %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-40(%rbp), %rdx
	addq	%rcx, %rdx
	movss	(%rdx), %xmm1
	movl	$4, %edx
	movl	%edx, %ecx
	imull	-12(%rbp), %ecx
	movl	-4(%rbp), %edx
	addl	%ecx, %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	movss	(%rdx), %xmm2
	movl	$4, %edx
	movl	%edx, %ecx
	imull	-4(%rbp), %ecx
	movl	-8(%rbp), %edx
	addl	%ecx, %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-32(%rbp), %rdx
	addq	%rcx, %rdx
	movss	(%rdx), %xmm0
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, (%rax)
	addl	$1, -4(%rbp)
.L13:
	movl	$4, %eax
	cmpl	%eax, -4(%rbp)
	jl	.L14
	addl	$1, -8(%rbp)
.L12:
	movl	$4, %eax
	cmpl	%eax, -8(%rbp)
	jl	.L15
	addl	$1, -12(%rbp)
.L11:
	movl	$4, %eax
	cmpl	%eax, -12(%rbp)
	jl	.L16
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	mullInternalMatrix, .-mullInternalMatrix
	.globl	fillMatrixRandElem
	.type	fillMatrixRandElem, @function
fillMatrixRandElem:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movl	$0, -32(%rbp)
	jmp	.L18
.L25:
	movl	$0, -28(%rbp)
	jmp	.L19
.L24:
	movl	$0, -24(%rbp)
	jmp	.L20
.L23:
	movl	$0, -20(%rbp)
	jmp	.L21
.L22:
	movl	-32(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	$4, %edx
	movl	%edx, %ecx
	imull	-24(%rbp), %ecx
	movl	-20(%rbp), %edx
	addl	%ecx, %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	leaq	(%rax,%rdx), %rbx
	call	rand
	movl	$128, %esi
	cltd
	idivl	%esi
	addl	$1, %eax
	pxor	%xmm0, %xmm0
	cvtsi2ss	%eax, %xmm0
	movss	%xmm0, (%rbx)
	addl	$1, -20(%rbp)
.L21:
	movl	$4, %eax
	cmpl	%eax, -20(%rbp)
	jl	.L22
	addl	$1, -24(%rbp)
.L20:
	movl	$4, %eax
	cmpl	%eax, -24(%rbp)
	jl	.L23
	addl	$1, -28(%rbp)
.L19:
	movl	$512, %eax
	cmpl	%eax, -28(%rbp)
	jl	.L24
	addl	$1, -32(%rbp)
.L18:
	movl	$512, %eax
	cmpl	%eax, -32(%rbp)
	jl	.L25
	nop
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	fillMatrixRandElem, .-fillMatrixRandElem
	.globl	allocMemMatrix
	.type	allocMemMatrix, @function
allocMemMatrix:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movl	$512, %eax
	cltq
	movq	%rax, %rsi
	movl	$8, %edi
	call	calloc
	movq	%rax, -24(%rbp)
	movl	$0, -36(%rbp)
	jmp	.L27
.L28:
	movl	-36(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	movl	$512, %eax
	cltq
	movq	%rax, %rsi
	movl	$8, %edi
	call	calloc
	movq	%rax, (%rbx)
	addl	$1, -36(%rbp)
.L27:
	movl	$512, %eax
	cmpl	%eax, -36(%rbp)
	jl	.L28
	movl	$0, -32(%rbp)
	jmp	.L29
.L32:
	movl	$0, -28(%rbp)
	jmp	.L30
.L31:
	movl	-32(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	leaq	(%rax,%rdx), %rbx
	movl	$4, %edx
	movl	$4, %eax
	imull	%edx, %eax
	cltq
	movq	%rax, %rsi
	movl	$4, %edi
	call	calloc
	movq	%rax, (%rbx)
	addl	$1, -28(%rbp)
.L30:
	movl	$512, %eax
	cmpl	%eax, -28(%rbp)
	jl	.L31
	addl	$1, -32(%rbp)
.L29:
	movl	$512, %eax
	cmpl	%eax, -32(%rbp)
	jl	.L32
	movq	-24(%rbp), %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	allocMemMatrix, .-allocMemMatrix
	.globl	freeMemMatrix
	.type	freeMemMatrix, @function
freeMemMatrix:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L35
.L38:
	movl	$0, -8(%rbp)
	jmp	.L36
.L37:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free
	addl	$1, -8(%rbp)
.L36:
	movl	$512, %eax
	cmpl	%eax, -8(%rbp)
	jl	.L37
	addl	$1, -12(%rbp)
.L35:
	movl	$512, %eax
	cmpl	%eax, -12(%rbp)
	jl	.L38
	movl	$0, -4(%rbp)
	jmp	.L39
.L40:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free
	addl	$1, -4(%rbp)
.L39:
	movl	$512, %eax
	cmpl	%eax, -4(%rbp)
	jl	.L40
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	freeMemMatrix, .-freeMemMatrix
	.type	rdtsc, @function
rdtsc:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
#APP
# 86 "/home/howki/workspace/ASP/1lab/src/base.c" 1
	rdtsc
# 0 "" 2
#NO_APP
	movq	%rax, -16(%rbp)
	movq	%rdx, -8(%rbp)
	movq	-8(%rbp), %rax
	salq	$32, %rax
	orq	-16(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	rdtsc, .-rdtsc
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.6) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
