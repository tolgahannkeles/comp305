# Recursive Fibonacci function in RISC-V assembly
# This function calculates the Fibonacci number for a given n.
# Assume n is passed in register a0.
# The result will be returned in register a0.

    .data
prompt: .asciiz "Enter a number: "

    .text
    .globl main

main:
    # Print prompt
    li a7, 4                  # syscall for print_string
    la a0, prompt
    ecall

    # Read integer input (n)
    li a7, 5                  # syscall for read_int
    ecall

    # Call fibonacci function
    mv a1, a0                 # move input n to a1 for the function call
    jal ra, fibonacci         # jump and link to fibonacci

    # Print result
    mv a0, a0                 # the result is already in a0
    li a7, 1                  # syscall for print_int
    ecall

    # Exit program
    li a7, 10                 # syscall for exit
    ecall

fibonacci:
    # Base cases: if n <= 1, return n
    li t0, 1                  # load immediate 1 into t0
    ble a1, t0, base_case     # if n <= 1, go to base_case

    # Recursive case
    addi sp, sp, -16          # allocate stack space
    sw ra, 12(sp)             # save return address
    sw a1, 8(sp)              # save n for later use

    # First recursive call: n-1
    addi a1, a1, -1           # n = n - 1
    jal ra, fibonacci         # fibonacci(n-1)
    mv t1, a0                 # save result of fibonacci(n-1) in t1

    # Second recursive call: n-2
    lw a1, 8(sp)              # restore original n
    addi a1, a1, -2           # n = n - 2
    jal ra, fibonacci         # fibonacci(n-2)
    add a0, a0, t1            # result = fibonacci(n-1) + fibonacci(n-2)

    # Restore stack and return
    lw ra, 12(sp)             # restore return address
    addi sp, sp, 16           # deallocate stack space
    jr ra                     # return

base_case:
    mv a0, a1                 # if n <= 1, return n in a0
    jr ra                     # return
