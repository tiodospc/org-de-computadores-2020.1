# # # # # # # # # # # # # # # # # # # # # # # # #
#  Organização de computadores 2020.1 - UFFS    #
#  Thiago Henrique Ferreira Correa - 1711100014 #
#  Debora Rebelatto  - 1721101034               #
# # # # # # # # # # # # # # # # # # # # # # # # # 

    .globl main

    .data
    

msg_inserir_value: 	.string  "\t 1 - Inserir valor na lista \n"
msg_remover_value: 	.string  "\t 2 - Remover valor \n"
msg_remover_index:	.string  "\t 3 - Remover por index \n"
msg_list:		.string  "\t 4 - Listar os valores \n"
msg_exit: 		.string  "\t 5 - Sair do programa \n"

	.text
	
main: 
	add  s0, zero, sp  #iniciar o lista valendo 0 
	addi a1, zero, 1
	addi a2, zero, 2
	addi a3, zero, 3
	addi a4, zero, 4
	
	j chamar_menu	
	
chamar_menu:	
		la a0, msg_inserir_value 
		li a7, 4
		ecall

		la a0, msg_remover_value
		li a7, 4
		ecall
	
		la a0, msg_remover_index
		li a7, 4
		ecall
	
		la a0, msg_list
		li a7, 4
		ecall
	
		la, a0, msg_exit
		li a7, 4
		ecall
		
		beq a1, a0, inserir_valor
		beq a2, a0, remover_valor
		beq a3, a0, remover_index
		beq a4, a0, listar_items
			
		
inserir_valor:
		li a7, 1
		ecall
		
		addi s1, s1, 1
		beqz s0, sp, primeiro_item
		lw t0, 0(s0)
		blt a0, t0, inserir_ordenado

primeiro_item:
		addi sp, sp, -8
		sw a0, 0(sp)
		sw t1, -4(sp)
		j menu		
					
