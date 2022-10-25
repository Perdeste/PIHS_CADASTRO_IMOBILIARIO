leReg:
    pushl   $txtPedeReg
    call    printf
    pushl   tamReg
    call    malloc
    movl    %eax, reg
    movl    reg, %edi  

#Insere campo ID no registro
    movl    proximoID, %eax
    movl    %eax, (%edi)
    inc     %eax
    movl    %eax, proximoID
    addl    $4, %edi

#Leitura campo Nome
    pushl   $txtPedeNome
    call    printf       
    addl    $12, %esp         
    
    pushl   stdin       
    pushl   $64           
    pushl   %edi        
    call    fgets        
    
    popl    %edi
    addl    $8, %esp
    addl    $64, %edi

#Leitura campo CPF
    movl    $txtPedeCPF, %ebx
    call    read_string    
    addl    $16, %edi                  

#Leitura campo Celular
    movl    $txtPedePhone, %ebx
    call    read_string  
    addl    $16, %edi          
        
#Leitura campo Tipo do Imóvel
    movl    $txtPedeTipo, %ebx
    call    read_string          
    addl    $12, %edi                

#Leitura campo Endereço do Imóvel
    pushl   $txtPedeEndereco    
    call    printf            
    addl    $4, %esp            

    pushl   stdin        
    pushl   $128                
    pushl   %edi            
    call    fgets    
    addl    $12, %esp

    pushl   stdin        
    pushl   $128                
    pushl   %edi            
    call    fgets        
    
    popl    %edi
    addl    $8, %esp
    addl    $128, %edi

#Leitura campo Número de quarto simples
    movl    $txtPedeQuartoSimples, %ebx         
    call    read_int                
    movl    (%edi), %eax
    movl    %eax, reg_quartos
    addl    $4, %edi               

#Leitura campo Número de quarto suite
    movl    $txtPedeQuartoSuite, %ebx         
    call    read_int 
    movl    (%edi), %eax
    addl    %eax, reg_quartos               
    addl    $4, %edi                        

#Leitura campo se tem banheiro social
    movl    $txtPedeBanheiroSocial, %ebx
    call    read_string         
    addl    $4, %edi                 

#Leitura campo se tem cozinha
    movl    $txtPedeCozinha, %ebx
    call    read_string          
    addl    $4, %edi                 

#Leitura campo se tem sala
    movl    $txtPedeSala, %ebx
    call    read_string        
    addl    $4, %edi                

#Leitura campo se tem garagem
    movl    $txtPedeGaragem, %ebx
    call    read_string                
    addl    $4, %edi                  

#Leitura campo tamanho metragem
    movl    $txtPedeMetragem, %ebx
    call    read_int  
    addl    $4, %edi     
    
#Leitura campo valor aluguel
    pushl    $txtPedeAluguel
    call    printf
    addl    $4, %esp

    pushl    %edi
    pushl    $tipoFloat
    call    scanf
    
    addl    $8, %esp
    
    addl    $4, %edi
    movl    $NULL, %eax
    movl    %eax, (%edi)   
    call    insertReg       
            
    RET            

#Função para ler um campo do tipo int
read_int:
    pushl   %edi 
    pushl   %ebx
    call    printf                
    addl    $4, %esp            
    
    pushl   $tipoNum             
    call    scanf                
    addl    $4, %esp    

    pushl	$lixo
    pushl	$tipoChar
	call	scanf
    addl    $8, %esp      

    popl    %edi              

    RET

#Função para ler um campo do tipo string
read_string:
    pushl   %edi
    pushl   %ebx
    call    printf          
    addl    $4, %esp        

    pushl   $tipoStr        
    call    scanf            
    addl    $4, %esp        
    popl    %edi 

    RET
