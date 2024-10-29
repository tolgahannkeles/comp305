.data
input_size_message:   .asciz "Give the length of array: "
input_element_message: .asciz "Enter element: "
invalid_array_size: .asciz "Invalid input. Give a positive integer.\n"
sorted_msg_prefix:    .asciz "Sorted array: "
divider:         .asciz " " 

.align 2                 # align data in memory (2^2=4 bytes)
array:   .space 100      # allocate 100 bytes space for the array

.text
.globl main

# t1 - address of array
# t0 - length of array

main:
    # print input size message
    li a7, 4                  
    la a0, input_size_message
    ecall

    # take input for array size
    li a7, 5
    ecall
    addi t0, a0, 0

check_size:
    bgt t0,zero, get_inputs    # if size>0, take elements
    # Print invalid input message
    li a7, 4
    la a0, invalid_array_size
    ecall
    j main

get_inputs:
    # take inputs from user
    la t1, array
    li t2, 0                  # i=0

input_loop: # for i=0 to n-1
    #print get element prefix
    li a7, 4
    la a0, input_element_message
    ecall

get_input:
    # read element
    li a7, 5      
    ecall
    sw a0, 0(t1) # store the element to memory
    addi t1, t1, 4            # forward the array address by 1(4 bytes)
    addi t2, t2, 1            # i++
    blt t2, t0, input_loop    # i<n
    j bubble_sort


bubble_sort:
    la t3, array              # load the memory address of array
    addi t4, t0, -1           # for i=n-1 to 0
    
outer_loop:
    beq t4,zero, print_array      # if i==0, then print it

    # for j=n-1 to 0
    addi t5, t4, 0           
    la t6, array              # load start address of array to t6

inner_loop:
    lw a1, 0(t6)              # get a j
    lw a2, 4(t6)              # get a j+1
    bge a1, a2, no_swap       # if a1> a2, then do not swap

    # swap them
    sw a2, 0(t6)              
    sw a1, 4(t6)              

no_swap:
    addi t6, t6, 4            # address +=4
    addi t5, t5, -1           # j--
    bnez t5, inner_loop       # go again to inner loop

    addi t4, t4, -1           # i--
    j outer_loop       # go again to outer loop

print_array:
    # printing sorted array prefix
    li a7, 4
    la a0, sorted_msg_prefix
    ecall

    # initialize the loop
    la t1, array              # loading memory address of start of array
    li t2, 0                  # i=0

print_loop: # for i=0 to n
    # print the element
    lw a0, 0(t1)              # load element to a0
    li a7, 1           
    ecall

    # printing divider after each element
    li a7, 4
    la a0, divider
    ecall

    addi t1, t1, 4            # the next word which is the next element of array
    addi t2, t2, 1            # i++
    blt t2, t0, print_loop    # until i<n, do it

    # exiting program
exit:
    li a7, 10
    ecall
