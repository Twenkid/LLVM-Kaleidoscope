	.text
	.file	"f.ll"
	.globl	fibonacci                       # -- Begin function fibonacci
	.p2align	4, 0x90
	.type	fibonacci,@function
fibonacci:                              # @fibonacci
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %rbp, -16
	testl	%edi, %edi
	je	.LBB0_1
# %bb.3:                                # %cont
	movl	%edi, %ebx
	cmpl	$1, %edi
	jne	.LBB0_5
# %bb.4:                                # %ret1
	movl	$1, %eax
	jmp	.LBB0_2
.LBB0_1:                                # %ret0
	xorl	%eax, %eax
	jmp	.LBB0_2
.LBB0_5:                                # %recurse
	leal	-1(%rbx), %edi
	addl	$-2, %ebx
	callq	fibonacci@PLT
	movl	%eax, %ebp
	movl	%ebx, %edi
	callq	fibonacci@PLT
	addl	%ebp, %eax
.LBB0_2:                                # %ret0
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	fibonacci, .Lfunc_end0-fibonacci
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$33, %edi
	callq	fibonacci@PLT
	movl	$.L.str, %edi
	movl	%eax, %esi
	xorl	%eax, %eax
	callq	printf@PLT
	movl	$5, %edi
	callq	fibonacci@PLT
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d\n"
	.size	.L.str, 4

	.section	".note.GNU-stack","",@progbits
