; file       :  base.asm
; Aunthor    :
; Date       :
; Class      : jud-3
; Assume     :size of all numbers is byte unsigned number
; Version    :2


		IDEAL
		
		MODEL small

		STACK 256


		
		DATASEG
                
		;array db 0EFFFh dup (?)

		CODESEG

Start:
        mov ax, @data
        mov ds, ax
        

Exit:
        mov ax, 4C00h
        int 21h
		END start
