removeReg:
    pushl   $txtRemoveReg           # Texto de inicialização do remove
    call    printf                  # chama para printar ele na tela
    addl    $4, %esp                # limpa 1 push feito

    # Pede Endereço Para remoção
    pushl   $txtRemoveID            # Texto que pede para o usuario inserir o id para remoçao
    call    printf                  # chama o print

    pushl   $id_remover             # da push na variavel do tipo space 128 para receber endereço
    pushl   $tipoNum                # da push no tipo string para inserir no endereco_remover
    call    scanf                   # faz o scanf
    addl    $12, %esp               # remove os 3 pushs realizados

    # Inicializa Lista
    movl    lista, %edi             # manda o endereço do primeiro registro
    movl    $NULL, %esi             # move o NULL para o registrador esi
    movl    reg, %ebx               # 
    cmpl    $NULL, lista            # caso a lista esteja vazia
    je      _removeVazio            # pula diretamente para a lista vazia

_loop_remove:
    cmpl    $NULL, %ebx             #
    je      _end_remove             #
    addl    $0, %ebx                #
    movl    (%ebx), %eax            #
    cmpl    endereco_remover, %eax  # compara para ver se é o endereço que se deseja remover
    jne     _next_remove            # caso não seja ele passa pro próximo registro

_remove_reg:
    call    printReg                # tenta printar o registrador para testar
    pushl   $txtRemovidoReg         # chama o texto de remocao com sucesso
    call    printf                  # chama o print
    addl    $4, %esp                # limpa 1 push
    RET

# Função para pular para o próx id
_next_remove:
    addl    $272, %edi              # pula para o inicio do proximo registro
    movl    (%edi), %edi            # muda o ponteiro para o proximo registro 
    jmp     _loop_remove            # volta para conferir se é o id pedido

# Função de falha ao remover registro por não encontrar o id solicitado
_removeFalha:
    pushl   $txtRemoveFalha         # push no texto de falha ao remover
    call    printf                  # chama o printf
    addl   $4, %esp                 # limpa 1 push
    RET

_removeVazio:
    pushl   $txtRemoveVazio         # push no texto de lista vazia
    call    printf                  # chama o printf
    addl   $4, %esp                 # limpa 1 push
    RET

_end_remove:
    RET
