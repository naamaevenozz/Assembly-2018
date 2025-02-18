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
                x dw 105
                y dw 180
                color db 15
                x2 dw 105
                y2 dw 180
                color2 db 15
		CODESEG

Start:
        mov ax, @data
        mov ds, ax
        mov ax,13h
        int 10h
point:
        mov bh,0h
        mov cx,[x]
        mov dx,[y]
        dec [x]
        dec [y]
        dec [color]

        mov al,[color]
        mov ah,0ch
        int 10h
        loop point

point2:
        mov bh,0h
        mov cx,[x2]
        mov dx,[y2]
        inc [x2]
        inc [y2]
        inc [color2]
        mov ah,0ch
        int 10h
        loop point2

l1:     in al,060h
        dec al
        jnz l1

Exit:
        mov ax, 4C00h
        int 21h
		END start
