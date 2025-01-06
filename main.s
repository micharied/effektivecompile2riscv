.section .text
.global _start

_start:
li t0, -24
sub t0, x0, t0
mv a0, t0
li a7, 93
ecall
