        .section .data
.LC0:
        .string  "5 Kuchen sind besser!"
.LC1:
        .string  "%d Kuchen sind gut!\n"
        .section .text
        .global  main

checkI:
        addi     sp,sp,-32
        sd       ra,24(sp)
        sd       s0,16(sp)
        addi     s0,sp,32
        mv       a5,a0
        sw       a5,-20(s0)
        lw       a5,-20(s0)
        sext.w   a4,a5
        li       a5,5
        bne      a4,a5,.L2
        lui      a5,%hi(.LC0)
        addi     a0,a5,%lo(.LC0)
        call     puts
        j        .L4
.L2:
        lw       a5,-20(s0)
        mv       a1,a5
        lui      a5,%hi(.LC1)
        addi     a0,a5,%lo(.LC1)
        call     printf
.L4:
        nop
        ld       ra,24(sp)
        ld       s0,16(sp)
        addi     sp,sp,32
        jr       ra
main:
        addi     sp,sp,-16
        sd       ra,8(sp)
        sd       s0,0(sp)
        addi     s0,sp,16

        li       a0,3
        call     checkI

        li       a0,5
        call     checkI

        li       a5,0
        mv       a0,a5
        
        ld       ra,8(sp)
        ld       s0,0(sp)
        addi     sp,sp,16
        jr       ra
