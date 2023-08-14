.data
# Command-line arguments
num_args: .word 0
addr_arg0: .word 0
addr_arg1: .word 0
addr_arg2: .word 0
addr_arg3: .word 0
addr_arg4: .word 0
no_args: .asciiz "You must provide at least one command-line argument.\n"

# Output messages
straight_str: .asciiz "STRAIGHT_HAND"
four_str: .asciiz "FOUR_OF_A_KIND_HAND"
pair_str: .asciiz "TWO_PAIR_HAND"
unknown_hand_str: .asciiz "UNKNOWN_HAND"

# Error messages
invalid_operation_error: .asciiz "INVALID_OPERATION"
invalid_args_error: .asciiz "INVALID_ARGS"

# Put your additional .data declarations here, if any.
format: .asciiz "%02d"
array: .word  0,0,0,0,0
space: .asciiz " "
length: .word 5

# Main program starts here
.text
.globl main
main:
    # Do not modify any of the code before the label named "start_coding_here"
    # Begin: save command-line arguments to main memory  
    sw $a0, num_args
    beqz $a0, zero_args
    li $t0, 1
    beq $a0, $t0, one_arg
    li $t0, 2
    beq $a0, $t0, two_args
    li $t0, 3
    beq $a0, $t0, three_args
    li $t0, 4
    beq $a0, $t0, four_args
five_args:
    lw $t0, 16($a1)
    sw $t0, addr_arg4
four_args:
    lw $t0, 12($a1)
    sw $t0, addr_arg3
three_args:
    lw $t0, 8($a1)
    sw $t0, addr_arg2
two_args:
    lw $t0, 4($a1)
    sw $t0, addr_arg1
one_arg:
    lw $t0, 0($a1)
    sw $t0, addr_arg0
    j start_coding_here

zero_args:
    la $a0, no_args
    li $v0, 4
    syscall
    j exit
    # End: save command-line arguments to main memory

start_coding_here:
    # Start the assignment by writing your code here
li $t1,69
li $t2,68
li $t3,80
move $s1,$t0
lb $s1,0($t0)
addi $t0,$t0,1
lb $s2,0($t0)

beq $s1, $t1, label_E
beq $s1, $t2, label_D
beq $s1, $t3, label_P
    
invalid_error:la $a0, invalid_operation_error
li $v0, 4
syscall
j exit
    
label_E: bgt $s2,$0,invalid_error
j at_E

label_D: bgt $s2,$0,invalid_error
j at_D

label_P:bgt $s2,$0,invalid_error
 j at_P

at_E:
li $t4,5
lw $s2,num_args
bne $s2,$t4,intermediate #checks if right format of E

#lw $s3,addr_arg1
la $a0, addr_arg1 # Load the address of addr_arg1 into $a0
lw $t2, 0($a0)   
li $s3,0
b loop_E


opcode:move $t4,$t0 #t4=opcode
li $t8, 64
bge $t4,$t8,intermediate
blt $t4,$0,intermediate
addi $s3,$s3,1


la $a0, addr_arg2 # Load the address of addr_arg1 into $a0
lw $t2, 0($a0)   
li $s4,1
b loop_E


rs:move $t5,$t0 #t5=rs
li $t8, 32
bge $t5,$t8,intermediate
blt $t5,$0,intermediate
addi $s3,$s3,1


la $a0, addr_arg3
lw $t2, 0($a0)   
li $s5,2
b loop_E


rt:move $t6,$t0  #t6,rt
li $t8, 32
bge $t6,$t8,intermediate
blt $t6,$0,intermediate
addi $s3,$s3,1

#lw $s6,addr_arg4
la $a0, addr_arg4 
lw $t2, 0($a0)   
li $s6,3
b loop_E

immediate:move $t7,$t0   #t7,immediate
li $t8, 65536
bge $t7,$t8,intermediate
blt $t7,$0,intermediate
j shifting


loop_E:
li $t0,0 #result
li $t1,10 

inner_loop:
lb $t3,0($t2)
beq $t3,$0,loop_done 

addi $t3,$t3,-48
mul $t0,$t0,$t1
add $t0,$t0,$t3

addi $t2,$t2,1
j inner_loop

loop_done:
beq $s3,$0,opcode
beq $s3,$s4,rs
beq $s3,$s5,rt
beq $s3,$s6,immediate

