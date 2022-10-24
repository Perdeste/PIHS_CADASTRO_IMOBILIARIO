removeReg:
    pushl   $txtRemoveReg           # Texto de inicialização do remove
    call    printf                  # chama para printar ele na tela
    addl    $4, %esp                # limpa 1 push feito

#Pede Endereço Para remoção
    pushl   $txtRemoveEndereco      # Texto que pede para o usuario inserir o endereço para remoçao
    call    printf                  # chama o print

    pushl   $endereco_remover       # da push na variavel do tipo space 128 para receber endereço
    pushl   $tipoStr                # da push no tipo string para inserir no endereco_remover
    call    scanf                   # faz o scanf
    addl    $12, %esp               # remove os 3 pushs realizados

#Inicializa Lista
    movl    lista, %edi             # move a lista que contem todos os registros para edi
    movl    $NULL, %esi             # move o NULL para o registrador esi
    movl    reg, %ebx               # 
    cmpl    $NULL, lista            #
    je      _removeVazio            #

_loop_remove:
    cmpl    $NULL, %edi             #
    je      _end_remove             #
    addl    $108, %edi              #
    movl    (%edi), %eax            #
    cmpl    endereco_remover, %eax  # compara para ver se é o endereço que se deseja remover
    jne     _next_remove            # caso não seja ele passa pro próximo registro

_remove_reg:
    subl    $108, %edi
    call    printReg
    pushl   $txtRemovidoReg
    call    printf
    addl    $4, %esp
    RET

# Função para pular para o próx endereço
_next_remove:
    addl    $140, %edi              # pula para o inicio do proximo registro
    movl    (%edi), %edi
    jmp     _loop_remove
    
_removeFalha:
    pushl   $txtRemoveFalha
    call    printf
    addl   $4, %esp
    RET

_removeVazio:
    pushl   $txtRemoveVazio
    call    printf
    addl   $4, %esp
    RET

_end_remove:
    RET
