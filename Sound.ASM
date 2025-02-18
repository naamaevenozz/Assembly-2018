;------------------------------------------
; File   :  MineSweeper.asm
; Author :  Elad Gildnur
; Date   : 12/6/2012
; Class  :  jud-4
;------------------------------------------
Model Small

Stack 100h

DataSeg
notes 	dw   415 ,329,415 ,329,369, 415 ,329,415 ,329,369 ,415,369,329  ; Notes table
speed 	dw 03333h    ; Speed of the note Sound
lengtM  equ 13       ; Length of the notes table

CodeSeg
Start:
    mov ax,@data
    mov ds,ax
    
	call soundIntro
   
	mov ax, 4c00h
	int 21h
soundIntro:
    IN AL, 61h  ; Get speaker state
      
    PUSH AX     ; Save speaker state in stack
      	
    mov     al, 182         ; Prepare the speaker for the
    out     43h, al         ;  note. 
      	
    push bp  
    mov bp,2    ; Play the sounds twice
startSound:   
    mov ax,lengtM     
    mov di,offset notes  
    mov si,offset speed  
loopSound: 
    mov cx,word ptr[si]    
    push ax
    mov dx,0012h        ; When choosing a note,  to play 
    mov ax,34dch        ; it you have to divide 1193180 by
    div word ptr[di]    ; the chosen note
    mov bx,ax         
    call sound   
    pop ax       
    add di,2            ; Every note takes 2 byte
    dec ax
    jnz loopSound   
    
    dec bp
    jnz  startSound
    pop bp
    
    POP AX            ; Restore Speaker state
    
    OUT 61h, AL       ; Set speaker state 
    
    mov ah,0
    int 16h           ; Wait for key stroke
    ret		
sound:
    MOV AL, 0B6h  ; Select Channel 2, write LSB/BSB mode 3
    OUT 43h, AL
    
    MOV AX, BX 
    OUT 42h, AL  ; Send the LSB   
    MOV AL, AH  
    OUT 42h, AL  ; Send the MSB
    
    in      al, 61h         ; Turn on note (get value from Speaker)
    or      al, 00000011b   ; Set bits 1 and 0.
    out     61h, al         ; Send new value.    
    
    mov bx,25
    
LoopS:    
    mov si,offset speed 
    mov cx,word ptr[si]
    
LoopS2:
    dec cx
    jnz LoopS2
    dec bx
    jnz LoopS
    ret
END start
