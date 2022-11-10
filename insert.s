# Função para ler um registro e armazenar na variavel reg
# Os nomes, posterior e anterior, são relacionados ao registro atual, ou seja, qual será o registro posterior e anterior em relação ao registro atual inserido
insertReg:
    movl    lista, %edi         # ponteiro para o registro posterior
    movl    $NULL, %esi         # ponteiro para o registro anterior
    movl    reg, %ebx           # ponteiro para o registro atual a ser inserido
    call    calcula_quartos
    cmpl    $NULL, lista        # Checar se a lista é vazia
    je      _first_reg
_volta_insert:
    addl    $240, %edi          
    movl    (%edi), %eax        # Pega o valor de quarto simples e colocar em %eax
    addl    $4, %edi
    addl    (%edi), %eax        # eax contém o valor total dos quartos
    cmpl    %eax, reg_quartos   # Comparação para determinar a posição do registro atual
    jle     _end_search
    addl    $28, %edi
    mov     %edi, %esi
    movl    (%edi), %edi
    subl    $272, %esi
    cmpl    $NULL, %edi
    je      _insert_end
    jmp     _volta_insert
_end_search:                    #Encontrou uma posição edi diferente de NULL
    cmpl    $NULL, %esi
    je      _insert_start
_insert_middle:
    addl    $272, %ebx
    addl    $272, %esi
    movl    (%esi), %eax
    movl    %eax, (%ebx)
    movl    reg, %eax
    movl    %eax, (%esi)
    RET
_insert_start:                  #Inserção no Inicio
    addl    $272, %ebx
    movl    lista, %eax
    movl    %eax, (%ebx)
    subl    $272, %ebx
    movl    %ebx, lista
    RET
_insert_end:                    #Inserção no Fim
    addl    $272, %esi
    movl    %ebx, (%esi)
    RET
_first_reg:                     #Primeira Inserção
    movl    %ebx, lista
    RET

calcula_quartos:
    addl    $240, %ebx
    movl    (%ebx), %eax        # Pega o valor de quarto simples e colocar em %eax
    addl    $4, %ebx
    addl    (%ebx), %eax        # eax contém o valor total dos quartos
    movl    %eax, reg_quartos
    subl    $244, %ebx
    RET