shifting: 
sll $t0,$t4,26  
sll $t1,$t5,27
srl $t1,$t1,6
sll $t2,$t6,27
srl $t2,$t2,11
sll $t3,$t7,16
srl $t3,$t3,16

or $t8,$t0,$t1
or $t8, $t8,$t2
or $t8,$t8,$t3

move $a0,$t8
li $v0, 34
syscall
j exit
       
at_D:
li $t5,2
lw $s2,num_args
bne $s2,$t5, intermediate

lw  $t2, addr_arg1 
lb $t0, 0($t2) 
addi $t0,$t0,-48

bne $t0,$0,intermediate
addi $t2,$t2,1
lb $t0, 0($t2) 
li $t1,120
bne $t0,$t1, intermediate

move $s3,$0

li $t3,0
li $t4,7
li $s4,57
li $s5,48
li $s6,97
li $s7,102

update: ble $t3,$t4, here

addi $t2,$t2,1
lb $t0, 0($t2) 
bnez $t0,intermediate


srl $t5,$s3,26
sll $t6,$s3,6
srl $t6,$t6,27
sll $t7,$s3,11
srl $t7,$t7,27
sll $t8,$s3,16
srl $t8,$t8,16 

li $t3,9
li $t4,99
li $t0,999
li $t1,9999


ble  $t5,$t3, opcode_print
opcode_return:move $a0, $t5 
li $v0,1
syscall 
la $a0,space
li $v0,4
syscall 

ble $t6,$t3, rs_print
rs_return:move $a0, $t6 
li $v0,1
syscall 
la $a0,space
li $v0,4
syscall 

ble $t7,$t3, rp_print
rp_return:move $a0, $t7 
li $v0,1
syscall 
la $a0,space
li $v0,4
syscall 

ble $t8,$t3,four_zeros
ble $t8,$t4,three_zeros
ble $t8,$t0,two_zeros
ble $t8,$t1,one_zeros
j finally

four_zeros: move $a0,$0
li $v0,1
syscall 
move $a0,$0
li $v0,1
syscall 
move $a0,$0
li $v0,1
syscall 
move $a0,$0
li $v0,1
syscall 
j finally

three_zeros:move $a0,$0
li $v0,1
syscall 
move $a0,$0
li $v0,1
syscall 
move $a0,$0
li $v0,1
syscall 
j finally

two_zeros: move $a0,$0
li $v0,1
syscall 
move $a0,$0
li $v0,1
syscall 
j finally

one_zeros:move $a0,$0
li $v0,1
syscall 
j finally

finally:move $a0, $t8 
li $v0,1
syscall 
j exit



     
    
opcode_print: 
move $a0,$0
li $v0,1
syscall 
j opcode_return

rs_print:
move $a0,$0
li $v0,1
syscall 
j rs_return

rp_print:
move $a0,$0
li $v0,1
syscall 
j rp_return


    

here: addi $t2,$t2,1
beqz $t2,intermediate
lb $t0, 0($t2) 
bge $t0,$s5,mid
blt $t0,$s5,intermediate
after_mid:or $s3,$s3,$t0
beq $t3,$t4,last
sll  $s3,$s3,4
b there

last:
j there

there: addi $t3,$t3,1
j update

mid:ble $t0,$s4,digit
blt $t0, $s6,intermediate
ble $t0,$s7, alphabet
j intermediate


digit: addi $t0,$t0,-48
j after_mid


alphabet: addi $t0,$t0,-97
addi $t0,$t0,10
j after_mid


at_P:
li $t6,2
lw $s2,num_args
bne $s2,$t6, intermediate


li $t0,0x31
li $t1,0x3D
li $t2,0x41
li $t3,0x4D
li $t4,0x51
li $t5,0x5D
li $t7,0x61
li $t8,0x6D

li $s1,5
li $s3,0
la $s4,array
li $s5,0

compute:  
beq $s1,$s3,ahead
la $s0, addr_arg1
lb $t9, 0($s0)
ble $t9,$t1,clubs
ble $t9,$t3,spades
ble $t9,$t5,diamonds
ble $t9,$t8,hearts

re: addi $s3,$s3,1
addi $s0,$s0,1
j compute

