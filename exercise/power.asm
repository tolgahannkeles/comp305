main:
	li a0, 5
	add t1, a0, zero
	li t0, 1
	addi a0, a0,-1
	jal fibonacci
	
	mv t2, a0
	
	addi a0, a0,-1
	jal fibonacci
	mv t3, a0
	
	add a0, t2,t3
	
	li a7,1
	ecall
	li a7, 10
	ecall
	
fibonacci:
	ble a0, t0, base
	
	sw a0, 0(sp)
	sw ra, 4(sp)
	addi sp, sp, -8
	addi, a0, a0,-1
	jal fibonacci
	addi, sp, sp, 8
	lw t0, 0(sp)
	lw ra, 4(sp)
	
	add a0, t0, a0

	ret
	
	
	

base:
	li a0, 1
	ret