LIST P=16F527
#INCLUDE<P16F527.INC>
__CONFIG _BOD_ON&_IOSCFS_4MHZ&_CP_OFF&_MCLRE_ON&_PWRTE_ON&_INTOSCIO&_WDT_OFF
COUNT		    CBLOCK  20H
		    ENDC
		    ORG	    OOH
		    NOP
		    NOP
		    NOP
		    GOTO    MAIN
	    
DELAY100MS	    MOVLW   82H
		    MOVWF   24H
    LOOP1	    MOVLW   0FFH
		    MOVWF   25H
    LOOP2	    DECFSZ  25H
		    GOTO    LOOP2
		    DECFSZ  24H	
		    GOTO    LOOP1
		    RETURN
	    
DELAY0.4S	    MOVLW   04h
		    MOVWF   26H
    LOOP5	    MOVLW   82H
		    MOVWF   24H
    LOOP3	    MOVLW   OFFH
		    MOVWF   25H
    LOOP4	    DECFSZ  25H
		    GOTO    LOOP4
		    DECFSZ  24H
		    GOTO    LOOP3
		    DECFSZ  26H
		    GOTO    LOOP5
		    RETURN
		    
MAIN		    BCF	    STATUS, RP0		    //port A  init
		    CLRF    PORTA		    
		    BSF	    STATUS, RP0
		    CLRF    ANSEL
		    MOVLW   08H
		    MOVWF   TRISA
		    BCF	    STATUS,RP0
		    CLRF    PORTC
		    BSF	    STATUS,RP0
		    MOVLW   02H	
		    MOVWF   ANSEL
		    MOVLW   3AH
		    MOVWF   TRISC
		    BCF	    STATUS,RP0
		    BSF	    PORTC,0
		    BSF	    PORTA,2
		    BSF	    PORTA,5
		    BSF	    PORTA,0
		    BCF	    PORTC,2
		    BCF	    PORTA,4
		    CLRF    COUNT
	LOOP	    CALL    DELAY100MS
		    BTFSS   PORTC,5
		    GOTO    CHDJC
		    CALL    DELAY100MS
		    BTFSC   PORTC,4
		    GOTO    CHM
		    BTFSC   COUNT,0
		    GOTO    CHD
	CHM	    CALL    DELAY100MS
		    BCF	    PORTA,4
		    BCF	    PORTA,5
		    BSF	    PORTA,0
		    BCF	    COUNT,0
		    BTFSS   PORTC,1
		    GOTO    LOOP
		    CALL    DELAY100MS
		    BSF	    PORTC,2
		    BCF	    PORTC,0
		    GOTO    LOOP
		    
		