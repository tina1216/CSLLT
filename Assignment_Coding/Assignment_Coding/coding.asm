;Chan Foong Nien Julian
;TP059783
;APD2F2202CS (CYB)

.model small
.stack 100h
.data

        price dw 100 dup(0) ;Initialize the Total pricings to have no duplicates
        ;It means price "dw" as 100 duplicates of zero. So it becomes 100 Times of 0,0,0,0,0,0,0....

        ;DB is used for Define Byte. 8 Bits
        ;DW is used for Define Word. Normally 2 bytes on a Typical x86 32-bit system
        ;DD is used for Difine Double Word. Normally 4 bytes on a typical x86 32-bit system
        ;https://stackoverflow.com/questions/10168743/which-variable-size-to-use-db-dw-dd-with-x86-assembly

        menu1 db 10, "***************************************   "
        db 10, "WELCOME TO THE APU CYBERSECURITY CLUB"
        db 10, "FSEC-SS CASH REGISTER SYSTEM"
        db 10, "***************************************  ",0ah 
        ;0ah is to skip a line

        db 10, "****************************************************************"
        db 10, "All the money collected will be contributed for the anual event."
        db 10, "****************************************************************",0ah

        db 10, "**********************"
        db 10, "The Battle of Hackers!"
        db 10, "**********************",0ah

        db 10,"*Limited Slot !!! While Stock Last !!!"
        db 10,"*Member of Cyber Security Club Can Enjoy 50% Discount !!!"
        db 10,"*T&C : No Refund and Changes shall be made after registration! Proceed with Cautions.",0ah

        db 10, "**************************************"
        db 10, "What activity would you like to join ?"
        db 10, "**************************************"
               db 10,"1. Workshops"
               db 10,"2. Competitions"
               db 10,"3. Activities"
               db 10,"4. Payment"
               db 10,"5. Exit Program"
               db 10,"Enter your choice: $"
        db 10, "************************************************   "

        workshopmenu db 10,"Please Select A Workshop"
        db 10,0ah, "************************************************   "
              db 10,"No.                                      Price(RM)"
              db 10,"1. Linux? The knowledge for students         10"
              db 10,"2. The future with Cloud Computing           10"
              db 10,"3. SQL Injecton                              10"
              db 10,"4. Back"
        db 10, "************************************************   "
              db 10,"Enter your choice: $"

        d1 db 10,"Selected, Linux? The knowledge for students!"
            db 10,"Register Completed",0ah

        d2 db 10,"Selected, The future with Cloud Computing"
            db 10,"Register Completed",0ah

        d3 db 10,"Selected, SQL Injecton"
            db 10,"Register Completed",0ah
        
        dfinal db 10,"Enter Y to Go back to Workshop menu"
               db 10,"Enter N to go back to main menu",0ah  
               db 10,"Enter your choice: $"

        
        comptmenu db 10,0ah, "************************************************   "
              db 10,"No.                                      Price(RM)"
              db 10,"1. Linux Exploitation                        20"
              db 10,"2. Mathemania                                20"
              db 10,"3. Capture The Flag                          20"
              db 10,"4. Back"
        db 10, "************************************************   "
              db 10,"Enter your choice: $"

        comp1 db 10,"Selected, Linux Exploitation!"
            db 10,10,"Register Completed",0ah

        comp2 db 10,"Selected, Mathemania!"
            db 10,"Register Completed",0ah

        comp3 db 10,"Selected, Capture The Flag!"
            db 10,"Register Completed",0ah
        
        compFinal db 10,"Enter Y to Go back to Competition menu"
               db 10,"Enter N to go back to main menu",0ah
               db 10,"Enter your choice: $"
              
        activitymenu db 10,"Please Select A Activity"
        db 10,0ah, "************************************************   "
              db 10,"No.                                      Price(RM)"
              db 10,"1. Capture The Flag Training                 30"
              db 10,"2. C++ Coding Training                       30"
              db 10,"3. Usage of Networking Tools                 30"
              db 10,"4. Back"
        db 10, "************************************************   "
              db 10,"Enter your choice: $"

        activityend1 db 10, "Selected, Capture The Flag Training"
            db 10,"Register Completed",0ah

        activityend2 db 10,"Selected, C++ Coding Training"
            db 10,"Register Completed",0ah

        activityend3 db 10,"Selected, Usage of Networking Tools"
            db 10,"Register Completed",0ah
        
        activityendFinal db 10,"Enter Y to Go back to Activities menu"
               db 10,"Enter N to go back to main menu",0ah
               db 10,"Enter your choice: $"

        memberprice db 10,"Are you a member?"
                db 10,"Enter Y if you are! : $"

        membership db 10,"Members are entitled for 50% off!$"
        cost db 10,"Final Price = $"
        close db 10,"Thank you and have a great day!$"
        error db 10,"Invalid Input!$"

        price10RM   dw 10
        price20RM   dw 20
        price30RM   dw 30
.code

