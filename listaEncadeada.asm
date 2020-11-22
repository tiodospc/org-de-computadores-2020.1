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
saiu:				.string "SSAIIIIUUUUU"
		.text
	
main: 
		add  s0, zero, sp  							# iniciar o lista valendo 0 
		addi a1, zero, 1
		addi a2, zero, 2
		addi a3, zero, 3
		addi a4, zero, 4
		addi a5, zero, 5
	
		li s1, 0 								# Contador de items adicionados a lista
		li s2, 0								# Contador de items retirados
	
		j chamar_menu	
	
chamar_menu:	 								  	# faz a chamada do menu com seus respectivos items	
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
							
		beq a1, a0, inserir_valor 						# realiza os desvios conforme o valor digita no menu
		beq a2, a0, remover_valor
		beq a3, a0, remover_index
		beq a4, a0, listar_items
		beq a5, a0, exit
			
# INSERIR DE DADOS#		

inserir_valor:
		la a0, msg_dig                         					# exibe mensagem para receber valor do usuario
		li a7 4
		ecall
		
		li a7, 5				 				# le o valor inteiro digitado
		ecall
											
		addi s1, s1, 1				 			 	# incrementa o contador
		beq  s0, sp, primeiro_item               				# verifica se o valor e seu respectivo sp tem o tamanho se sim insere o primeiro elemento
		lw   t0, 0(s0)							 	# registrador temporario recebe s0 na posi??o 0
		blt  a0, t0, inserir_primeira_posicao	 				# compara se o valor digitado e menor que a primeira posi??o e coloca no atual
		add  t0, zero, s0						 	# colocar a pilha no registrador temporario
		j inserir_atras

primeiro_item:
		sw   a0, 0(sp)								# adicionar valor digitado na primeira posi??o
		sw   t1, -4(sp)								# faz o link com o proximo elemento
		addi sp, sp, -8								# alocar espa?o na pilha
		j chamar_menu							

inserir_primeira_posicao:
		add t1, zero, s0							# adicionar o valor da 1 posi??o no registrador temporario t1
		sw  a0, 0(sp)								# primeira posi??o recebe o valor digitado
		sw  t1, -4(sp)								# link proximo elemento
		add s0, zero, sp							# atualiza  endere?o ultimo valor
		addi sp, sp, -8								# adiciona espa?o a pilha 
		j chamar_menu

inserir_atras:
		lw   t1, -4(t0)    							# tras o valor do proximo elemento da lista e coloca no registrador temporario t1
		beqz t1, link                           				# compara de o valor e igual zero faz desvio 
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


# REMOCAO DE DADOS 
		
remover_valor:
	addi s2, s2, 1
	li a7, 5				 				# le o valor inteiro digitado
	ecall
	
_remove_valor_inicio:
	beq  s0 , sp ,chamar_menu
	add t0, zero, s0
	lw t1, 0 (t0)
	bne  t1 , a0 , _remove_valor_loop
	lw t3, -4 (t0)
	add s0, zero, t3
	beqz s0, _restaura_pilha
	j _remove_valor_inicio
	
_remove_valor_loop:
	lw t1, -4 (t0) 
	beqz t1, chamar_menu
	
	lw t2, 0 (t1)
	
	bne  t2 ,   a0 ,_procura_proximo_valor   
	lw t3, -4 (t1)
	sw t3, -4 (t0)
	j _remove_valor_loop
	
_procura_proximo_valor:
	add t0, zero, t1
	j _remove_valor_loop

_restaura_pilha:
	add s0, zero, sp
	j chamar_menu


remover_index:

# LISTAGEM DE DADOS 

listar_items:
		# comecei aqui mais n ta funfando resolvam KKKK
		
		addi a0, s0, 0
	##	li a7, 4
	##	ecall
		
		lw t0, 0(a0)
		add a0, zero, t0
		li a7, 1
		ecall    
		la a0, espaco
		li a7, 4
		ecall
		
		j chamar_menu

# FINALIZAR PROGRAMA #

exit: 
	la a0, saiu
	li a7, 4
	ecall
