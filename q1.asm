.data
.align 2
print_format_a:
	.asciz "a: %d\n"

print_format_b:
	.asciz "b: %d\n"

print_format_c:
	.asciz "c: %d\n"

print_format_d:
	.asciz "d: %d\n"

.align 2
x: .word 10

.align 2
y: .word 5

z: .word 2

.balign 2
result: .word 0
	
.text
.global main

a:
	ldr r1, =x

	@ 5 * 10 * 10
	mov r2, #5
	ldr r1, [r1] @ load the value of x from address
	mul r0, r1, r2
	mul r0, r1, r0

	@ 5 * 10 * 10 + 3 * 10
	mov r2, #3
	mla r0, r2, r1, r0
	add r0, r0, r1

	ldr r2, =result @result address
	str r0, [r2] @store value in r0 into result
	ldr r1, [r2] @ load result into r1

	ldr r0,=print_format_a @load print format address into memory

	bx lr

b:
	ldr r1, =x
	ldr r1, [r1] @ load the value of x from address
	ldr r2, =y
	ldr r2, [r2] @ load the value of x from address

	@ 2 * x * x

	mul r0, r1, r1
	mov r0, r0, lsl #1 @ multiply by 2, using shift operation

	ldr r3, =result @result address
	str r0, [r3] @store value in r0 into result

	@ 7 * x * y

	mov r3, #7
	mul r3, r1, r3
	mla r0, r2, r3, r0

	@ 5 * y * y - 7
	mul r1, r2, r2
	mov r2, #5
	mla r0, r2, r1, r0
	sub r0, r0, #7

	ldr r2, =result @result address
	str r0, [r2] @store value in r0 into result
	ldr r1, [r2] @ load result into r1

	ldr r0, =print_format_b

	bx lr

c:
	ldr r1, =x
	ldr r1, [r1] @ load the value of x from address

	@ x * x * x

	mul r2, r1, r1
	mul r0, r1, r2
	
	@ -2 x * x
	mov r2, r2, lsl #1 @ multiply by 2, using shift operation
	sub r0, r0, r2

	ldr r3, =result @result address
	str r0, [r3] @store value in r0 into result

	@ 2 * x + 5

	mov r1, r1, lsl #1 @ multiply by 2, using shift operation
	add r0, r1, r0
	add r0, r0, #5


	ldr r2, =result @result address
	str r0, [r2] @store value in r0 into result
	ldr r1, [r2] @ load result into r1

	ldr r0, =print_format_c

	bx lr

d:
	ldr r1, =x
	ldr r1, [r1] @ load the value of x from address

	@ 2 * x * x * x * x

	mul r2, r1, r1
	mul r0, r2, r2
	mov r0, r0, lsl #1 @ multiply by 2, using shift operation
	

	@ -6 * x

	add r2, r1, r1 @ 2 * x
	add r1, r1, r2 @ 3 * x
	
	sub r0, r0, r1, lsl #1 @ multiply by 2, using shift operation

	@ -5 * y * y * y * z
	ldr r1, =y
	ldr r1, [r1] @ load the value of y from address

	mul r2, r1, r1 @ y * y
	mul r1, r2, r1 @ y * y * y
	mov r2, r1, lsl #2 @ multiply by 4, using shift operation
	add r1, r2, r1

	ldr r2, =z
	ldr r2, [r2] @ load the value of z from address
	mul r1, r2, r1

	sub r0, r0, r1

	@ + 10

	add r0, r0, #10

	ldr r3, =result @result address
	str r0, [r3] @store value in r0 into result


	ldr r2, =result @result address
	str r0, [r2] @store value in r0 into result
	ldr r1, [r2] @ load result into r1

	ldr r0, =print_format_d

	bx lr

main:
	ldr r2, =y
	ldr r3, =z

	bl a
	@print values from register using print_format string
	bl printf

	bl b
	@print values from register using print_format string
	bl printf

	bl c
	@print values from register using print_format string
	bl printf

	bl d
	@print values from register using print_format string
	bl printf

	b end

end:
	mov r7, #1
	swi 0
