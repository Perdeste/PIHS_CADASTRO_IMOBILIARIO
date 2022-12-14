# Função para printar todos os campos de um registro
# O registrador %ebx esta sendo utilizado para guardar as variaveis que contém o texto
printReg:
    pushl   $txtMostraReg
    call    printf
    addl    $4, %esp

    # Mostra campo ID
    movl    $txtMostraID, %ebx
    call    print_int

    # Mostra campo Nome
    movl    $txtMostraNome, %ebx
    call    print_string
    addl    $64, %edi

    # Mostra campo CPF
    movl    $txtMostraCPF, %ebx
    call    print_string
    addl    $16, %edi

    # Mostra campo Telefone
    movl    $txtMostraPhone, %ebx
    call    print_string
    addl    $16, %edi

    # Mostra campo Tipo
    movl    $txtMostraTipo, %ebx
    call    print_string
    addl    $12, %edi

    # Mostra campo Endereço
    movl    $txtMostraEndereco, %ebx
    call    print_string
    addl    $128, %edi
    
    # Mostra campo Número Quarto Simples
    movl    $txtMostraQuartoSimples, %ebx
    call    print_int

    # Mostra campo Número Quarto Suíte
    movl    $txtMostraQuartoSuite, %ebx
    call    print_int

    # Mostra campo Banheiro Social
    movl    $txtMostraBanheiroSocial, %ebx
    call    print_string
    addl    $4, %edi

    # Mostra campo Cozinha
    movl    $txtMostraCozinha, %ebx
    call    print_string
    addl    $4, %edi

    # Mostra campo Sala
    movl    $txtMostraSala, %ebx
    call    print_string
    addl    $4, %edi

    # Mostra campo Garagem
    movl    $txtMostraGaragem, %ebx
    call    print_string
    addl    $4, %edi

    # Mostra campo Metragem
    movl    $txtMostraMetragem, %ebx
    call    print_int

    # Mostra campo Aluguel
    pushl   %edi
    flds    (%edi)
    subl    $8, %esp
    fstl    (%esp)
    pushl   $txtMostraAluguel
    call    printf
    addl    $12, %esp
    popl    %edi
    addl    $4, %edi
    movl    (%edi), %edi
    RET

# Função básica para toda vez que deseja-se printar um campo do tipo string sem espaço
print_string:
    pushl   %edi
    pushl   %ebx
    call    printf
    addl    $4, %esp

    popl    %edi
    RET

# Função básica para toda vez que deseja-se printar um campo do tipo inteiro
print_int:
    pushl   %edi
    movl    (%edi), %eax
    pushl   %eax
    pushl   %ebx
    call    printf
    addl    $8, %esp

    popl    %edi
    addl    $4, %edi
    RET

# Função para printar todos os registros da lista
print_lista:
    movl    lista, %edi
_loop_print_lista:
    cmpl    $NULL, %edi
    je      _end_print_lista
    call    printReg
    jmp     _loop_print_lista
_end_print_lista:
    RET

# Função para printar os registros com metragem dentro de um intervalo
consulta:
    pushl   $txtConsultaReg
    call    printf

    pushl   $txtConsultaMin         # Consulta o valor minimo do intervalo
    call    printf
    pushl   $metragem_min
    pushl   $tipoNum
    call    scanf

    pushl   $txtConsultaMax         # Consulta o valor maximo do intervalo
    call    printf
    pushl   $metragem_max
    pushl   $tipoNum
    call    scanf

    addl    $28, %esp
    movl    lista, %edi
_loop_consulta:
    cmpl    $NULL, %edi
    je      _end_consulta
    addl    $264, %edi              # Move até o campo de metragem e coloca o valor no %eax
    movl    (%edi), %eax
    cmpl    metragem_min, %eax      # Se o %eax é menor do que o valor mínimo, então pula para o próximo registro
    jl      _next_consulta
    cmpl    metragem_max, %eax      # Se o %eax é maior do que o valor máximo, então pula para o próximo registro
    jg      _next_consulta
_printa_consulta:                   # Registro dentro do intervalo, volta o ponteiro para o inicio e printa o registro
    subl    $264, %edi
    call    printReg
    jmp    _loop_consulta
_next_consulta:                     # Registro fora do intervalo, move para o próximo registro
    addl    $8, %edi                # Temos que mover 8 bytes no intervalo (264 + 8) para posicionar no campo do endereço do próximo
    movl    (%edi), %edi
    jmp    _loop_consulta
_end_consulta:
    RET
