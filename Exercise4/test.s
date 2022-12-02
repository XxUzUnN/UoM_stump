	ORG 0
	B clean

clean	LD R1, lcd_st
	LD R3, lcd_en
cln_lp	MOV R2, #0
	ST R2, [R1]
	ADD R1, R1, #1
	CMP R1, R3
	BLE cln_lp
	LD R1, lcd_st
	LD R3, lcd_en
	B scr
lcd_st	DEFW 0xFF40
lcd_en	DEFW 0xFF8F
asc_A	DEFW 0x0041
scr	LD R1, lcd_st	;lcd screen
	LD R2, asc_A
	ADD R2, R2, #1
	ST R2, [R1]	;B
	ADD R1, R1, #1
	ADD R2, R2, #10
	ADD R2, R2, #9
	ST R2, [R1]	;U
	ADD R1, R1, #1
	SUB R2, R2, #1
	ST R2, [R1]	;T
	ADD R1, R1, #1
	ST R2, [R1]	;T
	ADD R1, R1, #1
	SUB R2, R2, #5
	ST R2, [R1]	;O
	ADD R1, R1, #1
	SUB R2, R2, #1
	ST R2, [R1]	;N
	ADD R1, R1, #2
	ADD R2, R2, #1
	ST R2, [R1]	;O
	ADD R1, R1, #1
	ADD R2, R2, #3
	ST R2, [R1]	;R
	ADD R1, R1, #1
	SUB R2, R2, #14
	ST R2, [R1]	;D
	ADD R1, R1, #1
	ADD R2, R2, #1
	ST R2, [R1]	;E
	ADD R1, R1, #1
	ADD R2, R2, #13
	ST R2, [R1]	;R
	ADD R1, R1, #1
	SUB R2, R2, #14
	SUB R2, R2, #10
	ST R2, [R1]	;:
	B scr2
asc_1	DEFW 0x0031
scr2	LD R2, asc_1
	ADD R1, R1, #8
	ST R2, [R1]	;1
	ADD R1, R1, #1
	ADD R2, R2, #1
	ST R2, [R1]	;2
	ADD R1, R1, #1
	ADD R2, R2, #1
	ST R2, [R1]	;3
	ADD R1, R1, #1
	SUB R2, R2, #6
	ST R2, [R1]	;-
	ADD R1, R1, #1
	ADD R2, R2, #10
	ADD R2, R2, #7
	ST R2, [R1]	;>
	ADD R1, R1, #1
	SUB R2, R2, #10
	ST R2, [R1]	;4
	ADD R1, R1, #1
	SUB R2, R2, #5
	ST R2, [R1]	;/
	ADD R1, R1, #1
	ADD R2, R2, #6
	ST R2, [R1]	;5
	ADD R1, R1, #1
	SUB R2, R2, #6
	ST R2, [R1]	;/
	ADD R1, R1, #1
	ADD R2, R2, #7
	ST R2, [R1]	;6
	ADD R1, R1, #1
	SUB R2, R2, #9
	ST R2, [R1]	;-
	ADD R1, R1, #1
	ADD R2, R2, #10
	ADD R2, R2, #7
	ST R2, [R1]	;>
	ADD R1, R1, #1
	SUB R2, R2, #14
	ST R2, [R1]	;0
	
	B clear
	
black	DEFW 00000000
cs_pos   DEFW 0xFF00
ce_pos   DEFW 0xFF3F
clear   LD R3, black    ;clear screen
        LD R2, cs_pos
        LD R4, ce_pos
clr_lp  CMP R2, R4
        BGT basic
        ST R3, [R2]
        ADD R2, R2, #1
        B clr_lp

white	DEFW 11111111
s_pos	DEFW 0xFF1B
basic	LD R1, white
	LD R2, s_pos	;basic cube position
	ST R1, [R2]
    	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #7
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	MOV R6, R7
	ADD R6, R6, #5
	B pre_l1

press1	DEFW 0xFF94
pre_l1	LD R5, press1	;press button '1'
	LD R5, [R5]
	CMP R5, #2
    	BEQ boom1
    	B pre_l1

boom1	ADD R2, R2, #9	;second cube layer
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
    	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #5
	ST R1, [R2]
	SUB R2, R2, #3
	ST R1, [R2]
	SUB R2, R2, #5
	ST R1, [R2]
	SUB R2, R2, #3
	ST R1, [R2]
	SUB R2, R2, #5
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	B pre_l2

