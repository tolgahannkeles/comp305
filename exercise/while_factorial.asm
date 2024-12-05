# mul=1 a2
# i=5 a1
# while(i=0)
#	mul*=i
#	i--

li a1, 20
li a2, 1

while:
	beq a1, zero, end_while
	mul a2, a2, a1
	addi a1, a1, -1
	j while
end_while: