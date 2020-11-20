# # # # # # # # # # # # # # # # # # # # # # # # #
#  Organiza??o de computadores 2020.1 - UFFS    #
#  Thiago Henrique Ferreira Correa - 1711100014 #
#  Debora Rebelatto  - 1721101034               #
# # # # # # # # # # # # # # # # # # # # # # # # # 

    .globl main

    .data
    

msg_inserir_value: 		.string  "\t 1 - Inserir valor na lista \n"
msg_remover_value: 		.string  "\t 2 - Remover valor \n"
msg_remover_index:		.string  "\t 3 - Remover por index \n"
msg_list:			.string  "\t 4 - Listar os valores \n"
msg_exit: 			.string  "\t 5 - Sair do programa \n"
msg_dig:			.string  "\tDigite o item a ser inserido na lista: "
espaco:				.string "\t "
		
		.text
	
main: 
		add  s0, zero, sp  								# iniciar o lista valendo 0 
		addi a1, zero, 1
		addi a2, zero, 2
		addi a3, zero, 3
		addi a4, zero, 4
	
		li s1, 0 									# Contador de items adicionados a lista
		li s2, 0									# Contador de items retirados
	
		j chamar_menu	
	
chamar_menu:	 										# faz a chamada do menu com seus respectivos items	
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
	
		li a7, 5
		ecall
							
		beq a1, a0, inserir_valor 				# realiza os desvios conforme o valor digita no menu
		beq a2, a0, remover_valor
		beq a3, a0, remover_index
		beq a4, a0, listar_items
			
# INSER??O DE DADOS#		

inserir_valor:
		la a0, msg_dig                         				 # exibe mensagem para receber valor do usuario
		li a7 4
		ecall
		
		li a7, 5				 			# le o valor inteiro digitado
		ecall
											
		addi s1, s1, 1				 			 # incrementa o contador
		beq  s0, sp, primeiro_item               			 # verifica se o valor e seu respectivo sp tem o tamanho se sim insere o primeiro elemento
		lw   t0, 0(s0)							 # registrador temporario recebe s0 na posi??o 0
		blt  a0, t0, inserir_primeira_posicao	 			 # compara se o valor digitado e menor que a primeira posi??o e coloca no atual
		add  t0, zero, s0						 # colocar a pilha no registrador temporario
		j inserir_atras

primeiro_item:
		sw   a0, 0(sp)							# adicionar valor digitado na primeira posi??o
		sw   t1, -4(sp)							# faz o link com o proximo elemento
		addi sp, sp, -8							# alocar espa?o na pilha
		j chamar_menu							

inserir_primeira_posicao:
		add t1, zero, s0						# adicionar o valor da 1 posi??o no registrador temporario t1
		sw  a0, 0(sp)							# primeira posi??o recebe o valor digitado
		sw  t1, -4(sp)							# link proximo elemento
		add s0, zero, sp						# atualiza  endere?o ultimo valor
		addi sp, sp, -8							# adiciona espa?o a pilha 
		j chamar_menu

inserir_atras:
		lw   t1, -4(t0)
		beqz t1, link
		lw   t2, -0(t1)
		blt  a0, t2, link
		add  t0, zero, t1
		j inserir_atras

link:
		lw t2, -4(t0)
		sw  a0, 0(sp)
		sw  t2, -4(sp)
		sw  sp, -4(t0)
		addi sp, sp, -8
		j chamar_menu


# REMO??O DE DADOS #
		
remover_valor:

remover_index:

# LISTAGEM DE DADOS #

listar_items:
		# comecei aqui mais n ta funfando resolvam KKKK
		
		addi a0, s0, 0
		li a7, 4
		ecall
		
		la a0, espaco
		li a7 4
		ecall
		
		lw a0, 0(t1)
		lw t1, -4(t1)
		
		li a7, 1
		ecall

# FINALIZAR PROGRAMA #

exit: 
		