main proc
        mov ax, @data
        mov ds, ax
        mov price, 0 ;To make sure it starts from 0, so previous memory will be gone. 

        call clear_screen

        call procPrintString

    start:
        lea dx, menu1
        call procPrintString

        call procGetInput
        mov dl, al

        cmp dl, '1'
        je workshops

        cmp dl, '2'
        jne next
        jmp competitions  

    next:
        cmp dl, '3'
        jne next1
        jmp activities

    next1:
        cmp dl, '4'
        jne next2
        jmp exit

    next2:
        cmp dl, '4'
        jg invalid 

    nextEnd:
        cmp dl, '5'
        jmp exit
        mov ax, 4c00h

    invalid:
        lea dx, error
        call procPrintString
        jmp start

    workshops:
        lea dx, workshopmenu
        call procPrintString

        mov ah, 01h
        int 21h

        mov dl, al

        cmp dl, '1'
        je purchase11

        cmp dl, '2'
        je purchase12

        cmp dl, '3'
        je purchase13

        cmp dl, '4'
        je start

        cmp dl, '4'
        jg invalid1
        ret

    invalid1:
        lea dx, error
        call procPrintString
        jmp workshops

    purchase11:
        mov ax, price10RM
        add price, ax
        jmp option11

    purchase12:
        mov ax, price10RM
        add price, ax
        jmp option12

    purchase13:
        mov ax, price10RM
        add price, ax
        jmp option13

    option11:
        lea dx, d1
        call procPrintString
        jmp worklast

    option12:
        lea dx, d2
        call procPrintString
        jmp worklast

    option13:
        lea dx, d3
        call procPrintString
        jmp worklast

    worklast:
        lea dx, dfinal
        call procPrintString
        call procGetInput
        mov dl, al

        cmp dl, 'Y'
        je workshops

        cmp dl, 'N'
        jne next3
        jmp start     

    next3:
        cmp dl, '3'
        je error_worklast

    error_worklast:
        lea dx, error
        call procPrintString
        jmp worklast


    competitions:
        lea dx, comptmenu
        call procPrintString

        mov ah, 01h
        int 21h

        mov dl, al

        cmp dl, '1'
        je purchase21

        cmp dl, '2'
        je purchase22

        cmp dl, '3'
        je purchase23

        cmp dl, '4'
        jne next4
        jmp start

    next4:
        cmp dl, '4'
        jg invalid2
        ret

    invalid2:
        lea dx, error
        call procPrintString
        jmp competitions

    purchase21:
        mov ax, price20RM
        add price, ax
        jmp option21

    purchase22:
        mov ax, price20RM
        add price, ax
        jmp option22

    purchase23:
        mov ax, price20RM
        add price, ax
        jmp option23

    option21:
        lea dx, comp1
        call procPrintString
        jmp comlast

    option22:
        lea dx, comp2
        call procPrintString
        jmp comlast

    option23:
        lea dx, comp3
        call procPrintString
        jmp comlast

    comlast:
        lea dx, compFinal
        call procPrintString
        call procGetInput
        mov dl, al

        cmp dl, 'Y'
        jne next5
        jmp workshops   

    next5:
        cmp dl, 'N'
        jne next6
        jmp start     

    next6:
        cmp dl, '3'
        je error_compt

    error_compt:
        lea dx, error
        call procPrintString
        jmp error_compt

    activities:
        lea dx, activitymenu
        call procPrintString

        mov ah, 01h
        int 21h

        mov dl, al

        cmp dl, '1'
        je purchase31

        cmp dl, '2'
        je purchase32

        cmp dl, '3'
        je purchase33

        cmp dl, '4'
        jne next7
        jmp start

    next7:
        cmp dl, '4'
        jg invalid3
        ret

    invalid3:
        lea dx, error
        call procPrintString
        jmp activities

    purchase31:
        mov ax, price30RM
        add price, ax
        jmp option31

    purchase32:
        mov ax, price30RM
        add price, ax
        jmp option32

    purchase33:
        mov ax, price30RM
        add price, ax
        jmp option33

    option31:
        lea dx, activityend1
        call procPrintString
        jmp actlast

    option32:
        lea dx, activityend2
        call procPrintString
        jmp actlast

    option33:
        lea dx, activityend3
        call procPrintString
        jmp actlast

    actlast:
        lea dx, activityendFinal
        call procPrintString
        call procGetInput
        mov dl, al

        cmp dl, 'Y'
        jne next8
        jmp workshops     

    next8:
        cmp dl, 'N'
        jne next9
        jmp start         

    next9:
        cmp dl, '3'
        je error_activity

    error_activity:
        lea dx, error
        call procPrintString
        jmp actlast

    exit:
        lea dx, memberprice
        call procPrintString

        mov ah, 01h
        int 21h

        mov dl, al

        cmp dl, '1'
        je member_p

        cmp dl, '1'
        jne final

    member_p:
        lea dx, membership
        call procPrintString

        mov ax, price
        mov bl, 2
        div bl
        mov price, ax
        jmp final


    final:
        lea dx, cost
        call procPrintString

        mov ax, price
        call procPrintDigit
        
    bye:
        mov ah, 09h
        mov dx, offset close
        int 21h

        mov ah, 4ch
        int 21h

        procPrintDigit: ; This is to print multiple Digit
        mov bx, 10
        xor cx, cx

        LOOP1:
            xor dx, dx
            div bx
            push dx     ;push the remainder to stack, which is the last digit
            inc cx      ;increment counter, counter represent the number of digit
            cmp ax, 0 
            jne LOOP1
        LOOP2:
            pop dx      ;pop the value in stack, LIFO, first digit is pop
            add dx, 30h ;ASCII normalisation
            mov ah, 02h
            int 21h
            loop LOOP2  ;loop until stack is empty
            ret
        procPrintString:
        ; PrintString
            mov ah, 09h          
            int 21h
            ret
        procGetInput:
        ; To get Input
            mov ah, 01h
            int 21h
            ret
main endp

clear_screen proc
    mov ah,0
    mov al,3
    int 10h
    ret
clear_screen endp

end main

