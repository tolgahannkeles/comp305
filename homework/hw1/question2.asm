.data
input_message: .asciz "Give the input for f(n): "
new_line: .asciz "\n"
result_text: .asciz "Result: "
.text
.globl main

# t0 - given input

main:
    # pinting input message
    la a0, input_message
    li a7, 4
    ecall

    # taking input from user and storing it in t0
    li a7, 5
    ecall
    addi t0, a0, 0

    # Call the recursive function f(n)
    jal ra, recursive

    # Print the prefix of result
    la a0, result_text    
    li a7, 4              
    ecall
    
    add a0, t1, zero      # Loading the result to a0
    li a7, 1              # print integer
    ecall

    # Exit program
    li a7, 10             # Exit call
    ecall

recursive:
    # base case -> if x <= 1, return 5
    addi t2, zero, 1
    ble t0, t2, base_case

    # Recursive case: 2*f(x-1) + x*x
    
    #allocating 8 byte space from stack
    addi sp, sp, -8
    sw t0, 4(sp)          # load t0 on stack
    sw ra, 0(sp)          # save return address

    addi t0, t0, -1
    jal ra, recursive     # go to f(x-1)

    lw t0, 4(sp)         
    lw ra, 0(sp)
    addi sp, sp, 8 #give the allocated space back

    # calculating recursive formula
    add t1, t1, t1        # t1 = 2 * f(x-1)

    mul t2, t0, t0        # t2 = x * x
    add t1, t1, t2        # t1 = 2*f(x-1) + x*x

    jr ra                 # Return the address back

base_case:
    li t1, 5              # return 5
    jr ra
