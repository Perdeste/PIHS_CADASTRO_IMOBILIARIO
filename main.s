.include "insert.s"
.include "mostra.s"
.include "leReg.s"

.section .data
    txtAbertura:            .asciz	"\n*** Cadastros de Registros ***\n"

    txtPedeReg:             .asciz  "\n*** Preenchimento de Registros ***\n"  
    txtPedeNome:    		.asciz	"Digite o nome do proprietario: "    #64
    txtPedeCPF:             .asciz	"Digite o CPF: "             #16        
    txtPedePhone:    		.asciz	"Digite o celular do proprietario: "    #16
    txtPedeTipo:    		.asciz	"Digite o tipo do imovel(casa ou apartamento): "    #12
    txtPedeEndereco:    	.asciz	"Digite o endereco do imovel: "            #128
    txtPedeQuartoSimples:   .asciz	"Digite o numero de quartos simples: "    #4 (int)
    txtPedeQuartoSuite:    	.asciz	"Digite o numero de quartos suite: "        #4 (int)
    txtPedeBanheiroSocial:  .asciz	"Digite se o imovel possui banheiro social(sim/nao): " #4
    txtPedeCozinha:    		.asciz	"Digite se o imovel possui cozinha(sim/nao): "    #4
    txtPedeSala:    		.asciz	"Digite se o imovel possui sala(sim/nao): "        #4
    txtPedeGaragem:    		.asciz	"Digite se o imovel possui garagem(sim/nao): "    #4
    txtPedeMetragem:    	.asciz	"Digite a metragem total do imovel: "        #4 (int)
    txtPedeAluguel:    		.asciz	"Digite o valor do aluguel do imovel: "        #4 (int) ?

    txtConsultaReg:         .asciz  "\n*** Consulta de Registros por metragem ***\n"
    txtConsultaMin:    		.asciz	"Digite o valor minimo do intervalo: "
    txtConsultaMax:    		.asciz	"Digite o valor maximo do intervalo: "

    txtMostraReg:    		.asciz	"\n*** Registro Lido ***\n"
    txtMostraNome:    		.asciz	"\nNome: %s"
    txtMostraPhone: 		.asciz	"\nCelular: %s"
    txtMostraCPF:    		.asciz	"\nCPF: %s"
    txtMostraTipo:    		.asciz	"\nTipo Imovel: %s"
    txtMostraEndereco:    	.asciz	"\nEndereco: %s"
    txtMostraQuartoSimples: .asciz	"\nNumero de Quartos Simples: %d"
    txtMostraQuartoSuite:   .asciz	"\nNumero de Quartos Suite: %d"
    txtMostraBanheiroSocial:.asciz	"\nBanheiro Social: %s"
    txtMostraCozinha:    	.asciz	"\nCozinha: %s"
    txtMostraSala:    		.asciz	"\nSala: %s"
    txtMostraGaragem:    	.asciz	"\nGaragem: %s"
    txtMostraMetragem:    	.asciz	"\nMetragem Total: %d"
    txtMostraAluguel:    	.asciz  "\nAluguel: %d\n"

    tipoNum:     		    .asciz	"%d"
    tipoChar:    		    .asciz	"%c"
    tipoStr:    		    .asciz	" %s"
    pulaLinha:     		    .asciz	"\n"

    tamReg:      		    .int	272    #268 + 4 bytes de enderço do próximo
    reg:        		    .space	4
    lista:        		    .space	4
    NULL:        		    .int	0

    reg_quartos:    		.int    0
    metragem_min:           .int    0
    metragem_max:           .int    0

.section .text
.globl _start
_start:
    pushl   $txtAbertura
    call	printf
    addl	$4, %esp

    movl	$NULL, lista

    call	leReg
    call	leReg
    call    leReg
    call    print_lista
    call    consulta
fim:
    pushl    $0
    call    exit



#TODO: somar o campo de quartos
#Dois ponteiros: anterior e atual
#Inserção do primeiro ou ultimo - OK
#Começo: reg aponta pra lista e depois lista recebe reg
#Meio: quando posterior > reg, então reg recebe posterior e depois anterior recebe reg
#Final: o anterior recebe reg e reg recebe NULL (mesmo valor que o posterior)







