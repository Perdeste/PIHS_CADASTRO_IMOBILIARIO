# Função de controle que será chamada para ler o arquivo
readData:
    call    clean_lista         # Função 
    call    openReadFile
    call    readReg
    call    closeFile
    RET

# Função para abrir o arquivo em modo leitura
openReadFile:
    movl    SYS_OPEN, %eax
    movl    $nomeArq, %ebx
    movl    O_RDONLY, %ecx
    int     $0x80
    movl    %eax, descritor 
    RET

# Função para ler cada registro e inserir na lista individualmente
readReg:
    movl	$NULL, lista
    movl    $0, proximoID
_loop_readReg:
    pushl   tamReg
    call    malloc
    movl    %eax, reg
    addl    $4, %esp
    movl    SYS_READ, %eax
    movl    descritor, %ebx
    movl    reg, %ecx
    movl    $272, %edx
    int     $0x80
    cmpl    $0, %eax
    je      _end_readReg
    movl    reg, %edi
    call    trata_ID
    addl    $272, %edi
    movl    $NULL, %eax
    movl    %eax, (%edi)
    call    insertReg
    jmp     _loop_readReg
_end_readReg:
    pushl   $txtCarregaSucesso
    call    printf
    addl    $4, %esp
    movl    proximoID, %eax
    inc     %eax
    movl    %eax, proximoID
    RET

# Limpa a lista %edi utilizando a função free
clean_lista:
    movl    lista, %edi
    cmpl    $NULL, %edi
    je      _end_clean_lista
    movl    $1, %ecx
    pushl   %ecx
    pushl   tamReg
    pushl   %edi
_loop_clean_lista:
    addl    $272, %edi
    movl    (%edi), %edi
    cmpl    $NULL, %edi
    je      _start_clean
    inc     %ecx
    pushl   %ecx
    pushl   tamReg
    pushl   %edi
    jmp     _loop_clean_lista
_start_clean:
    call    free
    addl    $8, %esp
    popl    %ecx
    loop    _start_clean
_end_clean_lista:
    movl    $NULL, lista
    RET

# Função para manter o valor do proximoID
trata_ID:
    movl    (%edi), %eax
    cmpl    proximoID, %eax
    jg      _troca_ID
    RET
_troca_ID:
    movl    %eax, proximoID
    RET
