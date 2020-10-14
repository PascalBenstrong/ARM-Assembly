.data
print_f: .asciz "fibonacci of %d is %d\n"

.text
fact:

    @we will use r0, for the input
    @ push r1 to r3 to the and lr
    @ lr will be storing the address to return to
    push {r1-r3,lr}

    @ check that the input is greater than 1
    cmp r0, #1
    ble fib_base @the base case
    
    mov r1, r0
    sub r0, r0, #1 @input to the first branch, n-1
    bl fact @output is in r0, first branch

    mov r2, r0 @save the output in r2
    sub r0, r1, #2 @input to the second branch, n-2
    bl fact @output is in r0, second branch

    add r0, r2, r0 @add the two outputs 

    @ pop r1 to r3 to the and lr
    pop {r1-r3,lr}
    bx lr @exit the fuction return the output in r0

    

fib_base:

    @ pop r0 to r3 to the and lr
    pop {r1-r3,lr}

    bx lr


.global main
main:
    mov r0, #15
    bl fact

    mov r2, r0 @fib of 15

    mov r1, #15 @first input to the format string

    ldr r0, =print_f @string format refence, used as the first input to printf
    bl printf

    mov r0, #30
    bl fact

    mov r2, r0 @fib of 30

    mov r1, #30 @first input to the format string

    ldr r0, =print_f @string format refence, used as the first input to printf
    bl printf

    mov r7, #1
    swi 0
