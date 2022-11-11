# Função da main para checar se o usuário deseja salvar as alterações da lista antes de sair do programa
check_save:
    movl    proximoID, %eax
    cmpl    $0, %eax
    jne      _pergunta          # Se o ID não for 0, então a lista tem no minimo 1 elemento
    RET
_pergunta:
    pushl   $txtPerguntaSalvar
    call    printf
    pushl   $opcao
    pushl   $tipoNum
    call    scanf
    addl    $12, %esp
    movl    opcao, %eax
    cmpl    $1, %eax            # Se o usuário digitar 1, então ele deseja salvar as alterações
    jne      _sair_e_limpar     # Caso contrário, o programa será encerrada normalmente
    call    saveData                     
_sair_e_limpar:
    call    clean_lista         # Limpa a lista para não deixar lixo na memória
    RET
