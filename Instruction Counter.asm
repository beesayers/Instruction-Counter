#################################################################################
#	PURPOSE:	This program counts the number of
#			occurrences of R, J, and I type instructions in the program.
#
#	ALGORITHM:
#			RCount = 0;
#			JCount = 0;
#			ICount = 0;
#			PROGRAM = (the instructions from each line of the program);
#			instruction = PROGRAM[i];
#			while instruction != "exit"
#    				if (instruction == R-type)
#					RCount = RCount + 1;				
#				else if (instruction == J-type)
#					JCount = JCount + 1;
#				else 
#					ICount = ICount + 1;
#				PROGRAM[i] = PROGRAM[i + 1];
#				instruction = PROGRAM[i];
#			end while;
#
#	INPUTS:		The program itself (PROGRAM) with an instruction on each line of code.  
#
#	OUTPUTS:	Variable RCount returns a count of the
#			number of R type instructions in the program.
#
#			Variable JCount returns a count of the
#			number of J type instructions in the program.
#
#			Variable ICount returns a count of the
#			number of I type instructions in the program.
#
#################################################################################

		.data			#
RCount:		.word	0		#
JCount:		.word	0		#
ICount:		.word	0		#
					#
		.text			#
main:					#
	la 	$s0, 0x400000		# 
	lw 	$s1, RCount		#  Rcount = 0;
	lw 	$s2, JCount		#  Jcount = 0; 
	lw 	$s3, ICount		#  Icount = 0;
loop:					#
	lw	$t0, 0($s0)		#  instruction = PROGRAM[i];
	beq	$t0, 12, endloop        #  while instruction != "exit"
	srl	$t0, $t0, 26		#	
	beq	$t0, 0, IfR		#  if (instruction == R-type)
	beq	$t0, 2, IfJ		#  else if (instruction == J-type)
	beq	$t0, 3, IfJ		#
IfI:					#
	addi	$s3, $s3, 1		#  ICount = ICount + 1;	
	addi	$s0, $s0, 4		#  PROGRAM[i] = PROGRAM[i + 1];
	j	loop			#
IfR:					#
	addi	$s1, $s1, 1		#  RCount = RCount + 1;
	addi	$s0, $s0, 4		#  PROGRAM[i] = PROGRAM[i + 1];
	j	loop			#
IfJ:					#
	addi	$s2, $s2, 1		#  JCount = JCount + 1;
	addi	$s0, $s0, 4		#  PROGRAM[i] = PROGRAM[i + 1];
	j	loop			#  end while;
endloop:				#
	sw	$s1, RCount		#  store RCount;
	sw	$s2, JCount		#  store JCount;
	sw	$s3, ICount		#  store ICount;
	li	$v0, 10			# 
	syscall				#  exit
	
