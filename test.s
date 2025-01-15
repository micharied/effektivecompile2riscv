        .section .data
.LC0:
        .string  "aber 5 Kuchen sind besser!\n"
.LC1:
        .string  "%d Kuchen sind gut, \n"
        .section .text
        .global  main

checkI:
        addi     sp,sp,-32      # Reserviert 32 Bytes auf dem Stack, um Platz für lokale Variablen zu schaffen.
        sd       ra,24(sp)      # Speichert das Rücksprung-Register (ra) auf dem Stack, um die Rücksprungadresse zu sichern.
        sd       s0,16(sp)      # Speichert das s0-Register auf dem Stack, um den aktuellen Frame-Pointer zu sichern.
        addi     s0,sp,32       # Setzt den Frame-Pointer (s0) auf den aktuellen Stack-Pointer plus 32 Bytes.

        mv       a5,a0          # Kopiert den Wert von a0 nach a5, um den Funktionsparameter zu speichern.
        sw       a5,-20(s0)     # Speichert den Wert von a5 an der Adresse -20(s0), um den Parameter auf dem Stack zu sichern.
        lw       a5,-20(s0)     # Lädt den Wert von der Adresse -20(s0) in a5, um den Parameter wiederherzustellen.

        sext.w   a4,a5          # Sign-Erweiterung des Wertes in a5 und speichert ihn in a4.

        li       a5,5           # Lädt den Wert 5 in das Register a5.   
        bne      a4,a5,.L2      # Verzweigt zu .L2, wenn a4 ungleich a5 ist.

        lui      a5,%hi(.LC0)   # Lädt das obere 20-Bit-Immediate von .LC0 in a5.
        addi     a0,a5,%lo(.LC0)# Addiert das untere 12-Bit-Immediate von .LC0 zu a5 und speichert das Ergebnis in a0.
        call     printf         # Ruft die printf-Funktion auf, um eine Nachricht auszugeben.
        j        .L4            # Springt zu .L4, um die Funktion zu beenden.
.L2:
        lw       a5,-20(s0)     # Lädt den Wert von der Adresse -20(s0) in a5, um den Parameter wiederherzustellen.
        mv       a1,a5          # Kopiert den Wert von a5 nach a1, um ihn als Argument für printf zu verwenden.
        lui      a5,%hi(.LC1)   # Lädt das obere 20-Bit-Immediate von .LC1 in a5.
        addi     a0,a5,%lo(.LC1)# Addiert das untere 12-Bit-Immediate von .LC1 zu a5 und speichert das Ergebnis in a0.
        call     printf         # Ruft die printf-Funktion auf, um eine Nachricht auszugeben.
.L4:
        nop                     # No-Operation, dient als Platzhalter.
        ld       ra,24(sp)      # Lädt das Rücksprung-Register (ra) vom Stack, um die Rücksprungadresse wiederherzustellen.
        ld       s0,16(sp)      # Lädt das s0-Register vom Stack, um den vorherigen Frame-Pointer wiederherzustellen.
        addi     sp,sp,32       # Gibt 32 Bytes auf dem Stack frei, um den Stack-Pointer wiederherzustellen.
        jr       ra             # Springt zurück zur aufrufenden Funktion.
main:
        addi     sp,sp,-16      # Reserviert 16 Bytes auf dem Stack, um Platz für lokale Variablen zu schaffen.
        sd       ra,8(sp)       # Speichert das Rücksprung-Register (ra) auf dem Stack, um die Rücksprungadresse zu sichern.
        sd       s0,0(sp)       # Speichert das s0-Register auf dem Stack, um den aktuellen Frame-Pointer zu sichern.
        addi     s0,sp,16       # Setzt den Frame-Pointer (s0) auf den aktuellen Stack-Pointer plus 16 Bytes.

        li       a0,3           # Lädt den Wert 3 in das Register a0.
        call     checkI         # Ruft die Funktion checkI auf.

        li       a0,5           # Lädt den Wert 5 in das Register a0.
        call     checkI         # Ruft die Funktion checkI auf.

        li       a5,0           # Lädt den Wert 0 in das Register a5.
        mv       a0,a5          # Kopiert den Wert von a5 nach a0.

        ld       ra,8(sp)       # Lädt das Rücksprung-Register (ra) vom Stack, um die Rücksprungadresse wiederherzustellen.
        ld       s0,0(sp)       # Lädt das s0-Register vom Stack, um den vorherigen Frame-Pointer wiederherzustellen.
        addi     sp,sp,16       # Gibt 16 Bytes auf dem Stack frei, um den Stack-Pointer wiederherzustellen.
        jr       ra             # Springt zurück zur aufrufenden Funktion.
