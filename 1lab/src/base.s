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
	.long	512
	.globl	MAX_RAND_DIV
	.align 4
	.type	MAX_RAND_DIV, @object
	.size	MAX_RAND_DIV, 4
MAX_RAND_DIV:
	.long	128
	.align 8
.LC1:
	.string	"Elapsed time: %.5f (seconds).\n"
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
	call	rdtsc
	subq	-8(%rbp), %rax
	testq	%rax, %rax
	js	.L2
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	jmp	.L3
.L2:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L3:
	movsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movl	$.LC1, %edi
	movl	$1, %eax
	call	printf
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
	jmp	.L6
.L11:
	movl	$0, -8(%rbp)
	jmp	.L7
.L10:
	movl	$0, -4(%rbp)
	jmp	.L8
.L9:
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
.L8:
	movl	$512, %eax
	cmpl	%eax, -4(%rbp)
	jl	.L9
	addl	$1, -8(%rbp)
.L7:
	movl	$512, %eax
	cmpl	%eax, -8(%rbp)
	jl	.L10
	addl	$1, -12(%rbp)
.L6:
	movl	$512, %eax
	cmpl	%eax, -12(%rbp)
	jl	.L11
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
	movl	$0, -16(%rbp)
	jmp	.L13
.L18:
	movl	$0, -12(%rbp)
	jmp	.L14
.L17:
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L15
.L16:
	movl	$512, %eax
	imull	-16(%rbp), %eax
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movl	$512, %edx
	movl	%edx, %ecx
	imull	-16(%rbp), %ecx
	movl	-8(%rbp), %edx
	addl	%ecx, %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-40(%rbp), %rdx
	addq	%rcx, %rdx
	movss	(%rdx), %xmm1
	movl	$512, %edx
	movl	%edx, %ecx
	imull	-16(%rbp), %ecx
	movl	-4(%rbp), %edx
	addl	%ecx, %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,4), %rcx
	movq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	movss	(%rdx), %xmm2
	movl	$512, %edx
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
	addl	$1, -8(%rbp)
.L15:
	movl	$512, %eax
	cmpl	%eax, -8(%rbp)
	jl	.L16
	addl	$1, -12(%rbp)
.L14:
	movl	$512, %eax
	cmpl	%eax, -12(%rbp)
	jl	.L17
	addl	$1, -16(%rbp)
.L13:
	movl	$512, %eax
	cmpl	%eax, -16(%rbp)
	jl	.L18
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
	jmp	.L20
.L27:
	movl	$0, -28(%rbp)
	jmp	.L21
.L26:
	movl	$0, -24(%rbp)
	jmp	.L22
.L25:
	movl	$0, -20(%rbp)
	jmp	.L23
.L24:
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
	movl	$512, %edx
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
.L23:
	movl	$512, %eax
	cmpl	%eax, -20(%rbp)
	jl	.L24
	addl	$1, -24(%rbp)
.L22:
	movl	$512, %eax
	cmpl	%eax, -24(%rbp)
	jl	.L25
	addl	$1, -28(%rbp)
.L21:
	movl	$512, %eax
	cmpl	%eax, -28(%rbp)
	jl	.L26
	addl	$1, -32(%rbp)
.L20:
	movl	$512, %eax
	cmpl	%eax, -32(%rbp)
	jl	.L27
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
	jmp	.L29
.L30:
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
.L29:
	movl	$512, %eax
	cmpl	%eax, -36(%rbp)
	jl	.L30
	movl	$0, -32(%rbp)
	jmp	.L31
.L34:
	movl	$0, -28(%rbp)
	jmp	.L32
.L33:
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
	movl	$512, %edx
	movl	$512, %eax
	imull	%edx, %eax
	cltq
	movq	%rax, %rsi
	movl	$4, %edi
	call	calloc
	movq	%rax, (%rbx)
	addl	$1, -28(%rbp)
.L32:
	movl	$512, %eax
	cmpl	%eax, -28(%rbp)
	jl	.L33
	addl	$1, -32(%rbp)
.L31:
	movl	$512, %eax
	cmpl	%eax, -32(%rbp)
	jl	.L34
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
	jmp	.L37
.L40:
	movl	$0, -8(%rbp)
	jmp	.L38
.L39:
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
.L38:
	movl	$512, %eax
	cmpl	%eax, -8(%rbp)
	jl	.L39
	addl	$1, -12(%rbp)
.L37:
	movl	$512, %eax
	cmpl	%eax, -12(%rbp)
	jl	.L40
	movl	$0, -4(%rbp)
	jmp	.L41
.L42:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	free
	addl	$1, -4(%rbp)
.L41:
	movl	$512, %eax
	cmpl	%eax, -4(%rbp)
	jl	.L42
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
# 88 "/home/howki/workspace/ASP/1lab/src/base.c" 1
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
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1105199104
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.6) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
