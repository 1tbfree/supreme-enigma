org 0x7c00            ; Set origin to 0x7c00 (standard for bootloaders)

jmp short start      ; Jump to 'start' label
nop

; FAT12 header
OEMIdentifier db 'MSDOS5.0'
BytesPerSector dw 512
SectorsPerCluster db 1
ReservedSectors dw 1
FATCount db 2
RootDirEntries dw 224
LogicalSectors dw 2880
MediumByte db 0xf0
SectorsPerFAT dw 9
SectorsPerTrack dw 18
Heads dw 2
HiddenSectors dd 0
LargeSectors dd 0
DriveNumber db 0
Flags db 0
Signature db 0x29
VolumeID dd 0x2d7e5a1a
VolumeLabel db 'MYBOOTDISK '
FileSystem db 'FAT12   '

start:
    cli             ; Clear interrupts
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00  ; Set stack pointer

    ; Print "Booting..." message
    mov si, msg
    call print_string
    jmp $           ; Infinite loop

print_string:
    ; String printing code here...
    ret

msg db 'Booting...', 0x0d, 0x0a, 0

times 510-($-$$) db 0 ; Pad remainder of boot sector with 0
dw 0xaa55             ; Boot signature
