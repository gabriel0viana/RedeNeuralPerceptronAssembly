.data
MSG1: .asciiz "\nErro: "
MSG2: .asciiz "\nW1: "
MSG3: .asciiz "\nW2: "
MSG4: .asciiz "\n"
MSG5: .asciiz "\nCiclo: "
MSG6: .asciiz "\nResultado de "
MSG7: .asciiz " + "
MSG8: .asciiz " = "
MSG9: .asciiz "\nRESULTADOS: \n"
MSG10: .asciiz "\nNumero de Ciclos: "
MSG11: .asciiz "\n===================================\n\n"
MSG12: .asciiz "\nFIM DO PROGRAMA \n"

w1: .float 0.0
w2: .float 0.8
taxaApren: .float 0.05
erro: .float 0.0
aux1: .float 0.0
aux2: .float 0.0

arrayA:
.space 40

arrayB:
.space 40

.text
main:
# DECLARACAO DE VARIAVEIS
lwc1 $f1, w1
lwc1 $f2, w2
lwc1 $f3, taxaApren
lwc1 $f4, erro
lwc1 $f5, aux1
lwc1 $f6, aux2

add $t0, $zero ,$zero
add $t3, $zero ,$zero

# PREENCHIMENTO DO VETOR COM OS NUMEROS INTEIROS DE 1 A 10 
forA: 
slti $t1, $t0, 10
beq $t1, $zero, parte2
addi $t3, $t3, 1
mul $t2, $t0, 4
sw $t3, arrayA($t2)
addi $t0, $t0, 1
j forA



parte2:
# CONTADORES
addi $t7, $zero,1

add $t5, $zero,$zero

# FOR PARA DEFINIR O NUMERO DE CICLOS
for1:slti $t1, $t5, 5
     beq $t1, $zero, parte3

     add $t0, $zero, $zero
     
     li $v0, 4
     la $a0, MSG11
     syscall     

     li $v0, 4
     la $a0, MSG5
     syscall

     li $v0, 1
     move $a0, $t7
     syscall
     
     li $v0, 4
     la $a0, MSG4
     syscall

     addi $t7, $t7,1

# FOR PARA OS CALCULOS
   for2:slti $t1, $t0, 5
        beq $t1, $zero, for1A


        mov.s $f5, $f1
        mov.s $f6, $f2

        mul $t2, $t0, 4
        lw $t3, arrayA($t2)

        mtc1 $t3, $f8
        cvt.s.w $f8, $f8

        #erro = (x[i] + x[i]) - ((x[i] * w1) + (x[i] * w2));
        add.s $f4, $f8, $f8      #(x[i] + x[i])
        mul.s $f9, $f8, $f1      #(x[i] * w1)
        mul.s $f10, $f8, $f2     #(x[i] * w2)
        add.s $f9, $f9, $f10     #((x[i] * w1) + (x[i] * w2))
        sub.s $f4, $f4, $f9      #erro = (x[i] + x[i]) - ((x[i] * w1) + (x[i] * w2))


        #w1 = w1 + erro * taxaApren * x[i];
        mul.s $f9, $f3, $f4     #erro * taxaApren
        mul.s $f9, $f9, $f8     #erro * taxaApren * x[i]
        add.s $f1, $f1, $f9     #w1 = w1 + erro * taxaApren * x[i];
        
        #w2 = w2 + erro * taxaApren * x[i];
        mul.s $f9, $f3, $f4     #erro * taxaApren
        mul.s $f9, $f9, $f8     #erro * taxaApren * x[i]
        add.s $f2, $f2, $f9     #w2 = w2 + erro * taxaApren * x[i];

        addi $t0, $t0, 1

        li $v0, 4
        la $a0, MSG1
        syscall

        li $v0, 2
        mov.s $f12, $f4
        syscall

        li $v0, 4
        la $a0, MSG2
        syscall

        li $v0, 2
        mov.s $f12, $f1
        syscall

        li $v0, 4
        la $a0, MSG3
        syscall

        li $v0, 2
        mov.s $f12, $f2
        syscall

        li $v0, 4
        la $a0, MSG4
        syscall
        
        j for2

    for1A: addi $t5, $t5, 1
           j for1
    
       
     
       
       
parte3:  li $v0, 4
         la $a0, MSG11
         syscall
         
         li $v0, 4
         la $a0, MSG9
         syscall
       
add $t0, $zero ,$zero

# VERIFICACAO DOS RESULTADOS
for3: slti $t1, $t0, 10
      beq $t1, $zero, FIM
      
      mul $t2, $t0, 4
      lw $t3, arrayA($t2)

      mtc1 $t3, $f8
      cvt.s.w $f8, $f8
      
      mul.s $f9, $f8, $f1
      mul.s $f10, $f8, $f2
      
      add.s $f9, $f9, $f10 
      
      
      
      li $v0, 4
      la $a0, MSG6
      syscall

      li $v0, 2
      mov.s $f12, $f8
      syscall
      
      li $v0, 4
      la $a0, MSG7
      syscall

      li $v0, 2
      mov.s $f12, $f8
      syscall
      
      li $v0, 4
      la $a0, MSG8
      syscall

      li $v0, 2
      mov.s $f12, $f9
      syscall
      
      li $v0, 4
      la $a0, MSG4
      syscall
      
      addi $t0, $t0 , 1
      
      j for3
      
      
      


FIM: 
li $v0, 4
la $a0, MSG12
syscall
jr $ra
