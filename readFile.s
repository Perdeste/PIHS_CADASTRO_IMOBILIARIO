# Função de controle que será chamada para ler o arquivo
readData:
    call    clean_lista         # Chama a função para esvaziar a lista da memória
    call    openReadFile        # Chama a função para abrir o arquivo em modo de leitura
    call    readReg             # Chama a função para ler os registros presentes arquivo
    call    closeFile           # Chama a função para fechar o arquivo
    RET

# Função para abrir o arquivo em modo leitura
openReadFile:
    movl    SYS_OPEN, %eax      # Abre o arquivo
    movl    $nomeArq, %ebx      # Nome do arquivo é definido como constante (registro.txt)
    movl    O_RDONLY, %ecx      # Define a opção de apenas leitura
    orl     O_CREAT, %ecx       # Cria um arquivo se não existir, para não ter problema na leitura caso o arquivo não exista
    movl    S_IRUSR, %edx       # Define permissão de leitura para o usuário
    orl     S_IWUSR, %edx       # Define permissão de escrita para o usuário
    int     $0x80               # Faz a chamada do sistema
    movl    %eax, descritor 
    RET

# Função para ler cada registro e inserir na lista individualmente
readReg:
    movl    $0, proximoID       # Reinicializa o id para evitar ids repetidos na lista
_loop_readReg:
    pushl   tamReg
    call    malloc              # Aloca espaço na memória para inserir um novo registro na lista
    movl    %eax, reg
    addl    $4, %esp
    movl    SYS_READ, %eax      # %eax = serviço da chamda do sistema
    movl    descritor, %ebx     # %ebx = indicador abstrato do arquivo
    movl    reg, %ecx           # %ecx = endereço de memória que receberá o conteúdo lido
    movl    $272, %edx          # %edx = quantidade de bytes a serem lidos no arquivo
    int     $0x80
    cmpl    $0, %eax            # Verifica se chegou ao fim do arquivo
    je      _end_readReg
    movl    reg, %edi           
    call    trata_ID            # Chama a função para verificar qual o maior id dos registros lidos até o momento
    addl    $272, %edi          # Da mesma forma que no leReg.s crie um registro com o endereço do próximo no NULL
    movl    $NULL, %eax         #
    movl    %eax, (%edi)        #
    call    insertReg           # Chama a função para inserir o registro lido na lista
    jmp     _loop_readReg
_end_readReg:
    cmpl    $0, proximoID
    je      _emptyFile          # Verifica se o ID é igual a 0, ou seja, nenhum registro foi inserido na lista
    pushl   $txtCarregaSucesso
    call    printf
    addl    $4, %esp
    RET
_emptyFile:
    pushl   $txtArquivoVazio
    call    printf
    addl    $4, %esp
    RET

# Limpa a lista %edi utilizando a função free
# O objetivo dessa função é não deixar lixo na memória, eliminando todos os mallocs feito
clean_lista:
    movl    lista, %edi         # Move a lista para %edi para esvasiar a lista
    cmpl    $NULL, %edi         # Compara se chegou ao final da lista
    je      _end_clean_lista
    movl    $1, %ecx            
    pushl   %ecx
    pushl   tamReg              # Empilhe a quantidade de bytes a ser liberado da memória
    pushl   %edi                # Empilhe o endereço de memória do primeiro elemento da lista
_loop_clean_lista:              # Para cada registro da lista faça...
    addl    $272, %edi          # Avança para o próximo registro da lista
    movl    (%edi), %edi
    cmpl    $NULL, %edi         # Começa a desalocar a memória dos registros da lista quando chega no final
    je      _start_clean
    inc     %ecx
    pushl   %ecx                # Empilhe o valor de ecx para não ser perdido na chamada do free
    pushl   tamReg              # Empilhe a quantidade de bytes a ser liberado da memória
    pushl   %edi                # Empilhe o endereço de memória a ser liberado ou seja, posição de memória + tamReg sera liberado
    jmp     _loop_clean_lista
_start_clean:                   # Para cada posição de memória na pilha faça...
    call    free                # Chama a função free para desalocar o espaço de um registro na memória
    addl    $8, %esp
    popl    %ecx                # Recupere o valor de ecx
    loop    _start_clean
_end_clean_lista:
    movl    $NULL, lista        # Ao fim, a lista vai estar vazia, portanto atribua o NULL como padrão
    RET

# Função para manter o valor do proximoID atualizado
trata_ID:
    movl    (%edi), %eax
    cmpl    proximoID, %eax
    jge      _troca_ID
    RET
_troca_ID:
    inc     %eax
    movl    %eax, proximoID
    RET
