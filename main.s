.include "insert.s"
.include "mostra.s"
.include "leReg.s"
.include "remove.s"

.section .data
    txtAbertura:            .asciz	"\n*** Cadastros Imobiliario em Assembly ***\n"

    txtMenu:                .asciz  "\n*** Menu ***\n(1) Cadastrar imóvel\n(2) Relatório \n(3) Consulta por metragem \n(4) Remover imóvel \n(5) Salvar Dados \n(6) Carregar Dados \n(0) Sair \n\nDigite a opcao desejada: "

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
    txtPedeAluguel:    		.asciz	"Digite o valor do aluguel do imovel: "        #4 (float) 

    txtConsultaReg:         .asciz  "\n*** Consulta de Registros por metragem ***\n"
    txtConsultaMin:    		.asciz	"Digite o valor minimo do intervalo: "
    txtConsultaMax:    		.asciz	"Digite o valor maximo do intervalo: "

    txtMostraReg:    		.asciz	"\n*** Registro Lido ***\n"
    txtMostraID:    		.asciz	"\nID: %d"
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
    txtMostraAluguel:    	.asciz  "\nAluguel: %.2lf\n"

    txtRemoveReg:           .asciz  "\n*** Remoção de Registro ***\n"
    txtRemoveEndereco:      .asciz  "\n*** Digite o Endereco para Remocao : "
    txtRemovidoReg:         .asciz  "\n*** Registro Removido com Sucesso ***\n"
    txtRemoveFalha:         .asciz  "\n*** Endereco Invalido... ***\n"
    txtRemoveVazio:         .asciz  "\n*** Lista Vazia... ***\n"

    tipoNum:     		    .asciz	"%d"
    tipoChar:    		    .asciz	"%c"
    tipoStr:    		    .asciz	" %s"
    tipoFloat:			    .asciz  "%f"
    pulaLinha:     		    .asciz	"\n"

    tamReg:      		    .int	276    #268 + 4 bytes de enderço do próximo
    reg:        		    .space	4
    proximoID:              .int    0
    lista:        		    .space	4
    NULL:        		    .int	0

    reg_quartos:    		.int    0
    metragem_min:           .int    0
    metragem_max:           .int    0

    id_remover:             .int    0

    opcao:                  .int    0
    lixo:                   .int    0

.section .text
.globl _start
_start:
    pushl   $txtAbertura
    call	printf
    addl	$4, %esp
    movl	$NULL, lista
_menu:
    pushl   $txtMenu
    call    printf
# Faz a leitura da opcao do menu
    pushl   $opcao
    pushl   $tipoNum
    call    scanf
	pushl	$lixo
	pushl	$tipoChar
	call	scanf
    addl    $12, %esp
# Tratamento do menu, pra cada opcao um valor é atribuido exclusivamente para uma funcionalidade do programa
    cmpl    $0, opcao
    je      _fim
    cmpl    $1, opcao
    je      _cadastrar_imovel
    cmpl    $2, opcao
    je      _relatorio_imovel
    cmpl    $3, opcao
    je      _consulta_imovel
    cmpl    $4, opcao
    je      _remover_imovel
    cmpl    $5, opcao
    je      _salvar_dados
    cmpl    $6, opcao
    je      _carregar_dados
    jmp     _menu
_fim:
    pushl    $0
    call    exit
_cadastrar_imovel:
    call    leReg
    jmp _menu
_relatorio_imovel:
    call    print_lista
    jmp _menu
_consulta_imovel:
    call    consulta
    jmp _menu
_remover_imovel:
    call    removeReg
    jmp _menu
_salvar_dados:
    # TODO: Colocar o salvamento dos dados
    jmp _menu
_carregar_dados:
    # TODO: Colocar o carregamento dos dados
    jmp _menu







