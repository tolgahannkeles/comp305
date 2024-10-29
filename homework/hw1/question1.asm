.data
input_message:     .string "Enter positive odd number: "
invalid:    .string "Invalid Input. Enter positive odd number!\n"
newline:    .string "\n"
space:      .string " "
star:       .string "*"


# a0 - input-output register
# a7 - systam call register
# t0 - input variable

.text
.globl main
main:
    # Printing input message
    la a0, input_message
    li a7, 4
    ecall

    # Reading input
    li a7, 5
    ecall
    add t0, a0, zero  # Storing the given input in t0 to check availability

    # Checking whether the number is positive or not
    blt t0, zero, invalid_input  # If t0 < 0, jump to invalid_input
    # Checking whether the number is odd or not
    andi t1, t0, 1          # Odd values have to have 1 at the end. To check it, we use and operation with 1. If 
    beq t1,zero, invalid_input  # If even (t1 == 0), jump to invalid_input

#--------------------------------------------------------------------
    # Calculating # of half of lines
    addi t2, t0, 1
    srai t2, t2, 1 # (t0+1)/2
    
    # Printing upper part of diamond
    li t3, 0                # index of loop
upper_loop:
    bge t3, t2, lower_part  # loop exit condition: t3 >= t2(# of half of lines) 

    # Print left spaces: t2-i-1
    sub t4, t2, t3
    addi t4, t4, -1
space_loop:
    blez t4, end_space
    la a0, space
    li a7, 4
    ecall
    addi t4, t4, -1
    j space_loop
end_space:
    # Print first star
    la a0, star
    li a7, 4
    ecall

    # inner space
    slli t5, t3, 1
    addi t5, t5, -1         # t5,j = 2 * i - 1 # of inner space
inner_space_loop:
    blez t5, end_inner      # Exit condition of inner spaces
    # printing spaces
    la a0, space
    li a7, 4
    ecall
    # j--
    addi t5, t5, -1
    j inner_space_loop
end_inner:
    # if i>0 print star, not no star
    beq t3,zero, no_second_star
    la a0, star
    li a7, 4
    ecall
no_second_star:
    # it will work if i=0 or n-1 and after the end of each line and prints new line
    la a0, newline
    li a7, 4
    ecall

    addi t3, t3, 1          # i++
    j upper_loop

# Printing lower part of the diamond
lower_part:
    addi t3, t2, -2         # i = (n-1)/2 - 1 for i=#ofhalf-2 to 0
lower_loop:
    blt t3,zero, exit           # Exit condition: i < 0

    # Print spaces
    sub t4, t2, t3
    addi t4, t4, -1         # t4 = #ofhalf-2 - i
space_loop_lower:
    ble t4,zero end_space_lower
    #printing spaces
    la a0, space
    li a7, 4
    ecall
    addi t4, t4, -1
    j space_loop_lower
end_space_lower:
    # Print first star
    la a0, star
    li a7, 4
    ecall

    # Printinf inner spaces
    slli t5, t3, 1
    addi t5, t5, -1         # t5 = 2 * line - 1
inner_space_loop_lower:
    ble t5,zero , end_inner_lower     # Exit inner space loop if 2*line-1>=0
    #printing spaces
    la a0, space
    li a7, 4
    ecall
    addi t5, t5, -1
    j inner_space_loop_lower
end_inner_lower:
    # Printing second star if i > 0
    beqz t3, no_second_star_lower
    la a0, star
    li a7, 4
    ecall
no_second_star_lower:
    # go to new line
    la a0, newline
    li a7, 4
    ecall
    addi t3, t3, -1         # i--
    j lower_loop
#exit
exit:
    li a7, 10
    ecall

invalid_input:
    #printing invalid input message
    la a0, invalid
    li a7, 4
    ecall
    j main
