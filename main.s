# Inclusão dos arquivos que contém as funcionalidades do programa (para maior organização)
.include "insert.s"
.include "mostra.s"
.include "leReg.s"
.include "remove.s"
.include "writeFile.s"
.include "readFile.s"
.include "checkBeforeLeave.s"

.section .data
    txtAbertura:            .asciz	"\n*** Cadastros Imobiliario em Assembly ***\n"
    txtMenu:                .asciz  "\n*** Menu ***\n(1) Cadastrar imóvel\n(2) Relatório \n(3) Consulta por metragem \n(4) Remover imóvel \n(5) Salvar Dados \n(6) Carregar Dados \n(0) Sair \n\nDigite a opcao desejada: "
    txtPerguntaSalvar:       .asciz  "\nVocê esta saindo do programa\nGostaria de salvar as alterações da lista? <1>Sim <2>Nao: "
    
    # Textos para pedir os campos (leReg.s)
    txtPedeReg:             .asciz  "\n*** Preenchimento de Registros ***\n"  
    txtPedeNome:    		.asciz	"Digite o nome do proprietario: "                       # 64
    txtPedeCPF:             .asciz	"Digite o CPF: "                                        # 16        
    txtPedePhone:    		.asciz	"Digite o celular do proprietario: "                    # 16
    txtPedeTipo:    		.asciz	"Digite o tipo do imovel(casa ou apartamento): "        # 12
    txtPedeEndereco:    	.asciz	"Digite o endereco do imovel: "                         # 128
    txtPedeQuartoSimples:   .asciz	"Digite o numero de quartos simples: "                  # 4 (int)
    txtPedeQuartoSuite:    	.asciz	"Digite o numero de quartos suite: "                    # 4 (int)
    txtPedeBanheiroSocial:  .asciz	"Digite se o imovel possui banheiro social(sim/nao): "  # 4
    txtPedeCozinha:    		.asciz	"Digite se o imovel possui cozinha(sim/nao): "          # 4
    txtPedeSala:    		.asciz	"Digite se o imovel possui sala(sim/nao): "             # 4
    txtPedeGaragem:    		.asciz	"Digite se o imovel possui garagem(sim/nao): "          # 4
    txtPedeMetragem:    	.asciz	"Digite a metragem total do imovel: "                   # 4 (int)
    txtPedeAluguel:    		.asciz	"Digite o valor do aluguel do imovel: "                 # 4 (float) 

    # Textos para pedir os valores para consulta (mostra.s)
    txtConsultaReg:         .asciz  "\n*** Consulta de Registros por metragem ***\n"
    txtConsultaMin:    		.asciz	"Digite o valor minimo do intervalo: "
    txtConsultaMax:    		.asciz	"Digite o valor maximo do intervalo: "

    # Textos para mostrar os campos (mostra.s)
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

    # Textos para remoção de um registro (remove.s)
    txtRemoveReg:           .asciz  "\n*** Remoção de Registro ***\n"
    txtRemoveID:            .asciz  "\nDigite o ID para Remocao : "
    txtRemovidoReg:         .asciz  "\n*** Registro Removido com Sucesso ***\n"
    txtRemoveFalha:         .asciz  "\n*** ID Invalido... ***\n"
    txtRemoveVazio:         .asciz  "\n*** Lista Vazia... ***\n"

    # Textos para salvar e carregar arquivo (readFile.s e writeFile.s)
    txtCarregaSucesso:      .asciz  "\n*** Arquivo Carregado com Sucesso ***\n" 
    txtArquivoVazio:        .asciz  "\n*** Arquivo Carregado esta Vazio ***\n" 
    txtSalvaSucesso:        .asciz  "\n*** Arquivo Salvo com Sucesso ***\n" 

    nomeArq:                .asciz  "registros.txt"

    # Tipos de variáveis (para o scanf)
    tipoNum:     		    .asciz	"%d"
    tipoChar:    		    .asciz	"%c"
    tipoStr:    		    .asciz	" %s"
    tipoFloat:			    .asciz  "%f"
    pulaLinha:     		    .asciz	"\n"

    # Variáveis para controlar a lista
    tamReg:      		    .int	276     # 272 + 4 bytes de enderço do próximo
    reg:        		    .space	4       # Guarda o registro atual
    proximoID:              .int    0       # Guarda o valor do ID do próximo registro a ser inserido
    lista:        		    .space	4       # Guarda a posição do primeiro elemento da lista
    NULL:        		    .int	0       # Representação do final da lista
    reg_quartos:    		.int    0       # Guarda o número de quartos do registro atual
    id_remover:             .int    0       # Guarda qual o ID do registro a ser removido

    # Variáveis para a consulta
    metragem_min:           .int    0
    metragem_max:           .int    0

    # Outras variáveis
    opcao:                  .int    0
    lixo:                   .int    0
    descritor:              .int    0

    # Constantes que se referem aos serviços disponibilizados
    SYS_READ:               .int 3
    SYS_WRITE:              .int 4
    SYS_OPEN:               .int 5
    SYS_CLOSE:              .int 6

    # Constantes que se referem as configurações do parâmetro flag da chamada open()
    O_RDONLY:               .int 0x0000 
    O_WRONLY:               .int 0x0001 
    O_CREAT:                .int 0x0040 
    O_APPEND:               .int 0x0400 
    O_TRUNC:                .int 0x0200 

    # Constantes que se referem as configurações do parâmetro mode da chamada open()
    S_IRUSR:                .int 0x0100 
    S_IWUSR:                .int 0x0080 


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
    call    check_save
    pushl   $0
    call    exit
_cadastrar_imovel:
    call    leReg
    jmp     _menu
_relatorio_imovel:
    call    print_lista
    jmp     _menu
_consulta_imovel:
    call    consulta
    jmp     _menu
_remover_imovel:
    call    removeReg
    jmp     _menu
_salvar_dados:
    call    saveData
    jmp     _menu
_carregar_dados:
    call    readData
    jmp     _menu