press2	DEFW 0xFF94
pre_l2	LD R5, press2	;press button '2'
	LD R5, [R5]
	CMP R5, #4
    	BEQ boom2
    	B pre_l2

boom2	SUB R2, R2, #9	;third cube layer
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #5
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #5
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #5
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #5
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	B pre_l3

press3	DEFW 0xFF94
pre_l3	LD R5, press3	;press button '3'
	LD R5, [R5]
	CMP R5, #8
    	BEQ boom3
    	B pre_l3

boom3	ADD R2, R2, #9	;fourth cube layer
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #7
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #7
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #7
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #7
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #7
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #7
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	SUB R2, R2, #1
	ST R1, [R2]
	B mpre_l

mpress	DEFW 0xFF94
btn_4	DEFW 0x0010
btn_5	DEFW 0x0020
btn_6	DEFW 0x0040
mpre_l	LD R5, mpress	;press button '4'
	LD R5, [R5]
	LD R6, btn_4
	LD R5, mpress	;press button '5'
	LD R5, [R5]
	LD R1, btn_5
	LD R5, mpress	;press button '6'
	LD R5, [R5]
	LD R2, btn_6
	CMP R5, R6
    	BEQ clear1
    	CMP R5, R1
    	BEQ clear2
    	CMP R5, R2
    	BEQ tmp1
    	B mpre_l

black1	DEFW 00000000
s_pos1	DEFW 0xFF00
e_pos1	DEFW 0xFF3F
clear1	LD R3, black1	;clear screen1
	LD R2, s_pos1
	LD R4, e_pos1
clr_lp1	CMP R2, R4
	BGT fig_1
	ST R3, [R2]
	ADD R2, R2, #1
	B clr_lp1

tmp1	B tmp2

fp_f1	DEFW 0xFF00
fig_1	LD R2, fp_f1
	MOV R1, #3	;draw figure1 in blue
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #6
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #8
	ST R1, [R2]
	ADD R2, R2, #8
	ST R1, [R2]
	ADD R2, R2, #8
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	B pre_l0

tmp2	B tmp3

press0	DEFW 0xFF94
pre_l0	LD R5, press0	;press button '0'
	LD R5, [R5]
	CMP R5, #1
    	BEQ hclear
    	B pre_l0

hblack	DEFW 00000000
hs_pos	DEFW 0xFF00
he_pos	DEFW 0xFF3F
hclear	LD R3, hblack	;clear screen
	LD R2, hs_pos
	LD R4, he_pos
hclr_lp	CMP R2, R4
	BGT back
	ST R3, [R2]
	ADD R2, R2, #1
	B hclr_lp
back	MOV R7, #0  

tmp3	B clear3


black2	DEFW 00000000
s_pos2	DEFW 0xFF00
e_pos2	DEFW 0xFF3F
clear2	LD R3, black2	;clear screen2
	LD R2, s_pos2
	LD R4, e_pos2
clr_lp2	CMP R2, R4
	BGT fig_2
	ST R3, [R2]
	ADD R2, R2, #1
	B clr_lp2
	
yellow	DEFW 11111100
fp_f2	DEFW 0xFF02
fig_2	LD R2, fp_f2
	LD R1, yellow	;draw figure2 in yellow
	ST R1, [R2]
	ADD R2, R2, #7
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #2
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #2
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #2
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #2
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #4
	ST R1, [R2]
	ADD R2, R2, #5
	ST R1, [R2]
	B pre_l0
	
black3	DEFW 00000000
s_pos3	DEFW 0xFF00
e_pos3	DEFW 0xFF3F
	MOV R6, R7
	ADD R6, R6, #1
clear3	LD R3, black3	;clear screen2
	LD R2, s_pos3
	LD R4, e_pos3
clr_lp3	CMP R2, R4
	BGT fig_3
	ST R3, [R2]
	ADD R2, R2, #1
	B clr_lp3
	
tmp4	B pre_l0
	
red	DEFW 11100000
fp_f3	DEFW 0xFF02
fig_3	LD R2, fp_f3
	LD R1, red	;draw figure2 in red
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #4
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #2
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #5
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #2
	ST R1, [R2]
	ADD R2, R2, #2
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #2
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #5
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #2
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #1
	ST R1, [R2]
	ADD R2, R2, #4
	ST R1, [R2]
	ADD R2, R2, #3
	ST R1, [R2]
	B tmp4
