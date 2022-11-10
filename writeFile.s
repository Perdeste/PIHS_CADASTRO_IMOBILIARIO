saveData:
    call    openWriteFile
    call    saveReg
    call    closeFile
    RET

# Abre o arquivo no mode escrita
openWriteFile:
    movl    SYS_OPEN, %eax     
    movl    $nomeArq, %ebx
    movl    O_WRONLY, %ecx
    orl     O_CREAT, %ecx
    orl     O_TRUNC, %ecx
    orl     O_APPEND, %ecx
    movl    S_IRUSR, %edx
    orl     S_IWUSR, %edx
    int     $0x80
    movl    %eax, descritor
    RET

# Salva Registro no arquivo
saveReg:
    movl    lista, %edi
_loop_saveReg:
    cmpl    $NULL, %edi
    je      _end_saveReg
    movl    SYS_WRITE, %eax
    movl    descritor, %ebx
    movl    %edi, %ecx
    movl    $272, %edx
    int     $0x80
    addl    $272, %edi
    movl    (%edi), %edi
    jmp     _loop_saveReg
_end_saveReg:
    pushl   $txtSalvaSucesso
    call    printf
    addl    $4, %esp
    RET

# Fecha arquivo
closeFile:
    movl    SYS_CLOSE, %eax
    movl    descritor, %ebx # recupera o descritor
    int     $0x80
    RET
