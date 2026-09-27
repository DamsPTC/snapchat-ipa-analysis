// Replacement at SCRT 0x22220. Keep the original stack frame for unwinding.
sub sp, sp, #0x60
stp x29, x30, [sp, #0x50]
add x29, sp, #0x50
adrp x8, #0xcb000
ldr x0, [x8, #0xb18]
bl #0x7cd60 // standardUserDefaults
mov x29, x29
bl #0x76468 // objc_retainAutoreleasedReturnValue
stur x0, [x29, #-8]
adrp x8, #0xcb000
ldr x0, [x8, #0xb10]
bl #0x79660 // mainBundle: singleton, alive through this synchronous call
bl #0x774e0 // bundleIdentifier
mov x29, x29
bl #0x76468
stur x0, [x29, #-16]
str x0, [sp] // Darwin variadic argument for SHIELD_ID_%@
adrp x8, #0xcb000
ldr x0, [x8, #0x9f8]
adrp x2, #0xb8000
add x2, x2, #0x950
bl #0x7d080 // stringWithFormat:
mov x29, x29
bl #0x76468
stur x0, [x29, #-24]
mov x2, x0
ldur x0, [x29, #-8]
bl #0x7d000 // stringForKey:
mov x29, x29
bl #0x76468
stur x0, [x29, #-32]
cbz x0, generate_identity
adrp x8, #0xcb000
ldr x0, [x8, #0xae8]
bl #0x76330 // objc_alloc(NSUUID)
ldur x2, [x29, #-32]
bl #0x79040 // initWithUUIDString: validates all UUID characters
cbz x0, generate_identity
bl #0x76438 // release validated UUID, keep the stored string
b publish_identity
generate_identity:
adrp x8, #0xcb000
ldr x0, [x8, #0xae8]
bl #0x76800 // UUID: autoreleased, used synchronously
bl #0x76820 // UUIDString
mov x29, x29
bl #0x76468
ldur x8, [x29, #-32]
stur x0, [x29, #-32]
mov x0, x8
bl #0x76438 // release missing/invalid saved string
ldur x0, [x29, #-8]
ldur x2, [x29, #-32]
ldur x3, [x29, #-24]
bl #0x7bae0 // setObject:forKey: only on first use or invalid saved data
ldur x0, [x29, #-8]
bl #0x7d500 // synchronize, preserve the archive's persistence behavior
publish_identity:
adrp x0, #0xcd000
add x0, x0, #0x7f0
ldur x1, [x29, #-32]
bl #0x764a4 // objc_storeStrong: retain new UUID string, release prior value
ldur x0, [x29, #-32]
bl #0x76438
ldur x0, [x29, #-24]
bl #0x76438
ldur x0, [x29, #-16]
bl #0x76438
ldur x0, [x29, #-8]
bl #0x76438
ldp x29, x30, [sp, #0x50]
add sp, sp, #0x60
ret
