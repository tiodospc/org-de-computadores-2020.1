# # # # # # # # # # # # # # # # # # # # # # # # #
#  Organização de computadores 2020.1 - UFFS    #
#  Thiago Henrique Ferreira Correa - 1711100014 #
#  Debora Rebelatto  - 1721101034               #
# # # # # # # # # # # # # # # # # # # # # # # # # 

    .globl main

    .data
    

msg_inserir_value: 	.string  "\t Inserir valor na lista \n"
msg_remover_value: 	.string  "\t  Remover valor \n"
msg_remover_index:	.string  "\t Remover por index \n"
msg_list:		.string  "\t Listar os valores \n"


	.text
	
main: 
	add s0, zero, sp  #iniciar o lista valendo 0 
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
	
		j valor_operacao

valor_operacao:
		li a7, 5 #ler valor da operação digitada
		ecall
		
			#executar operação digitada

		
