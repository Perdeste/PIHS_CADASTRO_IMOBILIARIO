.section .data
    txtRemoveReg:       .asciz  "\n*** Remoção de Registro ***\n"
    txtRemoveEndereco:  .asciz  "\n*** Digite o Endereco para Remocao ***\n"
    txtRemovidoReg:     .asciz  "\n*** Registro %d Removido com Sucesso ***\n"
    txtRemoveFalha:     .asciz  "\n*** Endereco Invalido... ***\n"
    txtRemoveVazio:     .asciz  "\n*** Lista Vazia... ***\n"

    endereco_remover    DB " ", 0

.section .text

removeReg:
    pushl   $txtRemoveReg
    call    printf
    addl    $4, %esp

#Pede Endereço Para remoção
    pushl    $txtRemoveEndereco
    call    printf

    pushl   $endereco_remover
    pushl   $tipoStr
    call    scanf
    addl    $12, %esp

#Inicializa Lista
    movl    lista, %edi
    movl    $NULL, %esi
    movl    reg, ebx
    cmpl    $NULL, lista
    je      _removeVazio

_loop_remove:
    cmpl    $NULL, %edi
    je      _end_remove
    addl    $108, %edi
    movl    (%edi), %eax
    cmpl    
    
_removeFalha:
    pushl   $txtRemoveFalha
    call    printf
    $addl   $4, %esp

_removeVazio:
    pushl   $txtRemoveVazio
    call    printf
    $addl   $4, %esp
    RET

