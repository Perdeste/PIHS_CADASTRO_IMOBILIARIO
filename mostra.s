printReg:
    pushl   $txtMostraReg
    call    printf
    addl    $4, %esp

#Mostra campo Nome
    movl    $txtMostraNome, %ebx
    call    print_string
    addl    $64, %edi

#Mostra campo CPF
    movl    $txtMostraCPF, %ebx
    call    print_string
    addl    $16, %edi

#Mostra campo Telefone
    movl    $txtMostraPhone, %ebx
    call    print_string
    addl    $16, %edi

#Mostra campo Tipo
    movl    $txtMostraTipo, %ebx
    call    print_string
    addl    $12, %edi

#Mostra campo Endereço
    movl    $txtMostraEndereco, %ebx
    call    print_string
    addl    $128, %edi
    
#Mostra campo Número Quarto Simples
    movl    $txtMostraQuartoSimples, %ebx
    call    print_int

#Mostra campo Número Quarto Suíte
    movl    $txtMostraQuartoSuite, %ebx
    call    print_int

#Mostra campo Banheiro Social
    movl    $txtMostraBanheiroSocial, %ebx
    call    print_string
    addl    $4, %edi

#Mostra campo Cozinha
    movl    $txtMostraCozinha, %ebx
    call    print_string
    addl    $4, %edi

#Mostra campo Sala
    movl    $txtMostraSala, %ebx
    call    print_string
    addl    $4, %edi

#Mostra campo Garagem
    movl    $txtMostraGaragem, %ebx
    call    print_string
    addl    $4, %edi

#Mostra campo Metragem
    movl    $txtMostraMetragem, %ebx
    call    print_int

#Mostra campo Aluguel
    movl    $txtMostraAluguel, %ebx
    call    print_int
    movl    (%edi), %edi
    RET

print_string:
    pushl   %edi
    pushl   %ebx
    call    printf
    addl    $4, %esp

    popl    %edi
    RET

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