clubs: bge $t9, $t0, intermediate
sub $t9,$t9,$t0
sw $t9,0($s4)
addi $s4,$s4,4
j re

spades: bge $t9,$t2,intermediate
sub $t9,$t9,$t2
sw $t9,0($s4)
addi $s4,$s4,4
j re


diamonds:bge $t9,$t4,intermediate
sub $t9,$t9,$t4
sw $t9,0($s4)
addi $s4,$s4,4
j re

hearts:bge $t9,$t7,intermediate
sub $t9,$t9,$t7
sw $t9,0($s4)
addi $s4,$s4,4
j re

ahead: 
beqz $s0,intermediate




j sort



sort:

la $s0, array	# $s0: base address of array
lw $s1, length	# number of elements in the array
	
	# initialize outer for-loop variables
	li $t0, 0		# $t0: i = 0	
	addi $t2, $s1, -1	# $t2 is upper bound on outer loop

outer_loop:
	bge $t0, $t2, end_outer_loop	# repeat until i >= length-1

	sll $s2, $t0, 2			# $s2 = 4*i
	add $s2, $s2, $s0		# $s2 is address of array[i]
	lw $s4, 0($s2)			# $s4 is currentMin; currentMin = array[i]
	move $s5, $s2			# $s5 is address of currentMin
	
	addi $t1, $t0, 1		# j = i + 1
inner_loops:    
	beq $t1, $s1, end_inner_loop	# repeat until j == length

	sll $s3, $t1, 2			# $s3 = 4*j
	add $s3, $s3, $s0		# $s3 is address of array[j]

	# do we have a new minimum?
	lw $t4, 0($s3)		# $t4 is value at array[j]
	ble $s4, $t4, element_not_smaller # element not smaller than current minimum
	lw $s4, 0($s3)		# we have a new minimum: currentMin = array[j];
	move $s5, $s3		# save address of new minimum
		
element_not_smaller:		

	addi $t1, $t1, 1	# j++
	j inner_loops
end_inner_loop:

	# swap array[i] with array[currentMinIndex] if necessary
	beq $s5, $s2, dont_swap # addr of minimum is still addr of array[i], so don't swap
	lw $t3, 0($s2)		# $t3 = array[i]
	sw $t3, 0($s5)		# array[currentMinIndex] = array[i]
	sw $s4, 0($s2)		# array[i] = currentMin	 
dont_swap:

	addi $t0, $t0, 1	# i++
	j outer_loop
end_outer_loop:	

la $t0,array
lw $t1,0($t0)
lw $t2,4($t0)
lw $t3,8($t0)
lw $t4,12($t0)
lw $t5,16($t0)



li $t6,0
li $s0,0
li $s1,0
li $s2,0
li $s3,0

li $t9,1


beq $t1,$t2,one_pair
sub $s0,$t2,$t1
beq $t2,$t3, two_three_pair
sub $s1,$t3,$t2
beq $t3,$t4, unknown_hand
sub $s2,$t4,$t3
beq $t4,$t5, unknown_hand
sub $s3,$t4,$t5
bne  $t9,$s0,unknown_hand
bne $t9,$s1,unknown_hand
bne $t9,$s2,unknown_hand
bne $t9,$s1,unknown_hand

la $a0, straight_str
li $v0,4
syscall
j exit


two_three_pair:beq $t2,$t4,check_for_fourth
beq $t4,$t5, two_pairs_confirmed
j unknown_hand


check_for_fourth: beq $t2,$t5,four_of_a_kind

one_pair: beq $t1,$t3,three_of_a_kind
addi $t6,$t6,1
bne $t3,$t4,last_pair
beq $t4,$t5,two_pairs_confirmed
j unknown_hand

last_pair:  beq $t4,$t5,two_pairs_confirmed
j unknown_hand


three_of_a_kind: beq $t1,$t4,four_of_a_kind
beq $t4,$t5,two_pairs_confirmed
j unknown_hand

unknown_hand:la $a0, unknown_hand_str
li $v0,4
syscall
j exit


two_pairs_confirmed:
la $a0, pair_str
li $v0,4
syscall
j exit


four_of_a_kind: la $a0, four_str
li $v0,4
syscall
j exit


j exit


intermediate: la $a0, invalid_args_error
li $v0, 4
syscall
j exit


exit:
    li $v0, 10
    syscall
