nop

addi $1, $0, 1  # pc1, r1 = 1
addi $2, $0, 2  # pc2, r2 = 2

blt $1, $2, 1  	# pc3, if ($1 < $2) PC = PC + 1 + 1
addi $3, $0, 9 	# pc4, r3 = 9
addi $3, $0, 4 	# pc5, r3 = 4
addi $4, $0, 1  # pc6, r4 = 1

blt $1, $1, 1  	# pc7, if ($1 < $1) PC = PC + 1 + 1
addi $4, $4, 1 	# pc8, r4 = r4 + 1
addi $5, $3, -1 # pc9, r5 = 3

blt $4, $5, -4 	# pc10, if ($4 < $5) PC = PC + 1 - 4

bne $1, $2, 1  	# pc11, if ($1 != $2) PC = PC + 1 + 1
addi $6, $0, 1 	# pc12, r6 = 1
addi $6, $0, 3 	# pc13, r6 = 3

bne $1, $1, 2 	# pc14, if ($1 != $1) PC = PC + 1 + 2
addi $4, $0, 1 	# pc15, r4 = 1
addi $4, $4, 1  # pc16, r4 = r4 + 1

bne $4, $5, -2 	# pc17, if ($4 != $5) PC = PC + 1 - 2

j 20 		# pc18, go to pc20

add $6, $4, $5  # pc19, r6 = $4 + $5
add $5, $4, $5  # pc20, r5 = $4 + %5

jal 28 		# pc21, go to pc28, $31 = 22

addi $1, $1, 1  # pc22, r1 = r1 + 1
addi $2, $2, 2  # pc23, r2 = r2 + 2

setx -1 	# pc24, r30 = -1
setx 1 		# pc25, r30 = 1

add $1, $2, $3  # pc26, r1 = r2 + r3
addi $2, $0, 2  # pc27, r2 = 2

bex 30 		# pc28, if (r30 != 0) PC = 30

addi $1, $1, 1  # pc29, r1 = r1 + 1
setx 0 		# pc30, r30 = 0

bex 31 		# pc31, if (r30 != 0) PC = 33
jr $31 		# pc32, go to pc in $31 = 22

add $1, $2, $3  # pc33, r1 = r2 + r3


