# Função de controle que será chamada para salvar os dados
saveData:
    call    openWriteFile       # Abre e cria o arquivo
    call    saveReg             # Salva todos os registros antes de fechar
    call    closeFile           # Fecha o arquivo
    RET

# Abre o arquivo no modo escrita
openWriteFile:
    movl    SYS_OPEN, %eax      # Abre o arquivo     
    movl    $nomeArq, %ebx      # Nome do arquivo é definido como constante (registro.txt)
    movl    O_WRONLY, %ecx      # Define a opção de apenas escrita
    orl     O_CREAT, %ecx       # Cria um arquivo se não existir
    orl     O_TRUNC, %ecx       # Limpa o arquivo
    orl     O_APPEND, %ecx      # Move o ponteiro para o final do arquivo
    movl    S_IRUSR, %edx
    orl     S_IWUSR, %edx
    int     $0x80               # Faz a chamada do sistema
    movl    %eax, descritor
    RET

# Salva Registro no arquivo
saveReg:
    movl    lista, %edi         # A lista é salva, inserindo um registro de cada vez, pois ela é uma lista encadeada
_loop_saveReg:                  # Para cada registro faça...
    cmpl    $NULL, %edi         # Caso a lista esteja vazia ou chegou ao fim da lista então encerre a execução
    je      _end_saveReg        #
    movl    SYS_WRITE, %eax     # %eax = serviço da chamda do sistema
    movl    descritor, %ebx     # %ebx = indicador abstrato do arquivo
    movl    %edi, %ecx          # %ecx = endereço de memória a ser que contém o conteúdo a ser escrito
    movl    $272, %edx          # %edx = quantidade de bytes a serem escritos no arquivo
    int     $0x80               
    addl    $272, %edi          # Move o ponteiro para o final do registro 
    movl    (%edi), %edi        # Faz %edi apontar para o próximo registro
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
