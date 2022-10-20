insertReg:
    movl    lista, %edi         #posterior
    movl    $NULL, %esi         #anterior
    movl    reg, %ebx
    cmpl    $NULL, lista
    je    _first_reg
_volta_insert:
    addl    $236, %edi          
    movl    (%edi), %eax        #Pegar valor de quarto simples e colocar em eax
    addl    $4, %edi
    addl    (%edi), %eax        #eax contém o valor total dos quartos
    cmpl    %eax, reg_quartos   #Comparação para determinar a posição do registro atual
    jle     _end_search
    addl    $28, %edi
    mov     %edi, %esi
    movl    (%edi), %edi
    subl    $268, %esi
    cmpl    $NULL, %edi
    je      _insert_end
    jmp     _volta_insert
_end_search:                    #Encontrou uma posição edi diferente de NULL
    cmpl    $NULL, %esi
    je      _insert_start
    RET
_insert_start:                  #Inserção no Inicio
    addl    $268, %ebx
    movl    lista, %eax
    movl    %eax, (%ebx)
    subl    $268, %ebx
    movl    %ebx, lista
    RET
_insert_end:                    #Inserção no Fim
    addl    $268, %esi
    movl    %ebx, (%esi)
    RET
_first_reg:                     #Primeira Inserção
    movl    %ebx, lista
    RET
