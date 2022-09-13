
obj/boot/boot1.elf:     file format elf32-i386


Disassembly of section .note.gnu.property:

080480d4 <.note.gnu.property>:
 80480d4:	04 00                	add    $0x0,%al
 80480d6:	00 00                	add    %al,(%eax)
 80480d8:	18 00                	sbb    %al,(%eax)
 80480da:	00 00                	add    %al,(%eax)
 80480dc:	05 00 00 00 47       	add    $0x47000000,%eax
 80480e1:	4e                   	dec    %esi
 80480e2:	55                   	push   %ebp
 80480e3:	00 01                	add    %al,(%ecx)
 80480e5:	00 01                	add    %al,(%ecx)
 80480e7:	c0 04 00 00          	rolb   $0x0,(%eax,%eax,1)
 80480eb:	00 01                	add    %al,(%ecx)
 80480ed:	00 00                	add    %al,(%eax)
 80480ef:	00 02                	add    %al,(%edx)
 80480f1:	00 01                	add    %al,(%ecx)
 80480f3:	c0 04 00 00          	rolb   $0x0,(%eax,%eax,1)
 80480f7:	00 01                	add    %al,(%ecx)
 80480f9:	00 00                	add    %al,(%eax)
 80480fb:	00                   	.byte 0x0

Disassembly of section .text:

00007e00 <start>:
	.set SMAP_SIG, 0x0534D4150	# "SMAP"

	.globl start
start:
	.code16
	cli
    7e00:	fa                   	cli    
	cld
    7e01:	fc                   	cld    

00007e02 <seta20.1>:

	/* enable A20 */
seta20.1:
	inb	$0x64, %al
    7e02:	e4 64                	in     $0x64,%al
	testb	$0x2, %al
    7e04:	a8 02                	test   $0x2,%al
	jnz	seta20.1
    7e06:	75 fa                	jne    7e02 <seta20.1>
	movb	$0xd1, %al
    7e08:	b0 d1                	mov    $0xd1,%al
	outb	%al, $0x64
    7e0a:	e6 64                	out    %al,$0x64

00007e0c <seta20.2>:
seta20.2:
	inb	$0x64, %al
    7e0c:	e4 64                	in     $0x64,%al
	testb	$0x2, %al
    7e0e:	a8 02                	test   $0x2,%al
	jnz	seta20.2
    7e10:	75 fa                	jne    7e0c <seta20.2>
	movb	$0xdf, %al
    7e12:	b0 df                	mov    $0xdf,%al
	outb	%al, $0x60
    7e14:	e6 60                	out    %al,$0x60

00007e16 <set_video_mode.2>:

	/*
	 * print starting message
	 */
set_video_mode.2:
	movw	$STARTUP_MSG, %si
    7e16:	be ab 7e e8 81       	mov    $0x81e87eab,%esi
	call	putstr
    7e1b:	00               	add    %ah,0x31(%esi)

00007e1c <e820>:

	/*
	 * detect the physical memory map
	 */
e820:
	xorl	%ebx, %ebx		# ebx must be 0 when first calling e820
    7e1c:	66 31 db             	xor    %bx,%bx
	movl	$SMAP_SIG, %edx		# edx must be 'SMAP' when calling e820
    7e1f:	66 ba 50 41          	mov    $0x4150,%dx
    7e23:	4d                   	dec    %ebp
    7e24:	53                   	push   %ebx
	movw	$(smap + 4), %di	# set the address of the output buffer
    7e25:	bf 2a 7f         	mov    $0xb9667f2a,%edi

00007e28 <e820.1>:
e820.1:
	movl	$20, %ecx		# set the size of the output buffer
    7e28:	66 b9 14 00          	mov    $0x14,%cx
    7e2c:	00 00                	add    %al,(%eax)
	movl	$0xe820, %eax		# set the BIOS service code
    7e2e:	66 b8 20 e8          	mov    $0xe820,%ax
    7e32:	00 00                	add    %al,(%eax)
	int	$0x15			# call BIOS service e820h
    7e34:	cd 15                	int    $0x15

00007e36 <e820.2>:
e820.2:
	jc	e820.fail		# error during e820h
    7e36:	72 24                	jb     7e5c <e820.fail>
	cmpl	$SMAP_SIG, %eax		# check eax, which should be 'SMAP'
    7e38:	66 3d 50 41          	cmp    $0x4150,%ax
    7e3c:	4d                   	dec    %ebp
    7e3d:	53                   	push   %ebx
	jne	e820.fail
    7e3e:	75 1c                	jne    7e5c <e820.fail>

00007e40 <e820.3>:
e820.3:
	movl	$20, -4(%di)
    7e40:	66 c7 45 fc 14 00    	movw   $0x14,-0x4(%ebp)
    7e46:	00 00                	add    %al,(%eax)
	addw	$24, %di
    7e48:	83 c7 18             	add    $0x18,%edi
	cmpl	$0x0, %ebx		# whether it's the last descriptor
    7e4b:	66 83 fb 00          	cmp    $0x0,%bx
	je	e820.4
    7e4f:	74 02                	je     7e53 <e820.4>
	jmp	e820.1
    7e51:	eb d5                	jmp    7e28 <e820.1>

00007e53 <e820.4>:
e820.4:					# zero the descriptor after the last one
	xorb	%al, %al
    7e53:	30 c0                	xor    %al,%al
	movw	$20, %cx
    7e55:	b9 14 00 f3 aa       	mov    $0xaaf30014,%ecx
	rep	stosb
	jmp	switch_prot
    7e5a:	eb 09                	jmp    7e65 <switch_prot>

00007e5c <e820.fail>:
e820.fail:
	movw	$E820_FAIL_MSG, %si
    7e5c:	be bd 7e e8 3b       	mov    $0x3be87ebd,%esi
	call	putstr
    7e61:	00 eb                	add    %ch,%bl
	jmp	spin16
    7e63:	00                 	add    %dh,%ah

00007e64 <spin16>:

spin16:
	hlt
    7e64:	f4                   	hlt    

00007e65 <switch_prot>:

	/*
	 * load the bootstrap GDT
	 */
switch_prot:
	lgdt	gdtdesc
    7e65:	0f 01 16             	lgdtl  (%esi)
    7e68:	20 7f 0f             	and    %bh,0xf(%edi)
	movl	%cr0, %eax
    7e6b:	20 c0                	and    %al,%al
	orl	$CR0_PE_ON, %eax
    7e6d:	66 83 c8 01          	or     $0x1,%ax
	movl	%eax, %cr0
    7e71:	0f 22 c0             	mov    %eax,%cr0
	/*
	 * switch to the protected mode
	 */
	ljmp	$PROT_MODE_CSEG, $protcseg
    7e74:	ea 79 7e 08 00   	ljmp   $0xb866,$0x87e79

00007e79 <protcseg>:

	.code32
protcseg:
	movw	$PROT_MODE_DSEG, %ax
    7e79:	66 b8 10 00          	mov    $0x10,%ax
	movw	%ax, %ds
    7e7d:	8e d8                	mov    %eax,%ds
	movw	%ax, %es
    7e7f:	8e c0                	mov    %eax,%es
	movw	%ax, %fs
    7e81:	8e e0                	mov    %eax,%fs
	movw	%ax, %gs
    7e83:	8e e8                	mov    %eax,%gs
	movw	%ax, %ss
    7e85:	8e d0                	mov    %eax,%ss

	/*
	 * jump to the C part
	 * (dev, lba, smap)
	 */
	pushl	$smap
    7e87:	68 26 7f 00 00       	push   $0x7f26
	pushl	$BOOT0
    7e8c:	68 00 7c 00 00       	push   $0x7c00
	movl	(BOOT0 - 4), %eax
    7e91:	a1 fc 7b 00 00       	mov    0x7bfc,%eax
	pushl	%eax
    7e96:	50                   	push   %eax
	call	boot1main
    7e97:	e8 d9 0f 00 00       	call   8e75 <boot1main>

00007e9c <spin>:

spin:
	hlt
    7e9c:	f4                   	hlt    

00007e9d <putstr>:
/*
 * print a string (@ %si) to the screen
 */
	.globl putstr
putstr:
	pusha
    7e9d:	60                   	pusha  
	movb	$0xe, %ah
    7e9e:	b4 0e                	mov    $0xe,%ah

00007ea0 <putstr.1>:
putstr.1:
	lodsb
    7ea0:	ac                   	lods   %ds:(%esi),%al
	cmp	$0, %al
    7ea1:	3c 00                	cmp    $0x0,%al
	je	putstr.2
    7ea3:	74 04                	je     7ea9 <putstr.2>
	int	$0x10
    7ea5:	cd 10                	int    $0x10
	jmp	putstr.1
    7ea7:	eb f7                	jmp    7ea0 <putstr.1>

00007ea9 <putstr.2>:
putstr.2:
	popa
    7ea9:	61                   	popa   
	ret
    7eaa:	c3                   	ret    

00007eab <STARTUP_MSG>:
    7eab:	53                   	push   %ebx
    7eac:	74 61                	je     7f0f <gdt+0x17>
    7eae:	72 74                	jb     7f24 <gdtdesc+0x4>
    7eb0:	20 62 6f             	and    %ah,0x6f(%edx)
    7eb3:	6f                   	outsl  %ds:(%esi),(%dx)
    7eb4:	74 31                	je     7ee7 <NO_BOOTABLE_MSG+0x8>
    7eb6:	20 2e                	and    %ch,(%esi)
    7eb8:	2e 2e 0d 0a 00   	cs cs or $0x7265000a,%eax

00007ebd <E820_FAIL_MSG>:
    7ebd:	65 72 72             	gs jb  7f32 <smap+0xc>
    7ec0:	6f                   	outsl  %ds:(%esi),(%dx)
    7ec1:	72 20                	jb     7ee3 <NO_BOOTABLE_MSG+0x4>
    7ec3:	77 68                	ja     7f2d <smap+0x7>
    7ec5:	65 6e                	outsb  %gs:(%esi),(%dx)
    7ec7:	20 64 65 74          	and    %ah,0x74(%ebp,%eiz,2)
    7ecb:	65 63 74 69 6e       	arpl   %si,%gs:0x6e(%ecx,%ebp,2)
    7ed0:	67 20 6d 65          	and    %ch,0x65(%di)
    7ed4:	6d                   	insl   (%dx),%es:(%edi)
    7ed5:	6f                   	outsl  %ds:(%esi),(%dx)
    7ed6:	72 79                	jb     7f51 <smap+0x2b>
    7ed8:	20 6d 61             	and    %ch,0x61(%ebp)
    7edb:	70 0d                	jo     7eea <NO_BOOTABLE_MSG+0xb>
    7edd:	0a 00                	or     (%eax),%al

00007edf <NO_BOOTABLE_MSG>:
    7edf:	4e                   	dec    %esi
    7ee0:	6f                   	outsl  %ds:(%esi),(%dx)
    7ee1:	20 62 6f             	and    %ah,0x6f(%edx)
    7ee4:	6f                   	outsl  %ds:(%esi),(%dx)
    7ee5:	74 61                	je     7f48 <smap+0x22>
    7ee7:	62 6c 65 20          	bound  %ebp,0x20(%ebp,%eiz,2)
    7eeb:	70 61                	jo     7f4e <smap+0x28>
    7eed:	72 74                	jb     7f63 <smap+0x3d>
    7eef:	69 74 69 6f 6e 2e 0d 	imul   $0xa0d2e6e,0x6f(%ecx,%ebp,2),%esi
    7ef6:	0a 
    7ef7:	00                 	add    %al,(%eax)

00007ef8 <gdt>:
    7ef8:	00 00                	add    %al,(%eax)
    7efa:	00 00                	add    %al,(%eax)
    7efc:	00 00                	add    %al,(%eax)
    7efe:	00 00                	add    %al,(%eax)
    7f00:	ff                   	(bad)  
    7f01:	ff 00                	incl   (%eax)
    7f03:	00 00                	add    %al,(%eax)
    7f05:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7f0c:	00 92 cf 00 ff ff    	add    %dl,-0xff31(%edx)
    7f12:	00 00                	add    %al,(%eax)
    7f14:	00 9e 00 00 ff ff    	add    %bl,-0x10000(%esi)
    7f1a:	00 00                	add    %al,(%eax)
    7f1c:	00 92 00 00      	add    %dl,0x270000(%edx)

00007f20 <gdtdesc>:
    7f20:	27                   	daa    
    7f21:	00 f8                	add    %bh,%al
    7f23:	7e 00                	jle    7f25 <gdtdesc+0x5>
    7f25:	00                 	add    %al,(%eax)

00007f26 <smap>:
    7f26:	00 00                	add    %al,(%eax)
    7f28:	00 00                	add    %al,(%eax)
    7f2a:	00 00                	add    %al,(%eax)
    7f2c:	00 00                	add    %al,(%eax)
    7f2e:	00 00                	add    %al,(%eax)
    7f30:	00 00                	add    %al,(%eax)
    7f32:	00 00                	add    %al,(%eax)
    7f34:	00 00                	add    %al,(%eax)
    7f36:	00 00                	add    %al,(%eax)
    7f38:	00 00                	add    %al,(%eax)
    7f3a:	00 00                	add    %al,(%eax)
    7f3c:	00 00                	add    %al,(%eax)
    7f3e:	00 00                	add    %al,(%eax)
    7f40:	00 00                	add    %al,(%eax)
    7f42:	00 00                	add    %al,(%eax)
    7f44:	00 00                	add    %al,(%eax)
    7f46:	00 00                	add    %al,(%eax)
    7f48:	00 00                	add    %al,(%eax)
    7f4a:	00 00                	add    %al,(%eax)
    7f4c:	00 00                	add    %al,(%eax)
    7f4e:	00 00                	add    %al,(%eax)
    7f50:	00 00                	add    %al,(%eax)
    7f52:	00 00                	add    %al,(%eax)
    7f54:	00 00                	add    %al,(%eax)
    7f56:	00 00                	add    %al,(%eax)
    7f58:	00 00                	add    %al,(%eax)
    7f5a:	00 00                	add    %al,(%eax)
    7f5c:	00 00                	add    %al,(%eax)
    7f5e:	00 00                	add    %al,(%eax)
    7f60:	00 00                	add    %al,(%eax)
    7f62:	00 00                	add    %al,(%eax)
    7f64:	00 00                	add    %al,(%eax)
    7f66:	00 00                	add    %al,(%eax)
    7f68:	00 00                	add    %al,(%eax)
    7f6a:	00 00                	add    %al,(%eax)
    7f6c:	00 00                	add    %al,(%eax)
    7f6e:	00 00                	add    %al,(%eax)
    7f70:	00 00                	add    %al,(%eax)
    7f72:	00 00                	add    %al,(%eax)
    7f74:	00 00                	add    %al,(%eax)
    7f76:	00 00                	add    %al,(%eax)
    7f78:	00 00                	add    %al,(%eax)
    7f7a:	00 00                	add    %al,(%eax)
    7f7c:	00 00                	add    %al,(%eax)
    7f7e:	00 00                	add    %al,(%eax)
    7f80:	00 00                	add    %al,(%eax)
    7f82:	00 00                	add    %al,(%eax)
    7f84:	00 00                	add    %al,(%eax)
    7f86:	00 00                	add    %al,(%eax)
    7f88:	00 00                	add    %al,(%eax)
    7f8a:	00 00                	add    %al,(%eax)
    7f8c:	00 00                	add    %al,(%eax)
    7f8e:	00 00                	add    %al,(%eax)
    7f90:	00 00                	add    %al,(%eax)
    7f92:	00 00                	add    %al,(%eax)
    7f94:	00 00                	add    %al,(%eax)
    7f96:	00 00                	add    %al,(%eax)
    7f98:	00 00                	add    %al,(%eax)
    7f9a:	00 00                	add    %al,(%eax)
    7f9c:	00 00                	add    %al,(%eax)
    7f9e:	00 00                	add    %al,(%eax)
    7fa0:	00 00                	add    %al,(%eax)
    7fa2:	00 00                	add    %al,(%eax)
    7fa4:	00 00                	add    %al,(%eax)
    7fa6:	00 00                	add    %al,(%eax)
    7fa8:	00 00                	add    %al,(%eax)
    7faa:	00 00                	add    %al,(%eax)
    7fac:	00 00                	add    %al,(%eax)
    7fae:	00 00                	add    %al,(%eax)
    7fb0:	00 00                	add    %al,(%eax)
    7fb2:	00 00                	add    %al,(%eax)
    7fb4:	00 00                	add    %al,(%eax)
    7fb6:	00 00                	add    %al,(%eax)
    7fb8:	00 00                	add    %al,(%eax)
    7fba:	00 00                	add    %al,(%eax)
    7fbc:	00 00                	add    %al,(%eax)
    7fbe:	00 00                	add    %al,(%eax)
    7fc0:	00 00                	add    %al,(%eax)
    7fc2:	00 00                	add    %al,(%eax)
    7fc4:	00 00                	add    %al,(%eax)
    7fc6:	00 00                	add    %al,(%eax)
    7fc8:	00 00                	add    %al,(%eax)
    7fca:	00 00                	add    %al,(%eax)
    7fcc:	00 00                	add    %al,(%eax)
    7fce:	00 00                	add    %al,(%eax)
    7fd0:	00 00                	add    %al,(%eax)
    7fd2:	00 00                	add    %al,(%eax)
    7fd4:	00 00                	add    %al,(%eax)
    7fd6:	00 00                	add    %al,(%eax)
    7fd8:	00 00                	add    %al,(%eax)
    7fda:	00 00                	add    %al,(%eax)
    7fdc:	00 00                	add    %al,(%eax)
    7fde:	00 00                	add    %al,(%eax)
    7fe0:	00 00                	add    %al,(%eax)
    7fe2:	00 00                	add    %al,(%eax)
    7fe4:	00 00                	add    %al,(%eax)
    7fe6:	00 00                	add    %al,(%eax)
    7fe8:	00 00                	add    %al,(%eax)
    7fea:	00 00                	add    %al,(%eax)
    7fec:	00 00                	add    %al,(%eax)
    7fee:	00 00                	add    %al,(%eax)
    7ff0:	00 00                	add    %al,(%eax)
    7ff2:	00 00                	add    %al,(%eax)
    7ff4:	00 00                	add    %al,(%eax)
    7ff6:	00 00                	add    %al,(%eax)
    7ff8:	00 00                	add    %al,(%eax)
    7ffa:	00 00                	add    %al,(%eax)
    7ffc:	00 00                	add    %al,(%eax)
    7ffe:	00 00                	add    %al,(%eax)
    8000:	00 00                	add    %al,(%eax)
    8002:	00 00                	add    %al,(%eax)
    8004:	00 00                	add    %al,(%eax)
    8006:	00 00                	add    %al,(%eax)
    8008:	00 00                	add    %al,(%eax)
    800a:	00 00                	add    %al,(%eax)
    800c:	00 00                	add    %al,(%eax)
    800e:	00 00                	add    %al,(%eax)
    8010:	00 00                	add    %al,(%eax)
    8012:	00 00                	add    %al,(%eax)
    8014:	00 00                	add    %al,(%eax)
    8016:	00 00                	add    %al,(%eax)
    8018:	00 00                	add    %al,(%eax)
    801a:	00 00                	add    %al,(%eax)
    801c:	00 00                	add    %al,(%eax)
    801e:	00 00                	add    %al,(%eax)
    8020:	00 00                	add    %al,(%eax)
    8022:	00 00                	add    %al,(%eax)
    8024:	00 00                	add    %al,(%eax)
    8026:	00 00                	add    %al,(%eax)
    8028:	00 00                	add    %al,(%eax)
    802a:	00 00                	add    %al,(%eax)
    802c:	00 00                	add    %al,(%eax)
    802e:	00 00                	add    %al,(%eax)
    8030:	00 00                	add    %al,(%eax)
    8032:	00 00                	add    %al,(%eax)
    8034:	00 00                	add    %al,(%eax)
    8036:	00 00                	add    %al,(%eax)
    8038:	00 00                	add    %al,(%eax)
    803a:	00 00                	add    %al,(%eax)
    803c:	00 00                	add    %al,(%eax)
    803e:	00 00                	add    %al,(%eax)
    8040:	00 00                	add    %al,(%eax)
    8042:	00 00                	add    %al,(%eax)
    8044:	00 00                	add    %al,(%eax)
    8046:	00 00                	add    %al,(%eax)
    8048:	00 00                	add    %al,(%eax)
    804a:	00 00                	add    %al,(%eax)
    804c:	00 00                	add    %al,(%eax)
    804e:	00 00                	add    %al,(%eax)
    8050:	00 00                	add    %al,(%eax)
    8052:	00 00                	add    %al,(%eax)
    8054:	00 00                	add    %al,(%eax)
    8056:	00 00                	add    %al,(%eax)
    8058:	00 00                	add    %al,(%eax)
    805a:	00 00                	add    %al,(%eax)
    805c:	00 00                	add    %al,(%eax)
    805e:	00 00                	add    %al,(%eax)
    8060:	00 00                	add    %al,(%eax)
    8062:	00 00                	add    %al,(%eax)
    8064:	00 00                	add    %al,(%eax)
    8066:	00 00                	add    %al,(%eax)
    8068:	00 00                	add    %al,(%eax)
    806a:	00 00                	add    %al,(%eax)
    806c:	00 00                	add    %al,(%eax)
    806e:	00 00                	add    %al,(%eax)
    8070:	00 00                	add    %al,(%eax)
    8072:	00 00                	add    %al,(%eax)
    8074:	00 00                	add    %al,(%eax)
    8076:	00 00                	add    %al,(%eax)
    8078:	00 00                	add    %al,(%eax)
    807a:	00 00                	add    %al,(%eax)
    807c:	00 00                	add    %al,(%eax)
    807e:	00 00                	add    %al,(%eax)
    8080:	00 00                	add    %al,(%eax)
    8082:	00 00                	add    %al,(%eax)
    8084:	00 00                	add    %al,(%eax)
    8086:	00 00                	add    %al,(%eax)
    8088:	00 00                	add    %al,(%eax)
    808a:	00 00                	add    %al,(%eax)
    808c:	00 00                	add    %al,(%eax)
    808e:	00 00                	add    %al,(%eax)
    8090:	00 00                	add    %al,(%eax)
    8092:	00 00                	add    %al,(%eax)
    8094:	00 00                	add    %al,(%eax)
    8096:	00 00                	add    %al,(%eax)
    8098:	00 00                	add    %al,(%eax)
    809a:	00 00                	add    %al,(%eax)
    809c:	00 00                	add    %al,(%eax)
    809e:	00 00                	add    %al,(%eax)
    80a0:	00 00                	add    %al,(%eax)
    80a2:	00 00                	add    %al,(%eax)
    80a4:	00 00                	add    %al,(%eax)
    80a6:	00 00                	add    %al,(%eax)
    80a8:	00 00                	add    %al,(%eax)
    80aa:	00 00                	add    %al,(%eax)
    80ac:	00 00                	add    %al,(%eax)
    80ae:	00 00                	add    %al,(%eax)
    80b0:	00 00                	add    %al,(%eax)
    80b2:	00 00                	add    %al,(%eax)
    80b4:	00 00                	add    %al,(%eax)
    80b6:	00 00                	add    %al,(%eax)
    80b8:	00 00                	add    %al,(%eax)
    80ba:	00 00                	add    %al,(%eax)
    80bc:	00 00                	add    %al,(%eax)
    80be:	00 00                	add    %al,(%eax)
    80c0:	00 00                	add    %al,(%eax)
    80c2:	00 00                	add    %al,(%eax)
    80c4:	00 00                	add    %al,(%eax)
    80c6:	00 00                	add    %al,(%eax)
    80c8:	00 00                	add    %al,(%eax)
    80ca:	00 00                	add    %al,(%eax)
    80cc:	00 00                	add    %al,(%eax)
    80ce:	00 00                	add    %al,(%eax)
    80d0:	00 00                	add    %al,(%eax)
    80d2:	00 00                	add    %al,(%eax)
    80d4:	00 00                	add    %al,(%eax)
    80d6:	00 00                	add    %al,(%eax)
    80d8:	00 00                	add    %al,(%eax)
    80da:	00 00                	add    %al,(%eax)
    80dc:	00 00                	add    %al,(%eax)
    80de:	00 00                	add    %al,(%eax)
    80e0:	00 00                	add    %al,(%eax)
    80e2:	00 00                	add    %al,(%eax)
    80e4:	00 00                	add    %al,(%eax)
    80e6:	00 00                	add    %al,(%eax)
    80e8:	00 00                	add    %al,(%eax)
    80ea:	00 00                	add    %al,(%eax)
    80ec:	00 00                	add    %al,(%eax)
    80ee:	00 00                	add    %al,(%eax)
    80f0:	00 00                	add    %al,(%eax)
    80f2:	00 00                	add    %al,(%eax)
    80f4:	00 00                	add    %al,(%eax)
    80f6:	00 00                	add    %al,(%eax)
    80f8:	00 00                	add    %al,(%eax)
    80fa:	00 00                	add    %al,(%eax)
    80fc:	00 00                	add    %al,(%eax)
    80fe:	00 00                	add    %al,(%eax)
    8100:	00 00                	add    %al,(%eax)
    8102:	00 00                	add    %al,(%eax)
    8104:	00 00                	add    %al,(%eax)
    8106:	00 00                	add    %al,(%eax)
    8108:	00 00                	add    %al,(%eax)
    810a:	00 00                	add    %al,(%eax)
    810c:	00 00                	add    %al,(%eax)
    810e:	00 00                	add    %al,(%eax)
    8110:	00 00                	add    %al,(%eax)
    8112:	00 00                	add    %al,(%eax)
    8114:	00 00                	add    %al,(%eax)
    8116:	00 00                	add    %al,(%eax)
    8118:	00 00                	add    %al,(%eax)
    811a:	00 00                	add    %al,(%eax)
    811c:	00 00                	add    %al,(%eax)
    811e:	00 00                	add    %al,(%eax)
    8120:	00 00                	add    %al,(%eax)
    8122:	00 00                	add    %al,(%eax)
    8124:	00 00                	add    %al,(%eax)
    8126:	00 00                	add    %al,(%eax)
    8128:	00 00                	add    %al,(%eax)
    812a:	00 00                	add    %al,(%eax)
    812c:	00 00                	add    %al,(%eax)
    812e:	00 00                	add    %al,(%eax)
    8130:	00 00                	add    %al,(%eax)
    8132:	00 00                	add    %al,(%eax)
    8134:	00 00                	add    %al,(%eax)
    8136:	00 00                	add    %al,(%eax)
    8138:	00 00                	add    %al,(%eax)
    813a:	00 00                	add    %al,(%eax)
    813c:	00 00                	add    %al,(%eax)
    813e:	00 00                	add    %al,(%eax)
    8140:	00 00                	add    %al,(%eax)
    8142:	00 00                	add    %al,(%eax)
    8144:	00 00                	add    %al,(%eax)
    8146:	00 00                	add    %al,(%eax)
    8148:	00 00                	add    %al,(%eax)
    814a:	00 00                	add    %al,(%eax)
    814c:	00 00                	add    %al,(%eax)
    814e:	00 00                	add    %al,(%eax)
    8150:	00 00                	add    %al,(%eax)
    8152:	00 00                	add    %al,(%eax)
    8154:	00 00                	add    %al,(%eax)
    8156:	00 00                	add    %al,(%eax)
    8158:	00 00                	add    %al,(%eax)
    815a:	00 00                	add    %al,(%eax)
    815c:	00 00                	add    %al,(%eax)
    815e:	00 00                	add    %al,(%eax)
    8160:	00 00                	add    %al,(%eax)
    8162:	00 00                	add    %al,(%eax)
    8164:	00 00                	add    %al,(%eax)
    8166:	00 00                	add    %al,(%eax)
    8168:	00 00                	add    %al,(%eax)
    816a:	00 00                	add    %al,(%eax)
    816c:	00 00                	add    %al,(%eax)
    816e:	00 00                	add    %al,(%eax)
    8170:	00 00                	add    %al,(%eax)
    8172:	00 00                	add    %al,(%eax)
    8174:	00 00                	add    %al,(%eax)
    8176:	00 00                	add    %al,(%eax)
    8178:	00 00                	add    %al,(%eax)
    817a:	00 00                	add    %al,(%eax)
    817c:	00 00                	add    %al,(%eax)
    817e:	00 00                	add    %al,(%eax)
    8180:	00 00                	add    %al,(%eax)
    8182:	00 00                	add    %al,(%eax)
    8184:	00 00                	add    %al,(%eax)
    8186:	00 00                	add    %al,(%eax)
    8188:	00 00                	add    %al,(%eax)
    818a:	00 00                	add    %al,(%eax)
    818c:	00 00                	add    %al,(%eax)
    818e:	00 00                	add    %al,(%eax)
    8190:	00 00                	add    %al,(%eax)
    8192:	00 00                	add    %al,(%eax)
    8194:	00 00                	add    %al,(%eax)
    8196:	00 00                	add    %al,(%eax)
    8198:	00 00                	add    %al,(%eax)
    819a:	00 00                	add    %al,(%eax)
    819c:	00 00                	add    %al,(%eax)
    819e:	00 00                	add    %al,(%eax)
    81a0:	00 00                	add    %al,(%eax)
    81a2:	00 00                	add    %al,(%eax)
    81a4:	00 00                	add    %al,(%eax)
    81a6:	00 00                	add    %al,(%eax)
    81a8:	00 00                	add    %al,(%eax)
    81aa:	00 00                	add    %al,(%eax)
    81ac:	00 00                	add    %al,(%eax)
    81ae:	00 00                	add    %al,(%eax)
    81b0:	00 00                	add    %al,(%eax)
    81b2:	00 00                	add    %al,(%eax)
    81b4:	00 00                	add    %al,(%eax)
    81b6:	00 00                	add    %al,(%eax)
    81b8:	00 00                	add    %al,(%eax)
    81ba:	00 00                	add    %al,(%eax)
    81bc:	00 00                	add    %al,(%eax)
    81be:	00 00                	add    %al,(%eax)
    81c0:	00 00                	add    %al,(%eax)
    81c2:	00 00                	add    %al,(%eax)
    81c4:	00 00                	add    %al,(%eax)
    81c6:	00 00                	add    %al,(%eax)
    81c8:	00 00                	add    %al,(%eax)
    81ca:	00 00                	add    %al,(%eax)
    81cc:	00 00                	add    %al,(%eax)
    81ce:	00 00                	add    %al,(%eax)
    81d0:	00 00                	add    %al,(%eax)
    81d2:	00 00                	add    %al,(%eax)
    81d4:	00 00                	add    %al,(%eax)
    81d6:	00 00                	add    %al,(%eax)
    81d8:	00 00                	add    %al,(%eax)
    81da:	00 00                	add    %al,(%eax)
    81dc:	00 00                	add    %al,(%eax)
    81de:	00 00                	add    %al,(%eax)
    81e0:	00 00                	add    %al,(%eax)
    81e2:	00 00                	add    %al,(%eax)
    81e4:	00 00                	add    %al,(%eax)
    81e6:	00 00                	add    %al,(%eax)
    81e8:	00 00                	add    %al,(%eax)
    81ea:	00 00                	add    %al,(%eax)
    81ec:	00 00                	add    %al,(%eax)
    81ee:	00 00                	add    %al,(%eax)
    81f0:	00 00                	add    %al,(%eax)
    81f2:	00 00                	add    %al,(%eax)
    81f4:	00 00                	add    %al,(%eax)
    81f6:	00 00                	add    %al,(%eax)
    81f8:	00 00                	add    %al,(%eax)
    81fa:	00 00                	add    %al,(%eax)
    81fc:	00 00                	add    %al,(%eax)
    81fe:	00 00                	add    %al,(%eax)
    8200:	00 00                	add    %al,(%eax)
    8202:	00 00                	add    %al,(%eax)
    8204:	00 00                	add    %al,(%eax)
    8206:	00 00                	add    %al,(%eax)
    8208:	00 00                	add    %al,(%eax)
    820a:	00 00                	add    %al,(%eax)
    820c:	00 00                	add    %al,(%eax)
    820e:	00 00                	add    %al,(%eax)
    8210:	00 00                	add    %al,(%eax)
    8212:	00 00                	add    %al,(%eax)
    8214:	00 00                	add    %al,(%eax)
    8216:	00 00                	add    %al,(%eax)
    8218:	00 00                	add    %al,(%eax)
    821a:	00 00                	add    %al,(%eax)
    821c:	00 00                	add    %al,(%eax)
    821e:	00 00                	add    %al,(%eax)
    8220:	00 00                	add    %al,(%eax)
    8222:	00 00                	add    %al,(%eax)
    8224:	00 00                	add    %al,(%eax)
    8226:	00 00                	add    %al,(%eax)
    8228:	00 00                	add    %al,(%eax)
    822a:	00 00                	add    %al,(%eax)
    822c:	00 00                	add    %al,(%eax)
    822e:	00 00                	add    %al,(%eax)
    8230:	00 00                	add    %al,(%eax)
    8232:	00 00                	add    %al,(%eax)
    8234:	00 00                	add    %al,(%eax)
    8236:	00 00                	add    %al,(%eax)
    8238:	00 00                	add    %al,(%eax)
    823a:	00 00                	add    %al,(%eax)
    823c:	00 00                	add    %al,(%eax)
    823e:	00 00                	add    %al,(%eax)
    8240:	00 00                	add    %al,(%eax)
    8242:	00 00                	add    %al,(%eax)
    8244:	00 00                	add    %al,(%eax)
    8246:	00 00                	add    %al,(%eax)
    8248:	00 00                	add    %al,(%eax)
    824a:	00 00                	add    %al,(%eax)
    824c:	00 00                	add    %al,(%eax)
    824e:	00 00                	add    %al,(%eax)
    8250:	00 00                	add    %al,(%eax)
    8252:	00 00                	add    %al,(%eax)
    8254:	00 00                	add    %al,(%eax)
    8256:	00 00                	add    %al,(%eax)
    8258:	00 00                	add    %al,(%eax)
    825a:	00 00                	add    %al,(%eax)
    825c:	00 00                	add    %al,(%eax)
    825e:	00 00                	add    %al,(%eax)
    8260:	00 00                	add    %al,(%eax)
    8262:	00 00                	add    %al,(%eax)
    8264:	00 00                	add    %al,(%eax)
    8266:	00 00                	add    %al,(%eax)
    8268:	00 00                	add    %al,(%eax)
    826a:	00 00                	add    %al,(%eax)
    826c:	00 00                	add    %al,(%eax)
    826e:	00 00                	add    %al,(%eax)
    8270:	00 00                	add    %al,(%eax)
    8272:	00 00                	add    %al,(%eax)
    8274:	00 00                	add    %al,(%eax)
    8276:	00 00                	add    %al,(%eax)
    8278:	00 00                	add    %al,(%eax)
    827a:	00 00                	add    %al,(%eax)
    827c:	00 00                	add    %al,(%eax)
    827e:	00 00                	add    %al,(%eax)
    8280:	00 00                	add    %al,(%eax)
    8282:	00 00                	add    %al,(%eax)
    8284:	00 00                	add    %al,(%eax)
    8286:	00 00                	add    %al,(%eax)
    8288:	00 00                	add    %al,(%eax)
    828a:	00 00                	add    %al,(%eax)
    828c:	00 00                	add    %al,(%eax)
    828e:	00 00                	add    %al,(%eax)
    8290:	00 00                	add    %al,(%eax)
    8292:	00 00                	add    %al,(%eax)
    8294:	00 00                	add    %al,(%eax)
    8296:	00 00                	add    %al,(%eax)
    8298:	00 00                	add    %al,(%eax)
    829a:	00 00                	add    %al,(%eax)
    829c:	00 00                	add    %al,(%eax)
    829e:	00 00                	add    %al,(%eax)
    82a0:	00 00                	add    %al,(%eax)
    82a2:	00 00                	add    %al,(%eax)
    82a4:	00 00                	add    %al,(%eax)
    82a6:	00 00                	add    %al,(%eax)
    82a8:	00 00                	add    %al,(%eax)
    82aa:	00 00                	add    %al,(%eax)
    82ac:	00 00                	add    %al,(%eax)
    82ae:	00 00                	add    %al,(%eax)
    82b0:	00 00                	add    %al,(%eax)
    82b2:	00 00                	add    %al,(%eax)
    82b4:	00 00                	add    %al,(%eax)
    82b6:	00 00                	add    %al,(%eax)
    82b8:	00 00                	add    %al,(%eax)
    82ba:	00 00                	add    %al,(%eax)
    82bc:	00 00                	add    %al,(%eax)
    82be:	00 00                	add    %al,(%eax)
    82c0:	00 00                	add    %al,(%eax)
    82c2:	00 00                	add    %al,(%eax)
    82c4:	00 00                	add    %al,(%eax)
    82c6:	00 00                	add    %al,(%eax)
    82c8:	00 00                	add    %al,(%eax)
    82ca:	00 00                	add    %al,(%eax)
    82cc:	00 00                	add    %al,(%eax)
    82ce:	00 00                	add    %al,(%eax)
    82d0:	00 00                	add    %al,(%eax)
    82d2:	00 00                	add    %al,(%eax)
    82d4:	00 00                	add    %al,(%eax)
    82d6:	00 00                	add    %al,(%eax)
    82d8:	00 00                	add    %al,(%eax)
    82da:	00 00                	add    %al,(%eax)
    82dc:	00 00                	add    %al,(%eax)
    82de:	00 00                	add    %al,(%eax)
    82e0:	00 00                	add    %al,(%eax)
    82e2:	00 00                	add    %al,(%eax)
    82e4:	00 00                	add    %al,(%eax)
    82e6:	00 00                	add    %al,(%eax)
    82e8:	00 00                	add    %al,(%eax)
    82ea:	00 00                	add    %al,(%eax)
    82ec:	00 00                	add    %al,(%eax)
    82ee:	00 00                	add    %al,(%eax)
    82f0:	00 00                	add    %al,(%eax)
    82f2:	00 00                	add    %al,(%eax)
    82f4:	00 00                	add    %al,(%eax)
    82f6:	00 00                	add    %al,(%eax)
    82f8:	00 00                	add    %al,(%eax)
    82fa:	00 00                	add    %al,(%eax)
    82fc:	00 00                	add    %al,(%eax)
    82fe:	00 00                	add    %al,(%eax)
    8300:	00 00                	add    %al,(%eax)
    8302:	00 00                	add    %al,(%eax)
    8304:	00 00                	add    %al,(%eax)
    8306:	00 00                	add    %al,(%eax)
    8308:	00 00                	add    %al,(%eax)
    830a:	00 00                	add    %al,(%eax)
    830c:	00 00                	add    %al,(%eax)
    830e:	00 00                	add    %al,(%eax)
    8310:	00 00                	add    %al,(%eax)
    8312:	00 00                	add    %al,(%eax)
    8314:	00 00                	add    %al,(%eax)
    8316:	00 00                	add    %al,(%eax)
    8318:	00 00                	add    %al,(%eax)
    831a:	00 00                	add    %al,(%eax)
    831c:	00 00                	add    %al,(%eax)
    831e:	00 00                	add    %al,(%eax)
    8320:	00 00                	add    %al,(%eax)
    8322:	00 00                	add    %al,(%eax)
    8324:	00 00                	add    %al,(%eax)
    8326:	00 00                	add    %al,(%eax)
    8328:	00 00                	add    %al,(%eax)
    832a:	00 00                	add    %al,(%eax)
    832c:	00 00                	add    %al,(%eax)
    832e:	00 00                	add    %al,(%eax)
    8330:	00 00                	add    %al,(%eax)
    8332:	00 00                	add    %al,(%eax)
    8334:	00 00                	add    %al,(%eax)
    8336:	00 00                	add    %al,(%eax)
    8338:	00 00                	add    %al,(%eax)
    833a:	00 00                	add    %al,(%eax)
    833c:	00 00                	add    %al,(%eax)
    833e:	00 00                	add    %al,(%eax)
    8340:	00 00                	add    %al,(%eax)
    8342:	00 00                	add    %al,(%eax)
    8344:	00 00                	add    %al,(%eax)
    8346:	00 00                	add    %al,(%eax)
    8348:	00 00                	add    %al,(%eax)
    834a:	00 00                	add    %al,(%eax)
    834c:	00 00                	add    %al,(%eax)
    834e:	00 00                	add    %al,(%eax)
    8350:	00 00                	add    %al,(%eax)
    8352:	00 00                	add    %al,(%eax)
    8354:	00 00                	add    %al,(%eax)
    8356:	00 00                	add    %al,(%eax)
    8358:	00 00                	add    %al,(%eax)
    835a:	00 00                	add    %al,(%eax)
    835c:	00 00                	add    %al,(%eax)
    835e:	00 00                	add    %al,(%eax)
    8360:	00 00                	add    %al,(%eax)
    8362:	00 00                	add    %al,(%eax)
    8364:	00 00                	add    %al,(%eax)
    8366:	00 00                	add    %al,(%eax)
    8368:	00 00                	add    %al,(%eax)
    836a:	00 00                	add    %al,(%eax)
    836c:	00 00                	add    %al,(%eax)
    836e:	00 00                	add    %al,(%eax)
    8370:	00 00                	add    %al,(%eax)
    8372:	00 00                	add    %al,(%eax)
    8374:	00 00                	add    %al,(%eax)
    8376:	00 00                	add    %al,(%eax)
    8378:	00 00                	add    %al,(%eax)
    837a:	00 00                	add    %al,(%eax)
    837c:	00 00                	add    %al,(%eax)
    837e:	00 00                	add    %al,(%eax)
    8380:	00 00                	add    %al,(%eax)
    8382:	00 00                	add    %al,(%eax)
    8384:	00 00                	add    %al,(%eax)
    8386:	00 00                	add    %al,(%eax)
    8388:	00 00                	add    %al,(%eax)
    838a:	00 00                	add    %al,(%eax)
    838c:	00 00                	add    %al,(%eax)
    838e:	00 00                	add    %al,(%eax)
    8390:	00 00                	add    %al,(%eax)
    8392:	00 00                	add    %al,(%eax)
    8394:	00 00                	add    %al,(%eax)
    8396:	00 00                	add    %al,(%eax)
    8398:	00 00                	add    %al,(%eax)
    839a:	00 00                	add    %al,(%eax)
    839c:	00 00                	add    %al,(%eax)
    839e:	00 00                	add    %al,(%eax)
    83a0:	00 00                	add    %al,(%eax)
    83a2:	00 00                	add    %al,(%eax)
    83a4:	00 00                	add    %al,(%eax)
    83a6:	00 00                	add    %al,(%eax)
    83a8:	00 00                	add    %al,(%eax)
    83aa:	00 00                	add    %al,(%eax)
    83ac:	00 00                	add    %al,(%eax)
    83ae:	00 00                	add    %al,(%eax)
    83b0:	00 00                	add    %al,(%eax)
    83b2:	00 00                	add    %al,(%eax)
    83b4:	00 00                	add    %al,(%eax)
    83b6:	00 00                	add    %al,(%eax)
    83b8:	00 00                	add    %al,(%eax)
    83ba:	00 00                	add    %al,(%eax)
    83bc:	00 00                	add    %al,(%eax)
    83be:	00 00                	add    %al,(%eax)
    83c0:	00 00                	add    %al,(%eax)
    83c2:	00 00                	add    %al,(%eax)
    83c4:	00 00                	add    %al,(%eax)
    83c6:	00 00                	add    %al,(%eax)
    83c8:	00 00                	add    %al,(%eax)
    83ca:	00 00                	add    %al,(%eax)
    83cc:	00 00                	add    %al,(%eax)
    83ce:	00 00                	add    %al,(%eax)
    83d0:	00 00                	add    %al,(%eax)
    83d2:	00 00                	add    %al,(%eax)
    83d4:	00 00                	add    %al,(%eax)
    83d6:	00 00                	add    %al,(%eax)
    83d8:	00 00                	add    %al,(%eax)
    83da:	00 00                	add    %al,(%eax)
    83dc:	00 00                	add    %al,(%eax)
    83de:	00 00                	add    %al,(%eax)
    83e0:	00 00                	add    %al,(%eax)
    83e2:	00 00                	add    %al,(%eax)
    83e4:	00 00                	add    %al,(%eax)
    83e6:	00 00                	add    %al,(%eax)
    83e8:	00 00                	add    %al,(%eax)
    83ea:	00 00                	add    %al,(%eax)
    83ec:	00 00                	add    %al,(%eax)
    83ee:	00 00                	add    %al,(%eax)
    83f0:	00 00                	add    %al,(%eax)
    83f2:	00 00                	add    %al,(%eax)
    83f4:	00 00                	add    %al,(%eax)
    83f6:	00 00                	add    %al,(%eax)
    83f8:	00 00                	add    %al,(%eax)
    83fa:	00 00                	add    %al,(%eax)
    83fc:	00 00                	add    %al,(%eax)
    83fe:	00 00                	add    %al,(%eax)
    8400:	00 00                	add    %al,(%eax)
    8402:	00 00                	add    %al,(%eax)
    8404:	00 00                	add    %al,(%eax)
    8406:	00 00                	add    %al,(%eax)
    8408:	00 00                	add    %al,(%eax)
    840a:	00 00                	add    %al,(%eax)
    840c:	00 00                	add    %al,(%eax)
    840e:	00 00                	add    %al,(%eax)
    8410:	00 00                	add    %al,(%eax)
    8412:	00 00                	add    %al,(%eax)
    8414:	00 00                	add    %al,(%eax)
    8416:	00 00                	add    %al,(%eax)
    8418:	00 00                	add    %al,(%eax)
    841a:	00 00                	add    %al,(%eax)
    841c:	00 00                	add    %al,(%eax)
    841e:	00 00                	add    %al,(%eax)
    8420:	00 00                	add    %al,(%eax)
    8422:	00 00                	add    %al,(%eax)
    8424:	00 00                	add    %al,(%eax)
    8426:	00 00                	add    %al,(%eax)
    8428:	00 00                	add    %al,(%eax)
    842a:	00 00                	add    %al,(%eax)
    842c:	00 00                	add    %al,(%eax)
    842e:	00 00                	add    %al,(%eax)
    8430:	00 00                	add    %al,(%eax)
    8432:	00 00                	add    %al,(%eax)
    8434:	00 00                	add    %al,(%eax)
    8436:	00 00                	add    %al,(%eax)
    8438:	00 00                	add    %al,(%eax)
    843a:	00 00                	add    %al,(%eax)
    843c:	00 00                	add    %al,(%eax)
    843e:	00 00                	add    %al,(%eax)
    8440:	00 00                	add    %al,(%eax)
    8442:	00 00                	add    %al,(%eax)
    8444:	00 00                	add    %al,(%eax)
    8446:	00 00                	add    %al,(%eax)
    8448:	00 00                	add    %al,(%eax)
    844a:	00 00                	add    %al,(%eax)
    844c:	00 00                	add    %al,(%eax)
    844e:	00 00                	add    %al,(%eax)
    8450:	00 00                	add    %al,(%eax)
    8452:	00 00                	add    %al,(%eax)
    8454:	00 00                	add    %al,(%eax)
    8456:	00 00                	add    %al,(%eax)
    8458:	00 00                	add    %al,(%eax)
    845a:	00 00                	add    %al,(%eax)
    845c:	00 00                	add    %al,(%eax)
    845e:	00 00                	add    %al,(%eax)
    8460:	00 00                	add    %al,(%eax)
    8462:	00 00                	add    %al,(%eax)
    8464:	00 00                	add    %al,(%eax)
    8466:	00 00                	add    %al,(%eax)
    8468:	00 00                	add    %al,(%eax)
    846a:	00 00                	add    %al,(%eax)
    846c:	00 00                	add    %al,(%eax)
    846e:	00 00                	add    %al,(%eax)
    8470:	00 00                	add    %al,(%eax)
    8472:	00 00                	add    %al,(%eax)
    8474:	00 00                	add    %al,(%eax)
    8476:	00 00                	add    %al,(%eax)
    8478:	00 00                	add    %al,(%eax)
    847a:	00 00                	add    %al,(%eax)
    847c:	00 00                	add    %al,(%eax)
    847e:	00 00                	add    %al,(%eax)
    8480:	00 00                	add    %al,(%eax)
    8482:	00 00                	add    %al,(%eax)
    8484:	00 00                	add    %al,(%eax)
    8486:	00 00                	add    %al,(%eax)
    8488:	00 00                	add    %al,(%eax)
    848a:	00 00                	add    %al,(%eax)
    848c:	00 00                	add    %al,(%eax)
    848e:	00 00                	add    %al,(%eax)
    8490:	00 00                	add    %al,(%eax)
    8492:	00 00                	add    %al,(%eax)
    8494:	00 00                	add    %al,(%eax)
    8496:	00 00                	add    %al,(%eax)
    8498:	00 00                	add    %al,(%eax)
    849a:	00 00                	add    %al,(%eax)
    849c:	00 00                	add    %al,(%eax)
    849e:	00 00                	add    %al,(%eax)
    84a0:	00 00                	add    %al,(%eax)
    84a2:	00 00                	add    %al,(%eax)
    84a4:	00 00                	add    %al,(%eax)
    84a6:	00 00                	add    %al,(%eax)
    84a8:	00 00                	add    %al,(%eax)
    84aa:	00 00                	add    %al,(%eax)
    84ac:	00 00                	add    %al,(%eax)
    84ae:	00 00                	add    %al,(%eax)
    84b0:	00 00                	add    %al,(%eax)
    84b2:	00 00                	add    %al,(%eax)
    84b4:	00 00                	add    %al,(%eax)
    84b6:	00 00                	add    %al,(%eax)
    84b8:	00 00                	add    %al,(%eax)
    84ba:	00 00                	add    %al,(%eax)
    84bc:	00 00                	add    %al,(%eax)
    84be:	00 00                	add    %al,(%eax)
    84c0:	00 00                	add    %al,(%eax)
    84c2:	00 00                	add    %al,(%eax)
    84c4:	00 00                	add    %al,(%eax)
    84c6:	00 00                	add    %al,(%eax)
    84c8:	00 00                	add    %al,(%eax)
    84ca:	00 00                	add    %al,(%eax)
    84cc:	00 00                	add    %al,(%eax)
    84ce:	00 00                	add    %al,(%eax)
    84d0:	00 00                	add    %al,(%eax)
    84d2:	00 00                	add    %al,(%eax)
    84d4:	00 00                	add    %al,(%eax)
    84d6:	00 00                	add    %al,(%eax)
    84d8:	00 00                	add    %al,(%eax)
    84da:	00 00                	add    %al,(%eax)
    84dc:	00 00                	add    %al,(%eax)
    84de:	00 00                	add    %al,(%eax)
    84e0:	00 00                	add    %al,(%eax)
    84e2:	00 00                	add    %al,(%eax)
    84e4:	00 00                	add    %al,(%eax)
    84e6:	00 00                	add    %al,(%eax)
    84e8:	00 00                	add    %al,(%eax)
    84ea:	00 00                	add    %al,(%eax)
    84ec:	00 00                	add    %al,(%eax)
    84ee:	00 00                	add    %al,(%eax)
    84f0:	00 00                	add    %al,(%eax)
    84f2:	00 00                	add    %al,(%eax)
    84f4:	00 00                	add    %al,(%eax)
    84f6:	00 00                	add    %al,(%eax)
    84f8:	00 00                	add    %al,(%eax)
    84fa:	00 00                	add    %al,(%eax)
    84fc:	00 00                	add    %al,(%eax)
    84fe:	00 00                	add    %al,(%eax)
    8500:	00 00                	add    %al,(%eax)
    8502:	00 00                	add    %al,(%eax)
    8504:	00 00                	add    %al,(%eax)
    8506:	00 00                	add    %al,(%eax)
    8508:	00 00                	add    %al,(%eax)
    850a:	00 00                	add    %al,(%eax)
    850c:	00 00                	add    %al,(%eax)
    850e:	00 00                	add    %al,(%eax)
    8510:	00 00                	add    %al,(%eax)
    8512:	00 00                	add    %al,(%eax)
    8514:	00 00                	add    %al,(%eax)
    8516:	00 00                	add    %al,(%eax)
    8518:	00 00                	add    %al,(%eax)
    851a:	00 00                	add    %al,(%eax)
    851c:	00 00                	add    %al,(%eax)
    851e:	00 00                	add    %al,(%eax)
    8520:	00 00                	add    %al,(%eax)
    8522:	00 00                	add    %al,(%eax)
    8524:	00 00                	add    %al,(%eax)
    8526:	00 00                	add    %al,(%eax)
    8528:	00 00                	add    %al,(%eax)
    852a:	00 00                	add    %al,(%eax)
    852c:	00 00                	add    %al,(%eax)
    852e:	00 00                	add    %al,(%eax)
    8530:	00 00                	add    %al,(%eax)
    8532:	00 00                	add    %al,(%eax)
    8534:	00 00                	add    %al,(%eax)
    8536:	00 00                	add    %al,(%eax)
    8538:	00 00                	add    %al,(%eax)
    853a:	00 00                	add    %al,(%eax)
    853c:	00 00                	add    %al,(%eax)
    853e:	00 00                	add    %al,(%eax)
    8540:	00 00                	add    %al,(%eax)
    8542:	00 00                	add    %al,(%eax)
    8544:	00 00                	add    %al,(%eax)
    8546:	00 00                	add    %al,(%eax)
    8548:	00 00                	add    %al,(%eax)
    854a:	00 00                	add    %al,(%eax)
    854c:	00 00                	add    %al,(%eax)
    854e:	00 00                	add    %al,(%eax)
    8550:	00 00                	add    %al,(%eax)
    8552:	00 00                	add    %al,(%eax)
    8554:	00 00                	add    %al,(%eax)
    8556:	00 00                	add    %al,(%eax)
    8558:	00 00                	add    %al,(%eax)
    855a:	00 00                	add    %al,(%eax)
    855c:	00 00                	add    %al,(%eax)
    855e:	00 00                	add    %al,(%eax)
    8560:	00 00                	add    %al,(%eax)
    8562:	00 00                	add    %al,(%eax)
    8564:	00 00                	add    %al,(%eax)
    8566:	00 00                	add    %al,(%eax)
    8568:	00 00                	add    %al,(%eax)
    856a:	00 00                	add    %al,(%eax)
    856c:	00 00                	add    %al,(%eax)
    856e:	00 00                	add    %al,(%eax)
    8570:	00 00                	add    %al,(%eax)
    8572:	00 00                	add    %al,(%eax)
    8574:	00 00                	add    %al,(%eax)
    8576:	00 00                	add    %al,(%eax)
    8578:	00 00                	add    %al,(%eax)
    857a:	00 00                	add    %al,(%eax)
    857c:	00 00                	add    %al,(%eax)
    857e:	00 00                	add    %al,(%eax)
    8580:	00 00                	add    %al,(%eax)
    8582:	00 00                	add    %al,(%eax)
    8584:	00 00                	add    %al,(%eax)
    8586:	00 00                	add    %al,(%eax)
    8588:	00 00                	add    %al,(%eax)
    858a:	00 00                	add    %al,(%eax)
    858c:	00 00                	add    %al,(%eax)
    858e:	00 00                	add    %al,(%eax)
    8590:	00 00                	add    %al,(%eax)
    8592:	00 00                	add    %al,(%eax)
    8594:	00 00                	add    %al,(%eax)
    8596:	00 00                	add    %al,(%eax)
    8598:	00 00                	add    %al,(%eax)
    859a:	00 00                	add    %al,(%eax)
    859c:	00 00                	add    %al,(%eax)
    859e:	00 00                	add    %al,(%eax)
    85a0:	00 00                	add    %al,(%eax)
    85a2:	00 00                	add    %al,(%eax)
    85a4:	00 00                	add    %al,(%eax)
    85a6:	00 00                	add    %al,(%eax)
    85a8:	00 00                	add    %al,(%eax)
    85aa:	00 00                	add    %al,(%eax)
    85ac:	00 00                	add    %al,(%eax)
    85ae:	00 00                	add    %al,(%eax)
    85b0:	00 00                	add    %al,(%eax)
    85b2:	00 00                	add    %al,(%eax)
    85b4:	00 00                	add    %al,(%eax)
    85b6:	00 00                	add    %al,(%eax)
    85b8:	00 00                	add    %al,(%eax)
    85ba:	00 00                	add    %al,(%eax)
    85bc:	00 00                	add    %al,(%eax)
    85be:	00 00                	add    %al,(%eax)
    85c0:	00 00                	add    %al,(%eax)
    85c2:	00 00                	add    %al,(%eax)
    85c4:	00 00                	add    %al,(%eax)
    85c6:	00 00                	add    %al,(%eax)
    85c8:	00 00                	add    %al,(%eax)
    85ca:	00 00                	add    %al,(%eax)
    85cc:	00 00                	add    %al,(%eax)
    85ce:	00 00                	add    %al,(%eax)
    85d0:	00 00                	add    %al,(%eax)
    85d2:	00 00                	add    %al,(%eax)
    85d4:	00 00                	add    %al,(%eax)
    85d6:	00 00                	add    %al,(%eax)
    85d8:	00 00                	add    %al,(%eax)
    85da:	00 00                	add    %al,(%eax)
    85dc:	00 00                	add    %al,(%eax)
    85de:	00 00                	add    %al,(%eax)
    85e0:	00 00                	add    %al,(%eax)
    85e2:	00 00                	add    %al,(%eax)
    85e4:	00 00                	add    %al,(%eax)
    85e6:	00 00                	add    %al,(%eax)
    85e8:	00 00                	add    %al,(%eax)
    85ea:	00 00                	add    %al,(%eax)
    85ec:	00 00                	add    %al,(%eax)
    85ee:	00 00                	add    %al,(%eax)
    85f0:	00 00                	add    %al,(%eax)
    85f2:	00 00                	add    %al,(%eax)
    85f4:	00 00                	add    %al,(%eax)
    85f6:	00 00                	add    %al,(%eax)
    85f8:	00 00                	add    %al,(%eax)
    85fa:	00 00                	add    %al,(%eax)
    85fc:	00 00                	add    %al,(%eax)
    85fe:	00 00                	add    %al,(%eax)
    8600:	00 00                	add    %al,(%eax)
    8602:	00 00                	add    %al,(%eax)
    8604:	00 00                	add    %al,(%eax)
    8606:	00 00                	add    %al,(%eax)
    8608:	00 00                	add    %al,(%eax)
    860a:	00 00                	add    %al,(%eax)
    860c:	00 00                	add    %al,(%eax)
    860e:	00 00                	add    %al,(%eax)
    8610:	00 00                	add    %al,(%eax)
    8612:	00 00                	add    %al,(%eax)
    8614:	00 00                	add    %al,(%eax)
    8616:	00 00                	add    %al,(%eax)
    8618:	00 00                	add    %al,(%eax)
    861a:	00 00                	add    %al,(%eax)
    861c:	00 00                	add    %al,(%eax)
    861e:	00 00                	add    %al,(%eax)
    8620:	00 00                	add    %al,(%eax)
    8622:	00 00                	add    %al,(%eax)
    8624:	00 00                	add    %al,(%eax)
    8626:	00 00                	add    %al,(%eax)
    8628:	00 00                	add    %al,(%eax)
    862a:	00 00                	add    %al,(%eax)
    862c:	00 00                	add    %al,(%eax)
    862e:	00 00                	add    %al,(%eax)
    8630:	00 00                	add    %al,(%eax)
    8632:	00 00                	add    %al,(%eax)
    8634:	00 00                	add    %al,(%eax)
    8636:	00 00                	add    %al,(%eax)
    8638:	00 00                	add    %al,(%eax)
    863a:	00 00                	add    %al,(%eax)
    863c:	00 00                	add    %al,(%eax)
    863e:	00 00                	add    %al,(%eax)
    8640:	00 00                	add    %al,(%eax)
    8642:	00 00                	add    %al,(%eax)
    8644:	00 00                	add    %al,(%eax)
    8646:	00 00                	add    %al,(%eax)
    8648:	00 00                	add    %al,(%eax)
    864a:	00 00                	add    %al,(%eax)
    864c:	00 00                	add    %al,(%eax)
    864e:	00 00                	add    %al,(%eax)
    8650:	00 00                	add    %al,(%eax)
    8652:	00 00                	add    %al,(%eax)
    8654:	00 00                	add    %al,(%eax)
    8656:	00 00                	add    %al,(%eax)
    8658:	00 00                	add    %al,(%eax)
    865a:	00 00                	add    %al,(%eax)
    865c:	00 00                	add    %al,(%eax)
    865e:	00 00                	add    %al,(%eax)
    8660:	00 00                	add    %al,(%eax)
    8662:	00 00                	add    %al,(%eax)
    8664:	00 00                	add    %al,(%eax)
    8666:	00 00                	add    %al,(%eax)
    8668:	00 00                	add    %al,(%eax)
    866a:	00 00                	add    %al,(%eax)
    866c:	00 00                	add    %al,(%eax)
    866e:	00 00                	add    %al,(%eax)
    8670:	00 00                	add    %al,(%eax)
    8672:	00 00                	add    %al,(%eax)
    8674:	00 00                	add    %al,(%eax)
    8676:	00 00                	add    %al,(%eax)
    8678:	00 00                	add    %al,(%eax)
    867a:	00 00                	add    %al,(%eax)
    867c:	00 00                	add    %al,(%eax)
    867e:	00 00                	add    %al,(%eax)
    8680:	00 00                	add    %al,(%eax)
    8682:	00 00                	add    %al,(%eax)
    8684:	00 00                	add    %al,(%eax)
    8686:	00 00                	add    %al,(%eax)
    8688:	00 00                	add    %al,(%eax)
    868a:	00 00                	add    %al,(%eax)
    868c:	00 00                	add    %al,(%eax)
    868e:	00 00                	add    %al,(%eax)
    8690:	00 00                	add    %al,(%eax)
    8692:	00 00                	add    %al,(%eax)
    8694:	00 00                	add    %al,(%eax)
    8696:	00 00                	add    %al,(%eax)
    8698:	00 00                	add    %al,(%eax)
    869a:	00 00                	add    %al,(%eax)
    869c:	00 00                	add    %al,(%eax)
    869e:	00 00                	add    %al,(%eax)
    86a0:	00 00                	add    %al,(%eax)
    86a2:	00 00                	add    %al,(%eax)
    86a4:	00 00                	add    %al,(%eax)
    86a6:	00 00                	add    %al,(%eax)
    86a8:	00 00                	add    %al,(%eax)
    86aa:	00 00                	add    %al,(%eax)
    86ac:	00 00                	add    %al,(%eax)
    86ae:	00 00                	add    %al,(%eax)
    86b0:	00 00                	add    %al,(%eax)
    86b2:	00 00                	add    %al,(%eax)
    86b4:	00 00                	add    %al,(%eax)
    86b6:	00 00                	add    %al,(%eax)
    86b8:	00 00                	add    %al,(%eax)
    86ba:	00 00                	add    %al,(%eax)
    86bc:	00 00                	add    %al,(%eax)
    86be:	00 00                	add    %al,(%eax)
    86c0:	00 00                	add    %al,(%eax)
    86c2:	00 00                	add    %al,(%eax)
    86c4:	00 00                	add    %al,(%eax)
    86c6:	00 00                	add    %al,(%eax)
    86c8:	00 00                	add    %al,(%eax)
    86ca:	00 00                	add    %al,(%eax)
    86cc:	00 00                	add    %al,(%eax)
    86ce:	00 00                	add    %al,(%eax)
    86d0:	00 00                	add    %al,(%eax)
    86d2:	00 00                	add    %al,(%eax)
    86d4:	00 00                	add    %al,(%eax)
    86d6:	00 00                	add    %al,(%eax)
    86d8:	00 00                	add    %al,(%eax)
    86da:	00 00                	add    %al,(%eax)
    86dc:	00 00                	add    %al,(%eax)
    86de:	00 00                	add    %al,(%eax)
    86e0:	00 00                	add    %al,(%eax)
    86e2:	00 00                	add    %al,(%eax)
    86e4:	00 00                	add    %al,(%eax)
    86e6:	00 00                	add    %al,(%eax)
    86e8:	00 00                	add    %al,(%eax)
    86ea:	00 00                	add    %al,(%eax)
    86ec:	00 00                	add    %al,(%eax)
    86ee:	00 00                	add    %al,(%eax)
    86f0:	00 00                	add    %al,(%eax)
    86f2:	00 00                	add    %al,(%eax)
    86f4:	00 00                	add    %al,(%eax)
    86f6:	00 00                	add    %al,(%eax)
    86f8:	00 00                	add    %al,(%eax)
    86fa:	00 00                	add    %al,(%eax)
    86fc:	00 00                	add    %al,(%eax)
    86fe:	00 00                	add    %al,(%eax)
    8700:	00 00                	add    %al,(%eax)
    8702:	00 00                	add    %al,(%eax)
    8704:	00 00                	add    %al,(%eax)
    8706:	00 00                	add    %al,(%eax)
    8708:	00 00                	add    %al,(%eax)
    870a:	00 00                	add    %al,(%eax)
    870c:	00 00                	add    %al,(%eax)
    870e:	00 00                	add    %al,(%eax)
    8710:	00 00                	add    %al,(%eax)
    8712:	00 00                	add    %al,(%eax)
    8714:	00 00                	add    %al,(%eax)
    8716:	00 00                	add    %al,(%eax)
    8718:	00 00                	add    %al,(%eax)
    871a:	00 00                	add    %al,(%eax)
    871c:	00 00                	add    %al,(%eax)
    871e:	00 00                	add    %al,(%eax)
    8720:	00 00                	add    %al,(%eax)
    8722:	00 00                	add    %al,(%eax)
    8724:	00 00                	add    %al,(%eax)
    8726:	00 00                	add    %al,(%eax)
    8728:	00 00                	add    %al,(%eax)
    872a:	00 00                	add    %al,(%eax)
    872c:	00 00                	add    %al,(%eax)
    872e:	00 00                	add    %al,(%eax)
    8730:	00 00                	add    %al,(%eax)
    8732:	00 00                	add    %al,(%eax)
    8734:	00 00                	add    %al,(%eax)
    8736:	00 00                	add    %al,(%eax)
    8738:	00 00                	add    %al,(%eax)
    873a:	00 00                	add    %al,(%eax)
    873c:	00 00                	add    %al,(%eax)
    873e:	00 00                	add    %al,(%eax)
    8740:	00 00                	add    %al,(%eax)
    8742:	00 00                	add    %al,(%eax)
    8744:	00 00                	add    %al,(%eax)
    8746:	00 00                	add    %al,(%eax)
    8748:	00 00                	add    %al,(%eax)
    874a:	00 00                	add    %al,(%eax)
    874c:	00 00                	add    %al,(%eax)
    874e:	00 00                	add    %al,(%eax)
    8750:	00 00                	add    %al,(%eax)
    8752:	00 00                	add    %al,(%eax)
    8754:	00 00                	add    %al,(%eax)
    8756:	00 00                	add    %al,(%eax)
    8758:	00 00                	add    %al,(%eax)
    875a:	00 00                	add    %al,(%eax)
    875c:	00 00                	add    %al,(%eax)
    875e:	00 00                	add    %al,(%eax)
    8760:	00 00                	add    %al,(%eax)
    8762:	00 00                	add    %al,(%eax)
    8764:	00 00                	add    %al,(%eax)
    8766:	00 00                	add    %al,(%eax)
    8768:	00 00                	add    %al,(%eax)
    876a:	00 00                	add    %al,(%eax)
    876c:	00 00                	add    %al,(%eax)
    876e:	00 00                	add    %al,(%eax)
    8770:	00 00                	add    %al,(%eax)
    8772:	00 00                	add    %al,(%eax)
    8774:	00 00                	add    %al,(%eax)
    8776:	00 00                	add    %al,(%eax)
    8778:	00 00                	add    %al,(%eax)
    877a:	00 00                	add    %al,(%eax)
    877c:	00 00                	add    %al,(%eax)
    877e:	00 00                	add    %al,(%eax)
    8780:	00 00                	add    %al,(%eax)
    8782:	00 00                	add    %al,(%eax)
    8784:	00 00                	add    %al,(%eax)
    8786:	00 00                	add    %al,(%eax)
    8788:	00 00                	add    %al,(%eax)
    878a:	00 00                	add    %al,(%eax)
    878c:	00 00                	add    %al,(%eax)
    878e:	00 00                	add    %al,(%eax)
    8790:	00 00                	add    %al,(%eax)
    8792:	00 00                	add    %al,(%eax)
    8794:	00 00                	add    %al,(%eax)
    8796:	00 00                	add    %al,(%eax)
    8798:	00 00                	add    %al,(%eax)
    879a:	00 00                	add    %al,(%eax)
    879c:	00 00                	add    %al,(%eax)
    879e:	00 00                	add    %al,(%eax)
    87a0:	00 00                	add    %al,(%eax)
    87a2:	00 00                	add    %al,(%eax)
    87a4:	00 00                	add    %al,(%eax)
    87a6:	00 00                	add    %al,(%eax)
    87a8:	00 00                	add    %al,(%eax)
    87aa:	00 00                	add    %al,(%eax)
    87ac:	00 00                	add    %al,(%eax)
    87ae:	00 00                	add    %al,(%eax)
    87b0:	00 00                	add    %al,(%eax)
    87b2:	00 00                	add    %al,(%eax)
    87b4:	00 00                	add    %al,(%eax)
    87b6:	00 00                	add    %al,(%eax)
    87b8:	00 00                	add    %al,(%eax)
    87ba:	00 00                	add    %al,(%eax)
    87bc:	00 00                	add    %al,(%eax)
    87be:	00 00                	add    %al,(%eax)
    87c0:	00 00                	add    %al,(%eax)
    87c2:	00 00                	add    %al,(%eax)
    87c4:	00 00                	add    %al,(%eax)
    87c6:	00 00                	add    %al,(%eax)
    87c8:	00 00                	add    %al,(%eax)
    87ca:	00 00                	add    %al,(%eax)
    87cc:	00 00                	add    %al,(%eax)
    87ce:	00 00                	add    %al,(%eax)
    87d0:	00 00                	add    %al,(%eax)
    87d2:	00 00                	add    %al,(%eax)
    87d4:	00 00                	add    %al,(%eax)
    87d6:	00 00                	add    %al,(%eax)
    87d8:	00 00                	add    %al,(%eax)
    87da:	00 00                	add    %al,(%eax)
    87dc:	00 00                	add    %al,(%eax)
    87de:	00 00                	add    %al,(%eax)
    87e0:	00 00                	add    %al,(%eax)
    87e2:	00 00                	add    %al,(%eax)
    87e4:	00 00                	add    %al,(%eax)
    87e6:	00 00                	add    %al,(%eax)
    87e8:	00 00                	add    %al,(%eax)
    87ea:	00 00                	add    %al,(%eax)
    87ec:	00 00                	add    %al,(%eax)
    87ee:	00 00                	add    %al,(%eax)
    87f0:	00 00                	add    %al,(%eax)
    87f2:	00 00                	add    %al,(%eax)
    87f4:	00 00                	add    %al,(%eax)
    87f6:	00 00                	add    %al,(%eax)
    87f8:	00 00                	add    %al,(%eax)
    87fa:	00 00                	add    %al,(%eax)
    87fc:	00 00                	add    %al,(%eax)
    87fe:	00 00                	add    %al,(%eax)
    8800:	00 00                	add    %al,(%eax)
    8802:	00 00                	add    %al,(%eax)
    8804:	00 00                	add    %al,(%eax)
    8806:	00 00                	add    %al,(%eax)
    8808:	00 00                	add    %al,(%eax)
    880a:	00 00                	add    %al,(%eax)
    880c:	00 00                	add    %al,(%eax)
    880e:	00 00                	add    %al,(%eax)
    8810:	00 00                	add    %al,(%eax)
    8812:	00 00                	add    %al,(%eax)
    8814:	00 00                	add    %al,(%eax)
    8816:	00 00                	add    %al,(%eax)
    8818:	00 00                	add    %al,(%eax)
    881a:	00 00                	add    %al,(%eax)
    881c:	00 00                	add    %al,(%eax)
    881e:	00 00                	add    %al,(%eax)
    8820:	00 00                	add    %al,(%eax)
    8822:	00 00                	add    %al,(%eax)
    8824:	00 00                	add    %al,(%eax)
    8826:	00 00                	add    %al,(%eax)
    8828:	00 00                	add    %al,(%eax)
    882a:	00 00                	add    %al,(%eax)
    882c:	00 00                	add    %al,(%eax)
    882e:	00 00                	add    %al,(%eax)
    8830:	00 00                	add    %al,(%eax)
    8832:	00 00                	add    %al,(%eax)
    8834:	00 00                	add    %al,(%eax)
    8836:	00 00                	add    %al,(%eax)
    8838:	00 00                	add    %al,(%eax)
    883a:	00 00                	add    %al,(%eax)
    883c:	00 00                	add    %al,(%eax)
    883e:	00 00                	add    %al,(%eax)
    8840:	00 00                	add    %al,(%eax)
    8842:	00 00                	add    %al,(%eax)
    8844:	00 00                	add    %al,(%eax)
    8846:	00 00                	add    %al,(%eax)
    8848:	00 00                	add    %al,(%eax)
    884a:	00 00                	add    %al,(%eax)
    884c:	00 00                	add    %al,(%eax)
    884e:	00 00                	add    %al,(%eax)
    8850:	00 00                	add    %al,(%eax)
    8852:	00 00                	add    %al,(%eax)
    8854:	00 00                	add    %al,(%eax)
    8856:	00 00                	add    %al,(%eax)
    8858:	00 00                	add    %al,(%eax)
    885a:	00 00                	add    %al,(%eax)
    885c:	00 00                	add    %al,(%eax)
    885e:	00 00                	add    %al,(%eax)
    8860:	00 00                	add    %al,(%eax)
    8862:	00 00                	add    %al,(%eax)
    8864:	00 00                	add    %al,(%eax)
    8866:	00 00                	add    %al,(%eax)
    8868:	00 00                	add    %al,(%eax)
    886a:	00 00                	add    %al,(%eax)
    886c:	00 00                	add    %al,(%eax)
    886e:	00 00                	add    %al,(%eax)
    8870:	00 00                	add    %al,(%eax)
    8872:	00 00                	add    %al,(%eax)
    8874:	00 00                	add    %al,(%eax)
    8876:	00 00                	add    %al,(%eax)
    8878:	00 00                	add    %al,(%eax)
    887a:	00 00                	add    %al,(%eax)
    887c:	00 00                	add    %al,(%eax)
    887e:	00 00                	add    %al,(%eax)
    8880:	00 00                	add    %al,(%eax)
    8882:	00 00                	add    %al,(%eax)
    8884:	00 00                	add    %al,(%eax)
    8886:	00 00                	add    %al,(%eax)
    8888:	00 00                	add    %al,(%eax)
    888a:	00 00                	add    %al,(%eax)
    888c:	00 00                	add    %al,(%eax)
    888e:	00 00                	add    %al,(%eax)
    8890:	00 00                	add    %al,(%eax)
    8892:	00 00                	add    %al,(%eax)
    8894:	00 00                	add    %al,(%eax)
    8896:	00 00                	add    %al,(%eax)
    8898:	00 00                	add    %al,(%eax)
    889a:	00 00                	add    %al,(%eax)
    889c:	00 00                	add    %al,(%eax)
    889e:	00 00                	add    %al,(%eax)
    88a0:	00 00                	add    %al,(%eax)
    88a2:	00 00                	add    %al,(%eax)
    88a4:	00 00                	add    %al,(%eax)
    88a6:	00 00                	add    %al,(%eax)
    88a8:	00 00                	add    %al,(%eax)
    88aa:	00 00                	add    %al,(%eax)
    88ac:	00 00                	add    %al,(%eax)
    88ae:	00 00                	add    %al,(%eax)
    88b0:	00 00                	add    %al,(%eax)
    88b2:	00 00                	add    %al,(%eax)
    88b4:	00 00                	add    %al,(%eax)
    88b6:	00 00                	add    %al,(%eax)
    88b8:	00 00                	add    %al,(%eax)
    88ba:	00 00                	add    %al,(%eax)
    88bc:	00 00                	add    %al,(%eax)
    88be:	00 00                	add    %al,(%eax)
    88c0:	00 00                	add    %al,(%eax)
    88c2:	00 00                	add    %al,(%eax)
    88c4:	00 00                	add    %al,(%eax)
    88c6:	00 00                	add    %al,(%eax)
    88c8:	00 00                	add    %al,(%eax)
    88ca:	00 00                	add    %al,(%eax)
    88cc:	00 00                	add    %al,(%eax)
    88ce:	00 00                	add    %al,(%eax)
    88d0:	00 00                	add    %al,(%eax)
    88d2:	00 00                	add    %al,(%eax)
    88d4:	00 00                	add    %al,(%eax)
    88d6:	00 00                	add    %al,(%eax)
    88d8:	00 00                	add    %al,(%eax)
    88da:	00 00                	add    %al,(%eax)
    88dc:	00 00                	add    %al,(%eax)
    88de:	00 00                	add    %al,(%eax)
    88e0:	00 00                	add    %al,(%eax)
    88e2:	00 00                	add    %al,(%eax)
    88e4:	00 00                	add    %al,(%eax)
    88e6:	00 00                	add    %al,(%eax)
    88e8:	00 00                	add    %al,(%eax)
    88ea:	00 00                	add    %al,(%eax)
    88ec:	00 00                	add    %al,(%eax)
    88ee:	00 00                	add    %al,(%eax)
    88f0:	00 00                	add    %al,(%eax)
    88f2:	00 00                	add    %al,(%eax)
    88f4:	00 00                	add    %al,(%eax)
    88f6:	00 00                	add    %al,(%eax)
    88f8:	00 00                	add    %al,(%eax)
    88fa:	00 00                	add    %al,(%eax)
    88fc:	00 00                	add    %al,(%eax)
    88fe:	00 00                	add    %al,(%eax)
    8900:	00 00                	add    %al,(%eax)
    8902:	00 00                	add    %al,(%eax)
    8904:	00 00                	add    %al,(%eax)
    8906:	00 00                	add    %al,(%eax)
    8908:	00 00                	add    %al,(%eax)
    890a:	00 00                	add    %al,(%eax)
    890c:	00 00                	add    %al,(%eax)
    890e:	00 00                	add    %al,(%eax)
    8910:	00 00                	add    %al,(%eax)
    8912:	00 00                	add    %al,(%eax)
    8914:	00 00                	add    %al,(%eax)
    8916:	00 00                	add    %al,(%eax)
    8918:	00 00                	add    %al,(%eax)
    891a:	00 00                	add    %al,(%eax)
    891c:	00 00                	add    %al,(%eax)
    891e:	00 00                	add    %al,(%eax)
    8920:	00 00                	add    %al,(%eax)
    8922:	00 00                	add    %al,(%eax)
    8924:	00 00                	add    %al,(%eax)
    8926:	00 00                	add    %al,(%eax)
    8928:	00 00                	add    %al,(%eax)
    892a:	00 00                	add    %al,(%eax)
    892c:	00 00                	add    %al,(%eax)
    892e:	00 00                	add    %al,(%eax)
    8930:	00 00                	add    %al,(%eax)
    8932:	00 00                	add    %al,(%eax)
    8934:	00 00                	add    %al,(%eax)
    8936:	00 00                	add    %al,(%eax)
    8938:	00 00                	add    %al,(%eax)
    893a:	00 00                	add    %al,(%eax)
    893c:	00 00                	add    %al,(%eax)
    893e:	00 00                	add    %al,(%eax)
    8940:	00 00                	add    %al,(%eax)
    8942:	00 00                	add    %al,(%eax)
    8944:	00 00                	add    %al,(%eax)
    8946:	00 00                	add    %al,(%eax)
    8948:	00 00                	add    %al,(%eax)
    894a:	00 00                	add    %al,(%eax)
    894c:	00 00                	add    %al,(%eax)
    894e:	00 00                	add    %al,(%eax)
    8950:	00 00                	add    %al,(%eax)
    8952:	00 00                	add    %al,(%eax)
    8954:	00 00                	add    %al,(%eax)
    8956:	00 00                	add    %al,(%eax)
    8958:	00 00                	add    %al,(%eax)
    895a:	00 00                	add    %al,(%eax)
    895c:	00 00                	add    %al,(%eax)
    895e:	00 00                	add    %al,(%eax)
    8960:	00 00                	add    %al,(%eax)
    8962:	00 00                	add    %al,(%eax)
    8964:	00 00                	add    %al,(%eax)
    8966:	00 00                	add    %al,(%eax)
    8968:	00 00                	add    %al,(%eax)
    896a:	00 00                	add    %al,(%eax)
    896c:	00 00                	add    %al,(%eax)
    896e:	00 00                	add    %al,(%eax)
    8970:	00 00                	add    %al,(%eax)
    8972:	00 00                	add    %al,(%eax)
    8974:	00 00                	add    %al,(%eax)
    8976:	00 00                	add    %al,(%eax)
    8978:	00 00                	add    %al,(%eax)
    897a:	00 00                	add    %al,(%eax)
    897c:	00 00                	add    %al,(%eax)
    897e:	00 00                	add    %al,(%eax)
    8980:	00 00                	add    %al,(%eax)
    8982:	00 00                	add    %al,(%eax)
    8984:	00 00                	add    %al,(%eax)
    8986:	00 00                	add    %al,(%eax)
    8988:	00 00                	add    %al,(%eax)
    898a:	00 00                	add    %al,(%eax)
    898c:	00 00                	add    %al,(%eax)
    898e:	00 00                	add    %al,(%eax)
    8990:	00 00                	add    %al,(%eax)
    8992:	00 00                	add    %al,(%eax)
    8994:	00 00                	add    %al,(%eax)
    8996:	00 00                	add    %al,(%eax)
    8998:	00 00                	add    %al,(%eax)
    899a:	00 00                	add    %al,(%eax)
    899c:	00 00                	add    %al,(%eax)
    899e:	00 00                	add    %al,(%eax)
    89a0:	00 00                	add    %al,(%eax)
    89a2:	00 00                	add    %al,(%eax)
    89a4:	00 00                	add    %al,(%eax)
    89a6:	00 00                	add    %al,(%eax)
    89a8:	00 00                	add    %al,(%eax)
    89aa:	00 00                	add    %al,(%eax)
    89ac:	00 00                	add    %al,(%eax)
    89ae:	00 00                	add    %al,(%eax)
    89b0:	00 00                	add    %al,(%eax)
    89b2:	00 00                	add    %al,(%eax)
    89b4:	00 00                	add    %al,(%eax)
    89b6:	00 00                	add    %al,(%eax)
    89b8:	00 00                	add    %al,(%eax)
    89ba:	00 00                	add    %al,(%eax)
    89bc:	00 00                	add    %al,(%eax)
    89be:	00 00                	add    %al,(%eax)
    89c0:	00 00                	add    %al,(%eax)
    89c2:	00 00                	add    %al,(%eax)
    89c4:	00 00                	add    %al,(%eax)
    89c6:	00 00                	add    %al,(%eax)
    89c8:	00 00                	add    %al,(%eax)
    89ca:	00 00                	add    %al,(%eax)
    89cc:	00 00                	add    %al,(%eax)
    89ce:	00 00                	add    %al,(%eax)
    89d0:	00 00                	add    %al,(%eax)
    89d2:	00 00                	add    %al,(%eax)
    89d4:	00 00                	add    %al,(%eax)
    89d6:	00 00                	add    %al,(%eax)
    89d8:	00 00                	add    %al,(%eax)
    89da:	00 00                	add    %al,(%eax)
    89dc:	00 00                	add    %al,(%eax)
    89de:	00 00                	add    %al,(%eax)
    89e0:	00 00                	add    %al,(%eax)
    89e2:	00 00                	add    %al,(%eax)
    89e4:	00 00                	add    %al,(%eax)
    89e6:	00 00                	add    %al,(%eax)
    89e8:	00 00                	add    %al,(%eax)
    89ea:	00 00                	add    %al,(%eax)
    89ec:	00 00                	add    %al,(%eax)
    89ee:	00 00                	add    %al,(%eax)
    89f0:	00 00                	add    %al,(%eax)
    89f2:	00 00                	add    %al,(%eax)
    89f4:	00 00                	add    %al,(%eax)
    89f6:	00 00                	add    %al,(%eax)
    89f8:	00 00                	add    %al,(%eax)
    89fa:	00 00                	add    %al,(%eax)
    89fc:	00 00                	add    %al,(%eax)
    89fe:	00 00                	add    %al,(%eax)
    8a00:	00 00                	add    %al,(%eax)
    8a02:	00 00                	add    %al,(%eax)
    8a04:	00 00                	add    %al,(%eax)
    8a06:	00 00                	add    %al,(%eax)
    8a08:	00 00                	add    %al,(%eax)
    8a0a:	00 00                	add    %al,(%eax)
    8a0c:	00 00                	add    %al,(%eax)
    8a0e:	00 00                	add    %al,(%eax)
    8a10:	00 00                	add    %al,(%eax)
    8a12:	00 00                	add    %al,(%eax)
    8a14:	00 00                	add    %al,(%eax)
    8a16:	00 00                	add    %al,(%eax)
    8a18:	00 00                	add    %al,(%eax)
    8a1a:	00 00                	add    %al,(%eax)
    8a1c:	00 00                	add    %al,(%eax)
    8a1e:	00 00                	add    %al,(%eax)
    8a20:	00 00                	add    %al,(%eax)
    8a22:	00 00                	add    %al,(%eax)
    8a24:	00 00                	add    %al,(%eax)
    8a26:	00 00                	add    %al,(%eax)
    8a28:	00 00                	add    %al,(%eax)
    8a2a:	00 00                	add    %al,(%eax)
    8a2c:	00 00                	add    %al,(%eax)
    8a2e:	00 00                	add    %al,(%eax)
    8a30:	00 00                	add    %al,(%eax)
    8a32:	00 00                	add    %al,(%eax)
    8a34:	00 00                	add    %al,(%eax)
    8a36:	00 00                	add    %al,(%eax)
    8a38:	00 00                	add    %al,(%eax)
    8a3a:	00 00                	add    %al,(%eax)
    8a3c:	00 00                	add    %al,(%eax)
    8a3e:	00 00                	add    %al,(%eax)
    8a40:	00 00                	add    %al,(%eax)
    8a42:	00 00                	add    %al,(%eax)
    8a44:	00 00                	add    %al,(%eax)
    8a46:	00 00                	add    %al,(%eax)
    8a48:	00 00                	add    %al,(%eax)
    8a4a:	00 00                	add    %al,(%eax)
    8a4c:	00 00                	add    %al,(%eax)
    8a4e:	00 00                	add    %al,(%eax)
    8a50:	00 00                	add    %al,(%eax)
    8a52:	00 00                	add    %al,(%eax)
    8a54:	00 00                	add    %al,(%eax)
    8a56:	00 00                	add    %al,(%eax)
    8a58:	00 00                	add    %al,(%eax)
    8a5a:	00 00                	add    %al,(%eax)
    8a5c:	00 00                	add    %al,(%eax)
    8a5e:	00 00                	add    %al,(%eax)
    8a60:	00 00                	add    %al,(%eax)
    8a62:	00 00                	add    %al,(%eax)
    8a64:	00 00                	add    %al,(%eax)
    8a66:	00 00                	add    %al,(%eax)
    8a68:	00 00                	add    %al,(%eax)
    8a6a:	00 00                	add    %al,(%eax)
    8a6c:	00 00                	add    %al,(%eax)
    8a6e:	00 00                	add    %al,(%eax)
    8a70:	00 00                	add    %al,(%eax)
    8a72:	00 00                	add    %al,(%eax)
    8a74:	00 00                	add    %al,(%eax)
    8a76:	00 00                	add    %al,(%eax)
    8a78:	00 00                	add    %al,(%eax)
    8a7a:	00 00                	add    %al,(%eax)
    8a7c:	00 00                	add    %al,(%eax)
    8a7e:	00 00                	add    %al,(%eax)
    8a80:	00 00                	add    %al,(%eax)
    8a82:	00 00                	add    %al,(%eax)
    8a84:	00 00                	add    %al,(%eax)
    8a86:	00 00                	add    %al,(%eax)
    8a88:	00 00                	add    %al,(%eax)
    8a8a:	00 00                	add    %al,(%eax)
    8a8c:	00 00                	add    %al,(%eax)
    8a8e:	00 00                	add    %al,(%eax)
    8a90:	00 00                	add    %al,(%eax)
    8a92:	00 00                	add    %al,(%eax)
    8a94:	00 00                	add    %al,(%eax)
    8a96:	00 00                	add    %al,(%eax)
    8a98:	00 00                	add    %al,(%eax)
    8a9a:	00 00                	add    %al,(%eax)
    8a9c:	00 00                	add    %al,(%eax)
    8a9e:	00 00                	add    %al,(%eax)
    8aa0:	00 00                	add    %al,(%eax)
    8aa2:	00 00                	add    %al,(%eax)
    8aa4:	00 00                	add    %al,(%eax)
    8aa6:	00 00                	add    %al,(%eax)
    8aa8:	00 00                	add    %al,(%eax)
    8aaa:	00 00                	add    %al,(%eax)
    8aac:	00 00                	add    %al,(%eax)
    8aae:	00 00                	add    %al,(%eax)
    8ab0:	00 00                	add    %al,(%eax)
    8ab2:	00 00                	add    %al,(%eax)
    8ab4:	00 00                	add    %al,(%eax)
    8ab6:	00 00                	add    %al,(%eax)
    8ab8:	00 00                	add    %al,(%eax)
    8aba:	00 00                	add    %al,(%eax)
    8abc:	00 00                	add    %al,(%eax)
    8abe:	00 00                	add    %al,(%eax)
    8ac0:	00 00                	add    %al,(%eax)
    8ac2:	00 00                	add    %al,(%eax)
    8ac4:	00 00                	add    %al,(%eax)
    8ac6:	00 00                	add    %al,(%eax)
    8ac8:	00 00                	add    %al,(%eax)
    8aca:	00 00                	add    %al,(%eax)
    8acc:	00 00                	add    %al,(%eax)
    8ace:	00 00                	add    %al,(%eax)
    8ad0:	00 00                	add    %al,(%eax)
    8ad2:	00 00                	add    %al,(%eax)
    8ad4:	00 00                	add    %al,(%eax)
    8ad6:	00 00                	add    %al,(%eax)
    8ad8:	00 00                	add    %al,(%eax)
    8ada:	00 00                	add    %al,(%eax)
    8adc:	00 00                	add    %al,(%eax)
    8ade:	00 00                	add    %al,(%eax)
    8ae0:	00 00                	add    %al,(%eax)
    8ae2:	00 00                	add    %al,(%eax)
    8ae4:	00 00                	add    %al,(%eax)
    8ae6:	00 00                	add    %al,(%eax)
    8ae8:	00 00                	add    %al,(%eax)
    8aea:	00 00                	add    %al,(%eax)
    8aec:	00 00                	add    %al,(%eax)
    8aee:	00 00                	add    %al,(%eax)
    8af0:	00 00                	add    %al,(%eax)
    8af2:	00 00                	add    %al,(%eax)
    8af4:	00 00                	add    %al,(%eax)
    8af6:	00 00                	add    %al,(%eax)
    8af8:	00 00                	add    %al,(%eax)
    8afa:	00 00                	add    %al,(%eax)
    8afc:	00 00                	add    %al,(%eax)
    8afe:	00 00                	add    %al,(%eax)
    8b00:	00 00                	add    %al,(%eax)
    8b02:	00 00                	add    %al,(%eax)
    8b04:	00 00                	add    %al,(%eax)
    8b06:	00 00                	add    %al,(%eax)
    8b08:	00 00                	add    %al,(%eax)
    8b0a:	00 00                	add    %al,(%eax)
    8b0c:	00 00                	add    %al,(%eax)
    8b0e:	00 00                	add    %al,(%eax)
    8b10:	00 00                	add    %al,(%eax)
    8b12:	00 00                	add    %al,(%eax)
    8b14:	00 00                	add    %al,(%eax)
    8b16:	00 00                	add    %al,(%eax)
    8b18:	00 00                	add    %al,(%eax)
    8b1a:	00 00                	add    %al,(%eax)
    8b1c:	00 00                	add    %al,(%eax)
    8b1e:	00 00                	add    %al,(%eax)
    8b20:	00 00                	add    %al,(%eax)
    8b22:	00 00                	add    %al,(%eax)
    8b24:	00 00                	add    %al,(%eax)

00008b26 <putc>:
 * video
 */
volatile char *video = (volatile char *) 0xB8000;

void putc(int l, int color, char ch)
{
    8b26:	55                   	push   %ebp
    8b27:	89 e5                	mov    %esp,%ebp
    8b29:	8b 45 08             	mov    0x8(%ebp),%eax
    volatile char *p = video + l * 2;
    *p = ch;
    8b2c:	8b 55 10             	mov    0x10(%ebp),%edx
    volatile char *p = video + l * 2;
    8b2f:	01 c0                	add    %eax,%eax
    8b31:	03 05 a4 92 00 00    	add    0x92a4,%eax
    *p = ch;
    8b37:	88 10                	mov    %dl,(%eax)
    *(p + 1) = color;
    8b39:	8b 55 0c             	mov    0xc(%ebp),%edx
    8b3c:	88 50 01             	mov    %dl,0x1(%eax)
}
    8b3f:	5d                   	pop    %ebp
    8b40:	c3                   	ret    

00008b41 <puts>:

int puts(int r, int c, int color, const char *string)
{
    8b41:	55                   	push   %ebp
    8b42:	89 e5                	mov    %esp,%ebp
    8b44:	56                   	push   %esi
    8b45:	53                   	push   %ebx
    int l = r * 80 + c;
    8b46:	6b 75 08 50          	imul   $0x50,0x8(%ebp),%esi
{
    8b4a:	8b 4d 10             	mov    0x10(%ebp),%ecx
    int l = r * 80 + c;
    8b4d:	03 75 0c             	add    0xc(%ebp),%esi
    8b50:	89 f0                	mov    %esi,%eax
    while (*string != 0) {
    8b52:	8b 55 14             	mov    0x14(%ebp),%edx
    8b55:	29 f2                	sub    %esi,%edx
    8b57:	0f be 14 02          	movsbl (%edx,%eax,1),%edx
    8b5b:	84 d2                	test   %dl,%dl
    8b5d:	74 15                	je     8b74 <puts+0x33>
        putc(l++, color, *string++);
    8b5f:	83 ec 04             	sub    $0x4,%esp
    8b62:	8d 58 01             	lea    0x1(%eax),%ebx
    8b65:	52                   	push   %edx
    8b66:	51                   	push   %ecx
    8b67:	50                   	push   %eax
    8b68:	e8 b9 ff ff ff       	call   8b26 <putc>
    8b6d:	83 c4 10             	add    $0x10,%esp
    8b70:	89 d8                	mov    %ebx,%eax
    8b72:	eb de                	jmp    8b52 <puts+0x11>
    }
    return l;
}
    8b74:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8b77:	5b                   	pop    %ebx
    8b78:	5e                   	pop    %esi
    8b79:	5d                   	pop    %ebp
    8b7a:	c3                   	ret    

00008b7b <putline>:

char *blank =
    "                                                                                ";

void putline(char *s)
{
    8b7b:	55                   	push   %ebp
    8b7c:	89 e5                	mov    %esp,%ebp
    8b7e:	53                   	push   %ebx
    8b7f:	50                   	push   %eax
    puts(row = (row >= CRT_ROWS) ? 0 : row + 1, 0, VGA_CLR_BLACK, blank);
    8b80:	a1 48 93 00 00       	mov    0x9348,%eax
    8b85:	8b 15 a0 92 00 00    	mov    0x92a0,%edx
    8b8b:	8d 58 01             	lea    0x1(%eax),%ebx
    8b8e:	83 f8 18             	cmp    $0x18,%eax
    8b91:	7e 02                	jle    8b95 <putline+0x1a>
    8b93:	31 db                	xor    %ebx,%ebx
    8b95:	89 1d 48 93 00 00    	mov    %ebx,0x9348
    8b9b:	52                   	push   %edx
    8b9c:	6a 00                	push   $0x0
    8b9e:	6a 00                	push   $0x0
    8ba0:	53                   	push   %ebx
    8ba1:	e8 9b ff ff ff       	call   8b41 <puts>
    puts(row, 0, VGA_CLR_WHITE, s);
    8ba6:	ff 75 08             	push   0x8(%ebp)
    8ba9:	6a 0f                	push   $0xf
    8bab:	6a 00                	push   $0x0
    8bad:	53                   	push   %ebx
    8bae:	e8 8e ff ff ff       	call   8b41 <puts>
}
    8bb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    8bb6:	83 c4 20             	add    $0x20,%esp
    8bb9:	c9                   	leave  
    8bba:	c3                   	ret    

00008bbb <roll>:

void roll(int r)
{
    8bbb:	55                   	push   %ebp
    8bbc:	89 e5                	mov    %esp,%ebp
    row = r;
    8bbe:	8b 45 08             	mov    0x8(%ebp),%eax
}
    8bc1:	5d                   	pop    %ebp
    row = r;
    8bc2:	a3 48 93 00 00       	mov    %eax,0x9348
}
    8bc7:	c3                   	ret    

00008bc8 <panic>:

void panic(char *m)
{
    8bc8:	55                   	push   %ebp
    8bc9:	89 e5                	mov    %esp,%ebp
    8bcb:	83 ec 08             	sub    $0x8,%esp
    puts(0, 0, VGA_CLR_RED, m);
    8bce:	ff 75 08             	push   0x8(%ebp)
    8bd1:	6a 04                	push   $0x4
    8bd3:	6a 00                	push   $0x0
    8bd5:	6a 00                	push   $0x0
    8bd7:	e8 65 ff ff ff       	call   8b41 <puts>
    8bdc:	83 c4 10             	add    $0x10,%esp
    while (1) {
        asm volatile ("hlt");
    8bdf:	f4                   	hlt    
    while (1) {
    8be0:	eb fd                	jmp    8bdf <panic+0x17>

00008be2 <strlen>:

/**
 * string
 */
int strlen(const char *s)
{
    8be2:	55                   	push   %ebp
    int n;

    for (n = 0; *s != '\0'; s++)
    8be3:	31 c0                	xor    %eax,%eax
{
    8be5:	89 e5                	mov    %esp,%ebp
    8be7:	8b 55 08             	mov    0x8(%ebp),%edx
    for (n = 0; *s != '\0'; s++)
    8bea:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    8bee:	74 03                	je     8bf3 <strlen+0x11>
        n++;
    8bf0:	40                   	inc    %eax
    for (n = 0; *s != '\0'; s++)
    8bf1:	eb f7                	jmp    8bea <strlen+0x8>
    return n;
}
    8bf3:	5d                   	pop    %ebp
    8bf4:	c3                   	ret    

00008bf5 <reverse>:

/* reverse: reverse string s in place */
void reverse(char s[])
{
    8bf5:	55                   	push   %ebp
    8bf6:	89 e5                	mov    %esp,%ebp
    8bf8:	56                   	push   %esi
    8bf9:	53                   	push   %ebx
    8bfa:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int i, j;
    char c;

    for (i = 0, j = strlen(s) - 1; i < j; i++, j--) {
    8bfd:	83 ec 0c             	sub    $0xc,%esp
    8c00:	51                   	push   %ecx
    8c01:	e8 dc ff ff ff       	call   8be2 <strlen>
    8c06:	83 c4 10             	add    $0x10,%esp
    8c09:	31 d2                	xor    %edx,%edx
    8c0b:	48                   	dec    %eax
    8c0c:	39 c2                	cmp    %eax,%edx
    8c0e:	7d 13                	jge    8c23 <reverse+0x2e>
        c = s[i];
    8c10:	0f b6 34 11          	movzbl (%ecx,%edx,1),%esi
        s[i] = s[j];
    8c14:	8a 1c 01             	mov    (%ecx,%eax,1),%bl
    8c17:	88 1c 11             	mov    %bl,(%ecx,%edx,1)
        s[j] = c;
    8c1a:	89 f3                	mov    %esi,%ebx
    for (i = 0, j = strlen(s) - 1; i < j; i++, j--) {
    8c1c:	42                   	inc    %edx
        s[j] = c;
    8c1d:	88 1c 01             	mov    %bl,(%ecx,%eax,1)
    for (i = 0, j = strlen(s) - 1; i < j; i++, j--) {
    8c20:	48                   	dec    %eax
    8c21:	eb e9                	jmp    8c0c <reverse+0x17>
    }
}
    8c23:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8c26:	5b                   	pop    %ebx
    8c27:	5e                   	pop    %esi
    8c28:	5d                   	pop    %ebp
    8c29:	c3                   	ret    

00008c2a <itox>:

/* itoa: convert n to characters in s */
void itox(int n, char s[], int root, char *table)
{
    8c2a:	55                   	push   %ebp
    8c2b:	89 e5                	mov    %esp,%ebp
    8c2d:	57                   	push   %edi
    8c2e:	56                   	push   %esi
    8c2f:	53                   	push   %ebx
    8c30:	83 ec 1c             	sub    $0x1c,%esp
    8c33:	8b 75 08             	mov    0x8(%ebp),%esi
    8c36:	8b 45 10             	mov    0x10(%ebp),%eax
    8c39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8c3c:	8b 7d 14             	mov    0x14(%ebp),%edi
    8c3f:	89 45 e0             	mov    %eax,-0x20(%ebp)
    int i, sign;

    if ((sign = n) < 0)            /* record sign */
    8c42:	89 f0                	mov    %esi,%eax
    8c44:	f7 d8                	neg    %eax
    8c46:	0f 48 c6             	cmovs  %esi,%eax
    8c49:	31 c9                	xor    %ecx,%ecx
        n = -n;                    /* make n positive */
    i = 0;
    do {                           /* generate digits in reverse order */
        s[i++] = table[n % root];  /* get next digit */
    8c4b:	99                   	cltd   
    8c4c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    8c4f:	41                   	inc    %ecx
    } while ((n /= root) > 0);     /* delete it */
    8c50:	f7 7d e0             	idivl  -0x20(%ebp)
        s[i++] = table[n % root];  /* get next digit */
    8c53:	8a 14 17             	mov    (%edi,%edx,1),%dl
    8c56:	88 54 0b ff          	mov    %dl,-0x1(%ebx,%ecx,1)
    8c5a:	89 ca                	mov    %ecx,%edx
    } while ((n /= root) > 0);     /* delete it */
    8c5c:	85 c0                	test   %eax,%eax
    8c5e:	7f eb                	jg     8c4b <itox+0x21>
    if (sign < 0)
    8c60:	85 f6                	test   %esi,%esi
    8c62:	79 0a                	jns    8c6e <itox+0x44>
        s[i++] = '-';
    8c64:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    8c67:	c6 04 13 2d          	movb   $0x2d,(%ebx,%edx,1)
    8c6b:	83 c1 02             	add    $0x2,%ecx
    s[i] = '\0';
    8c6e:	c6 04 0b 00          	movb   $0x0,(%ebx,%ecx,1)
    reverse(s);
    8c72:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
    8c75:	83 c4 1c             	add    $0x1c,%esp
    8c78:	5b                   	pop    %ebx
    8c79:	5e                   	pop    %esi
    8c7a:	5f                   	pop    %edi
    8c7b:	5d                   	pop    %ebp
    reverse(s);
    8c7c:	e9 74 ff ff ff       	jmp    8bf5 <reverse>

00008c81 <itoa>:

void itoa(int n, char s[])
{
    8c81:	55                   	push   %ebp
    8c82:	89 e5                	mov    %esp,%ebp
    8c84:	83 ec 08             	sub    $0x8,%esp
    static char dec[] = "0123456789";
    itox(n, s, 10, dec);
    8c87:	68 94 92 00 00       	push   $0x9294
    8c8c:	6a 0a                	push   $0xa
    8c8e:	ff 75 0c             	push   0xc(%ebp)
    8c91:	ff 75 08             	push   0x8(%ebp)
    8c94:	e8 91 ff ff ff       	call   8c2a <itox>
}
    8c99:	83 c4 10             	add    $0x10,%esp
    8c9c:	c9                   	leave  
    8c9d:	c3                   	ret    

00008c9e <itoh>:

void itoh(int n, char *s)
{
    8c9e:	55                   	push   %ebp
    8c9f:	89 e5                	mov    %esp,%ebp
    8ca1:	83 ec 08             	sub    $0x8,%esp
    static char hex[] = "0123456789abcdef";
    itox(n, s, 16, hex);
    8ca4:	68 80 92 00 00       	push   $0x9280
    8ca9:	6a 10                	push   $0x10
    8cab:	ff 75 0c             	push   0xc(%ebp)
    8cae:	ff 75 08             	push   0x8(%ebp)
    8cb1:	e8 74 ff ff ff       	call   8c2a <itox>
}
    8cb6:	83 c4 10             	add    $0x10,%esp
    8cb9:	c9                   	leave  
    8cba:	c3                   	ret    

00008cbb <puti>:
{
    8cbb:	55                   	push   %ebp
    8cbc:	89 e5                	mov    %esp,%ebp
    8cbe:	83 ec 10             	sub    $0x10,%esp
    itoh(i, puti_str);
    8cc1:	68 20 93 00 00       	push   $0x9320
    8cc6:	ff 75 08             	push   0x8(%ebp)
    8cc9:	e8 d0 ff ff ff       	call   8c9e <itoh>
    putline(puti_str);
    8cce:	c7 45 08 20 93 00 00 	movl   $0x9320,0x8(%ebp)
    8cd5:	83 c4 10             	add    $0x10,%esp
}
    8cd8:	c9                   	leave  
    putline(puti_str);
    8cd9:	e9 9d fe ff ff       	jmp    8b7b <putline>

00008cde <readsector>:
    while ((inb(0x1F7) & 0xC0) != 0x40)
        /* do nothing */ ;
}

void readsector(void *dst, uint32_t offset)
{
    8cde:	55                   	push   %ebp
    8cdf:	89 e5                	mov    %esp,%ebp
    8ce1:	57                   	push   %edi
}

static inline uint8_t inb(int port)
{
    uint8_t data;
    __asm __volatile ("inb %w1,%0" : "=a" (data) : "d" (port));
    8ce2:	bf f7 01 00 00       	mov    $0x1f7,%edi
    8ce7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    8cea:	89 fa                	mov    %edi,%edx
    8cec:	ec                   	in     (%dx),%al
    while ((inb(0x1F7) & 0xC0) != 0x40)
    8ced:	83 e0 c0             	and    $0xffffffc0,%eax
    8cf0:	3c 40                	cmp    $0x40,%al
    8cf2:	75 f6                	jne    8cea <readsector+0xc>
    __asm __volatile ("outb %0,%w1" :: "a" (data), "d" (port));
    8cf4:	b0 01                	mov    $0x1,%al
    8cf6:	ba f2 01 00 00       	mov    $0x1f2,%edx
    8cfb:	ee                   	out    %al,(%dx)
    8cfc:	ba f3 01 00 00       	mov    $0x1f3,%edx
    8d01:	89 c8                	mov    %ecx,%eax
    8d03:	ee                   	out    %al,(%dx)
    // wait for disk to be ready
    waitdisk();

    outb(0x1F2, 1);     // count = 1
    outb(0x1F3, offset);
    outb(0x1F4, offset >> 8);
    8d04:	89 c8                	mov    %ecx,%eax
    8d06:	ba f4 01 00 00       	mov    $0x1f4,%edx
    8d0b:	c1 e8 08             	shr    $0x8,%eax
    8d0e:	ee                   	out    %al,(%dx)
    outb(0x1F5, offset >> 16);
    8d0f:	89 c8                	mov    %ecx,%eax
    8d11:	ba f5 01 00 00       	mov    $0x1f5,%edx
    8d16:	c1 e8 10             	shr    $0x10,%eax
    8d19:	ee                   	out    %al,(%dx)
    outb(0x1F6, (offset >> 24) | 0xE0);
    8d1a:	89 c8                	mov    %ecx,%eax
    8d1c:	ba f6 01 00 00       	mov    $0x1f6,%edx
    8d21:	c1 e8 18             	shr    $0x18,%eax
    8d24:	83 c8 e0             	or     $0xffffffe0,%eax
    8d27:	ee                   	out    %al,(%dx)
    8d28:	b0 20                	mov    $0x20,%al
    8d2a:	89 fa                	mov    %edi,%edx
    8d2c:	ee                   	out    %al,(%dx)
    __asm __volatile ("inb %w1,%0" : "=a" (data) : "d" (port));
    8d2d:	ba f7 01 00 00       	mov    $0x1f7,%edx
    8d32:	ec                   	in     (%dx),%al
    while ((inb(0x1F7) & 0xC0) != 0x40)
    8d33:	83 e0 c0             	and    $0xffffffc0,%eax
    8d36:	3c 40                	cmp    $0x40,%al
    8d38:	75 f8                	jne    8d32 <readsector+0x54>
    return data;
}

static inline void insl(int port, void *addr, int cnt)
{
    __asm __volatile ("cld\n\trepne\n\tinsl"
    8d3a:	8b 7d 08             	mov    0x8(%ebp),%edi
    8d3d:	b9 80 00 00 00       	mov    $0x80,%ecx
    8d42:	ba f0 01 00 00       	mov    $0x1f0,%edx
    8d47:	fc                   	cld    
    8d48:	f2 6d                	repnz insl (%dx),%es:(%edi)
    // wait for disk to be ready
    waitdisk();

    // read a sector
    insl(0x1F0, dst, SECTOR_SIZE / 4);
}
    8d4a:	5f                   	pop    %edi
    8d4b:	5d                   	pop    %ebp
    8d4c:	c3                   	ret    

00008d4d <readsection>:

// Read 'count' bytes at 'offset' from kernel into virtual address 'va'.
// Might copy more than asked
void readsection(uint32_t va, uint32_t count, uint32_t offset, uint32_t lba)
{
    8d4d:	55                   	push   %ebp
    8d4e:	89 e5                	mov    %esp,%ebp
    8d50:	57                   	push   %edi
    8d51:	56                   	push   %esi
    8d52:	53                   	push   %ebx
    8d53:	83 ec 0c             	sub    $0xc,%esp
    8d56:	8b 5d 08             	mov    0x8(%ebp),%ebx
    end_va = va + count;
    // round down to sector boundary
    va &= ~(SECTOR_SIZE - 1);

    // translate from bytes to sectors, and kernel starts at sector 1
    offset = (offset / SECTOR_SIZE) + lba;
    8d59:	8b 75 10             	mov    0x10(%ebp),%esi
    va &= 0xFFFFFF;
    8d5c:	89 df                	mov    %ebx,%edi
    offset = (offset / SECTOR_SIZE) + lba;
    8d5e:	c1 ee 09             	shr    $0x9,%esi
    va &= ~(SECTOR_SIZE - 1);
    8d61:	81 e3 00 fe ff 00    	and    $0xfffe00,%ebx
    offset = (offset / SECTOR_SIZE) + lba;
    8d67:	03 75 14             	add    0x14(%ebp),%esi
    va &= 0xFFFFFF;
    8d6a:	81 e7 ff ff ff 00    	and    $0xffffff,%edi
    end_va = va + count;
    8d70:	03 7d 0c             	add    0xc(%ebp),%edi

    // If this is too slow, we could read lots of sectors at a time.
    // We'd write more to memory than asked, but it doesn't matter --
    // we load in increasing order.
    while (va < end_va) {
    8d73:	39 fb                	cmp    %edi,%ebx
    8d75:	73 15                	jae    8d8c <readsection+0x3f>
        readsector((uint8_t *) va, offset);
    8d77:	50                   	push   %eax
    8d78:	50                   	push   %eax
    8d79:	56                   	push   %esi
        va += SECTOR_SIZE;
        offset++;
    8d7a:	46                   	inc    %esi
        readsector((uint8_t *) va, offset);
    8d7b:	53                   	push   %ebx
        va += SECTOR_SIZE;
    8d7c:	81 c3 00 02 00 00    	add    $0x200,%ebx
        readsector((uint8_t *) va, offset);
    8d82:	e8 57 ff ff ff       	call   8cde <readsector>
        offset++;
    8d87:	83 c4 10             	add    $0x10,%esp
    8d8a:	eb e7                	jmp    8d73 <readsection+0x26>
    }
}
    8d8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    8d8f:	5b                   	pop    %ebx
    8d90:	5e                   	pop    %esi
    8d91:	5f                   	pop    %edi
    8d92:	5d                   	pop    %ebp
    8d93:	c3                   	ret    

00008d94 <load_kernel>:
}

#define ELFHDR ((elfhdr *) 0x20000)

uint32_t load_kernel(uint32_t dkernel)
{
    8d94:	55                   	push   %ebp
    8d95:	89 e5                	mov    %esp,%ebp
    8d97:	57                   	push   %edi
    8d98:	56                   	push   %esi
    8d99:	53                   	push   %ebx
    8d9a:	83 ec 0c             	sub    $0xc,%esp
    8d9d:	8b 7d 08             	mov    0x8(%ebp),%edi
    // load kernel from the beginning of the first bootable partition
    proghdr *ph, *eph;

    readsection((uint32_t) ELFHDR, SECTOR_SIZE * 8, 0, dkernel);
    8da0:	57                   	push   %edi
    8da1:	6a 00                	push   $0x0
    8da3:	68 00 10 00 00       	push   $0x1000
    8da8:	68 00 00 02 00       	push   $0x20000
    8dad:	e8 9b ff ff ff       	call   8d4d <readsection>

    // is this a valid ELF?
    if (ELFHDR->e_magic != ELF_MAGIC)
    8db2:	83 c4 10             	add    $0x10,%esp
    8db5:	81 3d 00 00 02 00 7f 	cmpl   $0x464c457f,0x20000
    8dbc:	45 4c 46 
    8dbf:	74 10                	je     8dd1 <load_kernel+0x3d>
        panic("Kernel is not a valid elf.");
    8dc1:	83 ec 0c             	sub    $0xc,%esp
    8dc4:	68 79 8f 00 00       	push   $0x8f79
    8dc9:	e8 fa fd ff ff       	call   8bc8 <panic>
    8dce:	83 c4 10             	add    $0x10,%esp

    // load each program segment (ignores ph flags)
    ph = (proghdr *) ((uint8_t *) ELFHDR + ELFHDR->e_phoff);
    8dd1:	a1 1c 00 02 00       	mov    0x2001c,%eax
    eph = ph + ELFHDR->e_phnum;
    8dd6:	0f b7 35 2c 00 02 00 	movzwl 0x2002c,%esi
    ph = (proghdr *) ((uint8_t *) ELFHDR + ELFHDR->e_phoff);
    8ddd:	8d 98 00 00 02 00    	lea    0x20000(%eax),%ebx
    eph = ph + ELFHDR->e_phnum;
    8de3:	c1 e6 05             	shl    $0x5,%esi
    8de6:	01 de                	add    %ebx,%esi

    for (; ph < eph; ph++) {
    8de8:	39 f3                	cmp    %esi,%ebx
    8dea:	73 17                	jae    8e03 <load_kernel+0x6f>
        readsection(ph->p_va, ph->p_memsz, ph->p_offset, dkernel);
    8dec:	57                   	push   %edi
    for (; ph < eph; ph++) {
    8ded:	83 c3 20             	add    $0x20,%ebx
        readsection(ph->p_va, ph->p_memsz, ph->p_offset, dkernel);
    8df0:	ff 73 e4             	push   -0x1c(%ebx)
    8df3:	ff 73 f4             	push   -0xc(%ebx)
    8df6:	ff 73 e8             	push   -0x18(%ebx)
    8df9:	e8 4f ff ff ff       	call   8d4d <readsection>
    for (; ph < eph; ph++) {
    8dfe:	83 c4 10             	add    $0x10,%esp
    8e01:	eb e5                	jmp    8de8 <load_kernel+0x54>
    }

    return (ELFHDR->e_entry & 0xFFFFFF);
    8e03:	a1 18 00 02 00       	mov    0x20018,%eax
}
    8e08:	8d 65 f4             	lea    -0xc(%ebp),%esp
    8e0b:	5b                   	pop    %ebx
    8e0c:	5e                   	pop    %esi
    return (ELFHDR->e_entry & 0xFFFFFF);
    8e0d:	25 ff ff ff 00       	and    $0xffffff,%eax
}
    8e12:	5f                   	pop    %edi
    8e13:	5d                   	pop    %ebp
    8e14:	c3                   	ret    

00008e15 <parse_e820>:

mboot_info_t *parse_e820(bios_smap_t *smap)
{
    8e15:	55                   	push   %ebp
    8e16:	89 e5                	mov    %esp,%ebp
    8e18:	56                   	push   %esi
    8e19:	53                   	push   %ebx
    8e1a:	8b 75 08             	mov    0x8(%ebp),%esi
    bios_smap_t *p;
    uint32_t mmap_len;
    p = smap;
    mmap_len = 0;
    8e1d:	31 db                	xor    %ebx,%ebx
    putline("* E820 Memory Map *");
    8e1f:	83 ec 0c             	sub    $0xc,%esp
    8e22:	68 94 8f 00 00       	push   $0x8f94
    8e27:	e8 4f fd ff ff       	call   8b7b <putline>
    while (p->base_addr != 0 || p->length != 0 || p->type != 0) {
    8e2c:	83 c4 10             	add    $0x10,%esp
    8e2f:	8b 44 1e 04          	mov    0x4(%esi,%ebx,1),%eax
    8e33:	89 c1                	mov    %eax,%ecx
    8e35:	0b 4c 1e 08          	or     0x8(%esi,%ebx,1),%ecx
    8e39:	74 11                	je     8e4c <parse_e820+0x37>
        puti(p->base_addr);
    8e3b:	83 ec 0c             	sub    $0xc,%esp
        p++;
        mmap_len += sizeof(bios_smap_t);
    8e3e:	83 c3 18             	add    $0x18,%ebx
        puti(p->base_addr);
    8e41:	50                   	push   %eax
    8e42:	e8 74 fe ff ff       	call   8cbb <puti>
        mmap_len += sizeof(bios_smap_t);
    8e47:	83 c4 10             	add    $0x10,%esp
    8e4a:	eb e3                	jmp    8e2f <parse_e820+0x1a>
    while (p->base_addr != 0 || p->length != 0 || p->type != 0) {
    8e4c:	8b 54 1e 10          	mov    0x10(%esi,%ebx,1),%edx
    8e50:	0b 54 1e 0c          	or     0xc(%esi,%ebx,1),%edx
    8e54:	75 e5                	jne    8e3b <parse_e820+0x26>
    8e56:	83 7c 1e 14 00       	cmpl   $0x0,0x14(%esi,%ebx,1)
    8e5b:	75 de                	jne    8e3b <parse_e820+0x26>
    }
    mboot_info.mmap_length = mmap_len;
    8e5d:	89 1d ec 92 00 00    	mov    %ebx,0x92ec
    mboot_info.mmap_addr = (uint32_t) smap;
    return &mboot_info;
}
    8e63:	b8 c0 92 00 00       	mov    $0x92c0,%eax
    mboot_info.mmap_addr = (uint32_t) smap;
    8e68:	89 35 f0 92 00 00    	mov    %esi,0x92f0
}
    8e6e:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8e71:	5b                   	pop    %ebx
    8e72:	5e                   	pop    %esi
    8e73:	5d                   	pop    %ebp
    8e74:	c3                   	ret    

00008e75 <boot1main>:
{
    8e75:	55                   	push   %ebp
    8e76:	89 e5                	mov    %esp,%ebp
    8e78:	56                   	push   %esi
    8e79:	53                   	push   %ebx
    8e7a:	8b 75 0c             	mov    0xc(%ebp),%esi
    8e7d:	8b 5d 10             	mov    0x10(%ebp),%ebx
    roll(3);
    8e80:	83 ec 0c             	sub    $0xc,%esp
    8e83:	6a 03                	push   $0x3
    8e85:	e8 31 fd ff ff       	call   8bbb <roll>
    putline("Start boot1 main ...");
    8e8a:	c7 04 24 a8 8f 00 00 	movl   $0x8fa8,(%esp)
    8e91:	e8 e5 fc ff ff       	call   8b7b <putline>
    8e96:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < 4; i++) {
    8e99:	31 c0                	xor    %eax,%eax
        if (mbr->partition[i].bootable == BOOTABLE_PARTITION) {
    8e9b:	89 c2                	mov    %eax,%edx
    8e9d:	c1 e2 04             	shl    $0x4,%edx
    8ea0:	80 bc 16 be 01 00 00 	cmpb   $0x80,0x1be(%esi,%edx,1)
    8ea7:	80 
    8ea8:	75 09                	jne    8eb3 <boot1main+0x3e>
            bootable_lba = mbr->partition[i].first_lba;
    8eaa:	8b b4 32 c6 01 00 00 	mov    0x1c6(%edx,%esi,1),%esi
    if (i == 4)
    8eb1:	eb 18                	jmp    8ecb <boot1main+0x56>
    for (i = 0; i < 4; i++) {
    8eb3:	40                   	inc    %eax
    8eb4:	83 f8 04             	cmp    $0x4,%eax
    8eb7:	75 e2                	jne    8e9b <boot1main+0x26>
        panic("Cannot find bootable partition!");
    8eb9:	83 ec 0c             	sub    $0xc,%esp
    uint32_t bootable_lba = 0;
    8ebc:	31 f6                	xor    %esi,%esi
        panic("Cannot find bootable partition!");
    8ebe:	68 bd 8f 00 00       	push   $0x8fbd
    8ec3:	e8 00 fd ff ff       	call   8bc8 <panic>
    8ec8:	83 c4 10             	add    $0x10,%esp
    parse_e820(smap);
    8ecb:	83 ec 0c             	sub    $0xc,%esp
    8ece:	53                   	push   %ebx
    8ecf:	e8 41 ff ff ff       	call   8e15 <parse_e820>
    putline("Load kernel ...\n");
    8ed4:	c7 04 24 dd 8f 00 00 	movl   $0x8fdd,(%esp)
    8edb:	e8 9b fc ff ff       	call   8b7b <putline>
    uint32_t entry = load_kernel(bootable_lba);
    8ee0:	89 34 24             	mov    %esi,(%esp)
    8ee3:	e8 ac fe ff ff       	call   8d94 <load_kernel>
    putline("Start kernel ...\n");
    8ee8:	c7 04 24 ee 8f 00 00 	movl   $0x8fee,(%esp)
    uint32_t entry = load_kernel(bootable_lba);
    8eef:	89 c3                	mov    %eax,%ebx
    putline("Start kernel ...\n");
    8ef1:	e8 85 fc ff ff       	call   8b7b <putline>
    exec_kernel(entry, &mboot_info);
    8ef6:	58                   	pop    %eax
    8ef7:	5a                   	pop    %edx
    8ef8:	68 c0 92 00 00       	push   $0x92c0
    8efd:	53                   	push   %ebx
    8efe:	e8 15 00 00 00       	call   8f18 <exec_kernel>
    panic("Fail to load kernel.");
    8f03:	c7 45 08 00 90 00 00 	movl   $0x9000,0x8(%ebp)
    8f0a:	83 c4 10             	add    $0x10,%esp
}
    8f0d:	8d 65 f8             	lea    -0x8(%ebp),%esp
    8f10:	5b                   	pop    %ebx
    8f11:	5e                   	pop    %esi
    8f12:	5d                   	pop    %ebp
    panic("Fail to load kernel.");
    8f13:	e9 b0 fc ff ff       	jmp    8bc8 <panic>

00008f18 <exec_kernel>:
	.set MBOOT_INFO_MAGIC, 0x2badb002

	.globl exec_kernel
	.code32
exec_kernel:
	cli
    8f18:	fa                   	cli    
	movl	$MBOOT_INFO_MAGIC, %eax
    8f19:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
	movl	8(%esp), %ebx
    8f1e:	8b 5c 24 08          	mov    0x8(%esp),%ebx
	movl	4(%esp), %edx
    8f22:	8b 54 24 04          	mov    0x4(%esp),%edx
	jmp	*%edx
    8f26:	ff e2                	jmp    *%edx

Disassembly of section .rodata:

00008f28 <.rodata>:
    8f28:	20 20                	and    %ah,(%eax)
    8f2a:	20 20                	and    %ah,(%eax)
    8f2c:	20 20                	and    %ah,(%eax)
    8f2e:	20 20                	and    %ah,(%eax)
    8f30:	20 20                	and    %ah,(%eax)
    8f32:	20 20                	and    %ah,(%eax)
    8f34:	20 20                	and    %ah,(%eax)
    8f36:	20 20                	and    %ah,(%eax)
    8f38:	20 20                	and    %ah,(%eax)
    8f3a:	20 20                	and    %ah,(%eax)
    8f3c:	20 20                	and    %ah,(%eax)
    8f3e:	20 20                	and    %ah,(%eax)
    8f40:	20 20                	and    %ah,(%eax)
    8f42:	20 20                	and    %ah,(%eax)
    8f44:	20 20                	and    %ah,(%eax)
    8f46:	20 20                	and    %ah,(%eax)
    8f48:	20 20                	and    %ah,(%eax)
    8f4a:	20 20                	and    %ah,(%eax)
    8f4c:	20 20                	and    %ah,(%eax)
    8f4e:	20 20                	and    %ah,(%eax)
    8f50:	20 20                	and    %ah,(%eax)
    8f52:	20 20                	and    %ah,(%eax)
    8f54:	20 20                	and    %ah,(%eax)
    8f56:	20 20                	and    %ah,(%eax)
    8f58:	20 20                	and    %ah,(%eax)
    8f5a:	20 20                	and    %ah,(%eax)
    8f5c:	20 20                	and    %ah,(%eax)
    8f5e:	20 20                	and    %ah,(%eax)
    8f60:	20 20                	and    %ah,(%eax)
    8f62:	20 20                	and    %ah,(%eax)
    8f64:	20 20                	and    %ah,(%eax)
    8f66:	20 20                	and    %ah,(%eax)
    8f68:	20 20                	and    %ah,(%eax)
    8f6a:	20 20                	and    %ah,(%eax)
    8f6c:	20 20                	and    %ah,(%eax)
    8f6e:	20 20                	and    %ah,(%eax)
    8f70:	20 20                	and    %ah,(%eax)
    8f72:	20 20                	and    %ah,(%eax)
    8f74:	20 20                	and    %ah,(%eax)
    8f76:	20 20                	and    %ah,(%eax)
    8f78:	00 4b 65             	add    %cl,0x65(%ebx)
    8f7b:	72 6e                	jb     8feb <exec_kernel+0xd3>
    8f7d:	65 6c                	gs insb (%dx),%es:(%edi)
    8f7f:	20 69 73             	and    %ch,0x73(%ecx)
    8f82:	20 6e 6f             	and    %ch,0x6f(%esi)
    8f85:	74 20                	je     8fa7 <exec_kernel+0x8f>
    8f87:	61                   	popa   
    8f88:	20 76 61             	and    %dh,0x61(%esi)
    8f8b:	6c                   	insb   (%dx),%es:(%edi)
    8f8c:	69 64 20 65 6c 66 2e 	imul   $0x2e666c,0x65(%eax,%eiz,1),%esp
    8f93:	00 
    8f94:	2a 20                	sub    (%eax),%ah
    8f96:	45                   	inc    %ebp
    8f97:	38 32                	cmp    %dh,(%edx)
    8f99:	30 20                	xor    %ah,(%eax)
    8f9b:	4d                   	dec    %ebp
    8f9c:	65 6d                	gs insl (%dx),%es:(%edi)
    8f9e:	6f                   	outsl  %ds:(%esi),(%dx)
    8f9f:	72 79                	jb     901a <exec_kernel+0x102>
    8fa1:	20 4d 61             	and    %cl,0x61(%ebp)
    8fa4:	70 20                	jo     8fc6 <exec_kernel+0xae>
    8fa6:	2a 00                	sub    (%eax),%al
    8fa8:	53                   	push   %ebx
    8fa9:	74 61                	je     900c <exec_kernel+0xf4>
    8fab:	72 74                	jb     9021 <exec_kernel+0x109>
    8fad:	20 62 6f             	and    %ah,0x6f(%edx)
    8fb0:	6f                   	outsl  %ds:(%esi),(%dx)
    8fb1:	74 31                	je     8fe4 <exec_kernel+0xcc>
    8fb3:	20 6d 61             	and    %ch,0x61(%ebp)
    8fb6:	69 6e 20 2e 2e 2e 00 	imul   $0x2e2e2e,0x20(%esi),%ebp
    8fbd:	43                   	inc    %ebx
    8fbe:	61                   	popa   
    8fbf:	6e                   	outsb  %ds:(%esi),(%dx)
    8fc0:	6e                   	outsb  %ds:(%esi),(%dx)
    8fc1:	6f                   	outsl  %ds:(%esi),(%dx)
    8fc2:	74 20                	je     8fe4 <exec_kernel+0xcc>
    8fc4:	66 69 6e 64 20 62    	imul   $0x6220,0x64(%esi),%bp
    8fca:	6f                   	outsl  %ds:(%esi),(%dx)
    8fcb:	6f                   	outsl  %ds:(%esi),(%dx)
    8fcc:	74 61                	je     902f <exec_kernel+0x117>
    8fce:	62 6c 65 20          	bound  %ebp,0x20(%ebp,%eiz,2)
    8fd2:	70 61                	jo     9035 <exec_kernel+0x11d>
    8fd4:	72 74                	jb     904a <exec_kernel+0x132>
    8fd6:	69 74 69 6f 6e 21 00 	imul   $0x4c00216e,0x6f(%ecx,%ebp,2),%esi
    8fdd:	4c 
    8fde:	6f                   	outsl  %ds:(%esi),(%dx)
    8fdf:	61                   	popa   
    8fe0:	64 20 6b 65          	and    %ch,%fs:0x65(%ebx)
    8fe4:	72 6e                	jb     9054 <exec_kernel+0x13c>
    8fe6:	65 6c                	gs insb (%dx),%es:(%edi)
    8fe8:	20 2e                	and    %ch,(%esi)
    8fea:	2e 2e 0a 00          	cs or  %cs:(%eax),%al
    8fee:	53                   	push   %ebx
    8fef:	74 61                	je     9052 <exec_kernel+0x13a>
    8ff1:	72 74                	jb     9067 <exec_kernel+0x14f>
    8ff3:	20 6b 65             	and    %ch,0x65(%ebx)
    8ff6:	72 6e                	jb     9066 <exec_kernel+0x14e>
    8ff8:	65 6c                	gs insb (%dx),%es:(%edi)
    8ffa:	20 2e                	and    %ch,(%esi)
    8ffc:	2e 2e 0a 00          	cs or  %cs:(%eax),%al
    9000:	46                   	inc    %esi
    9001:	61                   	popa   
    9002:	69 6c 20 74 6f 20 6c 	imul   $0x6f6c206f,0x74(%eax,%eiz,1),%ebp
    9009:	6f 
    900a:	61                   	popa   
    900b:	64 20 6b 65          	and    %ch,%fs:0x65(%ebx)
    900f:	72 6e                	jb     907f <exec_kernel+0x167>
    9011:	65 6c                	gs insb (%dx),%es:(%edi)
    9013:	2e                   	cs
    9014:	00                   	.byte 0x0

Disassembly of section .eh_frame:

00009018 <.eh_frame>:
    9018:	14 00                	adc    $0x0,%al
    901a:	00 00                	add    %al,(%eax)
    901c:	00 00                	add    %al,(%eax)
    901e:	00 00                	add    %al,(%eax)
    9020:	01 7a 52             	add    %edi,0x52(%edx)
    9023:	00 01                	add    %al,(%ecx)
    9025:	7c 08                	jl     902f <exec_kernel+0x117>
    9027:	01 1b                	add    %ebx,(%ebx)
    9029:	0c 04                	or     $0x4,%al
    902b:	04 88                	add    $0x88,%al
    902d:	01 00                	add    %eax,(%eax)
    902f:	00 1c 00             	add    %bl,(%eax,%eax,1)
    9032:	00 00                	add    %al,(%eax)
    9034:	1c 00                	sbb    $0x0,%al
    9036:	00 00                	add    %al,(%eax)
    9038:	ee                   	out    %al,(%dx)
    9039:	fa                   	cli    
    903a:	ff                   	(bad)  
    903b:	ff 1b                	lcall  *(%ebx)
    903d:	00 00                	add    %al,(%eax)
    903f:	00 00                	add    %al,(%eax)
    9041:	41                   	inc    %ecx
    9042:	0e                   	push   %cs
    9043:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9049:	57                   	push   %edi
    904a:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    904d:	04 00                	add    $0x0,%al
    904f:	00 24 00             	add    %ah,(%eax,%eax,1)
    9052:	00 00                	add    %al,(%eax)
    9054:	3c 00                	cmp    $0x0,%al
    9056:	00 00                	add    %al,(%eax)
    9058:	e9 fa ff ff 3a       	jmp    3b009057 <MBOOT_INFO_MAGIC+0xf52e055>
    905d:	00 00                	add    %al,(%eax)
    905f:	00 00                	add    %al,(%eax)
    9061:	41                   	inc    %ecx
    9062:	0e                   	push   %cs
    9063:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9069:	42                   	inc    %edx
    906a:	86 03                	xchg   %al,(%ebx)
    906c:	83 04 72 c3          	addl   $0xffffffc3,(%edx,%esi,2)
    9070:	41                   	inc    %ecx
    9071:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    9075:	04 04                	add    $0x4,%al
    9077:	00 20                	add    %ah,(%eax)
    9079:	00 00                	add    %al,(%eax)
    907b:	00 64 00 00          	add    %ah,0x0(%eax,%eax,1)
    907f:	00 fb                	add    %bh,%bl
    9081:	fa                   	cli    
    9082:	ff                   	(bad)  
    9083:	ff 40 00             	incl   0x0(%eax)
    9086:	00 00                	add    %al,(%eax)
    9088:	00 41 0e             	add    %al,0xe(%ecx)
    908b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9091:	42                   	inc    %edx
    9092:	83 03 7a             	addl   $0x7a,(%ebx)
    9095:	c5 c3 0c             	(bad)
    9098:	04 04                	add    $0x4,%al
    909a:	00 00                	add    %al,(%eax)
    909c:	1c 00                	sbb    $0x0,%al
    909e:	00 00                	add    %al,(%eax)
    90a0:	88 00                	mov    %al,(%eax)
    90a2:	00 00                	add    %al,(%eax)
    90a4:	17                   	pop    %ss
    90a5:	fb                   	sti    
    90a6:	ff                   	(bad)  
    90a7:	ff 0d 00 00 00 00    	decl   0x0
    90ad:	41                   	inc    %ecx
    90ae:	0e                   	push   %cs
    90af:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    90b5:	44                   	inc    %esp
    90b6:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    90b9:	04 00                	add    $0x0,%al
    90bb:	00 18                	add    %bl,(%eax)
    90bd:	00 00                	add    %al,(%eax)
    90bf:	00 a8 00 00 00 04    	add    %ch,0x4000000(%eax)
    90c5:	fb                   	sti    
    90c6:	ff                   	(bad)  
    90c7:	ff 1a                	lcall  *(%edx)
    90c9:	00 00                	add    %al,(%eax)
    90cb:	00 00                	add    %al,(%eax)
    90cd:	41                   	inc    %ecx
    90ce:	0e                   	push   %cs
    90cf:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    90d5:	00 00                	add    %al,(%eax)
    90d7:	00 1c 00             	add    %bl,(%eax,%eax,1)
    90da:	00 00                	add    %al,(%eax)
    90dc:	c4 00                	les    (%eax),%eax
    90de:	00 00                	add    %al,(%eax)
    90e0:	02 fb                	add    %bl,%bh
    90e2:	ff                   	(bad)  
    90e3:	ff 13                	call   *(%ebx)
    90e5:	00 00                	add    %al,(%eax)
    90e7:	00 00                	add    %al,(%eax)
    90e9:	41                   	inc    %ecx
    90ea:	0e                   	push   %cs
    90eb:	08 85 02 44 0d 05    	or     %al,0x50d4402(%ebp)
    90f1:	4d                   	dec    %ebp
    90f2:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    90f5:	04 00                	add    $0x0,%al
    90f7:	00 24 00             	add    %ah,(%eax,%eax,1)
    90fa:	00 00                	add    %al,(%eax)
    90fc:	e4 00                	in     $0x0,%al
    90fe:	00 00                	add    %al,(%eax)
    9100:	f5                   	cmc    
    9101:	fa                   	cli    
    9102:	ff                   	(bad)  
    9103:	ff 35 00 00 00 00    	push   0x0
    9109:	41                   	inc    %ecx
    910a:	0e                   	push   %cs
    910b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9111:	42                   	inc    %edx
    9112:	86 03                	xchg   %al,(%ebx)
    9114:	83 04 6d c3 41 c6 41 	addl   $0xffffffc5,0x41c641c3(,%ebp,2)
    911b:	c5 
    911c:	0c 04                	or     $0x4,%al
    911e:	04 00                	add    $0x0,%al
    9120:	28 00                	sub    %al,(%eax)
    9122:	00 00                	add    %al,(%eax)
    9124:	0c 01                	or     $0x1,%al
    9126:	00 00                	add    %al,(%eax)
    9128:	02 fb                	add    %bl,%bh
    912a:	ff                   	(bad)  
    912b:	ff 57 00             	call   *0x0(%edi)
    912e:	00 00                	add    %al,(%eax)
    9130:	00 41 0e             	add    %al,0xe(%ecx)
    9133:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9139:	46                   	inc    %esi
    913a:	87 03                	xchg   %eax,(%ebx)
    913c:	86 04 83             	xchg   %al,(%ebx,%eax,4)
    913f:	05 02 46 c3 41       	add    $0x41c34602,%eax
    9144:	c6 41 c7 41          	movb   $0x41,-0x39(%ecx)
    9148:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    914b:	04 1c                	add    $0x1c,%al
    914d:	00 00                	add    %al,(%eax)
    914f:	00 38                	add    %bh,(%eax)
    9151:	01 00                	add    %eax,(%eax)
    9153:	00 2d fb ff ff 1d    	add    %ch,0x1dfffffb
    9159:	00 00                	add    %al,(%eax)
    915b:	00 00                	add    %al,(%eax)
    915d:	41                   	inc    %ecx
    915e:	0e                   	push   %cs
    915f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9165:	59                   	pop    %ecx
    9166:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9169:	04 00                	add    $0x0,%al
    916b:	00 1c 00             	add    %bl,(%eax,%eax,1)
    916e:	00 00                	add    %al,(%eax)
    9170:	58                   	pop    %eax
    9171:	01 00                	add    %eax,(%eax)
    9173:	00 2a                	add    %ch,(%edx)
    9175:	fb                   	sti    
    9176:	ff                   	(bad)  
    9177:	ff 1d 00 00 00 00    	lcall  *0x0
    917d:	41                   	inc    %ecx
    917e:	0e                   	push   %cs
    917f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9185:	59                   	pop    %ecx
    9186:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9189:	04 00                	add    $0x0,%al
    918b:	00 1c 00             	add    %bl,(%eax,%eax,1)
    918e:	00 00                	add    %al,(%eax)
    9190:	78 01                	js     9193 <exec_kernel+0x27b>
    9192:	00 00                	add    %al,(%eax)
    9194:	27                   	daa    
    9195:	fb                   	sti    
    9196:	ff                   	(bad)  
    9197:	ff 23                	jmp    *(%ebx)
    9199:	00 00                	add    %al,(%eax)
    919b:	00 00                	add    %al,(%eax)
    919d:	41                   	inc    %ecx
    919e:	0e                   	push   %cs
    919f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    91a5:	5b                   	pop    %ebx
    91a6:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    91a9:	04 00                	add    $0x0,%al
    91ab:	00 20                	add    %ah,(%eax)
    91ad:	00 00                	add    %al,(%eax)
    91af:	00 98 01 00 00 2a    	add    %bl,0x2a000001(%eax)
    91b5:	fb                   	sti    
    91b6:	ff                   	(bad)  
    91b7:	ff 6f 00             	ljmp   *0x0(%edi)
    91ba:	00 00                	add    %al,(%eax)
    91bc:	00 41 0e             	add    %al,0xe(%ecx)
    91bf:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    91c5:	41                   	inc    %ecx
    91c6:	87 03                	xchg   %eax,(%ebx)
    91c8:	02 69 c7             	add    -0x39(%ecx),%ch
    91cb:	41                   	inc    %ecx
    91cc:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    91cf:	04 28                	add    $0x28,%al
    91d1:	00 00                	add    %al,(%eax)
    91d3:	00 bc 01 00 00 75 fb 	add    %bh,-0x48b0000(%ecx,%eax,1)
    91da:	ff                   	(bad)  
    91db:	ff 47 00             	incl   0x0(%edi)
    91de:	00 00                	add    %al,(%eax)
    91e0:	00 41 0e             	add    %al,0xe(%ecx)
    91e3:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    91e9:	46                   	inc    %esi
    91ea:	87 03                	xchg   %eax,(%ebx)
    91ec:	86 04 83             	xchg   %al,(%ebx,%eax,4)
    91ef:	05 7a c3 41 c6       	add    $0xc641c37a,%eax
    91f4:	41                   	inc    %ecx
    91f5:	c7 41 c5 0c 04 04 00 	movl   $0x4040c,-0x3b(%ecx)
    91fc:	28 00                	sub    %al,(%eax)
    91fe:	00 00                	add    %al,(%eax)
    9200:	e8 01 00 00 90       	call   90009206 <SMAP_SIG+0x3cb350b6>
    9205:	fb                   	sti    
    9206:	ff                   	(bad)  
    9207:	ff 81 00 00 00 00    	incl   0x0(%ecx)
    920d:	41                   	inc    %ecx
    920e:	0e                   	push   %cs
    920f:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9215:	46                   	inc    %esi
    9216:	87 03                	xchg   %eax,(%ebx)
    9218:	86 04 83             	xchg   %al,(%ebx,%eax,4)
    921b:	05 02 6f c3 41       	add    $0x41c36f02,%eax
    9220:	c6 46 c7 41          	movb   $0x41,-0x39(%esi)
    9224:	c5 0c 04             	lds    (%esp,%eax,1),%ecx
    9227:	04 24                	add    $0x24,%al
    9229:	00 00                	add    %al,(%eax)
    922b:	00 14 02             	add    %dl,(%edx,%eax,1)
    922e:	00 00                	add    %al,(%eax)
    9230:	e5 fb                	in     $0xfb,%eax
    9232:	ff                   	(bad)  
    9233:	ff 60 00             	jmp    *0x0(%eax)
    9236:	00 00                	add    %al,(%eax)
    9238:	00 41 0e             	add    %al,0xe(%ecx)
    923b:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9241:	42                   	inc    %edx
    9242:	86 03                	xchg   %al,(%ebx)
    9244:	83 04 02 58          	addl   $0x58,(%edx,%eax,1)
    9248:	c3                   	ret    
    9249:	41                   	inc    %ecx
    924a:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    924e:	04 04                	add    $0x4,%al
    9250:	24 00                	and    $0x0,%al
    9252:	00 00                	add    %al,(%eax)
    9254:	3c 02                	cmp    $0x2,%al
    9256:	00 00                	add    %al,(%eax)
    9258:	1d fc ff ff a3       	sbb    $0xa3fffffc,%eax
    925d:	00 00                	add    %al,(%eax)
    925f:	00 00                	add    %al,(%eax)
    9261:	41                   	inc    %ecx
    9262:	0e                   	push   %cs
    9263:	08 85 02 42 0d 05    	or     %al,0x50d4202(%ebp)
    9269:	42                   	inc    %edx
    926a:	86 03                	xchg   %al,(%ebx)
    926c:	83 04 02 97          	addl   $0xffffff97,(%edx,%eax,1)
    9270:	c3                   	ret    
    9271:	41                   	inc    %ecx
    9272:	c6 41 c5 0c          	movb   $0xc,-0x3b(%ecx)
    9276:	04 04                	add    $0x4,%al

Disassembly of section .data:

00009280 <hex.0>:
    9280:	30 31                	xor    %dh,(%ecx)
    9282:	32 33                	xor    (%ebx),%dh
    9284:	34 35                	xor    $0x35,%al
    9286:	36 37                	ss aaa 
    9288:	38 39                	cmp    %bh,(%ecx)
    928a:	61                   	popa   
    928b:	62 63 64             	bound  %esp,0x64(%ebx)
    928e:	65 66 00 00          	data16 add %al,%gs:(%eax)
    9292:	00 00                	add    %al,(%eax)

00009294 <dec.1>:
    9294:	30 31                	xor    %dh,(%ecx)
    9296:	32 33                	xor    (%ebx),%dh
    9298:	34 35                	xor    $0x35,%al
    929a:	36 37                	ss aaa 
    929c:	38 39                	cmp    %bh,(%ecx)
    929e:	00 00                	add    %al,(%eax)

000092a0 <blank>:
char *blank =
    92a0:	28 8f 00 00      	sub    %cl,-0x80000000(%edi)

000092a4 <video>:
volatile char *video = (volatile char *) 0xB8000;
    92a4:	00 80 0b 00 00 00    	add    %al,0xb(%eax)
    92aa:	00 00                	add    %al,(%eax)
    92ac:	00 00                	add    %al,(%eax)
    92ae:	00 00                	add    %al,(%eax)
    92b0:	00 00                	add    %al,(%eax)
    92b2:	00 00                	add    %al,(%eax)
    92b4:	00 00                	add    %al,(%eax)
    92b6:	00 00                	add    %al,(%eax)
    92b8:	00 00                	add    %al,(%eax)
    92ba:	00 00                	add    %al,(%eax)
    92bc:	00 00                	add    %al,(%eax)
    92be:	00 00                	add    %al,(%eax)

000092c0 <mboot_info>:
mboot_info_t mboot_info = {.flags = (1 << 6), };
    92c0:	40                   	inc    %eax
    92c1:	00 00                	add    %al,(%eax)
    92c3:	00 00                	add    %al,(%eax)
    92c5:	00 00                	add    %al,(%eax)
    92c7:	00 00                	add    %al,(%eax)
    92c9:	00 00                	add    %al,(%eax)
    92cb:	00 00                	add    %al,(%eax)
    92cd:	00 00                	add    %al,(%eax)
    92cf:	00 00                	add    %al,(%eax)
    92d1:	00 00                	add    %al,(%eax)
    92d3:	00 00                	add    %al,(%eax)
    92d5:	00 00                	add    %al,(%eax)
    92d7:	00 00                	add    %al,(%eax)
    92d9:	00 00                	add    %al,(%eax)
    92db:	00 00                	add    %al,(%eax)
    92dd:	00 00                	add    %al,(%eax)
    92df:	00 00                	add    %al,(%eax)
    92e1:	00 00                	add    %al,(%eax)
    92e3:	00 00                	add    %al,(%eax)
    92e5:	00 00                	add    %al,(%eax)
    92e7:	00 00                	add    %al,(%eax)
    92e9:	00 00                	add    %al,(%eax)
    92eb:	00 00                	add    %al,(%eax)
    92ed:	00 00                	add    %al,(%eax)
    92ef:	00 00                	add    %al,(%eax)
    92f1:	00 00                	add    %al,(%eax)
    92f3:	00 00                	add    %al,(%eax)
    92f5:	00 00                	add    %al,(%eax)
    92f7:	00 00                	add    %al,(%eax)
    92f9:	00 00                	add    %al,(%eax)
    92fb:	00 00                	add    %al,(%eax)
    92fd:	00 00                	add    %al,(%eax)
    92ff:	00 00                	add    %al,(%eax)
    9301:	00 00                	add    %al,(%eax)
    9303:	00 00                	add    %al,(%eax)
    9305:	00 00                	add    %al,(%eax)
    9307:	00 00                	add    %al,(%eax)
    9309:	00 00                	add    %al,(%eax)
    930b:	00 00                	add    %al,(%eax)
    930d:	00 00                	add    %al,(%eax)
    930f:	00 00                	add    %al,(%eax)
    9311:	00 00                	add    %al,(%eax)
    9313:	00 00                	add    %al,(%eax)
    9315:	00 00                	add    %al,(%eax)
    9317:	00 00                	add    %al,(%eax)
    9319:	00 00                	add    %al,(%eax)
    931b:	00 00                	add    %al,(%eax)
    931d:	00 00                	add    %al,(%eax)
    931f:	00                   	.byte 0x0

Disassembly of section .bss:

00009320 <puti_str>:
    9320:	00 00                	add    %al,(%eax)
    9322:	00 00                	add    %al,(%eax)
    9324:	00 00                	add    %al,(%eax)
    9326:	00 00                	add    %al,(%eax)
    9328:	00 00                	add    %al,(%eax)
    932a:	00 00                	add    %al,(%eax)
    932c:	00 00                	add    %al,(%eax)
    932e:	00 00                	add    %al,(%eax)
    9330:	00 00                	add    %al,(%eax)
    9332:	00 00                	add    %al,(%eax)
    9334:	00 00                	add    %al,(%eax)
    9336:	00 00                	add    %al,(%eax)
    9338:	00 00                	add    %al,(%eax)
    933a:	00 00                	add    %al,(%eax)
    933c:	00 00                	add    %al,(%eax)
    933e:	00 00                	add    %al,(%eax)
    9340:	00 00                	add    %al,(%eax)
    9342:	00 00                	add    %al,(%eax)
    9344:	00 00                	add    %al,(%eax)
    9346:	00 00                	add    %al,(%eax)

00009348 <row>:
static int row = 0;
    9348:	00 00                	add    %al,(%eax)
    934a:	00 00                	add    %al,(%eax)

Disassembly of section .comment:

00000000 <.comment>:
   0:	47                   	inc    %edi
   1:	43                   	inc    %ebx
   2:	43                   	inc    %ebx
   3:	3a 20                	cmp    (%eax),%ah
   5:	28 47 4e             	sub    %al,0x4e(%edi)
   8:	55                   	push   %ebp
   9:	29 20                	sub    %esp,(%eax)
   b:	31 32                	xor    %esi,(%edx)
   d:	2e 31 2e             	xor    %ebp,%cs:(%esi)
  10:	31 20                	xor    %esp,(%eax)
  12:	32 30                	xor    (%eax),%dh
  14:	32 32                	xor    (%edx),%dh
  16:	30 35 30 37 20 28    	xor    %dh,0x28203730
  1c:	52                   	push   %edx
  1d:	65 64 20 48 61       	gs and %cl,%fs:0x61(%eax)
  22:	74 20                	je     44 <PROT_MODE_DSEG+0x34>
  24:	31 32                	xor    %esi,(%edx)
  26:	2e 31 2e             	xor    %ebp,%cs:(%esi)
  29:	31                   	.byte 0x31
  2a:	2d                   	.byte 0x2d
  2b:	31 29                	xor    %ebp,(%ecx)
  2d:	00                   	.byte 0x0

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	1c 00                	sbb    $0x0,%al
   2:	00 00                	add    %al,(%eax)
   4:	02 00                	add    (%eax),%al
   6:	00 00                	add    %al,(%eax)
   8:	00 00                	add    %al,(%eax)
   a:	04 00                	add    $0x0,%al
   c:	00 00                	add    %al,(%eax)
   e:	00 00                	add    %al,(%eax)
  10:	00 7e 00             	add    %bh,0x0(%esi)
  13:	00 26                	add    %ah,(%esi)
  15:	0d 00 00 00 00       	or     $0x0,%eax
  1a:	00 00                	add    %al,(%eax)
  1c:	00 00                	add    %al,(%eax)
  1e:	00 00                	add    %al,(%eax)
  20:	1c 00                	sbb    $0x0,%al
  22:	00 00                	add    %al,(%eax)
  24:	02 00                	add    (%eax),%al
  26:	25 00 00 00 04       	and    $0x4000000,%eax
  2b:	00 00                	add    %al,(%eax)
  2d:	00 00                	add    %al,(%eax)
  2f:	00 26                	add    %ah,(%esi)
  31:	8b 00                	mov    (%eax),%eax
  33:	00 6e 02             	add    %ch,0x2(%esi)
  36:	00 00                	add    %al,(%eax)
  38:	00 00                	add    %al,(%eax)
  3a:	00 00                	add    %al,(%eax)
  3c:	00 00                	add    %al,(%eax)
  3e:	00 00                	add    %al,(%eax)
  40:	1c 00                	sbb    $0x0,%al
  42:	00 00                	add    %al,(%eax)
  44:	02 00                	add    (%eax),%al
  46:	ad                   	lods   %ds:(%esi),%eax
  47:	07                   	pop    %es
  48:	00 00                	add    %al,(%eax)
  4a:	04 00                	add    $0x0,%al
  4c:	00 00                	add    %al,(%eax)
  4e:	00 00                	add    %al,(%eax)
  50:	94                   	xchg   %eax,%esp
  51:	8d 00                	lea    (%eax),%eax
  53:	00 84 01 00 00 00 00 	add    %al,0x0(%ecx,%eax,1)
  5a:	00 00                	add    %al,(%eax)
  5c:	00 00                	add    %al,(%eax)
  5e:	00 00                	add    %al,(%eax)
  60:	1c 00                	sbb    $0x0,%al
  62:	00 00                	add    %al,(%eax)
  64:	02 00                	add    (%eax),%al
  66:	ff 0e                	decl   (%esi)
  68:	00 00                	add    %al,(%eax)
  6a:	04 00                	add    $0x0,%al
  6c:	00 00                	add    %al,(%eax)
  6e:	00 00                	add    %al,(%eax)
  70:	18 8f 00 00 10 00    	sbb    %cl,0x100000(%edi)
  76:	00 00                	add    %al,(%eax)
  78:	00 00                	add    %al,(%eax)
  7a:	00 00                	add    %al,(%eax)
  7c:	00 00                	add    %al,(%eax)
  7e:	00 00                	add    %al,(%eax)

Disassembly of section .debug_info:

00000000 <.debug_info>:
   0:	21 00                	and    %eax,(%eax)
   2:	00 00                	add    %al,(%eax)
   4:	05 00 01 04 00       	add    $0x40100,%eax
   9:	00 00                	add    %al,(%eax)
   b:	00 01                	add    %al,(%ecx)
   d:	00 00                	add    %al,(%eax)
   f:	00 00                	add    %al,(%eax)
  11:	00 7e 00             	add    %bh,0x0(%esi)
  14:	00 a6 1a 00 00 00    	add    %ah,0x1a(%esi)
  1a:	00 08                	add    %cl,(%eax)
  1c:	00 00                	add    %al,(%eax)
  1e:	00 4a 00             	add    %cl,0x0(%edx)
  21:	00 00                	add    %al,(%eax)
  23:	01 80 84 07 00 00    	add    %eax,0x784(%eax)
  29:	05 00 01 04 14       	add    $0x14040100,%eax
  2e:	00 00                	add    %al,(%eax)
  30:	00 18                	add    %bl,(%eax)
  32:	95                   	xchg   %eax,%ebp
  33:	00 00                	add    %al,(%eax)
  35:	00 1d 55 00 00 00    	add    %bl,0x55
  3b:	00 00                	add    %al,(%eax)
  3d:	00 00                	add    %al,(%eax)
  3f:	26 8b 00             	mov    %es:(%eax),%eax
  42:	00 6e 02             	add    %ch,0x2(%esi)
  45:	00 00                	add    %al,(%eax)
  47:	87 00                	xchg   %eax,(%eax)
  49:	00 00                	add    %al,(%eax)
  4b:	05 01 06 40 01       	add    $0x1400601,%eax
  50:	00 00                	add    %al,(%eax)
  52:	0b 0d 01 00 00 0d    	or     0xd000001,%ecx
  58:	37                   	aaa    
  59:	00 00                	add    %al,(%eax)
  5b:	00 05 01 08 3e 01    	add    %al,0x13e0801
  61:	00 00                	add    %al,(%eax)
  63:	05 02 05 6e 00       	add    $0x6e0502,%eax
  68:	00 00                	add    %al,(%eax)
  6a:	05 02 07 80 01       	add    $0x1800702,%eax
  6f:	00 00                	add    %al,(%eax)
  71:	0b 6e 01             	or     0x1(%esi),%ebp
  74:	00 00                	add    %al,(%eax)
  76:	10 56 00             	adc    %dl,0x0(%esi)
  79:	00 00                	add    %al,(%eax)
  7b:	19 04 05 69 6e 74 00 	sbb    %eax,0x746e69(,%eax,1)
  82:	0b 6d 01             	or     0x1(%ebp),%ebp
  85:	00 00                	add    %al,(%eax)
  87:	11 67 00             	adc    %esp,0x0(%edi)
  8a:	00 00                	add    %al,(%eax)
  8c:	05 04 07 60 01       	add    $0x1600704,%eax
  91:	00 00                	add    %al,(%eax)
  93:	05 08 05 1f 01       	add    $0x11f0508,%eax
  98:	00 00                	add    %al,(%eax)
  9a:	05 08 07 56 01       	add    $0x1560708,%eax
  9f:	00 00                	add    %al,(%eax)
  a1:	11 d0                	adc    %edx,%eax
  a3:	01 00                	add    %eax,(%eax)
  a5:	00 06                	add    %al,(%esi)
  a7:	10 8d 00 00 00 05    	adc    %cl,0x5000000(%ebp)
  ad:	03 a4 92 00 00 0c 99 	add    -0x66f40000(%edx,%edx,4),%esp
  b4:	00 00                	add    %al,(%eax)
  b6:	00 05 01 06 47 01    	add    %al,0x1470601
  bc:	00 00                	add    %al,(%eax)
  be:	1a 92 00 00 00 1b    	sbb    0x1b000000(%edx),%dl
  c4:	92                   	xchg   %eax,%edx
  c5:	00 00                	add    %al,(%eax)
  c7:	00 0d 72 6f 77 00    	add    %cl,0x776f72
  cd:	18 0c 56             	sbb    %cl,(%esi,%edx,2)
  d0:	00 00                	add    %al,(%eax)
  d2:	00 05 03 48 93 00    	add    %al,0x934803
  d8:	00 11                	add    %dl,(%ecx)
  da:	c5 01                	lds    (%ecx),%eax
  dc:	00 00                	add    %al,(%eax)
  de:	1a 07                	sbb    (%edi),%al
  e0:	c5 00                	lds    (%eax),%eax
  e2:	00 00                	add    %al,(%eax)
  e4:	05 03 a0 92 00       	add    $0x92a003,%eax
  e9:	00 0c 92             	add    %cl,(%edx,%edx,4)
  ec:	00 00                	add    %al,(%eax)
  ee:	00 0e                	add    %cl,(%esi)
  f0:	92                   	xchg   %eax,%edx
  f1:	00 00                	add    %al,(%eax)
  f3:	00 da                	add    %bl,%dl
  f5:	00 00                	add    %al,(%eax)
  f7:	00 0f                	add    %cl,(%edi)
  f9:	67 00 00             	add    %al,(%bx,%si)
  fc:	00 27                	add    %ah,(%edi)
  fe:	00 1c bc             	add    %bl,(%esp,%edi,4)
 101:	01 00                	add    %eax,(%eax)
 103:	00 01                	add    %al,(%ecx)
 105:	30 0d ca 00 00 00    	xor    %cl,0xca
 10b:	05 03 20 93 00       	add    $0x932003,%eax
 110:	00 03                	add    %al,(%ebx)
 112:	2d 01 00 00 8d       	sub    $0x8d000001,%eax
 117:	4d                   	dec    %ebp
 118:	8d 00                	lea    (%eax),%eax
 11a:	00 47 00             	add    %al,0x0(%edi)
 11d:	00 00                	add    %al,(%eax)
 11f:	01 9c 68 01 00 00 02 	add    %ebx,0x2000001(%eax,%ebp,2)
 126:	76 61                	jbe    189 <PR_BOOTABLE+0x109>
 128:	00 8d 1b 5d 00 00    	add    %cl,0x5d1b(%ebp)
 12e:	00 1e                	add    %bl,(%esi)
 130:	00 00                	add    %al,(%eax)
 132:	00 0c 00             	add    %cl,(%eax,%eax,1)
 135:	00 00                	add    %al,(%eax)
 137:	06                   	push   %es
 138:	78 04                	js     13e <PR_BOOTABLE+0xbe>
 13a:	00 00                	add    %al,(%eax)
 13c:	8d 28                	lea    (%eax),%ebp
 13e:	5d                   	pop    %ebp
 13f:	00 00                	add    %al,(%eax)
 141:	00 7e 00             	add    %bh,0x0(%esi)
 144:	00 00                	add    %al,(%eax)
 146:	7c 00                	jl     148 <PR_BOOTABLE+0xc8>
 148:	00 00                	add    %al,(%eax)
 14a:	06                   	push   %es
 14b:	3b 02                	cmp    (%edx),%eax
 14d:	00 00                	add    %al,(%eax)
 14f:	8d 38                	lea    (%eax),%edi
 151:	5d                   	pop    %ebp
 152:	00 00                	add    %al,(%eax)
 154:	00 91 00 00 00 87    	add    %dl,-0x79000000(%ecx)
 15a:	00 00                	add    %al,(%eax)
 15c:	00 02                	add    %al,(%edx)
 15e:	6c                   	insb   (%dx),%es:(%edi)
 15f:	62 61 00             	bound  %esp,0x0(%ecx)
 162:	8d 49 5d             	lea    0x5d(%ecx),%ecx
 165:	00 00                	add    %al,(%eax)
 167:	00 bb 00 00 00 b9    	add    %bh,-0x47000000(%ebx)
 16d:	00 00                	add    %al,(%eax)
 16f:	00 12                	add    %dl,(%edx)
 171:	56                   	push   %esi
 172:	00 00                	add    %al,(%eax)
 174:	00 8f 0e 5d 00 00    	add    %cl,0x5d0e(%edi)
 17a:	00 c6                	add    %al,%dh
 17c:	00 00                	add    %al,(%eax)
 17e:	00 c4                	add    %al,%ah
 180:	00 00                	add    %al,(%eax)
 182:	00 04 87             	add    %al,(%edi,%eax,4)
 185:	8d 00                	lea    (%eax),%eax
 187:	00 68 01             	add    %ch,0x1(%eax)
 18a:	00 00                	add    %al,(%eax)
 18c:	00 03                	add    %al,(%ebx)
 18e:	9f                   	lahf   
 18f:	01 00                	add    %eax,(%eax)
 191:	00 78 de             	add    %bh,-0x22(%eax)
 194:	8c 00                	mov    %es,(%eax)
 196:	00 6f 00             	add    %ch,0x0(%edi)
 199:	00 00                	add    %al,(%eax)
 19b:	01 9c 8c 03 00 00 02 	add    %ebx,0x2000003(%esp,%ecx,4)
 1a2:	64 73 74             	fs jae 219 <PR_BOOTABLE+0x199>
 1a5:	00 78 17             	add    %bh,0x17(%eax)
 1a8:	8c 03                	mov    %es,(%ebx)
 1aa:	00 00                	add    %al,(%eax)
 1ac:	d0 00                	rolb   (%eax)
 1ae:	00 00                	add    %al,(%eax)
 1b0:	ce                   	into   
 1b1:	00 00                	add    %al,(%eax)
 1b3:	00 06                	add    %al,(%esi)
 1b5:	3b 02                	cmp    (%edx),%eax
 1b7:	00 00                	add    %al,(%eax)
 1b9:	78 25                	js     1e0 <PR_BOOTABLE+0x160>
 1bb:	5d                   	pop    %ebp
 1bc:	00 00                	add    %al,(%eax)
 1be:	00 db                	add    %bl,%bl
 1c0:	00 00                	add    %al,(%eax)
 1c2:	00 d9                	add    %bl,%cl
 1c4:	00 00                	add    %al,(%eax)
 1c6:	00 09                	add    %cl,(%ecx)
 1c8:	8e 03                	mov    (%ebx),%es
 1ca:	00 00                	add    %al,(%eax)
 1cc:	de 8c 00 00 02 0c 00 	fimuls 0xc0200(%eax,%eax,1)
 1d3:	00 00                	add    %al,(%eax)
 1d5:	7b e6                	jnp    1bd <PR_BOOTABLE+0x13d>
 1d7:	01 00                	add    %eax,(%eax)
 1d9:	00 13                	add    %dl,(%ebx)
 1db:	3e 07                	ds pop %es
 1dd:	00 00                	add    %al,(%eax)
 1df:	ea 8c 00 00 01 1c 00 	ljmp   $0x1c,$0x100008c
 1e6:	00 00                	add    %al,(%eax)
 1e8:	74 01                	je     1eb <PR_BOOTABLE+0x16b>
 1ea:	4f                   	dec    %edi
 1eb:	07                   	pop    %es
 1ec:	00 00                	add    %al,(%eax)
 1ee:	e6 00                	out    %al,$0x0
 1f0:	00 00                	add    %al,(%eax)
 1f2:	e4 00                	in     $0x0,%al
 1f4:	00 00                	add    %al,(%eax)
 1f6:	14 1c                	adc    $0x1c,%al
 1f8:	00 00                	add    %al,(%eax)
 1fa:	00 15 5a 07 00 00    	add    %dl,0x75a
 200:	f3 00 00             	repz add %al,(%eax)
 203:	00 f1                	add    %dh,%cl
 205:	00 00                	add    %al,(%eax)
 207:	00 00                	add    %al,(%eax)
 209:	00 00                	add    %al,(%eax)
 20b:	0a 67 07             	or     0x7(%edi),%ah
 20e:	00 00                	add    %al,(%eax)
 210:	f4                   	hlt    
 211:	8c 00                	mov    %es,(%eax)
 213:	00 01                	add    %al,(%ecx)
 215:	f4                   	hlt    
 216:	8c 00                	mov    %es,(%eax)
 218:	00 08                	add    %cl,(%eax)
 21a:	00 00                	add    %al,(%eax)
 21c:	00 7d 18             	add    %bh,0x18(%ebp)
 21f:	02 00                	add    (%eax),%al
 221:	00 01                	add    %al,(%ecx)
 223:	7b 07                	jnp    22c <PR_BOOTABLE+0x1ac>
 225:	00 00                	add    %al,(%eax)
 227:	fd                   	std    
 228:	00 00                	add    %al,(%eax)
 22a:	00 fb                	add    %bh,%bl
 22c:	00 00                	add    %al,(%eax)
 22e:	00 01                	add    %al,(%ecx)
 230:	70 07                	jo     239 <PR_BOOTABLE+0x1b9>
 232:	00 00                	add    %al,(%eax)
 234:	08 01                	or     %al,(%ecx)
 236:	00 00                	add    %al,(%eax)
 238:	06                   	push   %es
 239:	01 00                	add    %eax,(%eax)
 23b:	00 00                	add    %al,(%eax)
 23d:	0a 67 07             	or     0x7(%edi),%ah
 240:	00 00                	add    %al,(%eax)
 242:	fc                   	cld    
 243:	8c 00                	mov    %es,(%eax)
 245:	00 02                	add    %al,(%edx)
 247:	fc                   	cld    
 248:	8c 00                	mov    %es,(%eax)
 24a:	00 08                	add    %cl,(%eax)
 24c:	00 00                	add    %al,(%eax)
 24e:	00 7e 4a             	add    %bh,0x4a(%esi)
 251:	02 00                	add    (%eax),%al
 253:	00 01                	add    %al,(%ecx)
 255:	7b 07                	jnp    25e <PR_BOOTABLE+0x1de>
 257:	00 00                	add    %al,(%eax)
 259:	15 01 00 00 13       	adc    $0x13000001,%eax
 25e:	01 00                	add    %eax,(%eax)
 260:	00 01                	add    %al,(%ecx)
 262:	70 07                	jo     26b <PR_BOOTABLE+0x1eb>
 264:	00 00                	add    %al,(%eax)
 266:	1f                   	pop    %ds
 267:	01 00                	add    %eax,(%eax)
 269:	00 1d 01 00 00 00    	add    %bl,0x1
 26f:	09 67 07             	or     %esp,0x7(%edi)
 272:	00 00                	add    %al,(%eax)
 274:	04 8d                	add    $0x8d,%al
 276:	00 00                	add    %al,(%eax)
 278:	02 27                	add    (%edi),%ah
 27a:	00 00                	add    %al,(%eax)
 27c:	00 7f 78             	add    %bh,0x78(%edi)
 27f:	02 00                	add    (%eax),%al
 281:	00 01                	add    %al,(%ecx)
 283:	7b 07                	jnp    28c <PR_BOOTABLE+0x20c>
 285:	00 00                	add    %al,(%eax)
 287:	2c 01                	sub    $0x1,%al
 289:	00 00                	add    %al,(%eax)
 28b:	2a 01                	sub    (%ecx),%al
 28d:	00 00                	add    %al,(%eax)
 28f:	01 70 07             	add    %esi,0x7(%eax)
 292:	00 00                	add    %al,(%eax)
 294:	3a 01                	cmp    (%ecx),%al
 296:	00 00                	add    %al,(%eax)
 298:	38 01                	cmp    %al,(%ecx)
 29a:	00 00                	add    %al,(%eax)
 29c:	00 09                	add    %cl,(%ecx)
 29e:	67 07                	addr16 pop %es
 2a0:	00 00                	add    %al,(%eax)
 2a2:	0f 8d 00 00 02 37    	jge    370202a8 <MBOOT_INFO_MAGIC+0xb5452a6>
 2a8:	00 00                	add    %al,(%eax)
 2aa:	00 80 a6 02 00 00    	add    %al,0x2a6(%eax)
 2b0:	01 7b 07             	add    %edi,0x7(%ebx)
 2b3:	00 00                	add    %al,(%eax)
 2b5:	47                   	inc    %edi
 2b6:	01 00                	add    %eax,(%eax)
 2b8:	00 45 01             	add    %al,0x1(%ebp)
 2bb:	00 00                	add    %al,(%eax)
 2bd:	01 70 07             	add    %esi,0x7(%eax)
 2c0:	00 00                	add    %al,(%eax)
 2c2:	55                   	push   %ebp
 2c3:	01 00                	add    %eax,(%eax)
 2c5:	00 53 01             	add    %dl,0x1(%ebx)
 2c8:	00 00                	add    %al,(%eax)
 2ca:	00 09                	add    %cl,(%ecx)
 2cc:	67 07                	addr16 pop %es
 2ce:	00 00                	add    %al,(%eax)
 2d0:	1a 8d 00 00 02 47    	sbb    0x47020000(%ebp),%cl
 2d6:	00 00                	add    %al,(%eax)
 2d8:	00 81 d4 02 00 00    	add    %al,0x2d4(%ecx)
 2de:	01 7b 07             	add    %edi,0x7(%ebx)
 2e1:	00 00                	add    %al,(%eax)
 2e3:	62 01                	bound  %eax,(%ecx)
 2e5:	00 00                	add    %al,(%eax)
 2e7:	60                   	pusha  
 2e8:	01 00                	add    %eax,(%eax)
 2ea:	00 01                	add    %al,(%ecx)
 2ec:	70 07                	jo     2f5 <PR_BOOTABLE+0x275>
 2ee:	00 00                	add    %al,(%eax)
 2f0:	73 01                	jae    2f3 <PR_BOOTABLE+0x273>
 2f2:	00 00                	add    %al,(%eax)
 2f4:	71 01                	jno    2f7 <PR_BOOTABLE+0x277>
 2f6:	00 00                	add    %al,(%eax)
 2f8:	00 0a                	add    %cl,(%edx)
 2fa:	67 07                	addr16 pop %es
 2fc:	00 00                	add    %al,(%eax)
 2fe:	28 8d 00 00 02 28    	sub    %cl,0x28020000(%ebp)
 304:	8d 00                	lea    (%eax),%eax
 306:	00 05 00 00 00 82    	add    %al,0x82000000
 30c:	06                   	push   %es
 30d:	03 00                	add    (%eax),%eax
 30f:	00 01                	add    %al,(%ecx)
 311:	7b 07                	jnp    31a <PR_BOOTABLE+0x29a>
 313:	00 00                	add    %al,(%eax)
 315:	80 01 00             	addb   $0x0,(%ecx)
 318:	00 7e 01             	add    %bh,0x1(%esi)
 31b:	00 00                	add    %al,(%eax)
 31d:	01 70 07             	add    %esi,0x7(%eax)
 320:	00 00                	add    %al,(%eax)
 322:	8c 01                	mov    %es,(%ecx)
 324:	00 00                	add    %al,(%eax)
 326:	8a 01                	mov    (%ecx),%al
 328:	00 00                	add    %al,(%eax)
 32a:	00 0a                	add    %cl,(%edx)
 32c:	8e 03                	mov    (%ebx),%es
 32e:	00 00                	add    %al,(%eax)
 330:	2d 8d 00 00 02       	sub    $0x200008d,%eax
 335:	2d 8d 00 00 0d       	sub    $0xd00008d,%eax
 33a:	00 00                	add    %al,(%eax)
 33c:	00 85 4e 03 00 00    	add    %al,0x34e(%ebp)
 342:	13 3e                	adc    (%esi),%edi
 344:	07                   	pop    %es
 345:	00 00                	add    %al,(%eax)
 347:	32 8d 00 00 01 57    	xor    0x57010000(%ebp),%cl
 34d:	00 00                	add    %al,(%eax)
 34f:	00 74 01 4f          	add    %dh,0x4f(%ecx,%eax,1)
 353:	07                   	pop    %es
 354:	00 00                	add    %al,(%eax)
 356:	99                   	cltd   
 357:	01 00                	add    %eax,(%eax)
 359:	00 97 01 00 00 14    	add    %dl,0x14000001(%edi)
 35f:	57                   	push   %edi
 360:	00 00                	add    %al,(%eax)
 362:	00 15 5a 07 00 00    	add    %dl,0x75a
 368:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
 369:	01 00                	add    %eax,(%eax)
 36b:	00 a4 01 00 00 00 00 	add    %ah,0x0(%ecx,%eax,1)
 372:	00 1d 0e 07 00 00    	add    %bl,0x70e
 378:	3a 8d 00 00 01 3a    	cmp    0x3a010000(%ebp),%cl
 37e:	8d 00                	lea    (%eax),%eax
 380:	00 10                	add    %dl,(%eax)
 382:	00 00                	add    %al,(%eax)
 384:	00 01                	add    %al,(%ecx)
 386:	88 05 01 31 07 00    	mov    %al,0x73101
 38c:	00 b0 01 00 00 ae    	add    %dh,-0x51ffffff(%eax)
 392:	01 00                	add    %eax,(%eax)
 394:	00 01                	add    %al,(%ecx)
 396:	26 07                	es pop %es
 398:	00 00                	add    %al,(%eax)
 39a:	bc 01 00 00 ba       	mov    $0xba000001,%esp
 39f:	01 00                	add    %eax,(%eax)
 3a1:	00 01                	add    %al,(%ecx)
 3a3:	1b 07                	sbb    (%edi),%eax
 3a5:	00 00                	add    %al,(%eax)
 3a7:	c7 01 00 00 c5 01    	movl   $0x1c50000,(%ecx)
 3ad:	00 00                	add    %al,(%eax)
 3af:	00 00                	add    %al,(%eax)
 3b1:	1e                   	push   %ds
 3b2:	04 1f                	add    $0x1f,%al
 3b4:	5d                   	pop    %ebp
 3b5:	00 00                	add    %al,(%eax)
 3b7:	00 01                	add    %al,(%ecx)
 3b9:	71 0d                	jno    3c8 <PR_BOOTABLE+0x348>
 3bb:	01 03                	add    %eax,(%ebx)
 3bd:	4c                   	dec    %esp
 3be:	01 00                	add    %eax,(%eax)
 3c0:	00 68 9e             	add    %ch,-0x62(%eax)
 3c3:	8c 00                	mov    %es,(%eax)
 3c5:	00 1d 00 00 00 01    	add    %bl,0x1000000
 3cb:	9c                   	pushf  
 3cc:	e8 03 00 00 02       	call   20003d4 <_end+0x1ff7088>
 3d1:	6e                   	outsb  %ds:(%esi),(%dx)
 3d2:	00 68 0f             	add    %ch,0xf(%eax)
 3d5:	56                   	push   %esi
 3d6:	00 00                	add    %al,(%eax)
 3d8:	00 d4                	add    %dl,%ah
 3da:	01 00                	add    %eax,(%eax)
 3dc:	00 d2                	add    %dl,%dl
 3de:	01 00                	add    %eax,(%eax)
 3e0:	00 02                	add    %al,(%edx)
 3e2:	73 00                	jae    3e4 <PR_BOOTABLE+0x364>
 3e4:	68 18 c5 00 00       	push   $0xc518
 3e9:	00 df                	add    %bl,%bh
 3eb:	01 00                	add    %eax,(%eax)
 3ed:	00 dd                	add    %bl,%ch
 3ef:	01 00                	add    %eax,(%eax)
 3f1:	00 0d 68 65 78 00    	add    %cl,0x786568
 3f7:	6a 11                	push   $0x11
 3f9:	e8 03 00 00 05       	call   5000401 <_end+0x4ff70b5>
 3fe:	03 80 92 00 00 04    	add    0x4000092(%eax),%eax
 404:	b6 8c                	mov    $0x8c,%dh
 406:	00 00                	add    %al,(%eax)
 408:	59                   	pop    %ecx
 409:	04 00                	add    $0x0,%al
 40b:	00 00                	add    %al,(%eax)
 40d:	0e                   	push   %cs
 40e:	92                   	xchg   %eax,%edx
 40f:	00 00                	add    %al,(%eax)
 411:	00 f8                	add    %bh,%al
 413:	03 00                	add    (%eax),%eax
 415:	00 0f                	add    %cl,(%edi)
 417:	67 00 00             	add    %al,(%bx,%si)
 41a:	00 10                	add    %dl,(%eax)
 41c:	00 03                	add    %al,(%ebx)
 41e:	39 01                	cmp    %eax,(%ecx)
 420:	00 00                	add    %al,(%eax)
 422:	62 81 8c 00 00 1d    	bound  %eax,0x1d00008c(%ecx)
 428:	00 00                	add    %al,(%eax)
 42a:	00 01                	add    %al,(%ecx)
 42c:	9c                   	pushf  
 42d:	49                   	dec    %ecx
 42e:	04 00                	add    $0x0,%al
 430:	00 02                	add    %al,(%edx)
 432:	6e                   	outsb  %ds:(%esi),(%dx)
 433:	00 62 0f             	add    %ah,0xf(%edx)
 436:	56                   	push   %esi
 437:	00 00                	add    %al,(%eax)
 439:	00 ea                	add    %ch,%dl
 43b:	01 00                	add    %eax,(%eax)
 43d:	00 e8                	add    %ch,%al
 43f:	01 00                	add    %eax,(%eax)
 441:	00 02                	add    %al,(%edx)
 443:	73 00                	jae    445 <PR_BOOTABLE+0x3c5>
 445:	62 17                	bound  %edx,(%edi)
 447:	c5 00                	lds    (%eax),%eax
 449:	00 00                	add    %al,(%eax)
 44b:	f5                   	cmc    
 44c:	01 00                	add    %eax,(%eax)
 44e:	00 f3                	add    %dh,%bl
 450:	01 00                	add    %eax,(%eax)
 452:	00 0d 64 65 63 00    	add    %cl,0x636564
 458:	64 11 49 04          	adc    %ecx,%fs:0x4(%ecx)
 45c:	00 00                	add    %al,(%eax)
 45e:	05 03 94 92 00       	add    $0x929403,%eax
 463:	00 04 99             	add    %al,(%ecx,%ebx,4)
 466:	8c 00                	mov    %es,(%eax)
 468:	00 59 04             	add    %bl,0x4(%ecx)
 46b:	00 00                	add    %al,(%eax)
 46d:	00 0e                	add    %cl,(%esi)
 46f:	92                   	xchg   %eax,%edx
 470:	00 00                	add    %al,(%eax)
 472:	00 59 04             	add    %bl,0x4(%ecx)
 475:	00 00                	add    %al,(%eax)
 477:	0f 67 00             	packuswb (%eax),%mm0
 47a:	00 00                	add    %al,(%eax)
 47c:	0a 00                	or     (%eax),%al
 47e:	03 76 01             	add    0x1(%esi),%esi
 481:	00 00                	add    %al,(%eax)
 483:	52                   	push   %edx
 484:	2a 8c 00 00 57 00 00 	sub    0x5700(%eax,%eax,1),%cl
 48b:	00 01                	add    %al,(%ecx)
 48d:	9c                   	pushf  
 48e:	e3 04                	jecxz  494 <PR_BOOTABLE+0x414>
 490:	00 00                	add    %al,(%eax)
 492:	02 6e 00             	add    0x0(%esi),%ch
 495:	52                   	push   %edx
 496:	0f 56 00             	orps   (%eax),%xmm0
 499:	00 00                	add    %al,(%eax)
 49b:	02 02                	add    (%edx),%al
 49d:	00 00                	add    %al,(%eax)
 49f:	fe 01                	incb   (%ecx)
 4a1:	00 00                	add    %al,(%eax)
 4a3:	02 73 00             	add    0x0(%ebx),%dh
 4a6:	52                   	push   %edx
 4a7:	17                   	pop    %ss
 4a8:	c5 00                	lds    (%eax),%eax
 4aa:	00 00                	add    %al,(%eax)
 4ac:	14 02                	adc    $0x2,%al
 4ae:	00 00                	add    %al,(%eax)
 4b0:	12 02                	adc    (%edx),%al
 4b2:	00 00                	add    %al,(%eax)
 4b4:	06                   	push   %es
 4b5:	cb                   	lret   
 4b6:	01 00                	add    %eax,(%eax)
 4b8:	00 52 20             	add    %dl,0x20(%edx)
 4bb:	56                   	push   %esi
 4bc:	00 00                	add    %al,(%eax)
 4be:	00 1f                	add    %bl,(%edi)
 4c0:	02 00                	add    (%eax),%al
 4c2:	00 1d 02 00 00 06    	add    %bl,0x6000002
 4c8:	d4 03                	aam    $0x3
 4ca:	00 00                	add    %al,(%eax)
 4cc:	52                   	push   %edx
 4cd:	2c c5                	sub    $0xc5,%al
 4cf:	00 00                	add    %al,(%eax)
 4d1:	00 2a                	add    %ch,(%edx)
 4d3:	02 00                	add    (%eax),%al
 4d5:	00 28                	add    %ch,(%eax)
 4d7:	02 00                	add    (%eax),%al
 4d9:	00 07                	add    %al,(%edi)
 4db:	69 00 54 09 56 00    	imul   $0x560954,(%eax),%eax
 4e1:	00 00                	add    %al,(%eax)
 4e3:	39 02                	cmp    %eax,(%edx)
 4e5:	00 00                	add    %al,(%eax)
 4e7:	33 02                	xor    (%edx),%eax
 4e9:	00 00                	add    %al,(%eax)
 4eb:	12 af 01 00 00 54    	adc    0x54000001(%edi),%ch
 4f1:	0c 56                	or     $0x56,%al
 4f3:	00 00                	add    %al,(%eax)
 4f5:	00 51 02             	add    %dl,0x2(%ecx)
 4f8:	00 00                	add    %al,(%eax)
 4fa:	4f                   	dec    %edi
 4fb:	02 00                	add    (%eax),%al
 4fd:	00 16                	add    %dl,(%esi)
 4ff:	81 8c 00 00 e3 04 00 	orl    $0xb4030000,0x4e300(%eax,%eax,1)
 506:	00 00 03 b4 
 50a:	01 00                	add    %eax,(%eax)
 50c:	00 45 f5             	add    %al,-0xb(%ebp)
 50f:	8b 00                	mov    (%eax),%eax
 511:	00 35 00 00 00 01    	add    %dh,0x1000000
 517:	9c                   	pushf  
 518:	45                   	inc    %ebp
 519:	05 00 00 02 73       	add    $0x73020000,%eax
 51e:	00 45 13             	add    %al,0x13(%ebp)
 521:	c5 00                	lds    (%eax),%eax
 523:	00 00                	add    %al,(%eax)
 525:	5b                   	pop    %ebx
 526:	02 00                	add    (%eax),%al
 528:	00 59 02             	add    %bl,0x2(%ecx)
 52b:	00 00                	add    %al,(%eax)
 52d:	07                   	pop    %es
 52e:	69 00 47 09 56 00    	imul   $0x560947,(%eax),%eax
 534:	00 00                	add    %al,(%eax)
 536:	6c                   	insb   (%dx),%es:(%edi)
 537:	02 00                	add    (%eax),%al
 539:	00 64 02 00          	add    %ah,0x0(%edx,%eax,1)
 53d:	00 07                	add    %al,(%edi)
 53f:	6a 00                	push   $0x0
 541:	47                   	inc    %edi
 542:	0c 56                	or     $0x56,%al
 544:	00 00                	add    %al,(%eax)
 546:	00 8e 02 00 00 8c    	add    %cl,-0x73fffffe(%esi)
 54c:	02 00                	add    (%eax),%al
 54e:	00 07                	add    %al,(%edi)
 550:	63 00                	arpl   %ax,(%eax)
 552:	48                   	dec    %eax
 553:	0a 92 00 00 00 98    	or     -0x68000000(%edx),%dl
 559:	02 00                	add    (%eax),%al
 55b:	00 96 02 00 00 04    	add    %dl,0x4000002(%esi)
 561:	06                   	push   %es
 562:	8c 00                	mov    %es,(%eax)
 564:	00 45 05             	add    %al,0x5(%ebp)
 567:	00 00                	add    %al,(%eax)
 569:	00 17                	add    %dl,(%edi)
 56b:	93                   	xchg   %eax,%ebx
 56c:	01 00                	add    %eax,(%eax)
 56e:	00 3b                	add    %bh,(%ebx)
 570:	56                   	push   %esi
 571:	00 00                	add    %al,(%eax)
 573:	00 e2                	add    %ah,%dl
 575:	8b 00                	mov    (%eax),%eax
 577:	00 13                	add    %dl,(%ebx)
 579:	00 00                	add    %al,(%eax)
 57b:	00 01                	add    %al,(%ecx)
 57d:	9c                   	pushf  
 57e:	80 05 00 00 02 73 00 	addb   $0x0,0x73020000
 585:	3b 18                	cmp    (%eax),%ebx
 587:	80 05 00 00 a8 02 00 	addb   $0x0,0x2a80000
 58e:	00 a0 02 00 00 07    	add    %ah,0x7000002(%eax)
 594:	6e                   	outsb  %ds:(%esi),(%dx)
 595:	00 3d 09 56 00 00    	add    %bh,0x5609
 59b:	00 de                	add    %bl,%dh
 59d:	02 00                	add    (%eax),%al
 59f:	00 da                	add    %bl,%dl
 5a1:	02 00                	add    (%eax),%al
 5a3:	00 00                	add    %al,(%eax)
 5a5:	0c 9e                	or     $0x9e,%al
 5a7:	00 00                	add    %al,(%eax)
 5a9:	00 03                	add    %al,(%ebx)
 5ab:	90                   	nop
 5ac:	00 00                	add    %al,(%eax)
 5ae:	00 32                	add    %dh,(%edx)
 5b0:	bb 8c 00 00 23       	mov    $0x2300008c,%ebx
 5b5:	00 00                	add    %al,(%eax)
 5b7:	00 01                	add    %al,(%ecx)
 5b9:	9c                   	pushf  
 5ba:	bd 05 00 00 02       	mov    $0x2000005,%ebp
 5bf:	69 00 32 13 4c 00    	imul   $0x4c1332,(%eax),%eax
 5c5:	00 00                	add    %al,(%eax)
 5c7:	f0 02 00             	lock add (%eax),%al
 5ca:	00 ee                	add    %ch,%dh
 5cc:	02 00                	add    (%eax),%al
 5ce:	00 04 ce             	add    %al,(%esi,%ecx,8)
 5d1:	8c 00                	mov    %es,(%eax)
 5d3:	00 97 03 00 00 16    	add    %dl,0x16000003(%edi)
 5d9:	de 8c 00 00 0d 06 00 	fimuls 0x60d00(%eax,%eax,1)
 5e0:	00 00                	add    %al,(%eax)
 5e2:	03 8a 00 00 00 28    	add    0x28000000(%edx),%ecx
 5e8:	c8 8b 00 00          	enter  $0x8b,$0x0
 5ec:	1a 00                	sbb    (%eax),%al
 5ee:	00 00                	add    %al,(%eax)
 5f0:	01 9c ec 05 00 00 02 	add    %ebx,0x2000005(%esp,%ebp,8)
 5f7:	6d                   	insl   (%dx),%es:(%edi)
 5f8:	00 28                	add    %ch,(%eax)
 5fa:	12 c5                	adc    %ch,%al
 5fc:	00 00                	add    %al,(%eax)
 5fe:	00 fb                	add    %bh,%bl
 600:	02 00                	add    (%eax),%al
 602:	00 f9                	add    %bh,%cl
 604:	02 00                	add    (%eax),%al
 606:	00 04 dc             	add    %al,(%esp,%ebx,8)
 609:	8b 00                	mov    (%eax),%eax
 60b:	00 45 06             	add    %al,0x6(%ebp)
 60e:	00 00                	add    %al,(%eax)
 610:	00 03                	add    %al,(%ebx)
 612:	7e 00                	jle    614 <PR_BOOTABLE+0x594>
 614:	00 00                	add    %al,(%eax)
 616:	23 bb 8b 00 00 0d    	and    0xd00008b(%ebx),%edi
 61c:	00 00                	add    %al,(%eax)
 61e:	00 01                	add    %al,(%ecx)
 620:	9c                   	pushf  
 621:	0d 06 00 00 10       	or     $0x10000006,%eax
 626:	72 00                	jb     628 <PR_BOOTABLE+0x5a8>
 628:	23 0f                	and    (%edi),%ecx
 62a:	56                   	push   %esi
 62b:	00 00                	add    %al,(%eax)
 62d:	00 02                	add    %al,(%edx)
 62f:	91                   	xchg   %eax,%ecx
 630:	00 00                	add    %al,(%eax)
 632:	03 66 00             	add    0x0(%esi),%esp
 635:	00 00                	add    %al,(%eax)
 637:	1d 7b 8b 00 00       	sbb    $0x8b7b,%eax
 63c:	40                   	inc    %eax
 63d:	00 00                	add    %al,(%eax)
 63f:	00 01                	add    %al,(%ecx)
 641:	9c                   	pushf  
 642:	45                   	inc    %ebp
 643:	06                   	push   %es
 644:	00 00                	add    %al,(%eax)
 646:	02 73 00             	add    0x0(%ebx),%dh
 649:	1d 14 c5 00 00       	sbb    $0xc514,%eax
 64e:	00 06                	add    %al,(%esi)
 650:	03 00                	add    (%eax),%eax
 652:	00 04 03             	add    %al,(%ebx,%eax,1)
 655:	00 00                	add    %al,(%eax)
 657:	04 a6                	add    $0xa6,%al
 659:	8b 00                	mov    (%eax),%eax
 65b:	00 45 06             	add    %al,0x6(%ebp)
 65e:	00 00                	add    %al,(%eax)
 660:	04 b3                	add    $0xb3,%al
 662:	8b 00                	mov    (%eax),%eax
 664:	00 45 06             	add    %al,0x6(%ebp)
 667:	00 00                	add    %al,(%eax)
 669:	00 17                	add    %dl,(%edi)
 66b:	7b 01                	jnp    66e <PR_BOOTABLE+0x5ee>
 66d:	00 00                	add    %al,(%eax)
 66f:	0f 56 00             	orps   (%eax),%xmm0
 672:	00 00                	add    %al,(%eax)
 674:	41                   	inc    %ecx
 675:	8b 00                	mov    (%eax),%eax
 677:	00 3a                	add    %bh,(%edx)
 679:	00 00                	add    %al,(%eax)
 67b:	00 01                	add    %al,(%ecx)
 67d:	9c                   	pushf  
 67e:	c0 06 00             	rolb   $0x0,(%esi)
 681:	00 02                	add    %al,(%edx)
 683:	72 00                	jb     685 <PR_BOOTABLE+0x605>
 685:	0f 0e                	femms  
 687:	56                   	push   %esi
 688:	00 00                	add    %al,(%eax)
 68a:	00 0f                	add    %cl,(%edi)
 68c:	03 00                	add    (%eax),%eax
 68e:	00 0d 03 00 00 02    	add    %cl,0x2000003
 694:	63 00                	arpl   %ax,(%eax)
 696:	0f 15 56 00          	unpckhps 0x0(%esi),%xmm2
 69a:	00 00                	add    %al,(%eax)
 69c:	18 03                	sbb    %al,(%ebx)
 69e:	00 00                	add    %al,(%eax)
 6a0:	16                   	push   %ss
 6a1:	03 00                	add    (%eax),%eax
 6a3:	00 06                	add    %al,(%esi)
 6a5:	78 00                	js     6a7 <PR_BOOTABLE+0x627>
 6a7:	00 00                	add    %al,(%eax)
 6a9:	0f 1c 56 00          	nopl   0x0(%esi)
 6ad:	00 00                	add    %al,(%eax)
 6af:	21 03                	and    %eax,(%ebx)
 6b1:	00 00                	add    %al,(%eax)
 6b3:	1f                   	pop    %ds
 6b4:	03 00                	add    (%eax),%eax
 6b6:	00 06                	add    %al,(%esi)
 6b8:	83 00 00             	addl   $0x0,(%eax)
 6bb:	00 0f                	add    %cl,(%edi)
 6bd:	2f                   	das    
 6be:	80 05 00 00 32 03 00 	addb   $0x0,0x3320000
 6c5:	00 28                	add    %ch,(%eax)
 6c7:	03 00                	add    (%eax),%eax
 6c9:	00 07                	add    %al,(%edi)
 6cb:	6c                   	insb   (%dx),%es:(%edi)
 6cc:	00 11                	add    %dl,(%ecx)
 6ce:	09 56 00             	or     %edx,0x0(%esi)
 6d1:	00 00                	add    %al,(%eax)
 6d3:	7b 03                	jnp    6d8 <PR_BOOTABLE+0x658>
 6d5:	00 00                	add    %al,(%eax)
 6d7:	73 03                	jae    6dc <PR_BOOTABLE+0x65c>
 6d9:	00 00                	add    %al,(%eax)
 6db:	04 6d                	add    $0x6d,%al
 6dd:	8b 00                	mov    (%eax),%eax
 6df:	00 c0                	add    %al,%al
 6e1:	06                   	push   %es
 6e2:	00 00                	add    %al,(%eax)
 6e4:	00 03                	add    %al,(%ebx)
 6e6:	51                   	push   %ecx
 6e7:	01 00                	add    %eax,(%eax)
 6e9:	00 08                	add    %cl,(%eax)
 6eb:	26 8b 00             	mov    %es:(%eax),%eax
 6ee:	00 1b                	add    %bl,(%ebx)
 6f0:	00 00                	add    %al,(%eax)
 6f2:	00 01                	add    %al,(%ecx)
 6f4:	9c                   	pushf  
 6f5:	0e                   	push   %cs
 6f6:	07                   	pop    %es
 6f7:	00 00                	add    %al,(%eax)
 6f9:	10 6c 00 08          	adc    %ch,0x8(%eax,%eax,1)
 6fd:	0f 56 00             	orps   (%eax),%xmm0
 700:	00 00                	add    %al,(%eax)
 702:	02 91 00 20 78 00    	add    0x782000(%ecx),%dl
 708:	00 00                	add    %al,(%eax)
 70a:	01 08                	add    %ecx,(%eax)
 70c:	16                   	push   %ss
 70d:	56                   	push   %esi
 70e:	00 00                	add    %al,(%eax)
 710:	00 02                	add    %al,(%edx)
 712:	91                   	xchg   %eax,%ecx
 713:	04 10                	add    $0x10,%al
 715:	63 68 00             	arpl   %bp,0x0(%eax)
 718:	08 22                	or     %ah,(%edx)
 71a:	92                   	xchg   %eax,%edx
 71b:	00 00                	add    %al,(%eax)
 71d:	00 02                	add    %al,(%edx)
 71f:	91                   	xchg   %eax,%ecx
 720:	08 07                	or     %al,(%edi)
 722:	70 00                	jo     724 <PR_BOOTABLE+0x6a4>
 724:	0a 14 8d 00 00 00 92 	or     -0x6e000000(,%ecx,4),%dl
 72b:	03 00                	add    (%eax),%eax
 72d:	00 90 03 00 00 00    	add    %dl,0x3(%eax)
 733:	21 1a                	and    %ebx,(%edx)
 735:	01 00                	add    %eax,(%eax)
 737:	00 02                	add    %al,(%edx)
 739:	29 14 03             	sub    %edx,(%ebx,%eax,1)
 73c:	3e 07                	ds pop %es
 73e:	00 00                	add    %al,(%eax)
 740:	08 aa 01 00 00 29    	or     %ch,0x29000001(%edx)
 746:	1d 56 00 00 00       	sbb    $0x56,%eax
 74b:	08 f0                	or     %dh,%al
 74d:	03 00                	add    (%eax),%eax
 74f:	00 29                	add    %ch,(%ecx)
 751:	29 8c 03 00 00 22 63 	sub    %ecx,0x63220000(%ebx,%eax,1)
 758:	6e                   	outsb  %ds:(%esi),(%dx)
 759:	74 00                	je     75b <PR_BOOTABLE+0x6db>
 75b:	02 29                	add    (%ecx),%ch
 75d:	33 56 00             	xor    0x0(%esi),%edx
 760:	00 00                	add    %al,(%eax)
 762:	00 23                	add    %ah,(%ebx)
 764:	69 6e 62 00 02 22 17 	imul   $0x17220200,0x62(%esi),%ebp
 76b:	2d 00 00 00 03       	sub    $0x3000000,%eax
 770:	67 07                	addr16 pop %es
 772:	00 00                	add    %al,(%eax)
 774:	08 aa 01 00 00 22    	or     %ch,0x22000001(%edx)
 77a:	1f                   	pop    %ds
 77b:	56                   	push   %esi
 77c:	00 00                	add    %al,(%eax)
 77e:	00 24 9a             	add    %ah,(%edx,%ebx,4)
 781:	01 00                	add    %eax,(%eax)
 783:	00 02                	add    %al,(%edx)
 785:	24 0d                	and    $0xd,%al
 787:	2d 00 00 00 00       	sub    $0x0,%eax
 78c:	25 15 01 00 00       	and    $0x115,%eax
 791:	02 18                	add    (%eax),%bl
 793:	14 03                	adc    $0x3,%al
 795:	08 aa 01 00 00 18    	or     %ch,0x18000001(%edx)
 79b:	1d 56 00 00 00       	sbb    $0x56,%eax
 7a0:	08 9a 01 00 00 18    	or     %bl,0x18000001(%edx)
 7a6:	2b 2d 00 00 00 00    	sub    0x0,%ebp
 7ac:	00 4e 07             	add    %cl,0x7(%esi)
 7af:	00 00                	add    %al,(%eax)
 7b1:	05 00 01 04 74       	add    $0x74040100,%eax
 7b6:	02 00                	add    (%eax),%al
 7b8:	00 13                	add    %dl,(%ebx)
 7ba:	95                   	xchg   %eax,%ebp
 7bb:	00 00                	add    %al,(%eax)
 7bd:	00 1d 76 00 00 00    	add    %bl,0x76
 7c3:	00 00                	add    %al,(%eax)
 7c5:	00 00                	add    %al,(%eax)
 7c7:	94                   	xchg   %eax,%esp
 7c8:	8d 00                	lea    (%eax),%eax
 7ca:	00 84 01 00 00 ab 04 	add    %al,0x4ab0000(%ecx,%eax,1)
 7d1:	00 00                	add    %al,(%eax)
 7d3:	05 01 06 40 01       	add    $0x1400601,%eax
 7d8:	00 00                	add    %al,(%eax)
 7da:	03 0d 01 00 00 0d    	add    0xd000001,%ecx
 7e0:	1c 38                	sbb    $0x38,%al
 7e2:	00 00                	add    %al,(%eax)
 7e4:	00 05 01 08 3e 01    	add    %al,0x13e0801
 7ea:	00 00                	add    %al,(%eax)
 7ec:	05 02 05 6e 00       	add    $0x6e0502,%eax
 7f1:	00 00                	add    %al,(%eax)
 7f3:	03 62 03             	add    0x3(%edx),%esp
 7f6:	00 00                	add    %al,(%eax)
 7f8:	0f 1c 51 00          	nopl   0x0(%ecx)
 7fc:	00 00                	add    %al,(%eax)
 7fe:	05 02 07 80 01       	add    $0x1800702,%eax
 803:	00 00                	add    %al,(%eax)
 805:	03 6e 01             	add    0x1(%esi),%ebp
 808:	00 00                	add    %al,(%eax)
 80a:	10 1c 63             	adc    %bl,(%ebx,%eiz,2)
 80d:	00 00                	add    %al,(%eax)
 80f:	00 14 04             	add    %dl,(%esp,%eax,1)
 812:	05 69 6e 74 00       	add    $0x746e69,%eax
 817:	03 6d 01             	add    0x1(%ebp),%ebp
 81a:	00 00                	add    %al,(%eax)
 81c:	11 1c 75 00 00 00 05 	adc    %ebx,0x5000000(,%esi,2)
 823:	04 07                	add    $0x7,%al
 825:	60                   	pusha  
 826:	01 00                	add    %eax,(%eax)
 828:	00 05 08 05 1f 01    	add    %al,0x11f0508
 82e:	00 00                	add    %al,(%eax)
 830:	03 1c 02             	add    (%edx,%eax,1),%ebx
 833:	00 00                	add    %al,(%eax)
 835:	13 1c 8e             	adc    (%esi,%ecx,4),%ebx
 838:	00 00                	add    %al,(%eax)
 83a:	00 05 08 07 56 01    	add    %al,0x1560708
 840:	00 00                	add    %al,(%eax)
 842:	0a 10                	or     (%eax),%dl
 844:	5e                   	pop    %esi
 845:	05 e5 00 00 00       	add    $0xe5,%eax
 84a:	01 54 03 00          	add    %edx,0x0(%ebx,%eax,1)
 84e:	00 5f 11             	add    %bl,0x11(%edi)
 851:	2d 00 00 00 00       	sub    $0x0,%eax
 856:	01 36                	add    %esi,(%esi)
 858:	03 00                	add    (%eax),%eax
 85a:	00 62 11             	add    %ah,0x11(%edx)
 85d:	e5 00                	in     $0x0,%eax
 85f:	00 00                	add    %al,(%eax)
 861:	01 10                	add    %edx,(%eax)
 863:	69 64 00 63 11 2d 00 	imul   $0x2d11,0x63(%eax,%eax,1),%esp
 86a:	00 
 86b:	00 04 01             	add    %al,(%ecx,%eax,1)
 86e:	e2 03                	loop   873 <PR_BOOTABLE+0x7f3>
 870:	00 00                	add    %al,(%eax)
 872:	67 11 e5             	addr16 adc %esp,%ebp
 875:	00 00                	add    %al,(%eax)
 877:	00 05 01 26 04 00    	add    %al,0x42601
 87d:	00 68 12             	add    %ch,0x12(%eax)
 880:	6a 00                	push   $0x0
 882:	00 00                	add    %al,(%eax)
 884:	08 01                	or     %al,(%ecx)
 886:	cb                   	lret   
 887:	04 00                	add    $0x0,%al
 889:	00 69 12             	add    %ch,0x12(%ecx)
 88c:	6a 00                	push   $0x0
 88e:	00 00                	add    %al,(%eax)
 890:	0c 00                	or     $0x0,%al
 892:	06                   	push   %es
 893:	2d 00 00 00 f5       	sub    $0xf5000000,%eax
 898:	00 00                	add    %al,(%eax)
 89a:	00 08                	add    %cl,(%eax)
 89c:	75 00                	jne    89e <PR_BOOTABLE+0x81e>
 89e:	00 00                	add    %al,(%eax)
 8a0:	02 00                	add    (%eax),%al
 8a2:	15 6d 62 72 00       	adc    $0x72626d,%eax
 8a7:	00 02                	add    %al,(%edx)
 8a9:	02 5b 10             	add    0x10(%ebx),%bl
 8ac:	37                   	aaa    
 8ad:	01 00                	add    %eax,(%eax)
 8af:	00 01                	add    %al,(%ecx)
 8b1:	42                   	inc    %edx
 8b2:	02 00                	add    (%eax),%al
 8b4:	00 5c 0d 37          	add    %bl,0x37(%ebp,%ecx,1)
 8b8:	01 00                	add    %eax,(%eax)
 8ba:	00 00                	add    %al,(%eax)
 8bc:	0d d6 01 00 00       	or     $0x1d6,%eax
 8c1:	5d                   	pop    %ebp
 8c2:	0d 48 01 00 00       	or     $0x148,%eax
 8c7:	b4 01                	mov    $0x1,%ah
 8c9:	0d df 02 00 00       	or     $0x2df,%eax
 8ce:	6a 12                	push   $0x12
 8d0:	58                   	pop    %eax
 8d1:	01 00                	add    %eax,(%eax)
 8d3:	00 be 01 0d 4f 04    	add    %bh,0x44f0d01(%esi)
 8d9:	00 00                	add    %al,(%eax)
 8db:	6b 0d 68 01 00 00 fe 	imul   $0xfffffffe,0x168,%ecx
 8e2:	01 00                	add    %eax,(%eax)
 8e4:	06                   	push   %es
 8e5:	2d 00 00 00 48       	sub    $0x48000000,%eax
 8ea:	01 00                	add    %eax,(%eax)
 8ec:	00 16                	add    %dl,(%esi)
 8ee:	75 00                	jne    8f0 <PR_BOOTABLE+0x870>
 8f0:	00 00                	add    %al,(%eax)
 8f2:	b3 01                	mov    $0x1,%bl
 8f4:	00 06                	add    %al,(%esi)
 8f6:	2d 00 00 00 58       	sub    $0x58000000,%eax
 8fb:	01 00                	add    %eax,(%eax)
 8fd:	00 08                	add    %cl,(%eax)
 8ff:	75 00                	jne    901 <PR_BOOTABLE+0x881>
 901:	00 00                	add    %al,(%eax)
 903:	09 00                	or     %eax,(%eax)
 905:	06                   	push   %es
 906:	95                   	xchg   %eax,%ebp
 907:	00 00                	add    %al,(%eax)
 909:	00 68 01             	add    %ch,0x1(%eax)
 90c:	00 00                	add    %al,(%eax)
 90e:	08 75 00             	or     %dh,0x0(%ebp)
 911:	00 00                	add    %al,(%eax)
 913:	03 00                	add    (%eax),%eax
 915:	06                   	push   %es
 916:	2d 00 00 00 78       	sub    $0x78000000,%eax
 91b:	01 00                	add    %eax,(%eax)
 91d:	00 08                	add    %cl,(%eax)
 91f:	75 00                	jne    921 <PR_BOOTABLE+0x8a1>
 921:	00 00                	add    %al,(%eax)
 923:	01 00                	add    %eax,(%eax)
 925:	03 bd 02 00 00 6c    	add    0x6c000002(%ebp),%edi
 92b:	0e                   	push   %cs
 92c:	f5                   	cmc    
 92d:	00 00                	add    %al,(%eax)
 92f:	00 0b                	add    %cl,(%ebx)
 931:	40                   	inc    %eax
 932:	03 00                	add    (%eax),%eax
 934:	00 18                	add    %bl,(%eax)
 936:	76 bf                	jbe    8f7 <PR_BOOTABLE+0x877>
 938:	01 00                	add    %eax,(%eax)
 93a:	00 01                	add    %al,(%ecx)
 93c:	21 04 00             	and    %eax,(%eax,%eax,1)
 93f:	00 77 0e             	add    %dh,0xe(%edi)
 942:	6a 00                	push   $0x0
 944:	00 00                	add    %al,(%eax)
 946:	00 01                	add    %al,(%ecx)
 948:	eb 03                	jmp    94d <PR_BOOTABLE+0x8cd>
 94a:	00 00                	add    %al,(%eax)
 94c:	78 0e                	js     95c <PR_BOOTABLE+0x8dc>
 94e:	83 00 00             	addl   $0x0,(%eax)
 951:	00 04 01             	add    %al,(%ecx,%eax,1)
 954:	70 03                	jo     959 <PR_BOOTABLE+0x8d9>
 956:	00 00                	add    %al,(%eax)
 958:	79 0e                	jns    968 <PR_BOOTABLE+0x8e8>
 95a:	83 00 00             	addl   $0x0,(%eax)
 95d:	00 0c 01             	add    %cl,(%ecx,%eax,1)
 960:	c5 02                	lds    (%edx),%eax
 962:	00 00                	add    %al,(%eax)
 964:	7a 0e                	jp     974 <PR_BOOTABLE+0x8f4>
 966:	6a 00                	push   $0x0
 968:	00 00                	add    %al,(%eax)
 96a:	14 00                	adc    $0x0,%al
 96c:	03 e9                	add    %ecx,%ebp
 96e:	02 00                	add    (%eax),%al
 970:	00 7b 0e             	add    %bh,0xe(%ebx)
 973:	83 01 00             	addl   $0x0,(%ecx)
 976:	00 0b                	add    %cl,(%ebx)
 978:	df 01                	filds  (%ecx)
 97a:	00 00                	add    %al,(%eax)
 97c:	34 83                	xor    $0x83,%al
 97e:	8a 02                	mov    (%edx),%al
 980:	00 00                	add    %al,(%eax)
 982:	01 da                	add    %ebx,%edx
 984:	03 00                	add    (%eax),%eax
 986:	00 84 0e 6a 00 00 00 	add    %al,0x6a(%esi,%ecx,1)
 98d:	00 01                	add    %al,(%ecx)
 98f:	ab                   	stos   %eax,%es:(%edi)
 990:	03 00                	add    (%eax),%eax
 992:	00 85 0d 8a 02 00    	add    %al,0x28a0d(%ebp)
 998:	00 04 01             	add    %al,(%ecx,%eax,1)
 99b:	c3                   	ret    
 99c:	02 00                	add    (%eax),%al
 99e:	00 86 0e 46 00 00    	add    %al,0x460e(%esi)
 9a4:	00 10                	add    %dl,(%eax)
 9a6:	01 5d 02             	add    %ebx,0x2(%ebp)
 9a9:	00 00                	add    %al,(%eax)
 9ab:	87 0e                	xchg   %ecx,(%esi)
 9ad:	46                   	inc    %esi
 9ae:	00 00                	add    %al,(%eax)
 9b0:	00 12                	add    %dl,(%edx)
 9b2:	01 19                	add    %ebx,(%ecx)
 9b4:	03 00                	add    (%eax),%eax
 9b6:	00 88 0e 6a 00 00    	add    %cl,0x6a0e(%eax)
 9bc:	00 14 01             	add    %dl,(%ecx,%eax,1)
 9bf:	14 02                	adc    $0x2,%al
 9c1:	00 00                	add    %al,(%eax)
 9c3:	89 0e                	mov    %ecx,(%esi)
 9c5:	6a 00                	push   $0x0
 9c7:	00 00                	add    %al,(%eax)
 9c9:	18 01                	sbb    %al,(%ecx)
 9cb:	c5 03                	lds    (%ebx),%eax
 9cd:	00 00                	add    %al,(%eax)
 9cf:	8a 0e                	mov    (%esi),%cl
 9d1:	6a 00                	push   $0x0
 9d3:	00 00                	add    %al,(%eax)
 9d5:	1c 01                	sbb    $0x1,%al
 9d7:	fe 03                	incb   (%ebx)
 9d9:	00 00                	add    %al,(%eax)
 9db:	8b 0e                	mov    (%esi),%ecx
 9dd:	6a 00                	push   $0x0
 9df:	00 00                	add    %al,(%eax)
 9e1:	20 01                	and    %al,(%ecx)
 9e3:	4d                   	dec    %ebp
 9e4:	02 00                	add    (%eax),%al
 9e6:	00 8c 0e 6a 00 00 00 	add    %cl,0x6a(%esi,%ecx,1)
 9ed:	24 01                	and    $0x1,%al
 9ef:	d6                   	(bad)  
 9f0:	02 00                	add    (%eax),%al
 9f2:	00 8d 0e 46 00 00    	add    %cl,0x460e(%ebp)
 9f8:	00 28                	add    %ch,(%eax)
 9fa:	01 67 02             	add    %esp,0x2(%edi)
 9fd:	00 00                	add    %al,(%eax)
 9ff:	8e 0e                	mov    (%esi),%cs
 a01:	46                   	inc    %esi
 a02:	00 00                	add    %al,(%eax)
 a04:	00 2a                	add    %ch,(%edx)
 a06:	01 47 04             	add    %eax,0x4(%edi)
 a09:	00 00                	add    %al,(%eax)
 a0b:	8f                   	(bad)  
 a0c:	0e                   	push   %cs
 a0d:	46                   	inc    %esi
 a0e:	00 00                	add    %al,(%eax)
 a10:	00 2c 01             	add    %ch,(%ecx,%eax,1)
 a13:	ab                   	stos   %eax,%es:(%edi)
 a14:	02 00                	add    (%eax),%al
 a16:	00 90 0e 46 00 00    	add    %dl,0x460e(%eax)
 a1c:	00 2e                	add    %ch,(%esi)
 a1e:	01 6b 04             	add    %ebp,0x4(%ebx)
 a21:	00 00                	add    %al,(%eax)
 a23:	91                   	xchg   %eax,%ecx
 a24:	0e                   	push   %cs
 a25:	46                   	inc    %esi
 a26:	00 00                	add    %al,(%eax)
 a28:	00 30                	add    %dh,(%eax)
 a2a:	01 e6                	add    %esp,%esi
 a2c:	01 00                	add    %eax,(%eax)
 a2e:	00 92 0e 46 00 00    	add    %dl,0x460e(%edx)
 a34:	00 32                	add    %dh,(%edx)
 a36:	00 06                	add    %al,(%esi)
 a38:	2d 00 00 00 9a       	sub    $0x9a000000,%eax
 a3d:	02 00                	add    (%eax),%al
 a3f:	00 08                	add    %cl,(%eax)
 a41:	75 00                	jne    a43 <PR_BOOTABLE+0x9c3>
 a43:	00 00                	add    %al,(%eax)
 a45:	0b 00                	or     (%eax),%eax
 a47:	03 fb                	add    %ebx,%edi
 a49:	01 00                	add    %eax,(%eax)
 a4b:	00 93 03 ca 01 00    	add    %dl,0x1ca03(%ebx)
 a51:	00 0b                	add    %cl,(%ebx)
 a53:	a3 02 00 00 20       	mov    %eax,0x20000002
 a58:	96                   	xchg   %eax,%esi
 a59:	11 03                	adc    %eax,(%ebx)
 a5b:	00 00                	add    %al,(%eax)
 a5d:	01 9c 02 00 00 97 0e 	add    %ebx,0xe970000(%edx,%eax,1)
 a64:	6a 00                	push   $0x0
 a66:	00 00                	add    %al,(%eax)
 a68:	00 01                	add    %al,(%ecx)
 a6a:	39 02                	cmp    %eax,(%edx)
 a6c:	00 00                	add    %al,(%eax)
 a6e:	98                   	cwtl   
 a6f:	0e                   	push   %cs
 a70:	6a 00                	push   $0x0
 a72:	00 00                	add    %al,(%eax)
 a74:	04 01                	add    $0x1,%al
 a76:	82 03 00             	addb   $0x0,(%ebx)
 a79:	00 99 0e 6a 00 00    	add    %bl,0x6a0e(%ecx)
 a7f:	00 08                	add    %cl,(%eax)
 a81:	01 c6                	add    %eax,%esi
 a83:	04 00                	add    $0x0,%al
 a85:	00 9a 0e 6a 00 00    	add    %bl,0x6a0e(%edx)
 a8b:	00 0c 01             	add    %cl,(%ecx,%eax,1)
 a8e:	3e 04 00             	ds add $0x0,%al
 a91:	00 9b 0e 6a 00 00    	add    %bl,0x6a0e(%ebx)
 a97:	00 10                	add    %dl,(%eax)
 a99:	01 31                	add    %esi,(%ecx)
 a9b:	02 00                	add    (%eax),%al
 a9d:	00 9c 0e 6a 00 00 00 	add    %bl,0x6a(%esi,%ecx,1)
 aa4:	14 01                	adc    $0x1,%al
 aa6:	98                   	cwtl   
 aa7:	03 00                	add    (%eax),%eax
 aa9:	00 9d 0e 6a 00 00    	add    %bl,0x6a0e(%ebp)
 aaf:	00 18                	add    %bl,(%eax)
 ab1:	01 b4 04 00 00 9e 0e 	add    %esi,0xe9e0000(%esp,%eax,1)
 ab8:	6a 00                	push   $0x0
 aba:	00 00                	add    %al,(%eax)
 abc:	1c 00                	sbb    $0x0,%al
 abe:	03 a3 02 00 00 9f    	add    -0x60fffffe(%ebx),%esp
 ac4:	03 a5 02 00 00 0a    	add    0xa000002(%ebp),%esp
 aca:	04 ad                	add    $0xad,%al
 acc:	05 55 03 00 00       	add    $0x355,%eax
 ad1:	01 2f                	add    %ebp,(%edi)
 ad3:	03 00                	add    (%eax),%eax
 ad5:	00 ae 11 2d 00 00    	add    %ch,0x2d11(%esi)
 adb:	00 00                	add    %al,(%eax)
 add:	01 23                	add    %esp,(%ebx)
 adf:	03 00                	add    (%eax),%eax
 ae1:	00 af 11 2d 00 00    	add    %ch,0x2d11(%edi)
 ae7:	00 01                	add    %al,(%ecx)
 ae9:	01 29                	add    %ebp,(%ecx)
 aeb:	03 00                	add    (%eax),%eax
 aed:	00 b0 11 2d 00 00    	add    %dh,0x2d11(%eax)
 af3:	00 02                	add    %al,(%edx)
 af5:	01 96 02 00 00 b1    	add    %edx,-0x4efffffe(%esi)
 afb:	11 2d 00 00 00 03    	adc    %ebp,0x3000000
 b01:	00 0a                	add    %cl,(%edx)
 b03:	10 be 09 8e 03 00    	adc    %bh,0x38e09(%esi)
 b09:	00 01                	add    %al,(%ecx)
 b0b:	1e                   	push   %ds
 b0c:	04 00                	add    $0x0,%al
 b0e:	00 bf 16 6a 00 00    	add    %bh,0x6a16(%edi)
 b14:	00 00                	add    %al,(%eax)
 b16:	01 8e 02 00 00 c0    	add    %ecx,-0x3ffffffe(%esi)
 b1c:	16                   	push   %ss
 b1d:	6a 00                	push   $0x0
 b1f:	00 00                	add    %al,(%eax)
 b21:	04 01                	add    $0x1,%al
 b23:	f0 03 00             	lock add (%eax),%eax
 b26:	00 c1                	add    %al,%cl
 b28:	16                   	push   %ss
 b29:	6a 00                	push   $0x0
 b2b:	00 00                	add    %al,(%eax)
 b2d:	08 01                	or     %al,(%ecx)
 b2f:	7e 04                	jle    b35 <PR_BOOTABLE+0xab5>
 b31:	00 00                	add    %al,(%eax)
 b33:	c2 16 6a             	ret    $0x6a16
 b36:	00 00                	add    %al,(%eax)
 b38:	00 0c 00             	add    %cl,(%eax,%eax,1)
 b3b:	0a 10                	or     (%eax),%dl
 b3d:	c4 09                	les    (%ecx),%ecx
 b3f:	c7 03 00 00 10 6e    	movl   $0x6e100000,(%ebx)
 b45:	75 6d                	jne    bb4 <PR_BOOTABLE+0xb34>
 b47:	00 c5                	add    %al,%ch
 b49:	16                   	push   %ss
 b4a:	6a 00                	push   $0x0
 b4c:	00 00                	add    %al,(%eax)
 b4e:	00 01                	add    %al,(%ecx)
 b50:	21 04 00             	and    %eax,(%eax,%eax,1)
 b53:	00 c6                	add    %al,%dh
 b55:	16                   	push   %ss
 b56:	6a 00                	push   $0x0
 b58:	00 00                	add    %al,(%eax)
 b5a:	04 01                	add    $0x1,%al
 b5c:	f0 03 00             	lock add (%eax),%eax
 b5f:	00 c7                	add    %al,%bh
 b61:	16                   	push   %ss
 b62:	6a 00                	push   $0x0
 b64:	00 00                	add    %al,(%eax)
 b66:	08 01                	or     %al,(%ecx)
 b68:	b7 02                	mov    $0x2,%bh
 b6a:	00 00                	add    %al,(%eax)
 b6c:	c8 16 6a 00          	enter  $0x6a16,$0x0
 b70:	00 00                	add    %al,(%eax)
 b72:	0c 00                	or     $0x0,%al
 b74:	17                   	pop    %ss
 b75:	10 02                	adc    %al,(%edx)
 b77:	bd 05 e9 03 00       	mov    $0x3e905,%ebp
 b7c:	00 18                	add    %bl,(%eax)
 b7e:	89 02                	mov    %eax,(%edx)
 b80:	00 00                	add    %al,(%eax)
 b82:	02 c3                	add    %bl,%al
 b84:	0b 55 03             	or     0x3(%ebp),%edx
 b87:	00 00                	add    %al,(%eax)
 b89:	19 65 6c             	sbb    %esp,0x6c(%ebp)
 b8c:	66 00 02             	data16 add %al,(%edx)
 b8f:	c9                   	leave  
 b90:	0b 8e 03 00 00 00    	or     0x3(%esi),%ecx
 b96:	0b 77 03             	or     0x3(%edi),%esi
 b99:	00 00                	add    %al,(%eax)
 b9b:	60                   	pusha  
 b9c:	a5                   	movsl  %ds:(%esi),%es:(%edi)
 b9d:	f1                   	icebp  
 b9e:	04 00                	add    $0x0,%al
 ba0:	00 01                	add    %al,(%ecx)
 ba2:	4f                   	dec    %edi
 ba3:	02 00                	add    (%eax),%al
 ba5:	00 a6 0e 6a 00 00    	add    %ah,0x6a0e(%esi)
 bab:	00 00                	add    %al,(%eax)
 bad:	01 4a 03             	add    %ecx,0x3(%edx)
 bb0:	00 00                	add    %al,(%eax)
 bb2:	a9 0e 6a 00 00       	test   $0x6a0e,%eax
 bb7:	00 04 01             	add    %al,(%ecx,%eax,1)
 bba:	06                   	push   %es
 bbb:	04 00                	add    $0x0,%al
 bbd:	00 aa 0e 6a 00 00    	add    %ch,0x6a0e(%edx)
 bc3:	00 08                	add    %cl,(%eax)
 bc5:	01 b1 03 00 00 b2    	add    %esi,-0x4dfffffd(%ecx)
 bcb:	07                   	pop    %es
 bcc:	1c 03                	sbb    $0x3,%al
 bce:	00 00                	add    %al,(%eax)
 bd0:	0c 01                	or     $0x1,%al
 bd2:	55                   	push   %ebp
 bd3:	02 00                	add    (%eax),%al
 bd5:	00 b5 0e 6a 00 00    	add    %dh,0x6a0e(%ebp)
 bdb:	00 10                	add    %dl,(%eax)
 bdd:	01 73 04             	add    %esi,0x4(%ebx)
 be0:	00 00                	add    %al,(%eax)
 be2:	b9 0e 6a 00 00       	mov    $0x6a0e,%ecx
 be7:	00 14 01             	add    %dl,(%ecx,%eax,1)
 bea:	7f 02                	jg     bee <PR_BOOTABLE+0xb6e>
 bec:	00 00                	add    %al,(%eax)
 bee:	ba 0e 6a 00 00       	mov    $0x6a0e,%edx
 bf3:	00 18                	add    %bl,(%eax)
 bf5:	01 5d 03             	add    %ebx,0x3(%ebp)
 bf8:	00 00                	add    %al,(%eax)
 bfa:	ca 07 c7             	lret   $0xc707
 bfd:	03 00                	add    (%eax),%eax
 bff:	00 1c 01             	add    %bl,(%ecx,%eax,1)
 c02:	6b 03 00             	imul   $0x0,(%ebx),%eax
 c05:	00 cd                	add    %cl,%ch
 c07:	0e                   	push   %cs
 c08:	6a 00                	push   $0x0
 c0a:	00 00                	add    %al,(%eax)
 c0c:	2c 01                	sub    $0x1,%al
 c0e:	f1                   	icebp  
 c0f:	01 00                	add    %eax,(%eax)
 c11:	00 cf                	add    %cl,%bh
 c13:	0e                   	push   %cs
 c14:	6a 00                	push   $0x0
 c16:	00 00                	add    %al,(%eax)
 c18:	30 01                	xor    %al,(%ecx)
 c1a:	30 04 00             	xor    %al,(%eax,%eax,1)
 c1d:	00 d3                	add    %dl,%bl
 c1f:	0e                   	push   %cs
 c20:	6a 00                	push   $0x0
 c22:	00 00                	add    %al,(%eax)
 c24:	34 01                	xor    $0x1,%al
 c26:	ca 02 00             	lret   $0x2
 c29:	00 d4                	add    %dl,%ah
 c2b:	0e                   	push   %cs
 c2c:	6a 00                	push   $0x0
 c2e:	00 00                	add    %al,(%eax)
 c30:	38 01                	cmp    %al,(%ecx)
 c32:	cd 03                	int    $0x3
 c34:	00 00                	add    %al,(%eax)
 c36:	d7                   	xlat   %ds:(%ebx)
 c37:	0e                   	push   %cs
 c38:	6a 00                	push   $0x0
 c3a:	00 00                	add    %al,(%eax)
 c3c:	3c 01                	cmp    $0x1,%al
 c3e:	88 04 00             	mov    %al,(%eax,%eax,1)
 c41:	00 da                	add    %bl,%dl
 c43:	0e                   	push   %cs
 c44:	6a 00                	push   $0x0
 c46:	00 00                	add    %al,(%eax)
 c48:	40                   	inc    %eax
 c49:	01 bc 04 00 00 dd 0e 	add    %edi,0xedd0000(%esp,%eax,1)
 c50:	6a 00                	push   $0x0
 c52:	00 00                	add    %al,(%eax)
 c54:	44                   	inc    %esp
 c55:	01 87 03 00 00 e0    	add    %eax,-0x1ffffffd(%edi)
 c5b:	0e                   	push   %cs
 c5c:	6a 00                	push   $0x0
 c5e:	00 00                	add    %al,(%eax)
 c60:	48                   	dec    %eax
 c61:	01 10                	add    %edx,(%eax)
 c63:	04 00                	add    $0x0,%al
 c65:	00 e1                	add    %ah,%cl
 c67:	0e                   	push   %cs
 c68:	6a 00                	push   $0x0
 c6a:	00 00                	add    %al,(%eax)
 c6c:	4c                   	dec    %esp
 c6d:	01 f5                	add    %esi,%ebp
 c6f:	03 00                	add    (%eax),%eax
 c71:	00 e2                	add    %ah,%dl
 c73:	0e                   	push   %cs
 c74:	6a 00                	push   $0x0
 c76:	00 00                	add    %al,(%eax)
 c78:	50                   	push   %eax
 c79:	01 99 04 00 00 e3    	add    %ebx,-0x1cfffffc(%ecx)
 c7f:	0e                   	push   %cs
 c80:	6a 00                	push   $0x0
 c82:	00 00                	add    %al,(%eax)
 c84:	54                   	push   %esp
 c85:	01 02                	add    %eax,(%edx)
 c87:	02 00                	add    (%eax),%al
 c89:	00 e4                	add    %ah,%ah
 c8b:	0e                   	push   %cs
 c8c:	6a 00                	push   $0x0
 c8e:	00 00                	add    %al,(%eax)
 c90:	58                   	pop    %eax
 c91:	01 59 04             	add    %ebx,0x4(%ecx)
 c94:	00 00                	add    %al,(%eax)
 c96:	e5 0e                	in     $0xe,%eax
 c98:	6a 00                	push   $0x0
 c9a:	00 00                	add    %al,(%eax)
 c9c:	5c                   	pop    %esp
 c9d:	00 03                	add    %al,(%ebx)
 c9f:	f5                   	cmc    
 ca0:	02 00                	add    (%eax),%al
 ca2:	00 e6                	add    %ah,%dh
 ca4:	03 e9                	add    %ecx,%ebp
 ca6:	03 00                	add    (%eax),%eax
 ca8:	00 1a                	add    %bl,(%edx)
 caa:	77 03                	ja     caf <PR_BOOTABLE+0xc2f>
 cac:	00 00                	add    %al,(%eax)
 cae:	01 08                	add    %ecx,(%eax)
 cb0:	0e                   	push   %cs
 cb1:	f1                   	icebp  
 cb2:	04 00                	add    $0x0,%al
 cb4:	00 05 03 c0 92 00    	add    %al,0x92c003
 cba:	00 07                	add    %al,(%edi)
 cbc:	90                   	nop
 cbd:	00 00                	add    %al,(%eax)
 cbf:	00 02                	add    %al,(%edx)
 cc1:	4a                   	dec    %edx
 cc2:	06                   	push   %es
 cc3:	20 05 00 00 04 58    	and    %al,0x58040000
 cc9:	00 00                	add    %al,(%eax)
 ccb:	00 00                	add    %al,(%eax)
 ccd:	07                   	pop    %es
 cce:	2d 01 00 00 02       	sub    $0x2000001,%eax
 cd3:	70 06                	jo     cdb <PR_BOOTABLE+0xc5b>
 cd5:	41                   	inc    %ecx
 cd6:	05 00 00 04 6a       	add    $0x6a040000,%eax
 cdb:	00 00                	add    %al,(%eax)
 cdd:	00 04 6a             	add    %al,(%edx,%ebp,2)
 ce0:	00 00                	add    %al,(%eax)
 ce2:	00 04 6a             	add    %al,(%edx,%ebp,2)
 ce5:	00 00                	add    %al,(%eax)
 ce7:	00 04 6a             	add    %al,(%edx,%ebp,2)
 cea:	00 00                	add    %al,(%eax)
 cec:	00 00                	add    %al,(%eax)
 cee:	07                   	pop    %es
 cef:	73 02                	jae    cf3 <PR_BOOTABLE+0xc73>
 cf1:	00 00                	add    %al,(%eax)
 cf3:	01 06                	add    %eax,(%esi)
 cf5:	0d 58 05 00 00       	or     $0x558,%eax
 cfa:	04 6a                	add    $0x6a,%al
 cfc:	00 00                	add    %al,(%eax)
 cfe:	00 04 58             	add    %al,(%eax,%ebx,2)
 d01:	05 00 00 00 09       	add    $0x9000000,%eax
 d06:	f1                   	icebp  
 d07:	04 00                	add    $0x0,%al
 d09:	00 07                	add    %al,(%edi)
 d0b:	8a 00                	mov    (%eax),%al
 d0d:	00 00                	add    %al,(%eax)
 d0f:	02 4c 06 6f          	add    0x6f(%esi,%eax,1),%cl
 d13:	05 00 00 04 6f       	add    $0x6f040000,%eax
 d18:	05 00 00 00 09       	add    $0x9000000,%eax
 d1d:	74 05                	je     d24 <PR_BOOTABLE+0xca4>
 d1f:	00 00                	add    %al,(%eax)
 d21:	05 01 06 47 01       	add    $0x1470601,%eax
 d26:	00 00                	add    %al,(%eax)
 d28:	07                   	pop    %es
 d29:	66 00 00             	data16 add %al,(%eax)
 d2c:	00 02                	add    %al,(%edx)
 d2e:	49                   	dec    %ecx
 d2f:	06                   	push   %es
 d30:	8d 05 00 00 04 6f    	lea    0x6f040000,%eax
 d36:	05 00 00 00 07       	add    $0x7000000,%eax
 d3b:	7e 00                	jle    d3d <PR_BOOTABLE+0xcbd>
 d3d:	00 00                	add    %al,(%eax)
 d3f:	02 4b 06             	add    0x6(%ebx),%cl
 d42:	9f                   	lahf   
 d43:	05 00 00 04 63       	add    $0x63040000,%eax
 d48:	00 00                	add    %al,(%eax)
 d4a:	00 00                	add    %al,(%eax)
 d4c:	11 a0 03 00 00 41    	adc    %esp,0x41000003(%eax)
 d52:	0f 58 05 00 00 15 8e 	addps  0x8e150000,%xmm0
 d59:	00 00                	add    %al,(%eax)
 d5b:	60                   	pusha  
 d5c:	00 00                	add    %al,(%eax)
 d5e:	00 01                	add    %al,(%ecx)
 d60:	9c                   	pushf  
 d61:	01 06                	add    %eax,(%esi)
 d63:	00 00                	add    %al,(%eax)
 d65:	0e                   	push   %cs
 d66:	45                   	inc    %ebp
 d67:	03 00                	add    (%eax),%eax
 d69:	00 41 27             	add    %al,0x27(%ecx)
 d6c:	01 06                	add    %eax,(%esi)
 d6e:	00 00                	add    %al,(%eax)
 d70:	a6                   	cmpsb  %es:(%edi),%ds:(%esi)
 d71:	03 00                	add    (%eax),%eax
 d73:	00 a4 03 00 00 0c 70 	add    %ah,0x700c0000(%ebx,%eax,1)
 d7a:	00 43 12             	add    %al,0x12(%ebx)
 d7d:	01 06                	add    %eax,(%esi)
 d7f:	00 00                	add    %al,(%eax)
 d81:	bb 03 00 00 af       	mov    $0xaf000003,%ebx
 d86:	03 00                	add    (%eax),%eax
 d88:	00 0f                	add    %cl,(%edi)
 d8a:	ab                   	stos   %eax,%es:(%edi)
 d8b:	04 00                	add    $0x0,%al
 d8d:	00 44 6a 00          	add    %al,0x0(%edx,%ebp,2)
 d91:	00 00                	add    %al,(%eax)
 d93:	14 04                	adc    $0x4,%al
 d95:	00 00                	add    %al,(%eax)
 d97:	0a 04 00             	or     (%eax,%eax,1),%al
 d9a:	00 02                	add    %al,(%edx)
 d9c:	2c 8e                	sub    $0x8e,%al
 d9e:	00 00                	add    %al,(%eax)
 da0:	7b 05                	jnp    da7 <PR_BOOTABLE+0xd27>
 da2:	00 00                	add    %al,(%eax)
 da4:	02 47 8e             	add    -0x72(%edi),%al
 da7:	00 00                	add    %al,(%eax)
 da9:	0e                   	push   %cs
 daa:	05 00 00 00 09       	add    $0x9000000,%eax
 daf:	bf 01 00 00 11       	mov    $0x11000001,%edi
 db4:	25 02 00 00 2b       	and    $0x2b000002,%eax
 db9:	0a 6a 00             	or     0x0(%edx),%ch
 dbc:	00 00                	add    %al,(%eax)
 dbe:	94                   	xchg   %eax,%esp
 dbf:	8d 00                	lea    (%eax),%eax
 dc1:	00 81 00 00 00 01    	add    %al,0x1000000(%ecx)
 dc7:	9c                   	pushf  
 dc8:	73 06                	jae    dd0 <PR_BOOTABLE+0xd50>
 dca:	00 00                	add    %al,(%eax)
 dcc:	0e                   	push   %cs
 dcd:	bd 03 00 00 2b       	mov    $0x2b000003,%ebp
 dd2:	1f                   	pop    %ds
 dd3:	6a 00                	push   $0x0
 dd5:	00 00                	add    %al,(%eax)
 dd7:	41                   	inc    %ecx
 dd8:	04 00                	add    $0x0,%al
 dda:	00 3f                	add    %bh,(%edi)
 ddc:	04 00                	add    $0x0,%al
 dde:	00 0c 70             	add    %cl,(%eax,%esi,2)
 de1:	68 00 2e 0e 73       	push   $0x730e2e00
 de6:	06                   	push   %es
 de7:	00 00                	add    %al,(%eax)
 de9:	4e                   	dec    %esi
 dea:	04 00                	add    $0x0,%al
 dec:	00 48 04             	add    %cl,0x4(%eax)
 def:	00 00                	add    %al,(%eax)
 df1:	0c 65                	or     $0x65,%al
 df3:	70 68                	jo     e5d <PR_BOOTABLE+0xddd>
 df5:	00 2e                	add    %ch,(%esi)
 df7:	13 73 06             	adc    0x6(%ebx),%esi
 dfa:	00 00                	add    %al,(%eax)
 dfc:	62 04 00             	bound  %eax,(%eax,%eax,1)
 dff:	00 60 04             	add    %ah,0x4(%eax)
 e02:	00 00                	add    %al,(%eax)
 e04:	02 b2 8d 00 00 20    	add    0x2000008d(%edx),%dh
 e0a:	05 00 00 02 ce       	add    $0xce020000,%eax
 e0f:	8d 00                	lea    (%eax),%eax
 e11:	00 5d 05             	add    %bl,0x5(%ebp)
 e14:	00 00                	add    %al,(%eax)
 e16:	02 fe                	add    %dh,%bh
 e18:	8d 00                	lea    (%eax),%eax
 e1a:	00 20                	add    %ah,(%eax)
 e1c:	05 00 00 00 09       	add    $0x9000000,%eax
 e21:	11 03                	adc    %eax,(%ebx)
 e23:	00 00                	add    %al,(%eax)
 e25:	1b 0f                	sbb    (%edi),%ecx
 e27:	03 00                	add    (%eax),%eax
 e29:	00 01                	add    %al,(%ecx)
 e2b:	0a 06                	or     (%esi),%al
 e2d:	75 8e                	jne    dbd <PR_BOOTABLE+0xd3d>
 e2f:	00 00                	add    %al,(%eax)
 e31:	a3 00 00 00 01       	mov    %eax,0x1000000
 e36:	9c                   	pushf  
 e37:	4c                   	dec    %esp
 e38:	07                   	pop    %es
 e39:	00 00                	add    %al,(%eax)
 e3b:	12 64 65 76          	adc    0x76(%ebp,%eiz,2),%ah
 e3f:	00 19                	add    %bl,(%ecx)
 e41:	6a 00                	push   $0x0
 e43:	00 00                	add    %al,(%eax)
 e45:	6a 04                	push   $0x4
 e47:	00 00                	add    %al,(%eax)
 e49:	68 04 00 00 12       	push   $0x12000004
 e4e:	6d                   	insl   (%dx),%es:(%edi)
 e4f:	62 72 00             	bound  %esi,0x0(%edx)
 e52:	25 4c 07 00 00       	and    $0x74c,%eax
 e57:	75 04                	jne    e5d <PR_BOOTABLE+0xddd>
 e59:	00 00                	add    %al,(%eax)
 e5b:	73 04                	jae    e61 <PR_BOOTABLE+0xde1>
 e5d:	00 00                	add    %al,(%eax)
 e5f:	0e                   	push   %cs
 e60:	45                   	inc    %ebp
 e61:	03 00                	add    (%eax),%eax
 e63:	00 0a                	add    %cl,(%edx)
 e65:	37                   	aaa    
 e66:	01 06                	add    %eax,(%esi)
 e68:	00 00                	add    %al,(%eax)
 e6a:	80 04 00 00          	addb   $0x0,(%eax,%eax,1)
 e6e:	7e 04                	jle    e74 <PR_BOOTABLE+0xdf4>
 e70:	00 00                	add    %al,(%eax)
 e72:	0c 69                	or     $0x69,%al
 e74:	00 10                	add    %dl,(%eax)
 e76:	09 63 00             	or     %esp,0x0(%ebx)
 e79:	00 00                	add    %al,(%eax)
 e7b:	8d 04 00             	lea    (%eax,%eax,1),%eax
 e7e:	00 89 04 00 00 0f    	add    %cl,0xf000004(%ecx)
 e84:	02 03                	add    (%ebx),%al
 e86:	00 00                	add    %al,(%eax)
 e88:	11 6a 00             	adc    %ebp,0x0(%edx)
 e8b:	00 00                	add    %al,(%eax)
 e8d:	a3 04 00 00 9d       	mov    %eax,0x9d000004
 e92:	04 00                	add    $0x0,%al
 e94:	00 0f                	add    %cl,(%edi)
 e96:	16                   	push   %ss
 e97:	02 00                	add    (%eax),%al
 e99:	00 1f                	add    %bl,(%edi)
 e9b:	6a 00                	push   $0x0
 e9d:	00 00                	add    %al,(%eax)
 e9f:	bf 04 00 00 bb       	mov    $0xbb000004,%edi
 ea4:	04 00                	add    $0x0,%al
 ea6:	00 02                	add    %al,(%edx)
 ea8:	8a 8e 00 00 8d 05    	mov    0x58d0000(%esi),%cl
 eae:	00 00                	add    %al,(%eax)
 eb0:	02 96 8e 00 00 7b    	add    0x7b00008e(%esi),%dl
 eb6:	05 00 00 02 c8       	add    $0xc8020000,%eax
 ebb:	8e 00                	mov    (%eax),%es
 ebd:	00 5d 05             	add    %bl,0x5(%ebp)
 ec0:	00 00                	add    %al,(%eax)
 ec2:	02 d4                	add    %ah,%dl
 ec4:	8e 00                	mov    (%eax),%es
 ec6:	00 9f 05 00 00 02    	add    %bl,0x2000005(%edi)
 ecc:	e0 8e                	loopne e5c <PR_BOOTABLE+0xddc>
 ece:	00 00                	add    %al,(%eax)
 ed0:	7b 05                	jnp    ed7 <PR_BOOTABLE+0xe57>
 ed2:	00 00                	add    %al,(%eax)
 ed4:	02 e8                	add    %al,%ch
 ed6:	8e 00                	mov    (%eax),%es
 ed8:	00 06                	add    %al,(%esi)
 eda:	06                   	push   %es
 edb:	00 00                	add    %al,(%eax)
 edd:	02 f6                	add    %dh,%dh
 edf:	8e 00                	mov    (%eax),%es
 ee1:	00 7b 05             	add    %bh,0x5(%ebx)
 ee4:	00 00                	add    %al,(%eax)
 ee6:	02 03                	add    (%ebx),%al
 ee8:	8f 00                	pop    (%eax)
 eea:	00 41 05             	add    %al,0x5(%ecx)
 eed:	00 00                	add    %al,(%eax)
 eef:	1c 18                	sbb    $0x18,%al
 ef1:	8f 00                	pop    (%eax)
 ef3:	00 5d 05             	add    %bl,0x5(%ebp)
 ef6:	00 00                	add    %al,(%eax)
 ef8:	00 09                	add    %cl,(%ecx)
 efa:	78 01                	js     efd <PR_BOOTABLE+0xe7d>
 efc:	00 00                	add    %al,(%eax)
 efe:	00 20                	add    %ah,(%eax)
 f00:	00 00                	add    %al,(%eax)
 f02:	00 05 00 01 04 3d    	add    %al,0x3d040100
 f08:	04 00                	add    $0x0,%al
 f0a:	00 01                	add    %al,(%ecx)
 f0c:	4d                   	dec    %ebp
 f0d:	06                   	push   %es
 f0e:	00 00                	add    %al,(%eax)
 f10:	18 8f 00 00 10 d9    	sbb    %cl,-0x26f00000(%edi)
 f16:	04 00                	add    $0x0,%al
 f18:	00 08                	add    %cl,(%eax)
 f1a:	00 00                	add    %al,(%eax)
 f1c:	00 4a 00             	add    %cl,0x0(%edx)
 f1f:	00 00                	add    %al,(%eax)
 f21:	01                   	.byte 0x1
 f22:	80                   	.byte 0x80

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	01 11                	add    %edx,(%ecx)
   2:	00 10                	add    %dl,(%eax)
   4:	17                   	pop    %ss
   5:	11 01                	adc    %eax,(%ecx)
   7:	12 0f                	adc    (%edi),%cl
   9:	03 0e                	add    (%esi),%ecx
   b:	1b 0e                	sbb    (%esi),%ecx
   d:	25 0e 13 05 00       	and    $0x5130e,%eax
  12:	00 00                	add    %al,(%eax)
  14:	01 05 00 31 13 02    	add    %eax,0x2133100
  1a:	17                   	pop    %ss
  1b:	b7 42                	mov    $0x42,%bh
  1d:	17                   	pop    %ss
  1e:	00 00                	add    %al,(%eax)
  20:	02 05 00 03 08 3a    	add    0x3a080300,%al
  26:	21 01                	and    %eax,(%ecx)
  28:	3b 0b                	cmp    (%ebx),%ecx
  2a:	39 0b                	cmp    %ecx,(%ebx)
  2c:	49                   	dec    %ecx
  2d:	13 02                	adc    (%edx),%eax
  2f:	17                   	pop    %ss
  30:	b7 42                	mov    $0x42,%bh
  32:	17                   	pop    %ss
  33:	00 00                	add    %al,(%eax)
  35:	03 2e                	add    (%esi),%ebp
  37:	01 3f                	add    %edi,(%edi)
  39:	19 03                	sbb    %eax,(%ebx)
  3b:	0e                   	push   %cs
  3c:	3a 21                	cmp    (%ecx),%ah
  3e:	01 3b                	add    %edi,(%ebx)
  40:	0b 39                	or     (%ecx),%edi
  42:	21 06                	and    %eax,(%esi)
  44:	27                   	daa    
  45:	19 11                	sbb    %edx,(%ecx)
  47:	01 12                	add    %edx,(%edx)
  49:	06                   	push   %es
  4a:	40                   	inc    %eax
  4b:	18 7a 19             	sbb    %bh,0x19(%edx)
  4e:	01 13                	add    %edx,(%ebx)
  50:	00 00                	add    %al,(%eax)
  52:	04 48                	add    $0x48,%al
  54:	00 7d 01             	add    %bh,0x1(%ebp)
  57:	7f 13                	jg     6c <PROT_MODE_DSEG+0x5c>
  59:	00 00                	add    %al,(%eax)
  5b:	05 24 00 0b 0b       	add    $0xb0b0024,%eax
  60:	3e 0b 03             	or     %ds:(%ebx),%eax
  63:	0e                   	push   %cs
  64:	00 00                	add    %al,(%eax)
  66:	06                   	push   %es
  67:	05 00 03 0e 3a       	add    $0x3a0e0300,%eax
  6c:	21 01                	and    %eax,(%ecx)
  6e:	3b 0b                	cmp    (%ebx),%ecx
  70:	39 0b                	cmp    %ecx,(%ebx)
  72:	49                   	dec    %ecx
  73:	13 02                	adc    (%edx),%eax
  75:	17                   	pop    %ss
  76:	b7 42                	mov    $0x42,%bh
  78:	17                   	pop    %ss
  79:	00 00                	add    %al,(%eax)
  7b:	07                   	pop    %es
  7c:	34 00                	xor    $0x0,%al
  7e:	03 08                	add    (%eax),%ecx
  80:	3a 21                	cmp    (%ecx),%ah
  82:	01 3b                	add    %edi,(%ebx)
  84:	0b 39                	or     (%ecx),%edi
  86:	0b 49 13             	or     0x13(%ecx),%ecx
  89:	02 17                	add    (%edi),%dl
  8b:	b7 42                	mov    $0x42,%bh
  8d:	17                   	pop    %ss
  8e:	00 00                	add    %al,(%eax)
  90:	08 05 00 03 0e 3a    	or     %al,0x3a0e0300
  96:	21 02                	and    %eax,(%edx)
  98:	3b 0b                	cmp    (%ebx),%ecx
  9a:	39 0b                	cmp    %ecx,(%ebx)
  9c:	49                   	dec    %ecx
  9d:	13 00                	adc    (%eax),%eax
  9f:	00 09                	add    %cl,(%ecx)
  a1:	1d 01 31 13 52       	sbb    $0x52133101,%eax
  a6:	01 b8 42 0b 55 17    	add    %edi,0x17550b42(%eax)
  ac:	58                   	pop    %eax
  ad:	21 01                	and    %eax,(%ecx)
  af:	59                   	pop    %ecx
  b0:	0b 57 21             	or     0x21(%edi),%edx
  b3:	05 01 13 00 00       	add    $0x1301,%eax
  b8:	0a 1d 01 31 13 52    	or     0x52133101,%bl
  be:	01 b8 42 0b 11 01    	add    %edi,0x1110b42(%eax)
  c4:	12 06                	adc    (%esi),%al
  c6:	58                   	pop    %eax
  c7:	21 01                	and    %eax,(%ecx)
  c9:	59                   	pop    %ecx
  ca:	0b 57 21             	or     0x21(%edi),%edx
  cd:	05 01 13 00 00       	add    $0x1301,%eax
  d2:	0b 16                	or     (%esi),%edx
  d4:	00 03                	add    %al,(%ebx)
  d6:	0e                   	push   %cs
  d7:	3a 21                	cmp    (%ecx),%ah
  d9:	02 3b                	add    (%ebx),%bh
  db:	0b 39                	or     (%ecx),%edi
  dd:	21 1c 49             	and    %ebx,(%ecx,%ecx,2)
  e0:	13 00                	adc    (%eax),%eax
  e2:	00 0c 0f             	add    %cl,(%edi,%ecx,1)
  e5:	00 0b                	add    %cl,(%ebx)
  e7:	21 04 49             	and    %eax,(%ecx,%ecx,2)
  ea:	13 00                	adc    (%eax),%eax
  ec:	00 0d 34 00 03 08    	add    %cl,0x8030034
  f2:	3a 21                	cmp    (%ecx),%ah
  f4:	01 3b                	add    %edi,(%ebx)
  f6:	0b 39                	or     (%ecx),%edi
  f8:	0b 49 13             	or     0x13(%ecx),%ecx
  fb:	02 18                	add    (%eax),%bl
  fd:	00 00                	add    %al,(%eax)
  ff:	0e                   	push   %cs
 100:	01 01                	add    %eax,(%ecx)
 102:	49                   	dec    %ecx
 103:	13 01                	adc    (%ecx),%eax
 105:	13 00                	adc    (%eax),%eax
 107:	00 0f                	add    %cl,(%edi)
 109:	21 00                	and    %eax,(%eax)
 10b:	49                   	dec    %ecx
 10c:	13 2f                	adc    (%edi),%ebp
 10e:	0b 00                	or     (%eax),%eax
 110:	00 10                	add    %dl,(%eax)
 112:	05 00 03 08 3a       	add    $0x3a080300,%eax
 117:	21 01                	and    %eax,(%ecx)
 119:	3b 0b                	cmp    (%ebx),%ecx
 11b:	39 0b                	cmp    %ecx,(%ebx)
 11d:	49                   	dec    %ecx
 11e:	13 02                	adc    (%edx),%eax
 120:	18 00                	sbb    %al,(%eax)
 122:	00 11                	add    %dl,(%ecx)
 124:	34 00                	xor    $0x0,%al
 126:	03 0e                	add    (%esi),%ecx
 128:	3a 21                	cmp    (%ecx),%ah
 12a:	01 3b                	add    %edi,(%ebx)
 12c:	0b 39                	or     (%ecx),%edi
 12e:	0b 49 13             	or     0x13(%ecx),%ecx
 131:	3f                   	aas    
 132:	19 02                	sbb    %eax,(%edx)
 134:	18 00                	sbb    %al,(%eax)
 136:	00 12                	add    %dl,(%edx)
 138:	34 00                	xor    $0x0,%al
 13a:	03 0e                	add    (%esi),%ecx
 13c:	3a 21                	cmp    (%ecx),%ah
 13e:	01 3b                	add    %edi,(%ebx)
 140:	0b 39                	or     (%ecx),%edi
 142:	0b 49 13             	or     0x13(%ecx),%ecx
 145:	02 17                	add    (%edi),%dl
 147:	b7 42                	mov    $0x42,%bh
 149:	17                   	pop    %ss
 14a:	00 00                	add    %al,(%eax)
 14c:	13 1d 01 31 13 52    	adc    0x52133101,%ebx
 152:	01 b8 42 0b 55 17    	add    %edi,0x17550b42(%eax)
 158:	58                   	pop    %eax
 159:	21 01                	and    %eax,(%ecx)
 15b:	59                   	pop    %ecx
 15c:	0b 57 21             	or     0x21(%edi),%edx
 15f:	0d 00 00 14 0b       	or     $0xb140000,%eax
 164:	01 55 17             	add    %edx,0x17(%ebp)
 167:	00 00                	add    %al,(%eax)
 169:	15 34 00 31 13       	adc    $0x13310034,%eax
 16e:	02 17                	add    (%edi),%dl
 170:	b7 42                	mov    $0x42,%bh
 172:	17                   	pop    %ss
 173:	00 00                	add    %al,(%eax)
 175:	16                   	push   %ss
 176:	48                   	dec    %eax
 177:	00 7d 01             	add    %bh,0x1(%ebp)
 17a:	82 01 19             	addb   $0x19,(%ecx)
 17d:	7f 13                	jg     192 <PR_BOOTABLE+0x112>
 17f:	00 00                	add    %al,(%eax)
 181:	17                   	pop    %ss
 182:	2e 01 3f             	add    %edi,%cs:(%edi)
 185:	19 03                	sbb    %eax,(%ebx)
 187:	0e                   	push   %cs
 188:	3a 21                	cmp    (%ecx),%ah
 18a:	01 3b                	add    %edi,(%ebx)
 18c:	0b 39                	or     (%ecx),%edi
 18e:	21 05 27 19 49 13    	and    %eax,0x13491927
 194:	11 01                	adc    %eax,(%ecx)
 196:	12 06                	adc    (%esi),%al
 198:	40                   	inc    %eax
 199:	18 7a 19             	sbb    %bh,0x19(%edx)
 19c:	01 13                	add    %edx,(%ebx)
 19e:	00 00                	add    %al,(%eax)
 1a0:	18 11                	sbb    %dl,(%ecx)
 1a2:	01 25 0e 13 0b 03    	add    %esp,0x30b130e
 1a8:	1f                   	pop    %ds
 1a9:	1b 1f                	sbb    (%edi),%ebx
 1ab:	11 01                	adc    %eax,(%ecx)
 1ad:	12 06                	adc    (%esi),%al
 1af:	10 17                	adc    %dl,(%edi)
 1b1:	00 00                	add    %al,(%eax)
 1b3:	19 24 00             	sbb    %esp,(%eax,%eax,1)
 1b6:	0b 0b                	or     (%ebx),%ecx
 1b8:	3e 0b 03             	or     %ds:(%ebx),%eax
 1bb:	08 00                	or     %al,(%eax)
 1bd:	00 1a                	add    %bl,(%edx)
 1bf:	35 00 49 13 00       	xor    $0x134900,%eax
 1c4:	00 1b                	add    %bl,(%ebx)
 1c6:	26 00 49 13          	add    %cl,%es:0x13(%ecx)
 1ca:	00 00                	add    %al,(%eax)
 1cc:	1c 34                	sbb    $0x34,%al
 1ce:	00 03                	add    %al,(%ebx)
 1d0:	0e                   	push   %cs
 1d1:	3a 0b                	cmp    (%ebx),%cl
 1d3:	3b 0b                	cmp    (%ebx),%ecx
 1d5:	39 0b                	cmp    %ecx,(%ebx)
 1d7:	49                   	dec    %ecx
 1d8:	13 02                	adc    (%edx),%eax
 1da:	18 00                	sbb    %al,(%eax)
 1dc:	00 1d 1d 01 31 13    	add    %bl,0x1331011d
 1e2:	52                   	push   %edx
 1e3:	01 b8 42 0b 11 01    	add    %edi,0x1110b42(%eax)
 1e9:	12 06                	adc    (%esi),%al
 1eb:	58                   	pop    %eax
 1ec:	0b 59 0b             	or     0xb(%ecx),%ebx
 1ef:	57                   	push   %edi
 1f0:	0b 00                	or     (%eax),%eax
 1f2:	00 1e                	add    %bl,(%esi)
 1f4:	0f 00 0b             	str    (%ebx)
 1f7:	0b 00                	or     (%eax),%eax
 1f9:	00 1f                	add    %bl,(%edi)
 1fb:	2e 00 03             	add    %al,%cs:(%ebx)
 1fe:	0e                   	push   %cs
 1ff:	3a 0b                	cmp    (%ebx),%cl
 201:	3b 0b                	cmp    (%ebx),%ecx
 203:	39 0b                	cmp    %ecx,(%ebx)
 205:	27                   	daa    
 206:	19 20                	sbb    %esp,(%eax)
 208:	0b 00                	or     (%eax),%eax
 20a:	00 20                	add    %ah,(%eax)
 20c:	05 00 03 0e 3a       	add    $0x3a0e0300,%eax
 211:	0b 3b                	or     (%ebx),%edi
 213:	0b 39                	or     (%ecx),%edi
 215:	0b 49 13             	or     0x13(%ecx),%ecx
 218:	02 18                	add    (%eax),%bl
 21a:	00 00                	add    %al,(%eax)
 21c:	21 2e                	and    %ebp,(%esi)
 21e:	01 03                	add    %eax,(%ebx)
 220:	0e                   	push   %cs
 221:	3a 0b                	cmp    (%ebx),%cl
 223:	3b 0b                	cmp    (%ebx),%ecx
 225:	39 0b                	cmp    %ecx,(%ebx)
 227:	27                   	daa    
 228:	19 20                	sbb    %esp,(%eax)
 22a:	0b 01                	or     (%ecx),%eax
 22c:	13 00                	adc    (%eax),%eax
 22e:	00 22                	add    %ah,(%edx)
 230:	05 00 03 08 3a       	add    $0x3a080300,%eax
 235:	0b 3b                	or     (%ebx),%edi
 237:	0b 39                	or     (%ecx),%edi
 239:	0b 49 13             	or     0x13(%ecx),%ecx
 23c:	00 00                	add    %al,(%eax)
 23e:	23 2e                	and    (%esi),%ebp
 240:	01 03                	add    %eax,(%ebx)
 242:	08 3a                	or     %bh,(%edx)
 244:	0b 3b                	or     (%ebx),%edi
 246:	0b 39                	or     (%ecx),%edi
 248:	0b 27                	or     (%edi),%esp
 24a:	19 49 13             	sbb    %ecx,0x13(%ecx)
 24d:	20 0b                	and    %cl,(%ebx)
 24f:	01 13                	add    %edx,(%ebx)
 251:	00 00                	add    %al,(%eax)
 253:	24 34                	and    $0x34,%al
 255:	00 03                	add    %al,(%ebx)
 257:	0e                   	push   %cs
 258:	3a 0b                	cmp    (%ebx),%cl
 25a:	3b 0b                	cmp    (%ebx),%ecx
 25c:	39 0b                	cmp    %ecx,(%ebx)
 25e:	49                   	dec    %ecx
 25f:	13 00                	adc    (%eax),%eax
 261:	00 25 2e 01 03 0e    	add    %ah,0xe03012e
 267:	3a 0b                	cmp    (%ebx),%cl
 269:	3b 0b                	cmp    (%ebx),%ecx
 26b:	39 0b                	cmp    %ecx,(%ebx)
 26d:	27                   	daa    
 26e:	19 20                	sbb    %esp,(%eax)
 270:	0b 00                	or     (%eax),%eax
 272:	00 00                	add    %al,(%eax)
 274:	01 0d 00 03 0e 3a    	add    %ecx,0x3a0e0300
 27a:	21 02                	and    %eax,(%edx)
 27c:	3b 0b                	cmp    (%ebx),%ecx
 27e:	39 0b                	cmp    %ecx,(%ebx)
 280:	49                   	dec    %ecx
 281:	13 38                	adc    (%eax),%edi
 283:	0b 00                	or     (%eax),%eax
 285:	00 02                	add    %al,(%edx)
 287:	48                   	dec    %eax
 288:	00 7d 01             	add    %bh,0x1(%ebp)
 28b:	7f 13                	jg     2a0 <PR_BOOTABLE+0x220>
 28d:	00 00                	add    %al,(%eax)
 28f:	03 16                	add    (%esi),%edx
 291:	00 03                	add    %al,(%ebx)
 293:	0e                   	push   %cs
 294:	3a 21                	cmp    (%ecx),%ah
 296:	02 3b                	add    (%ebx),%bh
 298:	0b 39                	or     (%ecx),%edi
 29a:	0b 49 13             	or     0x13(%ecx),%ecx
 29d:	00 00                	add    %al,(%eax)
 29f:	04 05                	add    $0x5,%al
 2a1:	00 49 13             	add    %cl,0x13(%ecx)
 2a4:	00 00                	add    %al,(%eax)
 2a6:	05 24 00 0b 0b       	add    $0xb0b0024,%eax
 2ab:	3e 0b 03             	or     %ds:(%ebx),%eax
 2ae:	0e                   	push   %cs
 2af:	00 00                	add    %al,(%eax)
 2b1:	06                   	push   %es
 2b2:	01 01                	add    %eax,(%ecx)
 2b4:	49                   	dec    %ecx
 2b5:	13 01                	adc    (%ecx),%eax
 2b7:	13 00                	adc    (%eax),%eax
 2b9:	00 07                	add    %al,(%edi)
 2bb:	2e 01 3f             	add    %edi,%cs:(%edi)
 2be:	19 03                	sbb    %eax,(%ebx)
 2c0:	0e                   	push   %cs
 2c1:	3a 0b                	cmp    (%ebx),%cl
 2c3:	3b 0b                	cmp    (%ebx),%ecx
 2c5:	39 0b                	cmp    %ecx,(%ebx)
 2c7:	27                   	daa    
 2c8:	19 3c 19             	sbb    %edi,(%ecx,%ebx,1)
 2cb:	01 13                	add    %edx,(%ebx)
 2cd:	00 00                	add    %al,(%eax)
 2cf:	08 21                	or     %ah,(%ecx)
 2d1:	00 49 13             	add    %cl,0x13(%ecx)
 2d4:	2f                   	das    
 2d5:	0b 00                	or     (%eax),%eax
 2d7:	00 09                	add    %cl,(%ecx)
 2d9:	0f 00 0b             	str    (%ebx)
 2dc:	21 04 49             	and    %eax,(%ecx,%ecx,2)
 2df:	13 00                	adc    (%eax),%eax
 2e1:	00 0a                	add    %cl,(%edx)
 2e3:	13 01                	adc    (%ecx),%eax
 2e5:	0b 0b                	or     (%ebx),%ecx
 2e7:	3a 21                	cmp    (%ecx),%ah
 2e9:	02 3b                	add    (%ebx),%bh
 2eb:	0b 39                	or     (%ecx),%edi
 2ed:	0b 01                	or     (%ecx),%eax
 2ef:	13 00                	adc    (%eax),%eax
 2f1:	00 0b                	add    %cl,(%ebx)
 2f3:	13 01                	adc    (%ecx),%eax
 2f5:	03 0e                	add    (%esi),%ecx
 2f7:	0b 0b                	or     (%ebx),%ecx
 2f9:	3a 21                	cmp    (%ecx),%ah
 2fb:	02 3b                	add    (%ebx),%bh
 2fd:	0b 39                	or     (%ecx),%edi
 2ff:	21 10                	and    %edx,(%eax)
 301:	01 13                	add    %edx,(%ebx)
 303:	00 00                	add    %al,(%eax)
 305:	0c 34                	or     $0x34,%al
 307:	00 03                	add    %al,(%ebx)
 309:	08 3a                	or     %bh,(%edx)
 30b:	21 01                	and    %eax,(%ecx)
 30d:	3b 0b                	cmp    (%ebx),%ecx
 30f:	39 0b                	cmp    %ecx,(%ebx)
 311:	49                   	dec    %ecx
 312:	13 02                	adc    (%edx),%eax
 314:	17                   	pop    %ss
 315:	b7 42                	mov    $0x42,%bh
 317:	17                   	pop    %ss
 318:	00 00                	add    %al,(%eax)
 31a:	0d 0d 00 03 0e       	or     $0xe03000d,%eax
 31f:	3a 21                	cmp    (%ecx),%ah
 321:	02 3b                	add    (%ebx),%bh
 323:	0b 39                	or     (%ecx),%edi
 325:	0b 49 13             	or     0x13(%ecx),%ecx
 328:	38 05 00 00 0e 05    	cmp    %al,0x50e0000
 32e:	00 03                	add    %al,(%ebx)
 330:	0e                   	push   %cs
 331:	3a 21                	cmp    (%ecx),%ah
 333:	01 3b                	add    %edi,(%ebx)
 335:	0b 39                	or     (%ecx),%edi
 337:	0b 49 13             	or     0x13(%ecx),%ecx
 33a:	02 17                	add    (%edi),%dl
 33c:	b7 42                	mov    $0x42,%bh
 33e:	17                   	pop    %ss
 33f:	00 00                	add    %al,(%eax)
 341:	0f 34                	sysenter 
 343:	00 03                	add    %al,(%ebx)
 345:	0e                   	push   %cs
 346:	3a 21                	cmp    (%ecx),%ah
 348:	01 3b                	add    %edi,(%ebx)
 34a:	0b 39                	or     (%ecx),%edi
 34c:	21 0e                	and    %ecx,(%esi)
 34e:	49                   	dec    %ecx
 34f:	13 02                	adc    (%edx),%eax
 351:	17                   	pop    %ss
 352:	b7 42                	mov    $0x42,%bh
 354:	17                   	pop    %ss
 355:	00 00                	add    %al,(%eax)
 357:	10 0d 00 03 08 3a    	adc    %cl,0x3a080300
 35d:	21 02                	and    %eax,(%edx)
 35f:	3b 0b                	cmp    (%ebx),%ecx
 361:	39 0b                	cmp    %ecx,(%ebx)
 363:	49                   	dec    %ecx
 364:	13 38                	adc    (%eax),%edi
 366:	0b 00                	or     (%eax),%eax
 368:	00 11                	add    %dl,(%ecx)
 36a:	2e 01 3f             	add    %edi,%cs:(%edi)
 36d:	19 03                	sbb    %eax,(%ebx)
 36f:	0e                   	push   %cs
 370:	3a 21                	cmp    (%ecx),%ah
 372:	01 3b                	add    %edi,(%ebx)
 374:	0b 39                	or     (%ecx),%edi
 376:	0b 27                	or     (%edi),%esp
 378:	19 49 13             	sbb    %ecx,0x13(%ecx)
 37b:	11 01                	adc    %eax,(%ecx)
 37d:	12 06                	adc    (%esi),%al
 37f:	40                   	inc    %eax
 380:	18 7a 19             	sbb    %bh,0x19(%edx)
 383:	01 13                	add    %edx,(%ebx)
 385:	00 00                	add    %al,(%eax)
 387:	12 05 00 03 08 3a    	adc    0x3a080300,%al
 38d:	21 01                	and    %eax,(%ecx)
 38f:	3b 21                	cmp    (%ecx),%esp
 391:	0a 39                	or     (%ecx),%bh
 393:	0b 49 13             	or     0x13(%ecx),%ecx
 396:	02 17                	add    (%edi),%dl
 398:	b7 42                	mov    $0x42,%bh
 39a:	17                   	pop    %ss
 39b:	00 00                	add    %al,(%eax)
 39d:	13 11                	adc    (%ecx),%edx
 39f:	01 25 0e 13 0b 03    	add    %esp,0x30b130e
 3a5:	1f                   	pop    %ds
 3a6:	1b 1f                	sbb    (%edi),%ebx
 3a8:	11 01                	adc    %eax,(%ecx)
 3aa:	12 06                	adc    (%esi),%al
 3ac:	10 17                	adc    %dl,(%edi)
 3ae:	00 00                	add    %al,(%eax)
 3b0:	14 24                	adc    $0x24,%al
 3b2:	00 0b                	add    %cl,(%ebx)
 3b4:	0b 3e                	or     (%esi),%edi
 3b6:	0b 03                	or     (%ebx),%eax
 3b8:	08 00                	or     %al,(%eax)
 3ba:	00 15 13 01 03 08    	add    %dl,0x8030113
 3c0:	0b 05 3a 0b 3b 0b    	or     0xb3b0b3a,%eax
 3c6:	39 0b                	cmp    %ecx,(%ebx)
 3c8:	01 13                	add    %edx,(%ebx)
 3ca:	00 00                	add    %al,(%eax)
 3cc:	16                   	push   %ss
 3cd:	21 00                	and    %eax,(%eax)
 3cf:	49                   	dec    %ecx
 3d0:	13 2f                	adc    (%edi),%ebp
 3d2:	05 00 00 17 17       	add    $0x17170000,%eax
 3d7:	01 0b                	add    %ecx,(%ebx)
 3d9:	0b 3a                	or     (%edx),%edi
 3db:	0b 3b                	or     (%ebx),%edi
 3dd:	0b 39                	or     (%ecx),%edi
 3df:	0b 01                	or     (%ecx),%eax
 3e1:	13 00                	adc    (%eax),%eax
 3e3:	00 18                	add    %bl,(%eax)
 3e5:	0d 00 03 0e 3a       	or     $0x3a0e0300,%eax
 3ea:	0b 3b                	or     (%ebx),%edi
 3ec:	0b 39                	or     (%ecx),%edi
 3ee:	0b 49 13             	or     0x13(%ecx),%ecx
 3f1:	00 00                	add    %al,(%eax)
 3f3:	19 0d 00 03 08 3a    	sbb    %ecx,0x3a080300
 3f9:	0b 3b                	or     (%ebx),%edi
 3fb:	0b 39                	or     (%ecx),%edi
 3fd:	0b 49 13             	or     0x13(%ecx),%ecx
 400:	00 00                	add    %al,(%eax)
 402:	1a 34 00             	sbb    (%eax,%eax,1),%dh
 405:	03 0e                	add    (%esi),%ecx
 407:	3a 0b                	cmp    (%ebx),%cl
 409:	3b 0b                	cmp    (%ebx),%ecx
 40b:	39 0b                	cmp    %ecx,(%ebx)
 40d:	49                   	dec    %ecx
 40e:	13 3f                	adc    (%edi),%edi
 410:	19 02                	sbb    %eax,(%edx)
 412:	18 00                	sbb    %al,(%eax)
 414:	00 1b                	add    %bl,(%ebx)
 416:	2e 01 3f             	add    %edi,%cs:(%edi)
 419:	19 03                	sbb    %eax,(%ebx)
 41b:	0e                   	push   %cs
 41c:	3a 0b                	cmp    (%ebx),%cl
 41e:	3b 0b                	cmp    (%ebx),%ecx
 420:	39 0b                	cmp    %ecx,(%ebx)
 422:	27                   	daa    
 423:	19 11                	sbb    %edx,(%ecx)
 425:	01 12                	add    %edx,(%edx)
 427:	06                   	push   %es
 428:	40                   	inc    %eax
 429:	18 7a 19             	sbb    %bh,0x19(%edx)
 42c:	01 13                	add    %edx,(%ebx)
 42e:	00 00                	add    %al,(%eax)
 430:	1c 48                	sbb    $0x48,%al
 432:	00 7d 01             	add    %bh,0x1(%ebp)
 435:	82 01 19             	addb   $0x19,(%ecx)
 438:	7f 13                	jg     44d <PR_BOOTABLE+0x3cd>
 43a:	00 00                	add    %al,(%eax)
 43c:	00 01                	add    %al,(%ecx)
 43e:	11 00                	adc    %eax,(%eax)
 440:	10 17                	adc    %dl,(%edi)
 442:	11 01                	adc    %eax,(%ecx)
 444:	12 0f                	adc    (%edi),%cl
 446:	03 0e                	add    (%esi),%ecx
 448:	1b 0e                	sbb    (%esi),%ecx
 44a:	25 0e 13 05 00       	and    $0x5130e,%eax
 44f:	00 00                	add    %al,(%eax)

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	83 00 00             	addl   $0x0,(%eax)
   3:	00 05 00 04 00 2e    	add    %al,0x2e000400
   9:	00 00                	add    %al,(%eax)
   b:	00 01                	add    %al,(%ecx)
   d:	01 01                	add    %eax,(%ecx)
   f:	fb                   	sti    
  10:	0e                   	push   %cs
  11:	0d 00 01 01 01       	or     $0x1010100,%eax
  16:	01 00                	add    %eax,(%eax)
  18:	00 00                	add    %al,(%eax)
  1a:	01 00                	add    %eax,(%eax)
  1c:	00 01                	add    %al,(%ecx)
  1e:	01 01                	add    %eax,(%ecx)
  20:	1f                   	pop    %ds
  21:	02 00                	add    (%eax),%al
  23:	00 00                	add    %al,(%eax)
  25:	00 42 00             	add    %al,0x0(%edx)
  28:	00 00                	add    %al,(%eax)
  2a:	02 01                	add    (%ecx),%al
  2c:	1f                   	pop    %ds
  2d:	02 0f                	add    (%edi),%cl
  2f:	02 4d 00             	add    0x0(%ebp),%cl
  32:	00 00                	add    %al,(%eax)
  34:	00 4d 00             	add    %cl,0x0(%ebp)
  37:	00 00                	add    %al,(%eax)
  39:	01 00                	add    %eax,(%eax)
  3b:	05 02 00 7e 00       	add    $0x7e0002,%eax
  40:	00 03                	add    %al,(%ebx)
  42:	29 01                	sub    %eax,(%ecx)
  44:	21 24 2f             	and    %esp,(%edi,%ebp,1)
  47:	2f                   	das    
  48:	2f                   	das    
  49:	2f                   	das    
  4a:	30 2f                	xor    %ch,(%edi)
  4c:	2f                   	das    
  4d:	2f                   	das    
  4e:	2f                   	das    
  4f:	34 3d                	xor    $0x3d,%al
  51:	42                   	inc    %edx
  52:	3d 67 3e 67 67       	cmp    $0x67673e67,%eax
  57:	30 2f                	xor    %ch,(%edi)
  59:	67 30 83 3d 4b       	xor    %al,0x4b3d(%bp,%di)
  5e:	2f                   	das    
  5f:	30 2f                	xor    %ch,(%edi)
  61:	3d 2f 30 3d 3d       	cmp    $0x3d3d302f,%eax
  66:	31 26                	xor    %esp,(%esi)
  68:	59                   	pop    %ecx
  69:	3d 4b 40 5c 4b       	cmp    $0x4b5c404b,%eax
  6e:	2f                   	das    
  6f:	2f                   	das    
  70:	2f                   	das    
  71:	2f                   	das    
  72:	34 59                	xor    $0x59,%al
  74:	59                   	pop    %ecx
  75:	59                   	pop    %ecx
  76:	21 5b 27             	and    %ebx,0x27(%ebx)
  79:	21 30                	and    %esi,(%eax)
  7b:	21 2f                	and    %ebp,(%edi)
  7d:	2f                   	das    
  7e:	2f                   	das    
  7f:	30 21                	xor    %ah,(%ecx)
  81:	02 fc                	add    %ah,%bh
  83:	18 00                	sbb    %al,(%eax)
  85:	01 01                	add    %eax,(%ecx)
  87:	20 04 00             	and    %al,(%eax,%eax,1)
  8a:	00 05 00 04 00 33    	add    %al,0x33000400
  90:	00 00                	add    %al,(%eax)
  92:	00 01                	add    %al,(%ecx)
  94:	01 01                	add    %eax,(%ecx)
  96:	fb                   	sti    
  97:	0e                   	push   %cs
  98:	0d 00 01 01 01       	or     $0x1010100,%eax
  9d:	01 00                	add    %eax,(%eax)
  9f:	00 00                	add    %al,(%eax)
  a1:	01 00                	add    %eax,(%eax)
  a3:	00 01                	add    %al,(%ecx)
  a5:	01 01                	add    %eax,(%ecx)
  a7:	1f                   	pop    %ds
  a8:	02 00                	add    (%eax),%al
  aa:	00 00                	add    %al,(%eax)
  ac:	00 42 00             	add    %al,0x0(%edx)
  af:	00 00                	add    %al,(%eax)
  b1:	02 01                	add    (%ecx),%al
  b3:	1f                   	pop    %ds
  b4:	02 0f                	add    (%edi),%cl
  b6:	03 55 00             	add    0x0(%ebp),%edx
  b9:	00 00                	add    %al,(%eax)
  bb:	00 60 00             	add    %ah,0x0(%eax)
  be:	00 00                	add    %al,(%eax)
  c0:	01 6b 00             	add    %ebp,0x0(%ebx)
  c3:	00 00                	add    %al,(%eax)
  c5:	01 05 01 00 05 02    	add    %eax,0x2050001
  cb:	26 8b 00             	mov    %es:(%eax),%eax
  ce:	00 1a                	add    %bl,(%edx)
  d0:	05 05 13 05 01       	add    $0x1051305,%eax
  d5:	06                   	push   %es
  d6:	11 3c 05 08 3e 05 22 	adc    %edi,0x22053e08(,%eax,1)
  dd:	3b 05 14 2e 05 05    	cmp    0x5052e14,%eax
  e3:	06                   	push   %es
  e4:	67 05 08 06 01 05    	addr16 add $0x5010608,%eax
  ea:	05 06 2f 05 0e       	add    $0xe052f06,%eax
  ef:	06                   	push   %es
  f0:	01 05 01 67 06 31    	add    %eax,0x31066701
  f6:	05 05 13 05 01       	add    $0x1051305,%eax
  fb:	06                   	push   %es
  fc:	11 4a 05             	adc    %ecx,0x5(%edx)
  ff:	0f 21 05             	mov    %db0,%ebp
 102:	01 49 05             	add    %ecx,0x5(%ecx)
 105:	09 3d 05 05 06 3d    	or     %edi,0x3d060505
 10b:	05 09 06 11 05       	add    $0x5110609,%eax
 110:	14 06                	adc    $0x6,%al
 112:	2f                   	das    
 113:	05 0c 06 01 05       	add    $0x501060c,%eax
 118:	14 90                	adc    $0x90,%al
 11a:	05 09 06 4b 06       	add    $0x64b0609,%eax
 11f:	01 66 82             	add    %esp,-0x7e(%esi)
 122:	05 05 06 76 05       	add    $0x5760605,%eax
 127:	01 06                	add    %eax,(%esi)
 129:	13 58 20             	adc    0x20(%eax),%ebx
 12c:	06                   	push   %es
 12d:	28 05 05 13 05 01    	sub    %al,0x1051305
 133:	06                   	push   %es
 134:	11 4a 05             	adc    %ecx,0x5(%edx)
 137:	15 21 05 05 58       	adc    $0x58050521,%eax
 13c:	05 26 66 05 05       	add    $0x5056626,%eax
 141:	00 02                	add    %al,(%edx)
 143:	04 04                	add    $0x4,%al
 145:	9e                   	sahf   
 146:	00 02                	add    %al,(%edx)
 148:	04 04                	add    $0x4,%al
 14a:	06                   	push   %es
 14b:	08 13                	or     %dl,(%ebx)
 14d:	05 01 00 02 04       	add    $0x4020001,%eax
 152:	04 06                	add    $0x6,%al
 154:	c9                   	leave  
 155:	06                   	push   %es
 156:	85 05 05 13 05 01    	test   %eax,0x1051305
 15c:	06                   	push   %es
 15d:	11 05 09 3d 05 01    	adc    %eax,0x1053d09
 163:	3d 05 09 1f 05       	cmp    $0x51f0905,%eax
 168:	01 59 06             	add    %ebx,0x6(%ecx)
 16b:	23 05 05 13 05 01    	and    0x1051305,%eax
 171:	06                   	push   %es
 172:	11 05 05 67 3c 00    	adc    %eax,0x3c6705
 178:	02 04 01             	add    (%ecx,%eax,1),%al
 17b:	06                   	push   %es
 17c:	d7                   	xlat   %ds:(%ebx)
 17d:	05 09 00 02 04       	add    $0x4020009,%eax
 182:	01 13                	add    %edx,(%ebx)
 184:	05 0b 00 02 04       	add    $0x402000b,%eax
 189:	01 1f                	add    %ebx,(%edi)
 18b:	05 01 03 11 2e       	add    $0x2e110301,%eax
 190:	05 05 13 14 05       	add    $0x5141305,%eax
 195:	01 06                	add    %eax,(%esi)
 197:	0f 05                	syscall 
 199:	0c 23                	or     $0x23,%al
 19b:	05 01 2b 2e 05       	add    $0x52e2b01,%eax
 1a0:	14 00                	adc    $0x0,%al
 1a2:	02 04 01             	add    (%ecx,%eax,1),%al
 1a5:	06                   	push   %es
 1a6:	3f                   	aas    
 1a7:	05 09 00 02 04       	add    $0x4020009,%eax
 1ac:	03 67 05             	add    0x5(%edi),%esp
 1af:	0a 00                	or     (%eax),%al
 1b1:	02 04 03             	add    (%ebx,%eax,1),%al
 1b4:	06                   	push   %es
 1b5:	01 05 1e 00 02 04    	add    %eax,0x402001e
 1bb:	03 06                	add    (%esi),%eax
 1bd:	1f                   	pop    %ds
 1be:	00 02                	add    %al,(%edx)
 1c0:	04 03                	add    $0x3,%al
 1c2:	06                   	push   %es
 1c3:	01 05 05 06 30 05    	add    %eax,0x5300605
 1c9:	01 06                	add    %eax,(%esi)
 1cb:	13 06                	adc    (%esi),%eax
 1cd:	32 05 05 13 13 14    	xor    0x14131305,%al
 1d3:	05 01 06 0e 4a       	add    $0x4a0e0601,%eax
 1d8:	20 05 15 40 05 0c    	and    %al,0xc054015
 1de:	ba 05 13 2e 05       	mov    $0x52e1305,%edx
 1e3:	26 00 02             	add    %al,%es:(%edx)
 1e6:	04 01                	add    $0x1,%al
 1e8:	06                   	push   %es
 1e9:	20 05 09 00 02 04    	and    %al,0x4020009
 1ef:	03 4b 05             	add    0x5(%ebx),%ecx
 1f2:	0b 00                	or     (%eax),%eax
 1f4:	02 04 03             	add    (%ebx,%eax,1),%al
 1f7:	06                   	push   %es
 1f8:	01 05 09 00 02 04    	add    %eax,0x4020009
 1fe:	03 06                	add    (%esi),%eax
 200:	4b                   	dec    %ebx
 201:	05 0e 00 02 04       	add    $0x402000e,%eax
 206:	03 06                	add    (%esi),%eax
 208:	01 05 09 00 02 04    	add    %eax,0x4020009
 20e:	03 06                	add    (%esi),%eax
 210:	67 05 0e 00 02 04    	addr16 add $0x402000e,%eax
 216:	03 06                	add    (%esi),%eax
 218:	01 05 2c 00 02 04    	add    %eax,0x402002c
 21e:	03 2b                	add    (%ebx),%ebp
 220:	05 0e 00 02 04       	add    $0x402000e,%eax
 225:	03 23                	add    (%ebx),%esp
 227:	05 2e 00 02 04       	add    $0x402002e,%eax
 22c:	03 06                	add    (%esi),%eax
 22e:	39 05 31 00 02 04    	cmp    %eax,0x4020031
 234:	03 06                	add    (%esi),%eax
 236:	01 00                	add    %eax,(%eax)
 238:	02 04 03             	add    (%ebx,%eax,1),%al
 23b:	20 05 01 33 06 78    	and    %al,0x78063301
 241:	05 05 13 14 05       	add    $0x5141305,%eax
 246:	01 06                	add    %eax,(%esi)
 248:	0f 4a 58 3c          	cmovp  0x3c(%eax),%ebx
 24c:	05 08 bd 05 05       	add    $0x505bd08,%eax
 251:	00 02                	add    %al,(%edx)
 253:	04 01                	add    $0x1,%al
 255:	06                   	push   %es
 256:	93                   	xchg   %eax,%ebx
 257:	05 09 00 02 04       	add    $0x4020009,%eax
 25c:	01 13                	add    %edx,(%ebx)
 25e:	05 0c 00 02 04       	add    $0x402000c,%eax
 263:	01 06                	add    %eax,(%esi)
 265:	4a                   	dec    %edx
 266:	05 1a 00 02 04       	add    $0x402001a,%eax
 26b:	01 06                	add    %eax,(%esi)
 26d:	21 05 17 00 02 04    	and    %eax,0x4020017
 273:	01 06                	add    %eax,(%esi)
 275:	3b 05 1a 00 02 04    	cmp    0x402001a,%eax
 27b:	01 91 05 05 06 4b    	add    %edx,0x4b060505(%ecx)
 281:	05 08 06 01 05       	add    $0x5010608,%eax
 286:	09 06                	or     %eax,(%esi)
 288:	4b                   	dec    %ebx
 289:	05 0c 06 01 05       	add    $0x501060c,%eax
 28e:	10 3c 05 0c 4a 05 05 	adc    %bh,0x5054a0c(,%eax,1)
 295:	06                   	push   %es
 296:	3d 05 0a 06 01       	cmp    $0x1060a05,%eax
 29b:	05 05 06 4b 05       	add    $0x54b0605,%eax
 2a0:	01 06                	add    %eax,(%esi)
 2a2:	3d 58 05 05 2d       	cmp    $0x2d050558,%eax
 2a7:	58                   	pop    %eax
 2a8:	05 01 06 00 05       	add    $0x5000601,%eax
 2ad:	02 81 8c 00 00 16    	add    0x1600008c(%ecx),%al
 2b3:	05 05 13 13 05       	add    $0x5131305,%eax
 2b8:	01 06                	add    %eax,(%esi)
 2ba:	10 05 05 68 58 05    	adc    %al,0x5586805
 2c0:	01 c9                	add    %ecx,%ecx
 2c2:	06                   	push   %es
 2c3:	5b                   	pop    %ebx
 2c4:	05 05 13 13 05       	add    $0x5131305,%eax
 2c9:	01 06                	add    %eax,(%esi)
 2cb:	10 05 05 68 58 05    	adc    %al,0x5586805
 2d1:	01 c9                	add    %ecx,%ecx
 2d3:	06                   	push   %es
 2d4:	03 47 58             	add    0x58(%edi),%eax
 2d7:	05 05 13 05 01       	add    $0x1051305,%eax
 2dc:	06                   	push   %es
 2dd:	11 05 05 67 58 06    	adc    %eax,0x6586705
 2e3:	83 05 01 06 9f 05 05 	addl   $0x5,0x59f0601
 2ea:	1f                   	pop    %ds
 2eb:	05 01 06 03 c4       	add    $0xc4030601,%eax
 2f0:	00 58 05             	add    %bl,0x5(%eax)
 2f3:	05 14 05 0d 03       	add    $0x30d0514,%eax
 2f8:	76 01                	jbe    2fb <PR_BOOTABLE+0x27b>
 2fa:	05 05 15 05 01       	add    $0x1051505,%eax
 2ff:	06                   	push   %es
 300:	17                   	pop    %ss
 301:	04 02                	add    $0x2,%al
 303:	05 05 03 ac 7f       	add    $0x7fac0305,%eax
 308:	4a                   	dec    %edx
 309:	04 01                	add    $0x1,%al
 30b:	05 01 03 d4 00       	add    $0xd40301,%eax
 310:	58                   	pop    %eax
 311:	05 20 06 37 04       	add    $0x4370620,%eax
 316:	02 05 17 03 ae 7f    	add    0x7fae0317,%al
 31c:	01 05 05 14 13 3d    	add    %eax,0x3d131405
 322:	06                   	push   %es
 323:	01 04 01             	add    %eax,(%ecx,%eax,1)
 326:	05 20 03 ce 00       	add    $0xce0320,%eax
 32b:	01 05 05 06 03 09    	add    %eax,0x9030605
 331:	74 04                	je     337 <PR_BOOTABLE+0x2b7>
 333:	02 05 14 03 9b 7f    	add    0x7f9b0314,%al
 339:	01 05 05 14 06 82    	add    %eax,0x82061405
 33f:	04 01                	add    $0x1,%al
 341:	06                   	push   %es
 342:	03 e4                	add    %esp,%esp
 344:	00 01                	add    %al,(%ecx)
 346:	04 02                	add    $0x2,%al
 348:	05 14 03 9a 7f       	add    $0x7f9a0314,%eax
 34d:	01 05 05 14 06 82    	add    %eax,0x82061405
 353:	04 01                	add    $0x1,%al
 355:	06                   	push   %es
 356:	03 e5                	add    %ebp,%esp
 358:	00 01                	add    %al,(%ecx)
 35a:	04 02                	add    $0x2,%al
 35c:	05 14 03 99 7f       	add    $0x7f990314,%eax
 361:	01 05 05 14 04 01    	add    %eax,0x1041405
 367:	05 18 06 03 e5       	add    $0xe5030618,%eax
 36c:	00 01                	add    %al,(%ecx)
 36e:	04 02                	add    $0x2,%al
 370:	05 05 03 9b 7f       	add    $0x7f9b0305,%eax
 375:	2e 04 01             	cs add $0x1,%al
 378:	05 18 03 e5 00       	add    $0xe50318,%eax
 37d:	58                   	pop    %eax
 37e:	04 02                	add    $0x2,%al
 380:	05 05 03 9b 7f       	add    $0x7f9b0305,%eax
 385:	3c 20                	cmp    $0x20,%al
 387:	04 01                	add    $0x1,%al
 389:	06                   	push   %es
 38a:	03 e6                	add    %esi,%esp
 38c:	00 01                	add    %al,(%ecx)
 38e:	04 02                	add    $0x2,%al
 390:	05 14 03 98 7f       	add    $0x7f980314,%eax
 395:	01 05 05 14 04 01    	add    %eax,0x1041405
 39b:	05 18 06 03 e6       	add    $0xe6030618,%eax
 3a0:	00 01                	add    %al,(%ecx)
 3a2:	04 02                	add    $0x2,%al
 3a4:	05 05 03 9a 7f       	add    $0x7f9a0305,%eax
 3a9:	2e 04 01             	cs add $0x1,%al
 3ac:	05 18 03 e6 00       	add    $0xe60318,%eax
 3b1:	58                   	pop    %eax
 3b2:	04 02                	add    $0x2,%al
 3b4:	05 05 03 9a 7f       	add    $0x7f9a0305,%eax
 3b9:	3c 20                	cmp    $0x20,%al
 3bb:	04 01                	add    $0x1,%al
 3bd:	06                   	push   %es
 3be:	03 e7                	add    %edi,%esp
 3c0:	00 01                	add    %al,(%ecx)
 3c2:	04 02                	add    $0x2,%al
 3c4:	05 14 03 97 7f       	add    $0x7f970314,%eax
 3c9:	01 05 05 14 04 01    	add    %eax,0x1041405
 3cf:	05 19 06 03 e7       	add    $0xe7030619,%eax
 3d4:	00 01                	add    %al,(%ecx)
 3d6:	04 02                	add    $0x2,%al
 3d8:	05 05 03 99 7f       	add    $0x7f990305,%eax
 3dd:	2e 04 01             	cs add $0x1,%al
 3e0:	05 19 03 e7 00       	add    $0xe70319,%eax
 3e5:	58                   	pop    %eax
 3e6:	05 20 3c 04 02       	add    $0x2043c20,%eax
 3eb:	05 05 03 99 7f       	add    $0x7f990305,%eax
 3f0:	3c 20                	cmp    $0x20,%al
 3f2:	04 01                	add    $0x1,%al
 3f4:	06                   	push   %es
 3f5:	03 e8                	add    %eax,%ebp
 3f7:	00 01                	add    %al,(%ecx)
 3f9:	04 02                	add    $0x2,%al
 3fb:	05 14 03 96 7f       	add    $0x7f960314,%eax
 400:	01 05 05 14 06 58    	add    %eax,0x58061405
 406:	04 01                	add    $0x1,%al
 408:	06                   	push   %es
 409:	03 eb                	add    %ebx,%ebp
 40b:	00 01                	add    %al,(%ecx)
 40d:	05 0d 03 6c 01       	add    $0x16c030d,%eax
 412:	04 02                	add    $0x2,%al
 414:	05 05 06 03 b4       	add    $0xb4030605,%eax
 419:	7f 01                	jg     41c <PR_BOOTABLE+0x39c>
 41b:	04 01                	add    $0x1,%al
 41d:	05 20 06 03 cf       	add    $0xcf030620,%eax
 422:	00 58 04             	add    %bl,0x4(%eax)
 425:	02 05 17 03 ae 7f    	add    0x7fae0317,%al
 42b:	01 05 05 14 13 21    	add    %eax,0x21131405
 431:	06                   	push   %es
 432:	01 04 01             	add    %eax,(%ecx,%eax,1)
 435:	05 20 03 ce 00       	add    $0xce0320,%eax
 43a:	01 05 05 06 03 14    	add    %eax,0x14030605
 440:	74 04                	je     446 <PR_BOOTABLE+0x3c6>
 442:	02 05 14 03 a1 7f    	add    0x7fa10314,%al
 448:	01 05 05 14 06 f2    	add    %eax,0xf2061405
 44e:	04 01                	add    $0x1,%al
 450:	05 01 03 de 00       	add    $0xde0301,%eax
 455:	01 06                	add    %eax,(%esi)
 457:	41                   	inc    %ecx
 458:	05 05 13 14 05       	add    $0x5141305,%eax
 45d:	01 06                	add    %eax,(%esi)
 45f:	0f 4a 58 05          	cmovp  0x5(%eax),%ebx
 463:	05 06 40 05 16       	add    $0x16054006,%eax
 468:	06                   	push   %es
 469:	17                   	pop    %ss
 46a:	05 08 03 7a 3c       	add    $0x3c7a0308,%eax
 46f:	05 16 34 05 08       	add    $0x8053416,%eax
 474:	39 05 0c 69 05 08    	cmp    %eax,0x805690c
 47a:	03 7a 3c             	add    0x3c(%edx),%edi
 47d:	05 0c 67 05 05       	add    $0x505670c,%eax
 482:	06                   	push   %es
 483:	3e 15 17 05 0f 01    	ds adc $0x10f0517,%eax
 489:	05 09 4b 05 0f       	add    $0xf054b09,%eax
 48e:	06                   	push   %es
 48f:	3e 05 09 1e 05 0c    	ds add $0xc051e09,%eax
 495:	21 05 09 65 06 59    	and    %eax,0x59066509
 49b:	13 05 0f 06 01 05    	adc    0x501060f,%eax
 4a1:	01 5a 4a             	add    %ebx,0x4a(%edx)
 4a4:	20 20                	and    %ah,(%eax)
 4a6:	02 02                	add    (%edx),%al
 4a8:	00 01                	add    %al,(%ecx)
 4aa:	01 9e 01 00 00 05    	add    %ebx,0x5000001(%esi)
 4b0:	00 04 00             	add    %al,(%eax,%eax,1)
 4b3:	33 00                	xor    (%eax),%eax
 4b5:	00 00                	add    %al,(%eax)
 4b7:	01 01                	add    %eax,(%ecx)
 4b9:	01 fb                	add    %edi,%ebx
 4bb:	0e                   	push   %cs
 4bc:	0d 00 01 01 01       	or     $0x1010100,%eax
 4c1:	01 00                	add    %eax,(%eax)
 4c3:	00 00                	add    %al,(%eax)
 4c5:	01 00                	add    %eax,(%eax)
 4c7:	00 01                	add    %al,(%ecx)
 4c9:	01 01                	add    %eax,(%ecx)
 4cb:	1f                   	pop    %ds
 4cc:	02 00                	add    (%eax),%al
 4ce:	00 00                	add    %al,(%eax)
 4d0:	00 42 00             	add    %al,0x0(%edx)
 4d3:	00 00                	add    %al,(%eax)
 4d5:	02 01                	add    (%ecx),%al
 4d7:	1f                   	pop    %ds
 4d8:	02 0f                	add    (%edi),%cl
 4da:	03 76 00             	add    0x0(%esi),%esi
 4dd:	00 00                	add    %al,(%eax)
 4df:	00 81 00 00 00 01    	add    %al,0x1000000(%ecx)
 4e5:	6b 00 00             	imul   $0x0,(%eax),%eax
 4e8:	00 01                	add    %al,(%ecx)
 4ea:	05 01 00 05 02       	add    $0x2050001,%eax
 4ef:	94                   	xchg   %eax,%esp
 4f0:	8d 00                	lea    (%eax),%eax
 4f2:	00 03                	add    %al,(%ebx)
 4f4:	2b 01                	sub    (%ecx),%eax
 4f6:	05 05 14 14 05       	add    $0x5141405,%eax
 4fb:	01 06                	add    %eax,(%esi)
 4fd:	0e                   	push   %cs
 4fe:	4a                   	dec    %edx
 4ff:	58                   	pop    %eax
 500:	05 05 40 06 08       	add    $0x8064005,%eax
 505:	23 05 08 06 01 05    	and    0x5010608,%eax
 50b:	09 06                	or     %eax,(%esi)
 50d:	e5 05                	in     $0x5,%eax
 50f:	05 f5 05 08 06       	add    $0x60805f5,%eax
 514:	01 05 16 59 05 08    	add    %eax,0x8055916
 51a:	73 05                	jae    521 <PR_BOOTABLE+0x4a1>
 51c:	05 06 67 05 0e       	add    $0xe056706,%eax
 521:	06                   	push   %es
 522:	01 05 09 3c 05 05    	add    %eax,0x5053c09
 528:	06                   	push   %es
 529:	30 05 0f 00 02 04    	xor    %al,0x402000f
 52f:	01 01                	add    %eax,(%ecx)
 531:	05 09 00 02 04       	add    $0x4020009,%eax
 536:	02 4b 05             	add    0x5(%ebx),%cl
 539:	18 00                	sbb    %al,(%eax)
 53b:	02 04 02             	add    (%edx,%eax,1),%al
 53e:	06                   	push   %es
 53f:	1f                   	pop    %ds
 540:	05 09 00 02 04       	add    $0x4020009,%eax
 545:	02 3d 05 18 00 02    	add    0x2001805,%bh
 54b:	04 02                	add    $0x2,%al
 54d:	06                   	push   %es
 54e:	d5 00                	aad    $0x0
 550:	02 04 02             	add    (%edx,%eax,1),%al
 553:	06                   	push   %es
 554:	01 05 05 06 5c 05    	add    %eax,0x55c0605
 55a:	1d 06 01 05 01       	sbb    $0x1050106,%eax
 55f:	59                   	pop    %ecx
 560:	4a                   	dec    %edx
 561:	05 1d 1f 05 01       	add    $0x1051f1d,%eax
 566:	59                   	pop    %ecx
 567:	06                   	push   %es
 568:	3f                   	aas    
 569:	05 05 13 13 13       	add    $0x13131305,%eax
 56e:	05 01 06 0f 4a       	add    $0x4a0f0601,%eax
 573:	20 05 05 06 40 13    	and    %al,0x13400605
 579:	05 0e 06 11 05       	add    $0x511060e,%eax
 57e:	05 2f 06 c9 05       	add    $0x5c9062f,%eax
 583:	0b 06                	or     (%esi),%eax
 585:	01 05 30 06 3c 05    	add    %eax,0x53c0630
 58b:	0d 06 01 05 30       	or     $0x30050106,%eax
 590:	4a                   	dec    %edx
 591:	05 09 06 83 05       	add    $0x5830609,%eax
 596:	12 06                	adc    (%esi),%al
 598:	3e 05 09 3a 06 67    	ds add $0x67063a09,%eax
 59e:	13 05 12 06 01 05    	adc    0x5010612,%eax
 5a4:	1e                   	push   %ds
 5a5:	00 02                	add    %al,(%edx)
 5a7:	04 01                	add    $0x1,%al
 5a9:	55                   	push   %ebp
 5aa:	05 30 00 02 04       	add    $0x4020030,%eax
 5af:	02 9e 05 05 06 79    	add    0x79060505(%esi),%bl
 5b5:	05 1c 06 01 05       	add    $0x501061c,%eax
 5ba:	05 06 67 05 01       	add    $0x1056706,%eax
 5bf:	06                   	push   %es
 5c0:	14 05                	adc    $0x5,%al
 5c2:	1a 56 05             	sbb    0x5(%esi),%dl
 5c5:	05 06 67 05 01       	add    $0x1056706,%eax
 5ca:	06                   	push   %es
 5cb:	13 4a 20             	adc    0x20(%edx),%ecx
 5ce:	06                   	push   %es
 5cf:	03 bb 7f 2e 05 05    	add    0x5052e7f(%ebx),%edi
 5d5:	13 05 01 06 11 4a    	adc    0x4a110601,%eax
 5db:	20 05 05 67 06 9f    	and    %al,0x9f066705
 5e1:	bd 13 13 05 13       	mov    $0x13051313,%ebp
 5e6:	01 05 05 06 0d 05    	add    %eax,0x50d0605
 5ec:	0c 41                	or     $0x41,%al
 5ee:	05 09 06 2f 05       	add    $0x52f0609,%eax
 5f3:	1e                   	push   %ds
 5f4:	06                   	push   %es
 5f5:	01 05 0c 58 05 0d    	add    %eax,0xd05580c
 5fb:	06                   	push   %es
 5fc:	9f                   	lahf   
 5fd:	05 1a 06 01 05       	add    $0x501061a,%eax
 602:	0d 06 75 05 05       	or     $0x5057506,%eax
 607:	16                   	push   %ss
 608:	05 19 00 02 04       	add    $0x4020019,%eax
 60d:	02 03                	add    (%ebx),%al
 60f:	79 2e                	jns    63f <PR_BOOTABLE+0x5bf>
 611:	05 13 00 02 04       	add    $0x4020013,%eax
 616:	02 20                	add    (%eax),%ah
 618:	05 05 5f 05 09       	add    $0x9055f05,%eax
 61d:	13 05 0e 06 03 77    	adc    0x7703060e,%eax
 623:	3c 05                	cmp    $0x5,%al
 625:	09 03                	or     %eax,(%ebx)
 627:	09 2e                	or     %ebp,(%esi)
 629:	9e                   	sahf   
 62a:	05 05 06 3e 92       	add    $0x923e0605,%eax
 62f:	bb 05 16 06 01       	mov    $0x1061605,%ebx
 634:	05 05 84 05 16       	add    $0x16058405,%eax
 639:	72 05                	jb     640 <PR_BOOTABLE+0x5c0>
 63b:	05 06 30 5a ca       	add    $0xca5a3006,%eax
 640:	05 01 06 a0 4a       	add    $0x4aa00601,%eax
 645:	05 05 2c 02 05       	add    $0x5022c05,%eax
 64a:	00 01                	add    %al,(%ecx)
 64c:	01 47 00             	add    %eax,0x0(%edi)
 64f:	00 00                	add    %al,(%eax)
 651:	05 00 04 00 2e       	add    $0x2e000400,%eax
 656:	00 00                	add    %al,(%eax)
 658:	00 01                	add    %al,(%ecx)
 65a:	01 01                	add    %eax,(%ecx)
 65c:	fb                   	sti    
 65d:	0e                   	push   %cs
 65e:	0d 00 01 01 01       	or     $0x1010100,%eax
 663:	01 00                	add    %eax,(%eax)
 665:	00 00                	add    %al,(%eax)
 667:	01 00                	add    %eax,(%eax)
 669:	00 01                	add    %al,(%ecx)
 66b:	01 01                	add    %eax,(%ecx)
 66d:	1f                   	pop    %ds
 66e:	02 00                	add    (%eax),%al
 670:	00 00                	add    %al,(%eax)
 672:	00 42 00             	add    %al,0x0(%edx)
 675:	00 00                	add    %al,(%eax)
 677:	02 01                	add    (%ecx),%al
 679:	1f                   	pop    %ds
 67a:	02 0f                	add    (%edi),%cl
 67c:	02 8d 00 00 00 00    	add    0x0(%ebp),%cl
 682:	8d 00                	lea    (%eax),%eax
 684:	00 00                	add    %al,(%eax)
 686:	01 00                	add    %eax,(%eax)
 688:	05 02 18 8f 00       	add    $0x8f1802,%eax
 68d:	00 17                	add    %dl,(%edi)
 68f:	21 59 4b             	and    %ebx,0x4b(%ecx)
 692:	4b                   	dec    %ebx
 693:	02 02                	add    (%edx),%al
 695:	00 01                	add    %al,(%ecx)
 697:	01                   	.byte 0x1

Disassembly of section .debug_str:

00000000 <.debug_str>:
   0:	62 6f 6f             	bound  %ebp,0x6f(%edi)
   3:	74 31                	je     36 <PROT_MODE_DSEG+0x26>
   5:	2e 53                	cs push %ebx
   7:	00 2f                	add    %ch,(%edi)
   9:	68 6f 6d 65 2f       	push   $0x2f656d6f
   e:	63 6c 61 73          	arpl   %bp,0x73(%ecx,%eiz,2)
  12:	73 65                	jae    79 <PROT_MODE_DSEG+0x69>
  14:	73 2f                	jae    45 <PROT_MODE_DSEG+0x35>
  16:	63 73 34             	arpl   %si,0x34(%ebx)
  19:	32 32                	xor    (%edx),%dh
  1b:	2f                   	das    
  1c:	63 6c 61 73          	arpl   %bp,0x73(%ecx,%eiz,2)
  20:	73 2f                	jae    51 <PROT_MODE_DSEG+0x41>
  22:	76 72                	jbe    96 <PR_BOOTABLE+0x16>
  24:	6f                   	outsl  %ds:(%esi),(%dx)
  25:	6f                   	outsl  %ds:(%esi),(%dx)
  26:	6e                   	outsb  %ds:(%esi),(%dx)
  27:	2e 64 79 6c          	cs jns,pn 97 <PR_BOOTABLE+0x17>
  2b:	61                   	popa   
  2c:	6e                   	outsb  %ds:(%esi),(%dx)
  2d:	2e 64 72 76          	cs jb,pn a7 <PR_BOOTABLE+0x27>
  31:	32 36                	xor    (%esi),%dh
  33:	2f                   	das    
  34:	61                   	popa   
  35:	73 73                	jae    aa <PR_BOOTABLE+0x2a>
  37:	31 2f                	xor    %ebp,(%edi)
  39:	63 73 34             	arpl   %si,0x34(%ebx)
  3c:	32 32                	xor    (%edx),%dh
  3e:	61                   	popa   
  3f:	73 73                	jae    b4 <PR_BOOTABLE+0x34>
  41:	69 67 6e 6d 65 6e 74 	imul   $0x746e656d,0x6e(%edi),%esp
  48:	31 00                	xor    %eax,(%eax)
  4a:	47                   	inc    %edi
  4b:	4e                   	dec    %esi
  4c:	55                   	push   %ebp
  4d:	20 41 53             	and    %al,0x53(%ecx)
  50:	20 32                	and    %dh,(%edx)
  52:	2e 33 37             	xor    %cs:(%edi),%esi
  55:	00 65 6e             	add    %ah,0x6e(%ebp)
  58:	64 5f                	fs pop %edi
  5a:	76 61                	jbe    bd <PR_BOOTABLE+0x3d>
  5c:	00 77 61             	add    %dh,0x61(%edi)
  5f:	69 74 64 69 73 6b 00 	imul   $0x70006b73,0x69(%esp,%eiz,2),%esi
  66:	70 
  67:	75 74                	jne    dd <PR_BOOTABLE+0x5d>
  69:	6c                   	insb   (%dx),%es:(%edi)
  6a:	69 6e 65 00 73 68 6f 	imul   $0x6f687300,0x65(%esi),%ebp
  71:	72 74                	jb     e7 <PR_BOOTABLE+0x67>
  73:	20 69 6e             	and    %ch,0x6e(%ecx)
  76:	74 00                	je     78 <PROT_MODE_DSEG+0x68>
  78:	63 6f 6c             	arpl   %bp,0x6c(%edi)
  7b:	6f                   	outsl  %ds:(%esi),(%dx)
  7c:	72 00                	jb     7e <PROT_MODE_DSEG+0x6e>
  7e:	72 6f                	jb     ef <PR_BOOTABLE+0x6f>
  80:	6c                   	insb   (%dx),%es:(%edi)
  81:	6c                   	insb   (%dx),%es:(%edi)
  82:	00 73 74             	add    %dh,0x74(%ebx)
  85:	72 69                	jb     f0 <PR_BOOTABLE+0x70>
  87:	6e                   	outsb  %ds:(%esi),(%dx)
  88:	67 00 70 61          	add    %dh,0x61(%bx,%si)
  8c:	6e                   	outsb  %ds:(%esi),(%dx)
  8d:	69 63 00 70 75 74 69 	imul   $0x69747570,0x0(%ebx),%esp
  94:	00 47 4e             	add    %al,0x4e(%edi)
  97:	55                   	push   %ebp
  98:	20 43 31             	and    %al,0x31(%ebx)
  9b:	37                   	aaa    
  9c:	20 31                	and    %dh,(%ecx)
  9e:	32 2e                	xor    (%esi),%ch
  a0:	31 2e                	xor    %ebp,(%esi)
  a2:	31 20                	xor    %esp,(%eax)
  a4:	32 30                	xor    (%eax),%dh
  a6:	32 32                	xor    (%edx),%dh
  a8:	30 35 30 37 20 28    	xor    %dh,0x28203730
  ae:	52                   	push   %edx
  af:	65 64 20 48 61       	gs and %cl,%fs:0x61(%eax)
  b4:	74 20                	je     d6 <PR_BOOTABLE+0x56>
  b6:	31 32                	xor    %esi,(%edx)
  b8:	2e 31 2e             	xor    %ebp,%cs:(%esi)
  bb:	31 2d 31 29 20 2d    	xor    %ebp,0x2d202931
  c1:	6d                   	insl   (%dx),%es:(%edi)
  c2:	33 32                	xor    (%edx),%esi
  c4:	20 2d 6d 74 75 6e    	and    %ch,0x6e75746d
  ca:	65 3d 67 65 6e 65    	gs cmp $0x656e6567,%eax
  d0:	72 69                	jb     13b <PR_BOOTABLE+0xbb>
  d2:	63 20                	arpl   %sp,(%eax)
  d4:	2d 6d 61 72 63       	sub    $0x6372616d,%eax
  d9:	68 3d 69 36 38       	push   $0x3836693d
  de:	36 20 2d 67 20 2d 4f 	and    %ch,%ss:0x4f2d2067
  e5:	73 20                	jae    107 <PR_BOOTABLE+0x87>
  e7:	2d 4f 73 20 2d       	sub    $0x2d20734f,%eax
  ec:	66 6e                	data16 outsb %ds:(%esi),(%dx)
  ee:	6f                   	outsl  %ds:(%esi),(%dx)
  ef:	2d 62 75 69 6c       	sub    $0x6c697562,%eax
  f4:	74 69                	je     15f <PR_BOOTABLE+0xdf>
  f6:	6e                   	outsb  %ds:(%esi),(%dx)
  f7:	20 2d 66 6e 6f 2d    	and    %ch,0x2d6f6e66
  fd:	73 74                	jae    173 <PR_BOOTABLE+0xf3>
  ff:	61                   	popa   
 100:	63 6b 2d             	arpl   %bp,0x2d(%ebx)
 103:	70 72                	jo     177 <PR_BOOTABLE+0xf7>
 105:	6f                   	outsl  %ds:(%esi),(%dx)
 106:	74 65                	je     16d <PR_BOOTABLE+0xed>
 108:	63 74 6f 72          	arpl   %si,0x72(%edi,%ebp,2)
 10c:	00 75 69             	add    %dh,0x69(%ebp)
 10f:	6e                   	outsb  %ds:(%esi),(%dx)
 110:	74 38                	je     14a <PR_BOOTABLE+0xca>
 112:	5f                   	pop    %edi
 113:	74 00                	je     115 <PR_BOOTABLE+0x95>
 115:	6f                   	outsl  %ds:(%esi),(%dx)
 116:	75 74                	jne    18c <PR_BOOTABLE+0x10c>
 118:	62 00                	bound  %eax,(%eax)
 11a:	69 6e 73 6c 00 6c 6f 	imul   $0x6f6c006c,0x73(%esi),%ebp
 121:	6e                   	outsb  %ds:(%esi),(%dx)
 122:	67 20 6c 6f          	and    %ch,0x6f(%si)
 126:	6e                   	outsb  %ds:(%esi),(%dx)
 127:	67 20 69 6e          	and    %ch,0x6e(%bx,%di)
 12b:	74 00                	je     12d <PR_BOOTABLE+0xad>
 12d:	72 65                	jb     194 <PR_BOOTABLE+0x114>
 12f:	61                   	popa   
 130:	64 73 65             	fs jae 198 <PR_BOOTABLE+0x118>
 133:	63 74 69 6f          	arpl   %si,0x6f(%ecx,%ebp,2)
 137:	6e                   	outsb  %ds:(%esi),(%dx)
 138:	00 69 74             	add    %ch,0x74(%ecx)
 13b:	6f                   	outsl  %ds:(%esi),(%dx)
 13c:	61                   	popa   
 13d:	00 75 6e             	add    %dh,0x6e(%ebp)
 140:	73 69                	jae    1ab <PR_BOOTABLE+0x12b>
 142:	67 6e                	outsb  %ds:(%si),(%dx)
 144:	65 64 20 63 68       	gs and %ah,%fs:0x68(%ebx)
 149:	61                   	popa   
 14a:	72 00                	jb     14c <PR_BOOTABLE+0xcc>
 14c:	69 74 6f 68 00 70 75 	imul   $0x74757000,0x68(%edi,%ebp,2),%esi
 153:	74 
 154:	63 00                	arpl   %ax,(%eax)
 156:	6c                   	insb   (%dx),%es:(%edi)
 157:	6f                   	outsl  %ds:(%esi),(%dx)
 158:	6e                   	outsb  %ds:(%esi),(%dx)
 159:	67 20 6c 6f          	and    %ch,0x6f(%si)
 15d:	6e                   	outsb  %ds:(%esi),(%dx)
 15e:	67 20 75 6e          	and    %dh,0x6e(%di)
 162:	73 69                	jae    1cd <PR_BOOTABLE+0x14d>
 164:	67 6e                	outsb  %ds:(%si),(%dx)
 166:	65 64 20 69 6e       	gs and %ch,%fs:0x6e(%ecx)
 16b:	74 00                	je     16d <PR_BOOTABLE+0xed>
 16d:	75 69                	jne    1d8 <PR_BOOTABLE+0x158>
 16f:	6e                   	outsb  %ds:(%esi),(%dx)
 170:	74 33                	je     1a5 <PR_BOOTABLE+0x125>
 172:	32 5f 74             	xor    0x74(%edi),%bl
 175:	00 69 74             	add    %ch,0x74(%ecx)
 178:	6f                   	outsl  %ds:(%esi),(%dx)
 179:	78 00                	js     17b <PR_BOOTABLE+0xfb>
 17b:	70 75                	jo     1f2 <PR_BOOTABLE+0x172>
 17d:	74 73                	je     1f2 <PR_BOOTABLE+0x172>
 17f:	00 73 68             	add    %dh,0x68(%ebx)
 182:	6f                   	outsl  %ds:(%esi),(%dx)
 183:	72 74                	jb     1f9 <PR_BOOTABLE+0x179>
 185:	20 75 6e             	and    %dh,0x6e(%ebp)
 188:	73 69                	jae    1f3 <PR_BOOTABLE+0x173>
 18a:	67 6e                	outsb  %ds:(%si),(%dx)
 18c:	65 64 20 69 6e       	gs and %ch,%fs:0x6e(%ecx)
 191:	74 00                	je     193 <PR_BOOTABLE+0x113>
 193:	73 74                	jae    209 <PR_BOOTABLE+0x189>
 195:	72 6c                	jb     203 <PR_BOOTABLE+0x183>
 197:	65 6e                	outsb  %gs:(%esi),(%dx)
 199:	00 64 61 74          	add    %ah,0x74(%ecx,%eiz,2)
 19d:	61                   	popa   
 19e:	00 72 65             	add    %dh,0x65(%edx)
 1a1:	61                   	popa   
 1a2:	64 73 65             	fs jae 20a <PR_BOOTABLE+0x18a>
 1a5:	63 74 6f 72          	arpl   %si,0x72(%edi,%ebp,2)
 1a9:	00 70 6f             	add    %dh,0x6f(%eax)
 1ac:	72 74                	jb     222 <PR_BOOTABLE+0x1a2>
 1ae:	00 73 69             	add    %dh,0x69(%ebx)
 1b1:	67 6e                	outsb  %ds:(%si),(%dx)
 1b3:	00 72 65             	add    %dh,0x65(%edx)
 1b6:	76 65                	jbe    21d <PR_BOOTABLE+0x19d>
 1b8:	72 73                	jb     22d <PR_BOOTABLE+0x1ad>
 1ba:	65 00 70 75          	add    %dh,%gs:0x75(%eax)
 1be:	74 69                	je     229 <PR_BOOTABLE+0x1a9>
 1c0:	5f                   	pop    %edi
 1c1:	73 74                	jae    237 <PR_BOOTABLE+0x1b7>
 1c3:	72 00                	jb     1c5 <PR_BOOTABLE+0x145>
 1c5:	62 6c 61 6e          	bound  %ebp,0x6e(%ecx,%eiz,2)
 1c9:	6b 00 72             	imul   $0x72,(%eax),%eax
 1cc:	6f                   	outsl  %ds:(%esi),(%dx)
 1cd:	6f                   	outsl  %ds:(%esi),(%dx)
 1ce:	74 00                	je     1d0 <PR_BOOTABLE+0x150>
 1d0:	76 69                	jbe    23b <PR_BOOTABLE+0x1bb>
 1d2:	64 65 6f             	fs outsl %gs:(%esi),(%dx)
 1d5:	00 64 69 73          	add    %ah,0x73(%ecx,%ebp,2)
 1d9:	6b 5f 73 69          	imul   $0x69,0x73(%edi),%ebx
 1dd:	67 00 65 6c          	add    %ah,0x6c(%di)
 1e1:	66 68 64 66          	pushw  $0x6664
 1e5:	00 65 5f             	add    %ah,0x5f(%ebp)
 1e8:	73 68                	jae    252 <PR_BOOTABLE+0x1d2>
 1ea:	73 74                	jae    260 <PR_BOOTABLE+0x1e0>
 1ec:	72 6e                	jb     25c <PR_BOOTABLE+0x1dc>
 1ee:	64 78 00             	fs js  1f1 <PR_BOOTABLE+0x171>
 1f1:	6d                   	insl   (%dx),%es:(%edi)
 1f2:	6d                   	insl   (%dx),%es:(%edi)
 1f3:	61                   	popa   
 1f4:	70 5f                	jo     255 <PR_BOOTABLE+0x1d5>
 1f6:	61                   	popa   
 1f7:	64 64 72 00          	fs fs jb 1fb <PR_BOOTABLE+0x17b>
 1fb:	65 6c                	gs insb (%dx),%es:(%edi)
 1fd:	66 68 64 72          	pushw  $0x7264
 201:	00 76 62             	add    %dh,0x62(%esi)
 204:	65 5f                	gs pop %edi
 206:	69 6e 74 65 72 66 61 	imul   $0x61667265,0x74(%esi),%ebp
 20d:	63 65 5f             	arpl   %sp,0x5f(%ebp)
 210:	6f                   	outsl  %ds:(%esi),(%dx)
 211:	66 66 00 65 5f       	data16 data16 add %ah,0x5f(%ebp)
 216:	65 6e                	outsb  %gs:(%esi),(%dx)
 218:	74 72                	je     28c <PR_BOOTABLE+0x20c>
 21a:	79 00                	jns    21c <PR_BOOTABLE+0x19c>
 21c:	75 69                	jne    287 <PR_BOOTABLE+0x207>
 21e:	6e                   	outsb  %ds:(%esi),(%dx)
 21f:	74 36                	je     257 <PR_BOOTABLE+0x1d7>
 221:	34 5f                	xor    $0x5f,%al
 223:	74 00                	je     225 <PR_BOOTABLE+0x1a5>
 225:	6c                   	insb   (%dx),%es:(%edi)
 226:	6f                   	outsl  %ds:(%esi),(%dx)
 227:	61                   	popa   
 228:	64 5f                	fs pop %edi
 22a:	6b 65 72 6e          	imul   $0x6e,0x72(%ebp),%esp
 22e:	65 6c                	gs insb (%dx),%es:(%edi)
 230:	00 70 5f             	add    %dh,0x5f(%eax)
 233:	6d                   	insl   (%dx),%es:(%edi)
 234:	65 6d                	gs insl (%dx),%es:(%edi)
 236:	73 7a                	jae    2b2 <PR_BOOTABLE+0x232>
 238:	00 70 5f             	add    %dh,0x5f(%eax)
 23b:	6f                   	outsl  %ds:(%esi),(%dx)
 23c:	66 66 73 65          	data16 data16 jae 2a5 <PR_BOOTABLE+0x225>
 240:	74 00                	je     242 <PR_BOOTABLE+0x1c2>
 242:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 245:	74 6c                	je     2b3 <PR_BOOTABLE+0x233>
 247:	6f                   	outsl  %ds:(%esi),(%dx)
 248:	61                   	popa   
 249:	64 65 72 00          	fs gs jb 24d <PR_BOOTABLE+0x1cd>
 24d:	65 5f                	gs pop %edi
 24f:	66 6c                	data16 insb (%dx),%es:(%edi)
 251:	61                   	popa   
 252:	67 73 00             	addr16 jae 255 <PR_BOOTABLE+0x1d5>
 255:	63 6d 64             	arpl   %bp,0x64(%ebp)
 258:	6c                   	insb   (%dx),%es:(%edi)
 259:	69 6e 65 00 65 5f 6d 	imul   $0x6d5f6500,0x65(%esi),%ebp
 260:	61                   	popa   
 261:	63 68 69             	arpl   %bp,0x69(%eax)
 264:	6e                   	outsb  %ds:(%esi),(%dx)
 265:	65 00 65 5f          	add    %ah,%gs:0x5f(%ebp)
 269:	70 68                	jo     2d3 <PR_BOOTABLE+0x253>
 26b:	65 6e                	outsb  %gs:(%esi),(%dx)
 26d:	74 73                	je     2e2 <PR_BOOTABLE+0x262>
 26f:	69 7a 65 00 65 78 65 	imul   $0x65786500,0x65(%edx),%edi
 276:	63 5f 6b             	arpl   %bx,0x6b(%edi)
 279:	65 72 6e             	gs jb  2ea <PR_BOOTABLE+0x26a>
 27c:	65 6c                	gs insb (%dx),%es:(%edi)
 27e:	00 6d 6f             	add    %ch,0x6f(%ebp)
 281:	64 73 5f             	fs jae 2e3 <PR_BOOTABLE+0x263>
 284:	61                   	popa   
 285:	64 64 72 00          	fs fs jb 289 <PR_BOOTABLE+0x209>
 289:	61                   	popa   
 28a:	6f                   	outsl  %ds:(%esi),(%dx)
 28b:	75 74                	jne    301 <PR_BOOTABLE+0x281>
 28d:	00 73 74             	add    %dh,0x74(%ebx)
 290:	72 73                	jb     305 <PR_BOOTABLE+0x285>
 292:	69 7a 65 00 70 61 72 	imul   $0x72617000,0x65(%edx),%edi
 299:	74 33                	je     2ce <PR_BOOTABLE+0x24e>
 29b:	00 70 5f             	add    %dh,0x5f(%eax)
 29e:	74 79                	je     319 <PR_BOOTABLE+0x299>
 2a0:	70 65                	jo     307 <PR_BOOTABLE+0x287>
 2a2:	00 70 72             	add    %dh,0x72(%eax)
 2a5:	6f                   	outsl  %ds:(%esi),(%dx)
 2a6:	67 68 64 72 00 65    	addr16 push $0x65007264
 2ac:	5f                   	pop    %edi
 2ad:	73 68                	jae    317 <PR_BOOTABLE+0x297>
 2af:	65 6e                	outsb  %gs:(%esi),(%dx)
 2b1:	74 73                	je     326 <PR_BOOTABLE+0x2a6>
 2b3:	69 7a 65 00 73 68 6e 	imul   $0x6e687300,0x65(%edx),%edi
 2ba:	64 78 00             	fs js  2bd <PR_BOOTABLE+0x23d>
 2bd:	6d                   	insl   (%dx),%es:(%edi)
 2be:	62 72 5f             	bound  %esi,0x5f(%edx)
 2c1:	74 00                	je     2c3 <PR_BOOTABLE+0x243>
 2c3:	65 5f                	gs pop %edi
 2c5:	74 79                	je     340 <PR_BOOTABLE+0x2c0>
 2c7:	70 65                	jo     32e <PR_BOOTABLE+0x2ae>
 2c9:	00 64 72 69          	add    %ah,0x69(%edx,%esi,2)
 2cd:	76 65                	jbe    334 <PR_BOOTABLE+0x2b4>
 2cf:	73 5f                	jae    330 <PR_BOOTABLE+0x2b0>
 2d1:	61                   	popa   
 2d2:	64 64 72 00          	fs fs jb 2d6 <PR_BOOTABLE+0x256>
 2d6:	65 5f                	gs pop %edi
 2d8:	65 68 73 69 7a 65    	gs push $0x657a6973
 2de:	00 70 61             	add    %dh,0x61(%eax)
 2e1:	72 74                	jb     357 <PR_BOOTABLE+0x2d7>
 2e3:	69 74 69 6f 6e 00 62 	imul   $0x6962006e,0x6f(%ecx,%ebp,2),%esi
 2ea:	69 
 2eb:	6f                   	outsl  %ds:(%esi),(%dx)
 2ec:	73 5f                	jae    34d <PR_BOOTABLE+0x2cd>
 2ee:	73 6d                	jae    35d <PR_BOOTABLE+0x2dd>
 2f0:	61                   	popa   
 2f1:	70 5f                	jo     352 <PR_BOOTABLE+0x2d2>
 2f3:	74 00                	je     2f5 <PR_BOOTABLE+0x275>
 2f5:	6d                   	insl   (%dx),%es:(%edi)
 2f6:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 2f9:	74 5f                	je     35a <PR_BOOTABLE+0x2da>
 2fb:	69 6e 66 6f 5f 74 00 	imul   $0x745f6f,0x66(%esi),%ebp
 302:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 305:	74 61                	je     368 <PR_BOOTABLE+0x2e8>
 307:	62 6c 65 5f          	bound  %ebp,0x5f(%ebp,%eiz,2)
 30b:	6c                   	insb   (%dx),%es:(%edi)
 30c:	62 61 00             	bound  %esp,0x0(%ecx)
 30f:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 312:	74 31                	je     345 <PR_BOOTABLE+0x2c5>
 314:	6d                   	insl   (%dx),%es:(%edi)
 315:	61                   	popa   
 316:	69 6e 00 65 5f 76 65 	imul   $0x65765f65,0x0(%esi),%ebp
 31d:	72 73                	jb     392 <PR_BOOTABLE+0x312>
 31f:	69 6f 6e 00 70 61 72 	imul   $0x72617000,0x6e(%edi),%ebp
 326:	74 31                	je     359 <PR_BOOTABLE+0x2d9>
 328:	00 70 61             	add    %dh,0x61(%eax)
 32b:	72 74                	jb     3a1 <PR_BOOTABLE+0x321>
 32d:	32 00                	xor    (%eax),%al
 32f:	64 72 69             	fs jb  39b <PR_BOOTABLE+0x31b>
 332:	76 65                	jbe    399 <PR_BOOTABLE+0x319>
 334:	72 00                	jb     336 <PR_BOOTABLE+0x2b6>
 336:	66 69 72 73 74 5f    	imul   $0x5f74,0x73(%edx),%si
 33c:	63 68 73             	arpl   %bp,0x73(%eax)
 33f:	00 62 69             	add    %ah,0x69(%edx)
 342:	6f                   	outsl  %ds:(%esi),(%dx)
 343:	73 5f                	jae    3a4 <PR_BOOTABLE+0x324>
 345:	73 6d                	jae    3b4 <PR_BOOTABLE+0x334>
 347:	61                   	popa   
 348:	70 00                	jo     34a <PR_BOOTABLE+0x2ca>
 34a:	6d                   	insl   (%dx),%es:(%edi)
 34b:	65 6d                	gs insl (%dx),%es:(%edi)
 34d:	5f                   	pop    %edi
 34e:	6c                   	insb   (%dx),%es:(%edi)
 34f:	6f                   	outsl  %ds:(%esi),(%dx)
 350:	77 65                	ja     3b7 <PR_BOOTABLE+0x337>
 352:	72 00                	jb     354 <PR_BOOTABLE+0x2d4>
 354:	62 6f 6f             	bound  %ebp,0x6f(%edi)
 357:	74 61                	je     3ba <PR_BOOTABLE+0x33a>
 359:	62 6c 65 00          	bound  %ebp,0x0(%ebp,%eiz,2)
 35d:	73 79                	jae    3d8 <PR_BOOTABLE+0x358>
 35f:	6d                   	insl   (%dx),%es:(%edi)
 360:	73 00                	jae    362 <PR_BOOTABLE+0x2e2>
 362:	75 69                	jne    3cd <PR_BOOTABLE+0x34d>
 364:	6e                   	outsb  %ds:(%esi),(%dx)
 365:	74 31                	je     398 <PR_BOOTABLE+0x318>
 367:	36 5f                	ss pop %edi
 369:	74 00                	je     36b <PR_BOOTABLE+0x2eb>
 36b:	6d                   	insl   (%dx),%es:(%edi)
 36c:	6d                   	insl   (%dx),%es:(%edi)
 36d:	61                   	popa   
 36e:	70 5f                	jo     3cf <PR_BOOTABLE+0x34f>
 370:	6c                   	insb   (%dx),%es:(%edi)
 371:	65 6e                	outsb  %gs:(%esi),(%dx)
 373:	67 74 68             	addr16 je 3de <PR_BOOTABLE+0x35e>
 376:	00 6d 62             	add    %ch,0x62(%ebp)
 379:	6f                   	outsl  %ds:(%esi),(%dx)
 37a:	6f                   	outsl  %ds:(%esi),(%dx)
 37b:	74 5f                	je     3dc <PR_BOOTABLE+0x35c>
 37d:	69 6e 66 6f 00 70 5f 	imul   $0x5f70006f,0x66(%esi),%ebp
 384:	76 61                	jbe    3e7 <PR_BOOTABLE+0x367>
 386:	00 76 62             	add    %dh,0x62(%esi)
 389:	65 5f                	gs pop %edi
 38b:	63 6f 6e             	arpl   %bp,0x6e(%edi)
 38e:	74 72                	je     402 <PR_BOOTABLE+0x382>
 390:	6f                   	outsl  %ds:(%esi),(%dx)
 391:	6c                   	insb   (%dx),%es:(%edi)
 392:	5f                   	pop    %edi
 393:	69 6e 66 6f 00 70 5f 	imul   $0x5f70006f,0x66(%esi),%ebp
 39a:	66 6c                	data16 insb (%dx),%es:(%edi)
 39c:	61                   	popa   
 39d:	67 73 00             	addr16 jae 3a0 <PR_BOOTABLE+0x320>
 3a0:	70 61                	jo     403 <PR_BOOTABLE+0x383>
 3a2:	72 73                	jb     417 <PR_BOOTABLE+0x397>
 3a4:	65 5f                	gs pop %edi
 3a6:	65 38 32             	cmp    %dh,%gs:(%edx)
 3a9:	30 00                	xor    %al,(%eax)
 3ab:	65 5f                	gs pop %edi
 3ad:	65 6c                	gs insb (%dx),%es:(%edi)
 3af:	66 00 62 6f          	data16 add %ah,0x6f(%edx)
 3b3:	6f                   	outsl  %ds:(%esi),(%dx)
 3b4:	74 5f                	je     415 <PR_BOOTABLE+0x395>
 3b6:	64 65 76 69          	fs gs jbe 423 <PR_BOOTABLE+0x3a3>
 3ba:	63 65 00             	arpl   %sp,0x0(%ebp)
 3bd:	64 6b 65 72 6e       	imul   $0x6e,%fs:0x72(%ebp),%esp
 3c2:	65 6c                	gs insb (%dx),%es:(%edi)
 3c4:	00 65 5f             	add    %ah,0x5f(%ebp)
 3c7:	70 68                	jo     431 <PR_BOOTABLE+0x3b1>
 3c9:	6f                   	outsl  %ds:(%esi),(%dx)
 3ca:	66 66 00 63 6f       	data16 data16 add %ah,0x6f(%ebx)
 3cf:	6e                   	outsb  %ds:(%esi),(%dx)
 3d0:	66 69 67 5f 74 61    	imul   $0x6174,0x5f(%edi),%sp
 3d6:	62 6c 65 00          	bound  %ebp,0x0(%ebp,%eiz,2)
 3da:	65 5f                	gs pop %edi
 3dc:	6d                   	insl   (%dx),%es:(%edi)
 3dd:	61                   	popa   
 3de:	67 69 63 00 6c 61 73 	imul   $0x7473616c,0x0(%bp,%di),%esp
 3e5:	74 
 3e6:	5f                   	pop    %edi
 3e7:	63 68 73             	arpl   %bp,0x73(%eax)
 3ea:	00 62 61             	add    %ah,0x61(%edx)
 3ed:	73 65                	jae    454 <PR_BOOTABLE+0x3d4>
 3ef:	5f                   	pop    %edi
 3f0:	61                   	popa   
 3f1:	64 64 72 00          	fs fs jb 3f5 <PR_BOOTABLE+0x375>
 3f5:	76 62                	jbe    459 <PR_BOOTABLE+0x3d9>
 3f7:	65 5f                	gs pop %edi
 3f9:	6d                   	insl   (%dx),%es:(%edi)
 3fa:	6f                   	outsl  %ds:(%esi),(%dx)
 3fb:	64 65 00 65 5f       	fs add %ah,%gs:0x5f(%ebp)
 400:	73 68                	jae    46a <PR_BOOTABLE+0x3ea>
 402:	6f                   	outsl  %ds:(%esi),(%dx)
 403:	66 66 00 6d 65       	data16 data16 add %ch,0x65(%ebp)
 408:	6d                   	insl   (%dx),%es:(%edi)
 409:	5f                   	pop    %edi
 40a:	75 70                	jne    47c <PR_BOOTABLE+0x3fc>
 40c:	70 65                	jo     473 <PR_BOOTABLE+0x3f3>
 40e:	72 00                	jb     410 <PR_BOOTABLE+0x390>
 410:	76 62                	jbe    474 <PR_BOOTABLE+0x3f4>
 412:	65 5f                	gs pop %edi
 414:	6d                   	insl   (%dx),%es:(%edi)
 415:	6f                   	outsl  %ds:(%esi),(%dx)
 416:	64 65 5f             	fs gs pop %edi
 419:	69 6e 66 6f 00 74 61 	imul   $0x6174006f,0x66(%esi),%ebp
 420:	62 73 69             	bound  %esi,0x69(%ebx)
 423:	7a 65                	jp     48a <PR_BOOTABLE+0x40a>
 425:	00 66 69             	add    %ah,0x69(%esi)
 428:	72 73                	jb     49d <PR_BOOTABLE+0x41d>
 42a:	74 5f                	je     48b <PR_BOOTABLE+0x40b>
 42c:	6c                   	insb   (%dx),%es:(%edi)
 42d:	62 61 00             	bound  %esp,0x0(%ecx)
 430:	64 72 69             	fs jb  49c <PR_BOOTABLE+0x41c>
 433:	76 65                	jbe    49a <PR_BOOTABLE+0x41a>
 435:	73 5f                	jae    496 <PR_BOOTABLE+0x416>
 437:	6c                   	insb   (%dx),%es:(%edi)
 438:	65 6e                	outsb  %gs:(%esi),(%dx)
 43a:	67 74 68             	addr16 je 4a5 <PR_BOOTABLE+0x425>
 43d:	00 70 5f             	add    %dh,0x5f(%eax)
 440:	66 69 6c 65 73 7a 00 	imul   $0x7a,0x73(%ebp,%eiz,2),%bp
 447:	65 5f                	gs pop %edi
 449:	70 68                	jo     4b3 <PR_BOOTABLE+0x433>
 44b:	6e                   	outsb  %ds:(%esi),(%dx)
 44c:	75 6d                	jne    4bb <PR_BOOTABLE+0x43b>
 44e:	00 73 69             	add    %dh,0x69(%ebx)
 451:	67 6e                	outsb  %ds:(%si),(%dx)
 453:	61                   	popa   
 454:	74 75                	je     4cb <PR_BOOTABLE+0x44b>
 456:	72 65                	jb     4bd <PR_BOOTABLE+0x43d>
 458:	00 76 62             	add    %dh,0x62(%esi)
 45b:	65 5f                	gs pop %edi
 45d:	69 6e 74 65 72 66 61 	imul   $0x61667265,0x74(%esi),%ebp
 464:	63 65 5f             	arpl   %sp,0x5f(%ebp)
 467:	6c                   	insb   (%dx),%es:(%edi)
 468:	65 6e                	outsb  %gs:(%esi),(%dx)
 46a:	00 65 5f             	add    %ah,0x5f(%ebp)
 46d:	73 68                	jae    4d7 <PR_BOOTABLE+0x457>
 46f:	6e                   	outsb  %ds:(%esi),(%dx)
 470:	75 6d                	jne    4df <PR_BOOTABLE+0x45f>
 472:	00 6d 6f             	add    %ch,0x6f(%ebp)
 475:	64 73 5f             	fs jae 4d7 <PR_BOOTABLE+0x457>
 478:	63 6f 75             	arpl   %bp,0x75(%edi)
 47b:	6e                   	outsb  %ds:(%esi),(%dx)
 47c:	74 00                	je     47e <PR_BOOTABLE+0x3fe>
 47e:	5f                   	pop    %edi
 47f:	72 65                	jb     4e6 <PR_BOOTABLE+0x466>
 481:	73 65                	jae    4e8 <PR_BOOTABLE+0x468>
 483:	72 76                	jb     4fb <PR_BOOTABLE+0x47b>
 485:	65 64 00 62 6f       	gs add %ah,%fs:0x6f(%edx)
 48a:	6f                   	outsl  %ds:(%esi),(%dx)
 48b:	74 5f                	je     4ec <PR_BOOTABLE+0x46c>
 48d:	6c                   	insb   (%dx),%es:(%edi)
 48e:	6f                   	outsl  %ds:(%esi),(%dx)
 48f:	61                   	popa   
 490:	64 65 72 5f          	fs gs jb 4f3 <PR_BOOTABLE+0x473>
 494:	6e                   	outsb  %ds:(%esi),(%dx)
 495:	61                   	popa   
 496:	6d                   	insl   (%dx),%es:(%edi)
 497:	65 00 76 62          	add    %dh,%gs:0x62(%esi)
 49b:	65 5f                	gs pop %edi
 49d:	69 6e 74 65 72 66 61 	imul   $0x61667265,0x74(%esi),%ebp
 4a4:	63 65 5f             	arpl   %sp,0x5f(%ebp)
 4a7:	73 65                	jae    50e <PR_BOOTABLE+0x48e>
 4a9:	67 00 6d 6d          	add    %ch,0x6d(%di)
 4ad:	61                   	popa   
 4ae:	70 5f                	jo     50f <PR_BOOTABLE+0x48f>
 4b0:	6c                   	insb   (%dx),%es:(%edi)
 4b1:	65 6e                	outsb  %gs:(%esi),(%dx)
 4b3:	00 70 5f             	add    %dh,0x5f(%eax)
 4b6:	61                   	popa   
 4b7:	6c                   	insb   (%dx),%es:(%edi)
 4b8:	69 67 6e 00 61 70 6d 	imul   $0x6d706100,0x6e(%edi),%esp
 4bf:	5f                   	pop    %edi
 4c0:	74 61                	je     523 <PR_BOOTABLE+0x4a3>
 4c2:	62 6c 65 00          	bound  %ebp,0x0(%ebp,%eiz,2)
 4c6:	70 5f                	jo     527 <PR_BOOTABLE+0x4a7>
 4c8:	70 61                	jo     52b <PR_BOOTABLE+0x4ab>
 4ca:	00 73 65             	add    %dh,0x65(%ebx)
 4cd:	63 74 6f 72          	arpl   %si,0x72(%edi,%ebp,2)
 4d1:	73 5f                	jae    532 <PR_BOOTABLE+0x4b2>
 4d3:	63 6f 75             	arpl   %bp,0x75(%edi)
 4d6:	6e                   	outsb  %ds:(%esi),(%dx)
 4d7:	74 00                	je     4d9 <PR_BOOTABLE+0x459>
 4d9:	65 78 65             	gs js  541 <PR_BOOTABLE+0x4c1>
 4dc:	63 5f 6b             	arpl   %bx,0x6b(%edi)
 4df:	65 72 6e             	gs jb  550 <PR_BOOTABLE+0x4d0>
 4e2:	65 6c                	gs insb (%dx),%es:(%edi)
 4e4:	2e 53                	cs push %ebx
 4e6:	00                   	.byte 0x0

Disassembly of section .debug_line_str:

00000000 <.debug_line_str>:
   0:	2f                   	das    
   1:	68 6f 6d 65 2f       	push   $0x2f656d6f
   6:	63 6c 61 73          	arpl   %bp,0x73(%ecx,%eiz,2)
   a:	73 65                	jae    71 <PROT_MODE_DSEG+0x61>
   c:	73 2f                	jae    3d <PROT_MODE_DSEG+0x2d>
   e:	63 73 34             	arpl   %si,0x34(%ebx)
  11:	32 32                	xor    (%edx),%dh
  13:	2f                   	das    
  14:	63 6c 61 73          	arpl   %bp,0x73(%ecx,%eiz,2)
  18:	73 2f                	jae    49 <PROT_MODE_DSEG+0x39>
  1a:	76 72                	jbe    8e <PR_BOOTABLE+0xe>
  1c:	6f                   	outsl  %ds:(%esi),(%dx)
  1d:	6f                   	outsl  %ds:(%esi),(%dx)
  1e:	6e                   	outsb  %ds:(%esi),(%dx)
  1f:	2e 64 79 6c          	cs jns,pn 8f <PR_BOOTABLE+0xf>
  23:	61                   	popa   
  24:	6e                   	outsb  %ds:(%esi),(%dx)
  25:	2e 64 72 76          	cs jb,pn 9f <PR_BOOTABLE+0x1f>
  29:	32 36                	xor    (%esi),%dh
  2b:	2f                   	das    
  2c:	61                   	popa   
  2d:	73 73                	jae    a2 <PR_BOOTABLE+0x22>
  2f:	31 2f                	xor    %ebp,(%edi)
  31:	63 73 34             	arpl   %si,0x34(%ebx)
  34:	32 32                	xor    (%edx),%dh
  36:	61                   	popa   
  37:	73 73                	jae    ac <PR_BOOTABLE+0x2c>
  39:	69 67 6e 6d 65 6e 74 	imul   $0x746e656d,0x6e(%edi),%esp
  40:	31 00                	xor    %eax,(%eax)
  42:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  45:	74 2f                	je     76 <PROT_MODE_DSEG+0x66>
  47:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  4a:	74 31                	je     7d <PROT_MODE_DSEG+0x6d>
  4c:	00 62 6f             	add    %ah,0x6f(%edx)
  4f:	6f                   	outsl  %ds:(%esi),(%dx)
  50:	74 31                	je     83 <PR_BOOTABLE+0x3>
  52:	2e 53                	cs push %ebx
  54:	00 62 6f             	add    %ah,0x6f(%edx)
  57:	6f                   	outsl  %ds:(%esi),(%dx)
  58:	74 2f                	je     89 <PR_BOOTABLE+0x9>
  5a:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  5d:	74 31                	je     90 <PR_BOOTABLE+0x10>
  5f:	2f                   	das    
  60:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  63:	74 31                	je     96 <PR_BOOTABLE+0x16>
  65:	6c                   	insb   (%dx),%es:(%edi)
  66:	69 62 2e 63 00 62 6f 	imul   $0x6f620063,0x2e(%edx),%esp
  6d:	6f                   	outsl  %ds:(%esi),(%dx)
  6e:	74 31                	je     a1 <PR_BOOTABLE+0x21>
  70:	6c                   	insb   (%dx),%es:(%edi)
  71:	69 62 2e 68 00 62 6f 	imul   $0x6f620068,0x2e(%edx),%esp
  78:	6f                   	outsl  %ds:(%esi),(%dx)
  79:	74 2f                	je     aa <PR_BOOTABLE+0x2a>
  7b:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  7e:	74 31                	je     b1 <PR_BOOTABLE+0x31>
  80:	2f                   	das    
  81:	62 6f 6f             	bound  %ebp,0x6f(%edi)
  84:	74 31                	je     b7 <PR_BOOTABLE+0x37>
  86:	6d                   	insl   (%dx),%es:(%edi)
  87:	61                   	popa   
  88:	69 6e 2e 63 00 65 78 	imul   $0x78650063,0x2e(%esi),%ebp
  8f:	65 63 5f 6b          	arpl   %bx,%gs:0x6b(%edi)
  93:	65 72 6e             	gs jb  104 <PR_BOOTABLE+0x84>
  96:	65 6c                	gs insb (%dx),%es:(%edi)
  98:	2e 53                	cs push %ebx
  9a:	00                   	.byte 0x0

Disassembly of section .debug_loclists:

00000000 <.debug_loclists>:
   0:	94                   	xchg   %eax,%esp
   1:	03 00                	add    (%eax),%eax
   3:	00 05 00 04 00 00    	add    %al,0x400
   9:	00 00                	add    %al,(%eax)
   b:	00 00                	add    %al,(%eax)
   d:	00 00                	add    %al,(%eax)
   f:	00 00                	add    %al,(%eax)
  11:	00 00                	add    %al,(%eax)
  13:	00 00                	add    %al,(%eax)
  15:	01 01                	add    %eax,(%ecx)
  17:	00 00                	add    %al,(%eax)
  19:	00 00                	add    %al,(%eax)
  1b:	01 01                	add    %eax,(%ecx)
  1d:	00 04 a7             	add    %al,(%edi,%eiz,4)
  20:	04 ab                	add    $0xab,%al
  22:	04 02                	add    $0x2,%al
  24:	91                   	xchg   %eax,%ecx
  25:	00 04 b3             	add    %al,(%ebx,%esi,4)
  28:	04 c1                	add    $0xc1,%al
  2a:	04 09                	add    $0x9,%al
  2c:	73 00                	jae    2e <PROT_MODE_DSEG+0x1e>
  2e:	0c ff                	or     $0xff,%al
  30:	ff                   	(bad)  
  31:	ff 00                	incl   (%eax)
  33:	1a 9f 04 c1 04 ca    	sbb    -0x35fb3efc(%edi),%bl
  39:	04 09                	add    $0x9,%al
  3b:	77 00                	ja     3d <PROT_MODE_DSEG+0x2d>
  3d:	0c ff                	or     $0xff,%al
  3f:	ff                   	(bad)  
  40:	ff 00                	incl   (%eax)
  42:	1a 9f 04 ca 04 cd    	sbb    -0x32fb35fc(%edi),%bl
  48:	04 01                	add    $0x1,%al
  4a:	57                   	push   %edi
  4b:	04 cd                	add    $0xcd,%al
  4d:	04 cd                	add    $0xcd,%al
  4f:	04 0a                	add    $0xa,%al
  51:	91                   	xchg   %eax,%ecx
  52:	00 06                	add    %al,(%esi)
  54:	0c ff                	or     $0xff,%al
  56:	ff                   	(bad)  
  57:	ff 00                	incl   (%eax)
  59:	1a 9f 04 cd 04 dc    	sbb    -0x23fb32fc(%edi),%bl
  5f:	04 01                	add    $0x1,%al
  61:	53                   	push   %ebx
  62:	04 dc                	add    $0xdc,%al
  64:	04 e0                	add    $0xe0,%al
  66:	04 02                	add    $0x2,%al
  68:	74 00                	je     6a <PROT_MODE_DSEG+0x5a>
  6a:	04 e0                	add    $0xe0,%al
  6c:	04 e1                	add    $0xe1,%al
  6e:	04 04                	add    $0x4,%al
  70:	73 80                	jae    fffffff2 <SMAP_SIG+0xacb2bea2>
  72:	7c 9f                	jl     13 <PROT_MODE_DSEG+0x3>
  74:	04 e1                	add    $0xe1,%al
  76:	04 ea                	add    $0xea,%al
  78:	04 01                	add    $0x1,%al
  7a:	53                   	push   %ebx
  7b:	00 00                	add    %al,(%eax)
  7d:	00 04 a7             	add    %al,(%edi,%eiz,4)
  80:	04 ab                	add    $0xab,%al
  82:	04 02                	add    $0x2,%al
  84:	91                   	xchg   %eax,%ecx
  85:	04 00                	add    $0x0,%al
  87:	00 00                	add    %al,(%eax)
  89:	02 00                	add    (%eax),%al
  8b:	00 00                	add    %al,(%eax)
  8d:	00 02                	add    %al,(%edx)
  8f:	02 00                	add    (%eax),%al
  91:	04 a7                	add    $0xa7,%al
  93:	04 ab                	add    $0xab,%al
  95:	04 02                	add    $0x2,%al
  97:	91                   	xchg   %eax,%ecx
  98:	08 04 cd 04 d5 04 01 	or     %al,0x104d504(,%ecx,8)
  9f:	56                   	push   %esi
  a0:	04 d5                	add    $0xd5,%al
  a2:	04 d6                	add    $0xd6,%al
  a4:	04 02                	add    $0x2,%al
  a6:	74 00                	je     a8 <PR_BOOTABLE+0x28>
  a8:	04 d6                	add    $0xd6,%al
  aa:	04 e1                	add    $0xe1,%al
  ac:	04 03                	add    $0x3,%al
  ae:	76 7f                	jbe    12f <PR_BOOTABLE+0xaf>
  b0:	9f                   	lahf   
  b1:	04 e1                	add    $0xe1,%al
  b3:	04 eb                	add    $0xeb,%al
  b5:	04 01                	add    $0x1,%al
  b7:	56                   	push   %esi
  b8:	00 00                	add    %al,(%eax)
  ba:	00 04 a7             	add    %al,(%edi,%eiz,4)
  bd:	04 ab                	add    $0xab,%al
  bf:	04 02                	add    $0x2,%al
  c1:	91                   	xchg   %eax,%ecx
  c2:	0c 00                	or     $0x0,%al
  c4:	00 00                	add    %al,(%eax)
  c6:	04 cd                	add    $0xcd,%al
  c8:	04 ec                	add    $0xec,%al
  ca:	04 01                	add    $0x1,%al
  cc:	57                   	push   %edi
  cd:	00 00                	add    %al,(%eax)
  cf:	00 04 b8             	add    %al,(%eax,%edi,4)
  d2:	03 bc 03 02 91 00 00 	add    0x9102(%ebx,%eax,1),%edi
  d9:	00 00                	add    %al,(%eax)
  db:	04 b8                	add    $0xb8,%al
  dd:	03 bc 03 02 91 04 00 	add    0x49102(%ebx,%eax,1),%edi
  e4:	01 01                	add    %eax,(%ecx)
  e6:	04 c4                	add    $0xc4,%al
  e8:	03 c7                	add    %edi,%eax
  ea:	03 04 0a             	add    (%edx,%ecx,1),%eax
  ed:	f7 01 9f 00 00 01    	testl  $0x100009f,(%ecx)
  f3:	04 c7                	add    $0xc7,%al
  f5:	03 c7                	add    %edi,%eax
  f7:	03 01                	add    (%ecx),%eax
  f9:	50                   	push   %eax
  fa:	00 01                	add    %al,(%ecx)
  fc:	00 04 ce             	add    %al,(%esi,%ecx,8)
  ff:	03 d6                	add    %esi,%edx
 101:	03 02                	add    (%edx),%eax
 103:	31 9f 00 01 00 04    	xor    %ebx,0x4000100(%edi)
 109:	ce                   	into   
 10a:	03 d6                	add    %esi,%edx
 10c:	03 04 0a             	add    (%edx,%ecx,1),%eax
 10f:	f2 01 9f 00 02 00 04 	repnz add %ebx,0x4000200(%edi)
 116:	d6                   	(bad)  
 117:	03 de                	add    %esi,%ebx
 119:	03 01                	add    (%ecx),%eax
 11b:	51                   	push   %ecx
 11c:	00 02                	add    %al,(%edx)
 11e:	00 04 d6             	add    %al,(%esi,%edx,8)
 121:	03 de                	add    %esi,%ebx
 123:	03 04 0a             	add    (%edx,%ecx,1),%eax
 126:	f3 01 9f 00 02 00 04 	repz add %ebx,0x4000200(%edi)
 12d:	de 03                	fiadds (%ebx)
 12f:	e9 03 05 71 00       	jmp    710637 <_end+0x7072eb>
 134:	38 25 9f 00 02 00    	cmp    %ah,0x2009f
 13a:	04 de                	add    $0xde,%al
 13c:	03 e9                	add    %ecx,%ebp
 13e:	03 04 0a             	add    (%edx,%ecx,1),%eax
 141:	f4                   	hlt    
 142:	01 9f 00 02 00 04    	add    %ebx,0x4000200(%edi)
 148:	e9 03 f4 03 05       	jmp    503f550 <_end+0x5036204>
 14d:	71 00                	jno    14f <PR_BOOTABLE+0xcf>
 14f:	40                   	inc    %eax
 150:	25 9f 00 02 00       	and    $0x2009f,%eax
 155:	04 e9                	add    $0xe9,%al
 157:	03 f4                	add    %esp,%esi
 159:	03 04 0a             	add    (%edx,%ecx,1),%eax
 15c:	f5                   	cmc    
 15d:	01 9f 00 02 00 04    	add    %ebx,0x4000200(%edi)
 163:	f4                   	hlt    
 164:	03 82 04 08 71 00    	add    0x710804(%edx),%eax
 16a:	48                   	dec    %eax
 16b:	25 09 e0 21 9f       	and    $0x9f21e009,%eax
 170:	00 02                	add    %al,(%edx)
 172:	00 04 f4             	add    %al,(%esp,%esi,8)
 175:	03 82 04 04 0a f6    	add    -0x9f5fbfc(%edx),%eax
 17b:	01 9f 00 02 00 04    	add    %ebx,0x4000200(%edi)
 181:	82 04 87 04          	addb   $0x4,(%edi,%eax,4)
 185:	03 08                	add    (%eax),%ecx
 187:	20 9f 00 02 00 04    	and    %bl,0x4000200(%edi)
 18d:	82 04 87 04          	addb   $0x4,(%edi,%eax,4)
 191:	04 0a                	add    $0xa,%al
 193:	f7 01 9f 00 01 01    	testl  $0x101009f,(%ecx)
 199:	04 8c                	add    $0x8c,%al
 19b:	04 8d                	add    $0x8d,%al
 19d:	04 04                	add    $0x4,%al
 19f:	0a f7                	or     %bh,%dh
 1a1:	01 9f 00 00 01 04    	add    %ebx,0x4010000(%edi)
 1a7:	8d 04 8d 04 01 50 00 	lea    0x500104(,%ecx,4),%eax
 1ae:	01 00                	add    %eax,(%eax)
 1b0:	04 94                	add    $0x94,%al
 1b2:	04 a4                	add    $0xa4,%al
 1b4:	04 03                	add    $0x3,%al
 1b6:	08 80 9f 00 01 00    	or     %al,0x1009f(%eax)
 1bc:	04 94                	add    $0x94,%al
 1be:	04 a4                	add    $0xa4,%al
 1c0:	04 02                	add    $0x2,%al
 1c2:	91                   	xchg   %eax,%ecx
 1c3:	00 00                	add    %al,(%eax)
 1c5:	01 00                	add    %eax,(%eax)
 1c7:	04 94                	add    $0x94,%al
 1c9:	04 a4                	add    $0xa4,%al
 1cb:	04 04                	add    $0x4,%al
 1cd:	0a f0                	or     %al,%dh
 1cf:	01 9f 00 00 00 04    	add    %ebx,0x4000000(%edi)
 1d5:	f8                   	clc    
 1d6:	02 83 03 02 91 00    	add    0x910203(%ebx),%al
 1dc:	00 00                	add    %al,(%eax)
 1de:	00 04 f8             	add    %al,(%eax,%edi,8)
 1e1:	02 83 03 02 91 04    	add    0x4910203(%ebx),%al
 1e7:	00 00                	add    %al,(%eax)
 1e9:	00 04 db             	add    %al,(%ebx,%ebx,8)
 1ec:	02 e6                	add    %dh,%ah
 1ee:	02 02                	add    (%edx),%al
 1f0:	91                   	xchg   %eax,%ecx
 1f1:	00 00                	add    %al,(%eax)
 1f3:	00 00                	add    %al,(%eax)
 1f5:	04 db                	add    $0xdb,%al
 1f7:	02 e6                	add    %dh,%ah
 1f9:	02 02                	add    (%edx),%al
 1fb:	91                   	xchg   %eax,%ecx
 1fc:	04 00                	add    $0x0,%al
 1fe:	00 00                	add    %al,(%eax)
 200:	00 00                	add    %al,(%eax)
 202:	04 84                	add    $0x84,%al
 204:	02 88 02 02 91 00    	add    0x910202(%eax),%cl
 20a:	04 a5                	add    $0xa5,%al
 20c:	02 da                	add    %dl,%bl
 20e:	02 01                	add    (%ecx),%al
 210:	50                   	push   %eax
 211:	00 00                	add    %al,(%eax)
 213:	00 04 84             	add    %al,(%esp,%eax,4)
 216:	02 88 02 02 91 04    	add    0x4910202(%eax),%cl
 21c:	00 00                	add    %al,(%eax)
 21e:	00 04 84             	add    %al,(%esp,%eax,4)
 221:	02 88 02 02 91 08    	add    0x8910202(%eax),%cl
 227:	00 00                	add    %al,(%eax)
 229:	00 04 84             	add    %al,(%esp,%eax,4)
 22c:	02 88 02 02 91 0c    	add    0xc910202(%eax),%cl
 232:	00 00                	add    %al,(%eax)
 234:	00 00                	add    %al,(%eax)
 236:	00 00                	add    %al,(%eax)
 238:	00 04 a5 02 c1 02 01 	add    %al,0x102c102(,%eiz,4)
 23f:	51                   	push   %ecx
 240:	04 c1                	add    $0xc1,%al
 242:	02 c8                	add    %al,%cl
 244:	02 01                	add    (%ecx),%al
 246:	52                   	push   %edx
 247:	04 c8                	add    $0xc8,%al
 249:	02 da                	add    %dl,%bl
 24b:	02 01                	add    (%ecx),%al
 24d:	51                   	push   %ecx
 24e:	00 00                	add    %al,(%eax)
 250:	00 04 90             	add    %al,(%eax,%edx,4)
 253:	02 d4                	add    %ah,%dl
 255:	02 01                	add    (%ecx),%al
 257:	56                   	push   %esi
 258:	00 00                	add    %al,(%eax)
 25a:	00 04 cf             	add    %al,(%edi,%ecx,8)
 25d:	01 d3                	add    %edx,%ebx
 25f:	01 02                	add    %eax,(%edx)
 261:	91                   	xchg   %eax,%ecx
 262:	00 00                	add    %al,(%eax)
 264:	04 00                	add    $0x0,%al
 266:	00 00                	add    %al,(%eax)
 268:	00 01                	add    %al,(%ecx)
 26a:	01 00                	add    %eax,(%eax)
 26c:	04 cf                	add    $0xcf,%al
 26e:	01 e6                	add    %esp,%esi
 270:	01 02                	add    %eax,(%edx)
 272:	30 9f 04 e6 01 f7    	xor    %bl,-0x8fe19fc(%edi)
 278:	01 01                	add    %eax,(%ecx)
 27a:	52                   	push   %edx
 27b:	04 f7                	add    $0xf7,%al
 27d:	01 fa                	add    %edi,%edx
 27f:	01 03                	add    %eax,(%ebx)
 281:	72 7f                	jb     302 <PR_BOOTABLE+0x282>
 283:	9f                   	lahf   
 284:	04 fa                	add    $0xfa,%al
 286:	01 84 02 01 52 00 00 	add    %eax,0x5201(%edx,%eax,1)
 28d:	00 04 e6             	add    %al,(%esi,%eiz,8)
 290:	01 84 02 01 50 00 00 	add    %eax,0x5001(%edx,%eax,1)
 297:	00 04 ee             	add    %al,(%esi,%ebp,8)
 29a:	01 fd                	add    %edi,%ebp
 29c:	01 01                	add    %eax,(%ecx)
 29e:	56                   	push   %esi
 29f:	00 00                	add    %al,(%eax)
 2a1:	00 00                	add    %al,(%eax)
 2a3:	00 00                	add    %al,(%eax)
 2a5:	01 01                	add    %eax,(%ecx)
 2a7:	00 04 bc             	add    %al,(%esp,%edi,4)
 2aa:	01 c4                	add    %eax,%esp
 2ac:	01 02                	add    %eax,(%edx)
 2ae:	91                   	xchg   %eax,%ecx
 2af:	00 04 c4             	add    %al,(%esp,%eax,8)
 2b2:	01 cb                	add    %ecx,%ebx
 2b4:	01 07                	add    %eax,(%edi)
 2b6:	91                   	xchg   %eax,%ecx
 2b7:	00 06                	add    %al,(%esi)
 2b9:	70 00                	jo     2bb <PR_BOOTABLE+0x23b>
 2bb:	22 9f 04 cb 01 cb    	and    -0x34fe34fc(%edi),%bl
 2c1:	01 09                	add    %ecx,(%ecx)
 2c3:	91                   	xchg   %eax,%ecx
 2c4:	00 06                	add    %al,(%esi)
 2c6:	70 00                	jo     2c8 <PR_BOOTABLE+0x248>
 2c8:	22 31                	and    (%ecx),%dh
 2ca:	1c 9f                	sbb    $0x9f,%al
 2cc:	04 cb                	add    $0xcb,%al
 2ce:	01 cf                	add    %ecx,%edi
 2d0:	01 07                	add    %eax,(%edi)
 2d2:	91                   	xchg   %eax,%ecx
 2d3:	00 06                	add    %al,(%esi)
 2d5:	70 00                	jo     2d7 <PR_BOOTABLE+0x257>
 2d7:	22 9f 00 03 00 00    	and    0x300(%edi),%bl
 2dd:	00 04 bc             	add    %al,(%esp,%edi,4)
 2e0:	01 c4                	add    %eax,%esp
 2e2:	01 02                	add    %eax,(%edx)
 2e4:	30 9f 04 c4 01 cf    	xor    %bl,-0x30fe3bfc(%edi)
 2ea:	01 01                	add    %eax,(%ecx)
 2ec:	50                   	push   %eax
 2ed:	00 00                	add    %al,(%eax)
 2ef:	00 04 95 03 a0 03 02 	add    %al,0x203a003(,%edx,4)
 2f6:	91                   	xchg   %eax,%ecx
 2f7:	00 00                	add    %al,(%eax)
 2f9:	00 00                	add    %al,(%eax)
 2fb:	04 a2                	add    $0xa2,%al
 2fd:	01 ab 01 02 91 00    	add    %ebp,0x910201(%ebx)
 303:	00 00                	add    %al,(%eax)
 305:	00 04 55 59 02 91 00 	add    %al,0x910259(,%edx,2)
 30c:	00 00                	add    %al,(%eax)
 30e:	00 04 1b             	add    %al,(%ebx,%ebx,1)
 311:	1f                   	pop    %ds
 312:	02 91 00 00 00 00    	add    0x0(%ecx),%dl
 318:	04 1b                	add    $0x1b,%al
 31a:	1f                   	pop    %ds
 31b:	02 91 04 00 00 00    	add    0x4(%ecx),%dl
 321:	04 1b                	add    $0x1b,%al
 323:	1f                   	pop    %ds
 324:	02 91 08 00 00 00    	add    0x8(%ecx),%dl
 32a:	00 01                	add    %al,(%ecx)
 32c:	01 00                	add    %eax,(%eax)
 32e:	00 00                	add    %al,(%eax)
 330:	00 00                	add    %al,(%eax)
 332:	04 1b                	add    $0x1b,%al
 334:	1f                   	pop    %ds
 335:	02 91 0c 04 2c 39    	add    0x392c040c(%ecx),%dl
 33b:	0a 91 0c 06 70 00    	or     0x70060c(%ecx),%dl
 341:	22 76 00             	and    0x0(%esi),%dh
 344:	1c 9f                	sbb    $0x9f,%al
 346:	04 39                	add    $0x39,%al
 348:	46                   	inc    %esi
 349:	0c 91                	or     $0x91,%al
 34b:	0c 06                	or     $0x6,%al
 34d:	70 00                	jo     34f <PR_BOOTABLE+0x2cf>
 34f:	22 76 00             	and    0x0(%esi),%dh
 352:	1c 23                	sbb    $0x23,%al
 354:	01 9f 04 46 4e 0a    	add    %ebx,0xa4e4604(%edi)
 35a:	91                   	xchg   %eax,%ecx
 35b:	0c 06                	or     $0x6,%al
 35d:	73 00                	jae    35f <PR_BOOTABLE+0x2df>
 35f:	22 76 00             	and    0x0(%esi),%dh
 362:	1c 9f                	sbb    $0x9f,%al
 364:	04 4e                	add    $0x4e,%al
 366:	53                   	push   %ebx
 367:	0a 91 0c 06 70 00    	or     0x70060c(%ecx),%dl
 36d:	22 76 00             	and    0x0(%esi),%dh
 370:	1c 9f                	sbb    $0x9f,%al
 372:	00 00                	add    %al,(%eax)
 374:	00 00                	add    %al,(%eax)
 376:	00 00                	add    %al,(%eax)
 378:	00 00                	add    %al,(%eax)
 37a:	00 04 2a             	add    %al,(%edx,%ebp,1)
 37d:	2c 01                	sub    $0x1,%al
 37f:	56                   	push   %esi
 380:	04 2c                	add    $0x2c,%al
 382:	3f                   	aas    
 383:	01 50 04             	add    %edx,0x4(%eax)
 386:	3f                   	aas    
 387:	4e                   	dec    %esi
 388:	01 53 04             	add    %edx,0x4(%ebx)
 38b:	4e                   	dec    %esi
 38c:	55                   	push   %ebp
 38d:	01 50 00             	add    %edx,0x0(%eax)
 390:	00 00                	add    %al,(%eax)
 392:	04 11                	add    $0x11,%al
 394:	1b 01                	sbb    (%ecx),%eax
 396:	50                   	push   %eax
 397:	00 32                	add    %dh,(%edx)
 399:	01 00                	add    %eax,(%eax)
 39b:	00 05 00 04 00 00    	add    %al,0x400
 3a1:	00 00                	add    %al,(%eax)
 3a3:	00 00                	add    %al,(%eax)
 3a5:	00 04 81             	add    %al,(%ecx,%eax,4)
 3a8:	01 85 01 02 91 00    	add    %eax,0x910201(%ebp)
 3ae:	00 00                	add    %al,(%eax)
 3b0:	00 00                	add    %al,(%eax)
 3b2:	00 00                	add    %al,(%eax)
 3b4:	01 00                	add    %eax,(%eax)
 3b6:	00 00                	add    %al,(%eax)
 3b8:	00 00                	add    %al,(%eax)
 3ba:	00 04 89             	add    %al,(%ecx,%ecx,4)
 3bd:	01 9b 01 01 56 04    	add    %ebx,0x4560101(%ebx)
 3c3:	9b                   	fwait
 3c4:	01 ad 01 06 76 00    	add    %ebp,0x760601(%ebp)
 3ca:	73 00                	jae    3cc <PR_BOOTABLE+0x34c>
 3cc:	22 9f 04 ad 01 b3    	and    -0x4cfe52fc(%edi),%bl
 3d2:	01 08                	add    %ecx,(%eax)
 3d4:	76 00                	jbe    3d6 <PR_BOOTABLE+0x356>
 3d6:	73 00                	jae    3d8 <PR_BOOTABLE+0x358>
 3d8:	22 48 1c             	and    0x1c(%eax),%cl
 3db:	9f                   	lahf   
 3dc:	04 b8                	add    $0xb8,%al
 3de:	01 de                	add    %ebx,%esi
 3e0:	01 06                	add    %eax,(%esi)
 3e2:	76 00                	jbe    3e4 <PR_BOOTABLE+0x364>
 3e4:	73 00                	jae    3e6 <PR_BOOTABLE+0x366>
 3e6:	22 9f 04 de 01 df    	and    -0x20fe21fc(%edi),%bl
 3ec:	01 0a                	add    %ecx,(%edx)
 3ee:	76 00                	jbe    3f0 <PR_BOOTABLE+0x370>
 3f0:	03 ec                	add    %esp,%ebp
 3f2:	92                   	xchg   %eax,%edx
 3f3:	00 00                	add    %al,(%eax)
 3f5:	06                   	push   %es
 3f6:	22 9f 04 df 01 e1    	and    -0x1efe20fc(%edi),%bl
 3fc:	01 0b                	add    %ecx,(%ebx)
 3fe:	91                   	xchg   %eax,%ecx
 3ff:	00 06                	add    %al,(%esi)
 401:	03 ec                	add    %esp,%ebp
 403:	92                   	xchg   %eax,%edx
 404:	00 00                	add    %al,(%eax)
 406:	06                   	push   %es
 407:	22 9f 00 01 00 00    	and    0x100(%edi),%bl
 40d:	00 00                	add    %al,(%eax)
 40f:	02 02                	add    (%edx),%al
 411:	00 00                	add    %al,(%eax)
 413:	00 04 89             	add    %al,(%ecx,%ecx,4)
 416:	01 9b 01 02 30 9f    	add    %ebx,-0x60cffdff(%ebx)
 41c:	04 9b                	add    $0x9b,%al
 41e:	01 ad 01 01 53 04    	add    %ebp,0x4530101(%ebp)
 424:	ad                   	lods   %ds:(%esi),%eax
 425:	01 b3 01 03 73 68    	add    %esi,0x68730301(%ebx)
 42b:	9f                   	lahf   
 42c:	04 b3                	add    $0xb3,%al
 42e:	01 de                	add    %ebx,%esi
 430:	01 01                	add    %eax,(%ecx)
 432:	53                   	push   %ebx
 433:	04 de                	add    $0xde,%al
 435:	01 e1                	add    %esp,%ecx
 437:	01 05 03 ec 92 00    	add    %eax,0x92ec03
 43d:	00 00                	add    %al,(%eax)
 43f:	00 00                	add    %al,(%eax)
 441:	04 00                	add    $0x0,%al
 443:	04 02                	add    $0x2,%al
 445:	91                   	xchg   %eax,%ecx
 446:	00 00                	add    %al,(%eax)
 448:	00 00                	add    %al,(%eax)
 44a:	00 01                	add    %al,(%ecx)
 44c:	01 00                	add    %eax,(%eax)
 44e:	04 4f                	add    $0x4f,%al
 450:	5c                   	pop    %esp
 451:	01 53 04             	add    %edx,0x4(%ebx)
 454:	5c                   	pop    %esp
 455:	6a 03                	push   $0x3
 457:	73 60                	jae    4b9 <PR_BOOTABLE+0x439>
 459:	9f                   	lahf   
 45a:	04 6a                	add    $0x6a,%al
 45c:	78 01                	js     45f <PR_BOOTABLE+0x3df>
 45e:	53                   	push   %ebx
 45f:	00 00                	add    %al,(%eax)
 461:	00 04 54             	add    %al,(%esp,%edx,2)
 464:	79 01                	jns    467 <PR_BOOTABLE+0x3e7>
 466:	56                   	push   %esi
 467:	00 00                	add    %al,(%eax)
 469:	00 04 e1             	add    %al,(%ecx,%eiz,8)
 46c:	01 e5                	add    %esp,%ebp
 46e:	01 02                	add    %eax,(%edx)
 470:	91                   	xchg   %eax,%ecx
 471:	00 00                	add    %al,(%eax)
 473:	00 00                	add    %al,(%eax)
 475:	04 e1                	add    $0xe1,%al
 477:	01 e5                	add    %esp,%ebp
 479:	01 02                	add    %eax,(%edx)
 47b:	91                   	xchg   %eax,%ecx
 47c:	04 00                	add    $0x0,%al
 47e:	00 00                	add    %al,(%eax)
 480:	04 e1                	add    $0xe1,%al
 482:	01 e5                	add    %esp,%ebp
 484:	01 02                	add    %eax,(%edx)
 486:	91                   	xchg   %eax,%ecx
 487:	08 00                	or     %al,(%eax)
 489:	03 00                	add    (%eax),%eax
 48b:	00 00                	add    %al,(%eax)
 48d:	04 82                	add    $0x82,%al
 48f:	02 87 02 02 30 9f    	add    -0x60cffdfe(%edi),%al
 495:	04 87                	add    $0x87,%al
 497:	02 b3 02 01 50 00    	add    0x500102(%ebx),%dh
 49d:	02 00                	add    (%eax),%al
 49f:	00 00                	add    %al,(%eax)
 4a1:	00 00                	add    %al,(%eax)
 4a3:	04 82                	add    $0x82,%al
 4a5:	02 9d 02 02 30 9f    	add    -0x60cffdfe(%ebp),%bl
 4ab:	04 9d                	add    $0x9d,%al
 4ad:	02 9f 02 01 56 04    	add    0x4560102(%edi),%bl
 4b3:	9f                   	lahf   
 4b4:	02 b7 02 02 30 9f    	add    -0x60cffdfe(%edi),%dh
 4ba:	00 00                	add    %al,(%eax)
 4bc:	00 00                	add    %al,(%eax)
 4be:	00 04 dd 02 e1 02 01 	add    %al,0x102e102(,%ebx,8)
 4c5:	50                   	push   %eax
 4c6:	04 e1                	add    $0xe1,%al
 4c8:	02 fd                	add    %ch,%bh
 4ca:	02 01                	add    (%ecx),%al
 4cc:	53                   	push   %ebx
 4cd:	00                   	.byte 0x0

Disassembly of section .debug_rnglists:

00000000 <.debug_rnglists>:
   0:	5e                   	pop    %esi
   1:	00 00                	add    %al,(%eax)
   3:	00 05 00 04 00 00    	add    %al,0x400
   9:	00 00                	add    %al,(%eax)
   b:	00 04 b8             	add    %al,(%eax,%edi,4)
   e:	03 b8 03 04 bc 03    	add    0x3bc0403(%eax),%edi
  14:	c1 03 04             	roll   $0x4,(%ebx)
  17:	c4 03                	les    (%ebx),%eax
  19:	ce                   	into   
  1a:	03 00                	add    (%eax),%eax
  1c:	04 bc                	add    $0xbc,%al
  1e:	03 c1                	add    %ecx,%eax
  20:	03 04 c4             	add    (%esp,%eax,8),%eax
  23:	03 c7                	add    %edi,%eax
  25:	03 00                	add    (%eax),%eax
  27:	04 de                	add    $0xde,%al
  29:	03 de                	add    %esi,%ebx
  2b:	03 04 e0             	add    (%eax,%eiz,8),%eax
  2e:	03 e5                	add    %ebp,%esp
  30:	03 04 e8             	add    (%eax,%ebp,8),%eax
  33:	03 e9                	add    %ecx,%ebp
  35:	03 00                	add    (%eax),%eax
  37:	04 e9                	add    $0xe9,%al
  39:	03 e9                	add    %ecx,%ebp
  3b:	03 04 eb             	add    (%ebx,%ebp,8),%eax
  3e:	03 f0                	add    %eax,%esi
  40:	03 04 f3             	add    (%ebx,%esi,8),%eax
  43:	03 f4                	add    %esp,%esi
  45:	03 00                	add    (%eax),%eax
  47:	04 f4                	add    $0xf4,%al
  49:	03 f4                	add    %esp,%esi
  4b:	03 04 f6             	add    (%esi,%esi,8),%eax
  4e:	03 fb                	add    %ebx,%edi
  50:	03 04 81             	add    (%ecx,%eax,4),%eax
  53:	04 82                	add    $0x82,%al
  55:	04 00                	add    $0x0,%al
  57:	04 87                	add    $0x87,%al
  59:	04 8c                	add    $0x8c,%al
  5b:	04 04                	add    $0x4,%al
  5d:	8c                   	.byte 0x8c
  5e:	04 8d                	add    $0x8d,%al
  60:	04 00                	add    $0x0,%al
