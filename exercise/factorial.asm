main:
	li a0, 5
	jal factorial
	li a7,1
	ecall
	li a7, 10
	ecall
	

factorial:
	beqz a0, base

	sw a0, 0(sp)
	sw ra, 4(sp)
	addi sp, sp, -8
	addi a0, a0, -1
	
	jal factorial
	
	addi sp, sp, 8
	lw t0, 0(sp)
	lw ra, 4(sp)
	mul a0,t0,a0
	ret

base:
	li a0, 1
	ret