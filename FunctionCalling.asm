;  Jocelyn Martinez
;  April 2023


.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA
string_in                   BYTE 100 DUP (?) 
string_out                  BYTE 100 DUP (?)
prompt1              BYTE  "In to string : ", 0
prompt2              BYTE  "Formatted string : ", 0

.CODE
_MainProc PROC

  
        input   prompt1, string_in, 40
        lea     ebx, string_in              ; Placing string_in and string_out into the stack as parameters for reformat_string
        push    ebx
        lea     ebx, string_out
        push    ebx
        call    reformat_string             ; Function call
        pop     ebx                         ; Clean up the stack
        pop     ebx
        output  prompt2, string_out

        mov     eax, 0  ; exit with return code 0
        ret

    reformat_string:                        ; Function to reformat string
       mov     eax, [esp+8]                 ; Eax pointing to the string_in
       mov     ecx, [esp+4]                 ; Ecx pointing to the string_out
       mov     ebx, 0                       ; Index strings
       mov     dl, [ebx+eax]                ; Looking at first char
       cmp     dl, 'a'
       jl      notLowerCase
       cmp     dl, 'z'
       jg      notLowerCase
       sub     dl, 32                       ; Converting to upper case
       mov     [ecx+ebx], dl                ; Write to output string
      
    notLowerCase:
    ;Convert remaining characters
       cmp     dl, 0                        ; Checks to see if at the end of the string.
       je      endReformat                  ; If end of string, return.
      
       inc     ebx                          ; Will convert uppercase string to lowercase
       mov     dl, [ebx+eax]
       cmp     dl, 'A'
       jl      upperCase
       cmp     dl, 'Z'
       jg      upperCase
       add     dl, 32                       ; Converting to lower case
       mov     [ecx+ebx], dl                ; Write to output string
       
    upperCase:
       mov     [ecx+ebx], dl                ; Copying lower case char into output string
       jmp     notLowerCase

    endReformat:
        ret

_MainProc ENDP
END                             ; end of source code
