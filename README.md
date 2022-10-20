# CONTROLE DE CADASTRO DE IMOBILIÁRIO EM ASSEMBLY

## OBSERVAÇÕES IMPORTANTES
O arquivo main.s deve conter apenas as chamadas de funções (call e include), NÃO insira o código da função neste arquivo.

As funções devem ser desenvolvidas em arquivos separados, como por exemplo os arquivos insert.s, leReg.s e mostra.s.

Para fazer a inclusão das funções na main.s basta colocar no topo do código o seguinte comando (com as aspas):

```
.include "nome_arquivo.s"
```

## COMANDOS PARA EXECUTAR O CÓDIGO
Comando para gerar o programa objeto:
```
as -32 main.s -o main.o
```
Comando para gerar o executável:
```
ld -m elf_i386 -lm -lc main.o -dynamic-linker /lib/ld-linux.so.2 -o main
```
Comando para executar o programa:
```
./main
```