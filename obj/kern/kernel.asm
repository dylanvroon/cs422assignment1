
obj/kern/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <video_init>:
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 18             	sub    $0x18,%esp
  100006:	c7 45 f4 00 80 0b 00 	movl   $0xb8000,-0xc(%ebp)
  10000d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100010:	0f b7 00             	movzwl (%eax),%eax
  100013:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  100017:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10001a:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
  10001f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100022:	0f b7 00             	movzwl (%eax),%eax
  100025:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100029:	74 29                	je     100054 <video_init+0x54>
  10002b:	c7 45 f4 00 00 0b 00 	movl   $0xb0000,-0xc(%ebp)
  100032:	c7 05 00 80 10 00 b4 	movl   $0x3b4,0x108000
  100039:	03 00 00 
  10003c:	a1 00 80 10 00       	mov    0x108000,%eax
  100041:	83 ec 08             	sub    $0x8,%esp
  100044:	50                   	push   %eax
  100045:	68 00 40 10 00       	push   $0x104000
  10004a:	e8 31 14 00 00       	call   101480 <dprintf>
  10004f:	83 c4 10             	add    $0x10,%esp
  100052:	eb 2a                	jmp    10007e <video_init+0x7e>
  100054:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100057:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10005b:	66 89 10             	mov    %dx,(%eax)
  10005e:	c7 05 00 80 10 00 d4 	movl   $0x3d4,0x108000
  100065:	03 00 00 
  100068:	a1 00 80 10 00       	mov    0x108000,%eax
  10006d:	83 ec 08             	sub    $0x8,%esp
  100070:	50                   	push   %eax
  100071:	68 00 40 10 00       	push   $0x104000
  100076:	e8 05 14 00 00       	call   101480 <dprintf>
  10007b:	83 c4 10             	add    $0x10,%esp
  10007e:	a1 00 80 10 00       	mov    0x108000,%eax
  100083:	83 ec 08             	sub    $0x8,%esp
  100086:	6a 0e                	push   $0xe
  100088:	50                   	push   %eax
  100089:	e8 d1 1f 00 00       	call   10205f <outb>
  10008e:	83 c4 10             	add    $0x10,%esp
  100091:	a1 00 80 10 00       	mov    0x108000,%eax
  100096:	83 c0 01             	add    $0x1,%eax
  100099:	83 ec 0c             	sub    $0xc,%esp
  10009c:	50                   	push   %eax
  10009d:	e8 82 1f 00 00       	call   102024 <inb>
  1000a2:	83 c4 10             	add    $0x10,%esp
  1000a5:	0f b6 c0             	movzbl %al,%eax
  1000a8:	c1 e0 08             	shl    $0x8,%eax
  1000ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1000ae:	a1 00 80 10 00       	mov    0x108000,%eax
  1000b3:	83 ec 08             	sub    $0x8,%esp
  1000b6:	6a 0f                	push   $0xf
  1000b8:	50                   	push   %eax
  1000b9:	e8 a1 1f 00 00       	call   10205f <outb>
  1000be:	83 c4 10             	add    $0x10,%esp
  1000c1:	a1 00 80 10 00       	mov    0x108000,%eax
  1000c6:	83 c0 01             	add    $0x1,%eax
  1000c9:	83 ec 0c             	sub    $0xc,%esp
  1000cc:	50                   	push   %eax
  1000cd:	e8 52 1f 00 00       	call   102024 <inb>
  1000d2:	83 c4 10             	add    $0x10,%esp
  1000d5:	0f b6 c0             	movzbl %al,%eax
  1000d8:	09 45 ec             	or     %eax,-0x14(%ebp)
  1000db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1000de:	a3 04 80 10 00       	mov    %eax,0x108004
  1000e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1000e6:	66 a3 08 80 10 00    	mov    %ax,0x108008
  1000ec:	c7 05 0c 80 10 00 00 	movl   $0x0,0x10800c
  1000f3:	00 00 00 
  1000f6:	90                   	nop
  1000f7:	c9                   	leave  
  1000f8:	c3                   	ret    

001000f9 <video_putc>:
  1000f9:	55                   	push   %ebp
  1000fa:	89 e5                	mov    %esp,%ebp
  1000fc:	53                   	push   %ebx
  1000fd:	83 ec 14             	sub    $0x14,%esp
  100100:	8b 45 08             	mov    0x8(%ebp),%eax
  100103:	3d ff 00 00 00       	cmp    $0xff,%eax
  100108:	77 07                	ja     100111 <video_putc+0x18>
  10010a:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
  100111:	8b 45 08             	mov    0x8(%ebp),%eax
  100114:	0f b6 c0             	movzbl %al,%eax
  100117:	83 f8 0d             	cmp    $0xd,%eax
  10011a:	0f 84 81 00 00 00    	je     1001a1 <video_putc+0xa8>
  100120:	83 f8 0d             	cmp    $0xd,%eax
  100123:	0f 8f f5 00 00 00    	jg     10021e <video_putc+0x125>
  100129:	83 f8 0a             	cmp    $0xa,%eax
  10012c:	74 63                	je     100191 <video_putc+0x98>
  10012e:	83 f8 0a             	cmp    $0xa,%eax
  100131:	0f 8f e7 00 00 00    	jg     10021e <video_putc+0x125>
  100137:	83 f8 08             	cmp    $0x8,%eax
  10013a:	74 0e                	je     10014a <video_putc+0x51>
  10013c:	83 f8 09             	cmp    $0x9,%eax
  10013f:	0f 84 96 00 00 00    	je     1001db <video_putc+0xe2>
  100145:	e9 d4 00 00 00       	jmp    10021e <video_putc+0x125>
  10014a:	0f b7 05 08 80 10 00 	movzwl 0x108008,%eax
  100151:	66 85 c0             	test   %ax,%ax
  100154:	0f 84 ea 00 00 00    	je     100244 <video_putc+0x14b>
  10015a:	0f b7 05 08 80 10 00 	movzwl 0x108008,%eax
  100161:	83 e8 01             	sub    $0x1,%eax
  100164:	66 a3 08 80 10 00    	mov    %ax,0x108008
  10016a:	8b 45 08             	mov    0x8(%ebp),%eax
  10016d:	b0 00                	mov    $0x0,%al
  10016f:	83 c8 20             	or     $0x20,%eax
  100172:	89 c1                	mov    %eax,%ecx
  100174:	a1 04 80 10 00       	mov    0x108004,%eax
  100179:	0f b7 15 08 80 10 00 	movzwl 0x108008,%edx
  100180:	0f b7 d2             	movzwl %dx,%edx
  100183:	01 d2                	add    %edx,%edx
  100185:	01 d0                	add    %edx,%eax
  100187:	89 ca                	mov    %ecx,%edx
  100189:	66 89 10             	mov    %dx,(%eax)
  10018c:	e9 b3 00 00 00       	jmp    100244 <video_putc+0x14b>
  100191:	0f b7 05 08 80 10 00 	movzwl 0x108008,%eax
  100198:	83 c0 50             	add    $0x50,%eax
  10019b:	66 a3 08 80 10 00    	mov    %ax,0x108008
  1001a1:	0f b7 1d 08 80 10 00 	movzwl 0x108008,%ebx
  1001a8:	0f b7 0d 08 80 10 00 	movzwl 0x108008,%ecx
  1001af:	0f b7 c1             	movzwl %cx,%eax
  1001b2:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  1001b8:	c1 e8 10             	shr    $0x10,%eax
  1001bb:	89 c2                	mov    %eax,%edx
  1001bd:	66 c1 ea 06          	shr    $0x6,%dx
  1001c1:	89 d0                	mov    %edx,%eax
  1001c3:	c1 e0 02             	shl    $0x2,%eax
  1001c6:	01 d0                	add    %edx,%eax
  1001c8:	c1 e0 04             	shl    $0x4,%eax
  1001cb:	29 c1                	sub    %eax,%ecx
  1001cd:	89 ca                	mov    %ecx,%edx
  1001cf:	89 d8                	mov    %ebx,%eax
  1001d1:	29 d0                	sub    %edx,%eax
  1001d3:	66 a3 08 80 10 00    	mov    %ax,0x108008
  1001d9:	eb 6a                	jmp    100245 <video_putc+0x14c>
  1001db:	83 ec 0c             	sub    $0xc,%esp
  1001de:	6a 20                	push   $0x20
  1001e0:	e8 14 ff ff ff       	call   1000f9 <video_putc>
  1001e5:	83 c4 10             	add    $0x10,%esp
  1001e8:	83 ec 0c             	sub    $0xc,%esp
  1001eb:	6a 20                	push   $0x20
  1001ed:	e8 07 ff ff ff       	call   1000f9 <video_putc>
  1001f2:	83 c4 10             	add    $0x10,%esp
  1001f5:	83 ec 0c             	sub    $0xc,%esp
  1001f8:	6a 20                	push   $0x20
  1001fa:	e8 fa fe ff ff       	call   1000f9 <video_putc>
  1001ff:	83 c4 10             	add    $0x10,%esp
  100202:	83 ec 0c             	sub    $0xc,%esp
  100205:	6a 20                	push   $0x20
  100207:	e8 ed fe ff ff       	call   1000f9 <video_putc>
  10020c:	83 c4 10             	add    $0x10,%esp
  10020f:	83 ec 0c             	sub    $0xc,%esp
  100212:	6a 20                	push   $0x20
  100214:	e8 e0 fe ff ff       	call   1000f9 <video_putc>
  100219:	83 c4 10             	add    $0x10,%esp
  10021c:	eb 27                	jmp    100245 <video_putc+0x14c>
  10021e:	8b 0d 04 80 10 00    	mov    0x108004,%ecx
  100224:	0f b7 05 08 80 10 00 	movzwl 0x108008,%eax
  10022b:	8d 50 01             	lea    0x1(%eax),%edx
  10022e:	66 89 15 08 80 10 00 	mov    %dx,0x108008
  100235:	0f b7 c0             	movzwl %ax,%eax
  100238:	01 c0                	add    %eax,%eax
  10023a:	01 c8                	add    %ecx,%eax
  10023c:	8b 55 08             	mov    0x8(%ebp),%edx
  10023f:	66 89 10             	mov    %dx,(%eax)
  100242:	eb 01                	jmp    100245 <video_putc+0x14c>
  100244:	90                   	nop
  100245:	0f b7 05 08 80 10 00 	movzwl 0x108008,%eax
  10024c:	66 3d cf 07          	cmp    $0x7cf,%ax
  100250:	76 59                	jbe    1002ab <video_putc+0x1b2>
  100252:	a1 04 80 10 00       	mov    0x108004,%eax
  100257:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  10025d:	a1 04 80 10 00       	mov    0x108004,%eax
  100262:	83 ec 04             	sub    $0x4,%esp
  100265:	68 00 0f 00 00       	push   $0xf00
  10026a:	52                   	push   %edx
  10026b:	50                   	push   %eax
  10026c:	e8 8a 0d 00 00       	call   100ffb <memmove>
  100271:	83 c4 10             	add    $0x10,%esp
  100274:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  10027b:	eb 15                	jmp    100292 <video_putc+0x199>
  10027d:	a1 04 80 10 00       	mov    0x108004,%eax
  100282:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100285:	01 d2                	add    %edx,%edx
  100287:	01 d0                	add    %edx,%eax
  100289:	66 c7 00 20 07       	movw   $0x720,(%eax)
  10028e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100292:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  100299:	7e e2                	jle    10027d <video_putc+0x184>
  10029b:	0f b7 05 08 80 10 00 	movzwl 0x108008,%eax
  1002a2:	83 e8 50             	sub    $0x50,%eax
  1002a5:	66 a3 08 80 10 00    	mov    %ax,0x108008
  1002ab:	a1 00 80 10 00       	mov    0x108000,%eax
  1002b0:	83 ec 08             	sub    $0x8,%esp
  1002b3:	6a 0e                	push   $0xe
  1002b5:	50                   	push   %eax
  1002b6:	e8 a4 1d 00 00       	call   10205f <outb>
  1002bb:	83 c4 10             	add    $0x10,%esp
  1002be:	0f b7 05 08 80 10 00 	movzwl 0x108008,%eax
  1002c5:	66 c1 e8 08          	shr    $0x8,%ax
  1002c9:	0f b6 c0             	movzbl %al,%eax
  1002cc:	8b 15 00 80 10 00    	mov    0x108000,%edx
  1002d2:	83 c2 01             	add    $0x1,%edx
  1002d5:	83 ec 08             	sub    $0x8,%esp
  1002d8:	50                   	push   %eax
  1002d9:	52                   	push   %edx
  1002da:	e8 80 1d 00 00       	call   10205f <outb>
  1002df:	83 c4 10             	add    $0x10,%esp
  1002e2:	a1 00 80 10 00       	mov    0x108000,%eax
  1002e7:	83 ec 08             	sub    $0x8,%esp
  1002ea:	6a 0f                	push   $0xf
  1002ec:	50                   	push   %eax
  1002ed:	e8 6d 1d 00 00       	call   10205f <outb>
  1002f2:	83 c4 10             	add    $0x10,%esp
  1002f5:	0f b7 05 08 80 10 00 	movzwl 0x108008,%eax
  1002fc:	0f b6 c0             	movzbl %al,%eax
  1002ff:	8b 15 00 80 10 00    	mov    0x108000,%edx
  100305:	83 c2 01             	add    $0x1,%edx
  100308:	83 ec 08             	sub    $0x8,%esp
  10030b:	50                   	push   %eax
  10030c:	52                   	push   %edx
  10030d:	e8 4d 1d 00 00       	call   10205f <outb>
  100312:	83 c4 10             	add    $0x10,%esp
  100315:	90                   	nop
  100316:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100319:	c9                   	leave  
  10031a:	c3                   	ret    

0010031b <video_set_cursor>:
  10031b:	55                   	push   %ebp
  10031c:	89 e5                	mov    %esp,%ebp
  10031e:	8b 45 08             	mov    0x8(%ebp),%eax
  100321:	89 c2                	mov    %eax,%edx
  100323:	89 d0                	mov    %edx,%eax
  100325:	c1 e0 02             	shl    $0x2,%eax
  100328:	01 d0                	add    %edx,%eax
  10032a:	c1 e0 04             	shl    $0x4,%eax
  10032d:	89 c2                	mov    %eax,%edx
  10032f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100332:	01 d0                	add    %edx,%eax
  100334:	66 a3 08 80 10 00    	mov    %ax,0x108008
  10033a:	90                   	nop
  10033b:	5d                   	pop    %ebp
  10033c:	c3                   	ret    

0010033d <video_clear_screen>:
  10033d:	55                   	push   %ebp
  10033e:	89 e5                	mov    %esp,%ebp
  100340:	83 ec 10             	sub    $0x10,%esp
  100343:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10034a:	eb 15                	jmp    100361 <video_clear_screen+0x24>
  10034c:	a1 04 80 10 00       	mov    0x108004,%eax
  100351:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100354:	01 d2                	add    %edx,%edx
  100356:	01 d0                	add    %edx,%eax
  100358:	66 c7 00 20 00       	movw   $0x20,(%eax)
  10035d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100361:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%ebp)
  100368:	7e e2                	jle    10034c <video_clear_screen+0xf>
  10036a:	90                   	nop
  10036b:	90                   	nop
  10036c:	c9                   	leave  
  10036d:	c3                   	ret    

0010036e <cons_init>:
  10036e:	55                   	push   %ebp
  10036f:	89 e5                	mov    %esp,%ebp
  100371:	83 ec 08             	sub    $0x8,%esp
  100374:	83 ec 04             	sub    $0x4,%esp
  100377:	68 08 02 00 00       	push   $0x208
  10037c:	6a 00                	push   $0x0
  10037e:	68 20 80 10 00       	push   $0x108020
  100383:	e8 03 0c 00 00       	call   100f8b <memset>
  100388:	83 c4 10             	add    $0x10,%esp
  10038b:	e8 7e 03 00 00       	call   10070e <serial_init>
  100390:	e8 6b fc ff ff       	call   100000 <video_init>
  100395:	90                   	nop
  100396:	c9                   	leave  
  100397:	c3                   	ret    

00100398 <cons_intr>:
  100398:	55                   	push   %ebp
  100399:	89 e5                	mov    %esp,%ebp
  10039b:	83 ec 18             	sub    $0x18,%esp
  10039e:	eb 36                	jmp    1003d6 <cons_intr+0x3e>
  1003a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003a4:	74 2f                	je     1003d5 <cons_intr+0x3d>
  1003a6:	a1 24 82 10 00       	mov    0x108224,%eax
  1003ab:	8d 50 01             	lea    0x1(%eax),%edx
  1003ae:	89 15 24 82 10 00    	mov    %edx,0x108224
  1003b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1003b7:	88 90 20 80 10 00    	mov    %dl,0x108020(%eax)
  1003bd:	a1 24 82 10 00       	mov    0x108224,%eax
  1003c2:	3d 00 02 00 00       	cmp    $0x200,%eax
  1003c7:	75 0d                	jne    1003d6 <cons_intr+0x3e>
  1003c9:	c7 05 24 82 10 00 00 	movl   $0x0,0x108224
  1003d0:	00 00 00 
  1003d3:	eb 01                	jmp    1003d6 <cons_intr+0x3e>
  1003d5:	90                   	nop
  1003d6:	8b 45 08             	mov    0x8(%ebp),%eax
  1003d9:	ff d0                	call   *%eax
  1003db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003de:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1003e2:	75 bc                	jne    1003a0 <cons_intr+0x8>
  1003e4:	90                   	nop
  1003e5:	90                   	nop
  1003e6:	c9                   	leave  
  1003e7:	c3                   	ret    

001003e8 <cons_getc>:
  1003e8:	55                   	push   %ebp
  1003e9:	89 e5                	mov    %esp,%ebp
  1003eb:	83 ec 18             	sub    $0x18,%esp
  1003ee:	e8 21 02 00 00       	call   100614 <serial_intr>
  1003f3:	e8 86 05 00 00       	call   10097e <keyboard_intr>
  1003f8:	8b 15 20 82 10 00    	mov    0x108220,%edx
  1003fe:	a1 24 82 10 00       	mov    0x108224,%eax
  100403:	39 c2                	cmp    %eax,%edx
  100405:	74 36                	je     10043d <cons_getc+0x55>
  100407:	a1 20 82 10 00       	mov    0x108220,%eax
  10040c:	8d 50 01             	lea    0x1(%eax),%edx
  10040f:	89 15 20 82 10 00    	mov    %edx,0x108220
  100415:	0f b6 80 20 80 10 00 	movzbl 0x108020(%eax),%eax
  10041c:	0f be c0             	movsbl %al,%eax
  10041f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100422:	a1 20 82 10 00       	mov    0x108220,%eax
  100427:	3d 00 02 00 00       	cmp    $0x200,%eax
  10042c:	75 0a                	jne    100438 <cons_getc+0x50>
  10042e:	c7 05 20 82 10 00 00 	movl   $0x0,0x108220
  100435:	00 00 00 
  100438:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10043b:	eb 05                	jmp    100442 <cons_getc+0x5a>
  10043d:	b8 00 00 00 00       	mov    $0x0,%eax
  100442:	c9                   	leave  
  100443:	c3                   	ret    

00100444 <cons_putc>:
  100444:	55                   	push   %ebp
  100445:	89 e5                	mov    %esp,%ebp
  100447:	83 ec 18             	sub    $0x18,%esp
  10044a:	8b 45 08             	mov    0x8(%ebp),%eax
  10044d:	88 45 f4             	mov    %al,-0xc(%ebp)
  100450:	0f be 45 f4          	movsbl -0xc(%ebp),%eax
  100454:	83 ec 0c             	sub    $0xc,%esp
  100457:	50                   	push   %eax
  100458:	e8 2f 02 00 00       	call   10068c <serial_putc>
  10045d:	83 c4 10             	add    $0x10,%esp
  100460:	0f be 45 f4          	movsbl -0xc(%ebp),%eax
  100464:	83 ec 0c             	sub    $0xc,%esp
  100467:	50                   	push   %eax
  100468:	e8 8c fc ff ff       	call   1000f9 <video_putc>
  10046d:	83 c4 10             	add    $0x10,%esp
  100470:	90                   	nop
  100471:	c9                   	leave  
  100472:	c3                   	ret    

00100473 <getchar>:
  100473:	55                   	push   %ebp
  100474:	89 e5                	mov    %esp,%ebp
  100476:	83 ec 18             	sub    $0x18,%esp
  100479:	90                   	nop
  10047a:	e8 69 ff ff ff       	call   1003e8 <cons_getc>
  10047f:	88 45 f7             	mov    %al,-0x9(%ebp)
  100482:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  100486:	74 f2                	je     10047a <getchar+0x7>
  100488:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  10048c:	c9                   	leave  
  10048d:	c3                   	ret    

0010048e <putchar>:
  10048e:	55                   	push   %ebp
  10048f:	89 e5                	mov    %esp,%ebp
  100491:	83 ec 18             	sub    $0x18,%esp
  100494:	8b 45 08             	mov    0x8(%ebp),%eax
  100497:	88 45 f4             	mov    %al,-0xc(%ebp)
  10049a:	0f be 45 f4          	movsbl -0xc(%ebp),%eax
  10049e:	83 ec 0c             	sub    $0xc,%esp
  1004a1:	50                   	push   %eax
  1004a2:	e8 9d ff ff ff       	call   100444 <cons_putc>
  1004a7:	83 c4 10             	add    $0x10,%esp
  1004aa:	90                   	nop
  1004ab:	c9                   	leave  
  1004ac:	c3                   	ret    

001004ad <readline>:
  1004ad:	55                   	push   %ebp
  1004ae:	89 e5                	mov    %esp,%ebp
  1004b0:	83 ec 18             	sub    $0x18,%esp
  1004b3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1004b7:	74 13                	je     1004cc <readline+0x1f>
  1004b9:	83 ec 08             	sub    $0x8,%esp
  1004bc:	ff 75 08             	push   0x8(%ebp)
  1004bf:	68 0e 40 10 00       	push   $0x10400e
  1004c4:	e8 b7 0f 00 00       	call   101480 <dprintf>
  1004c9:	83 c4 10             	add    $0x10,%esp
  1004cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1004d3:	e8 9b ff ff ff       	call   100473 <getchar>
  1004d8:	88 45 f3             	mov    %al,-0xd(%ebp)
  1004db:	80 7d f3 00          	cmpb   $0x0,-0xd(%ebp)
  1004df:	79 1f                	jns    100500 <readline+0x53>
  1004e1:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  1004e5:	83 ec 08             	sub    $0x8,%esp
  1004e8:	50                   	push   %eax
  1004e9:	68 11 40 10 00       	push   $0x104011
  1004ee:	e8 8d 0f 00 00       	call   101480 <dprintf>
  1004f3:	83 c4 10             	add    $0x10,%esp
  1004f6:	b8 00 00 00 00       	mov    $0x0,%eax
  1004fb:	e9 8d 00 00 00       	jmp    10058d <readline+0xe0>
  100500:	80 7d f3 08          	cmpb   $0x8,-0xd(%ebp)
  100504:	74 06                	je     10050c <readline+0x5f>
  100506:	80 7d f3 7f          	cmpb   $0x7f,-0xd(%ebp)
  10050a:	75 19                	jne    100525 <readline+0x78>
  10050c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100510:	7e 13                	jle    100525 <readline+0x78>
  100512:	83 ec 0c             	sub    $0xc,%esp
  100515:	6a 08                	push   $0x8
  100517:	e8 72 ff ff ff       	call   10048e <putchar>
  10051c:	83 c4 10             	add    $0x10,%esp
  10051f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  100523:	eb 63                	jmp    100588 <readline+0xdb>
  100525:	80 7d f3 1f          	cmpb   $0x1f,-0xd(%ebp)
  100529:	7e 2e                	jle    100559 <readline+0xac>
  10052b:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100532:	7f 25                	jg     100559 <readline+0xac>
  100534:	0f be 45 f3          	movsbl -0xd(%ebp),%eax
  100538:	83 ec 0c             	sub    $0xc,%esp
  10053b:	50                   	push   %eax
  10053c:	e8 4d ff ff ff       	call   10048e <putchar>
  100541:	83 c4 10             	add    $0x10,%esp
  100544:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100547:	8d 50 01             	lea    0x1(%eax),%edx
  10054a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10054d:	0f b6 55 f3          	movzbl -0xd(%ebp),%edx
  100551:	88 90 40 82 10 00    	mov    %dl,0x108240(%eax)
  100557:	eb 2f                	jmp    100588 <readline+0xdb>
  100559:	80 7d f3 0a          	cmpb   $0xa,-0xd(%ebp)
  10055d:	74 0a                	je     100569 <readline+0xbc>
  10055f:	80 7d f3 0d          	cmpb   $0xd,-0xd(%ebp)
  100563:	0f 85 6a ff ff ff    	jne    1004d3 <readline+0x26>
  100569:	83 ec 0c             	sub    $0xc,%esp
  10056c:	6a 0a                	push   $0xa
  10056e:	e8 1b ff ff ff       	call   10048e <putchar>
  100573:	83 c4 10             	add    $0x10,%esp
  100576:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100579:	05 40 82 10 00       	add    $0x108240,%eax
  10057e:	c6 00 00             	movb   $0x0,(%eax)
  100581:	b8 40 82 10 00       	mov    $0x108240,%eax
  100586:	eb 05                	jmp    10058d <readline+0xe0>
  100588:	e9 46 ff ff ff       	jmp    1004d3 <readline+0x26>
  10058d:	c9                   	leave  
  10058e:	c3                   	ret    

0010058f <delay>:
  10058f:	55                   	push   %ebp
  100590:	89 e5                	mov    %esp,%ebp
  100592:	83 ec 08             	sub    $0x8,%esp
  100595:	83 ec 0c             	sub    $0xc,%esp
  100598:	68 84 00 00 00       	push   $0x84
  10059d:	e8 82 1a 00 00       	call   102024 <inb>
  1005a2:	83 c4 10             	add    $0x10,%esp
  1005a5:	83 ec 0c             	sub    $0xc,%esp
  1005a8:	68 84 00 00 00       	push   $0x84
  1005ad:	e8 72 1a 00 00       	call   102024 <inb>
  1005b2:	83 c4 10             	add    $0x10,%esp
  1005b5:	83 ec 0c             	sub    $0xc,%esp
  1005b8:	68 84 00 00 00       	push   $0x84
  1005bd:	e8 62 1a 00 00       	call   102024 <inb>
  1005c2:	83 c4 10             	add    $0x10,%esp
  1005c5:	83 ec 0c             	sub    $0xc,%esp
  1005c8:	68 84 00 00 00       	push   $0x84
  1005cd:	e8 52 1a 00 00       	call   102024 <inb>
  1005d2:	83 c4 10             	add    $0x10,%esp
  1005d5:	90                   	nop
  1005d6:	c9                   	leave  
  1005d7:	c3                   	ret    

001005d8 <serial_proc_data>:
  1005d8:	55                   	push   %ebp
  1005d9:	89 e5                	mov    %esp,%ebp
  1005db:	83 ec 08             	sub    $0x8,%esp
  1005de:	83 ec 0c             	sub    $0xc,%esp
  1005e1:	68 fd 03 00 00       	push   $0x3fd
  1005e6:	e8 39 1a 00 00       	call   102024 <inb>
  1005eb:	83 c4 10             	add    $0x10,%esp
  1005ee:	0f b6 c0             	movzbl %al,%eax
  1005f1:	83 e0 01             	and    $0x1,%eax
  1005f4:	85 c0                	test   %eax,%eax
  1005f6:	75 07                	jne    1005ff <serial_proc_data+0x27>
  1005f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1005fd:	eb 13                	jmp    100612 <serial_proc_data+0x3a>
  1005ff:	83 ec 0c             	sub    $0xc,%esp
  100602:	68 f8 03 00 00       	push   $0x3f8
  100607:	e8 18 1a 00 00       	call   102024 <inb>
  10060c:	83 c4 10             	add    $0x10,%esp
  10060f:	0f b6 c0             	movzbl %al,%eax
  100612:	c9                   	leave  
  100613:	c3                   	ret    

00100614 <serial_intr>:
  100614:	55                   	push   %ebp
  100615:	89 e5                	mov    %esp,%ebp
  100617:	83 ec 08             	sub    $0x8,%esp
  10061a:	0f b6 05 40 86 10 00 	movzbl 0x108640,%eax
  100621:	84 c0                	test   %al,%al
  100623:	74 10                	je     100635 <serial_intr+0x21>
  100625:	83 ec 0c             	sub    $0xc,%esp
  100628:	68 d8 05 10 00       	push   $0x1005d8
  10062d:	e8 66 fd ff ff       	call   100398 <cons_intr>
  100632:	83 c4 10             	add    $0x10,%esp
  100635:	90                   	nop
  100636:	c9                   	leave  
  100637:	c3                   	ret    

00100638 <serial_reformatnewline>:
  100638:	55                   	push   %ebp
  100639:	89 e5                	mov    %esp,%ebp
  10063b:	83 ec 18             	sub    $0x18,%esp
  10063e:	c7 45 f4 0d 00 00 00 	movl   $0xd,-0xc(%ebp)
  100645:	c7 45 f0 0a 00 00 00 	movl   $0xa,-0x10(%ebp)
  10064c:	8b 45 08             	mov    0x8(%ebp),%eax
  10064f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  100652:	75 31                	jne    100685 <serial_reformatnewline+0x4d>
  100654:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100657:	0f b6 c0             	movzbl %al,%eax
  10065a:	83 ec 08             	sub    $0x8,%esp
  10065d:	50                   	push   %eax
  10065e:	ff 75 0c             	push   0xc(%ebp)
  100661:	e8 f9 19 00 00       	call   10205f <outb>
  100666:	83 c4 10             	add    $0x10,%esp
  100669:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10066c:	0f b6 c0             	movzbl %al,%eax
  10066f:	83 ec 08             	sub    $0x8,%esp
  100672:	50                   	push   %eax
  100673:	ff 75 0c             	push   0xc(%ebp)
  100676:	e8 e4 19 00 00       	call   10205f <outb>
  10067b:	83 c4 10             	add    $0x10,%esp
  10067e:	b8 01 00 00 00       	mov    $0x1,%eax
  100683:	eb 05                	jmp    10068a <serial_reformatnewline+0x52>
  100685:	b8 00 00 00 00       	mov    $0x0,%eax
  10068a:	c9                   	leave  
  10068b:	c3                   	ret    

0010068c <serial_putc>:
  10068c:	55                   	push   %ebp
  10068d:	89 e5                	mov    %esp,%ebp
  10068f:	83 ec 28             	sub    $0x28,%esp
  100692:	8b 45 08             	mov    0x8(%ebp),%eax
  100695:	88 45 e4             	mov    %al,-0x1c(%ebp)
  100698:	0f b6 05 40 86 10 00 	movzbl 0x108640,%eax
  10069f:	84 c0                	test   %al,%al
  1006a1:	74 68                	je     10070b <serial_putc+0x7f>
  1006a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1006aa:	eb 09                	jmp    1006b5 <serial_putc+0x29>
  1006ac:	e8 de fe ff ff       	call   10058f <delay>
  1006b1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1006b5:	83 ec 0c             	sub    $0xc,%esp
  1006b8:	68 fd 03 00 00       	push   $0x3fd
  1006bd:	e8 62 19 00 00       	call   102024 <inb>
  1006c2:	83 c4 10             	add    $0x10,%esp
  1006c5:	0f b6 c0             	movzbl %al,%eax
  1006c8:	83 e0 20             	and    $0x20,%eax
  1006cb:	85 c0                	test   %eax,%eax
  1006cd:	75 09                	jne    1006d8 <serial_putc+0x4c>
  1006cf:	81 7d f4 ff 31 00 00 	cmpl   $0x31ff,-0xc(%ebp)
  1006d6:	7e d4                	jle    1006ac <serial_putc+0x20>
  1006d8:	0f be 45 e4          	movsbl -0x1c(%ebp),%eax
  1006dc:	83 ec 08             	sub    $0x8,%esp
  1006df:	68 f8 03 00 00       	push   $0x3f8
  1006e4:	50                   	push   %eax
  1006e5:	e8 4e ff ff ff       	call   100638 <serial_reformatnewline>
  1006ea:	83 c4 10             	add    $0x10,%esp
  1006ed:	85 c0                	test   %eax,%eax
  1006ef:	75 1b                	jne    10070c <serial_putc+0x80>
  1006f1:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
  1006f5:	0f b6 c0             	movzbl %al,%eax
  1006f8:	83 ec 08             	sub    $0x8,%esp
  1006fb:	50                   	push   %eax
  1006fc:	68 f8 03 00 00       	push   $0x3f8
  100701:	e8 59 19 00 00       	call   10205f <outb>
  100706:	83 c4 10             	add    $0x10,%esp
  100709:	eb 01                	jmp    10070c <serial_putc+0x80>
  10070b:	90                   	nop
  10070c:	c9                   	leave  
  10070d:	c3                   	ret    

0010070e <serial_init>:
  10070e:	55                   	push   %ebp
  10070f:	89 e5                	mov    %esp,%ebp
  100711:	83 ec 08             	sub    $0x8,%esp
  100714:	83 ec 08             	sub    $0x8,%esp
  100717:	6a 00                	push   $0x0
  100719:	68 f9 03 00 00       	push   $0x3f9
  10071e:	e8 3c 19 00 00       	call   10205f <outb>
  100723:	83 c4 10             	add    $0x10,%esp
  100726:	83 ec 08             	sub    $0x8,%esp
  100729:	68 80 00 00 00       	push   $0x80
  10072e:	68 fb 03 00 00       	push   $0x3fb
  100733:	e8 27 19 00 00       	call   10205f <outb>
  100738:	83 c4 10             	add    $0x10,%esp
  10073b:	83 ec 08             	sub    $0x8,%esp
  10073e:	6a 01                	push   $0x1
  100740:	68 f8 03 00 00       	push   $0x3f8
  100745:	e8 15 19 00 00       	call   10205f <outb>
  10074a:	83 c4 10             	add    $0x10,%esp
  10074d:	83 ec 08             	sub    $0x8,%esp
  100750:	6a 00                	push   $0x0
  100752:	68 f9 03 00 00       	push   $0x3f9
  100757:	e8 03 19 00 00       	call   10205f <outb>
  10075c:	83 c4 10             	add    $0x10,%esp
  10075f:	83 ec 08             	sub    $0x8,%esp
  100762:	6a 03                	push   $0x3
  100764:	68 fb 03 00 00       	push   $0x3fb
  100769:	e8 f1 18 00 00       	call   10205f <outb>
  10076e:	83 c4 10             	add    $0x10,%esp
  100771:	83 ec 08             	sub    $0x8,%esp
  100774:	68 c7 00 00 00       	push   $0xc7
  100779:	68 fa 03 00 00       	push   $0x3fa
  10077e:	e8 dc 18 00 00       	call   10205f <outb>
  100783:	83 c4 10             	add    $0x10,%esp
  100786:	83 ec 08             	sub    $0x8,%esp
  100789:	6a 0b                	push   $0xb
  10078b:	68 fc 03 00 00       	push   $0x3fc
  100790:	e8 ca 18 00 00       	call   10205f <outb>
  100795:	83 c4 10             	add    $0x10,%esp
  100798:	83 ec 0c             	sub    $0xc,%esp
  10079b:	68 fd 03 00 00       	push   $0x3fd
  1007a0:	e8 7f 18 00 00       	call   102024 <inb>
  1007a5:	83 c4 10             	add    $0x10,%esp
  1007a8:	3c ff                	cmp    $0xff,%al
  1007aa:	0f 95 c0             	setne  %al
  1007ad:	a2 40 86 10 00       	mov    %al,0x108640
  1007b2:	83 ec 0c             	sub    $0xc,%esp
  1007b5:	68 fa 03 00 00       	push   $0x3fa
  1007ba:	e8 65 18 00 00       	call   102024 <inb>
  1007bf:	83 c4 10             	add    $0x10,%esp
  1007c2:	83 ec 0c             	sub    $0xc,%esp
  1007c5:	68 f8 03 00 00       	push   $0x3f8
  1007ca:	e8 55 18 00 00       	call   102024 <inb>
  1007cf:	83 c4 10             	add    $0x10,%esp
  1007d2:	90                   	nop
  1007d3:	c9                   	leave  
  1007d4:	c3                   	ret    

001007d5 <serial_intenable>:
  1007d5:	55                   	push   %ebp
  1007d6:	89 e5                	mov    %esp,%ebp
  1007d8:	83 ec 08             	sub    $0x8,%esp
  1007db:	0f b6 05 40 86 10 00 	movzbl 0x108640,%eax
  1007e2:	84 c0                	test   %al,%al
  1007e4:	74 17                	je     1007fd <serial_intenable+0x28>
  1007e6:	83 ec 08             	sub    $0x8,%esp
  1007e9:	6a 01                	push   $0x1
  1007eb:	68 f9 03 00 00       	push   $0x3f9
  1007f0:	e8 6a 18 00 00       	call   10205f <outb>
  1007f5:	83 c4 10             	add    $0x10,%esp
  1007f8:	e8 17 fe ff ff       	call   100614 <serial_intr>
  1007fd:	90                   	nop
  1007fe:	c9                   	leave  
  1007ff:	c3                   	ret    

00100800 <kbd_proc_data>:
  100800:	55                   	push   %ebp
  100801:	89 e5                	mov    %esp,%ebp
  100803:	83 ec 18             	sub    $0x18,%esp
  100806:	83 ec 0c             	sub    $0xc,%esp
  100809:	6a 64                	push   $0x64
  10080b:	e8 14 18 00 00       	call   102024 <inb>
  100810:	83 c4 10             	add    $0x10,%esp
  100813:	0f b6 c0             	movzbl %al,%eax
  100816:	83 e0 01             	and    $0x1,%eax
  100819:	85 c0                	test   %eax,%eax
  10081b:	75 0a                	jne    100827 <kbd_proc_data+0x27>
  10081d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100822:	e9 55 01 00 00       	jmp    10097c <kbd_proc_data+0x17c>
  100827:	83 ec 0c             	sub    $0xc,%esp
  10082a:	6a 60                	push   $0x60
  10082c:	e8 f3 17 00 00       	call   102024 <inb>
  100831:	83 c4 10             	add    $0x10,%esp
  100834:	88 45 f3             	mov    %al,-0xd(%ebp)
  100837:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  10083b:	75 17                	jne    100854 <kbd_proc_data+0x54>
  10083d:	a1 44 86 10 00       	mov    0x108644,%eax
  100842:	83 c8 40             	or     $0x40,%eax
  100845:	a3 44 86 10 00       	mov    %eax,0x108644
  10084a:	b8 00 00 00 00       	mov    $0x0,%eax
  10084f:	e9 28 01 00 00       	jmp    10097c <kbd_proc_data+0x17c>
  100854:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  100858:	84 c0                	test   %al,%al
  10085a:	79 47                	jns    1008a3 <kbd_proc_data+0xa3>
  10085c:	a1 44 86 10 00       	mov    0x108644,%eax
  100861:	83 e0 40             	and    $0x40,%eax
  100864:	85 c0                	test   %eax,%eax
  100866:	75 09                	jne    100871 <kbd_proc_data+0x71>
  100868:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10086c:	83 e0 7f             	and    $0x7f,%eax
  10086f:	eb 04                	jmp    100875 <kbd_proc_data+0x75>
  100871:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  100875:	88 45 f3             	mov    %al,-0xd(%ebp)
  100878:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10087c:	0f b6 80 00 70 10 00 	movzbl 0x107000(%eax),%eax
  100883:	83 c8 40             	or     $0x40,%eax
  100886:	0f b6 c0             	movzbl %al,%eax
  100889:	f7 d0                	not    %eax
  10088b:	89 c2                	mov    %eax,%edx
  10088d:	a1 44 86 10 00       	mov    0x108644,%eax
  100892:	21 d0                	and    %edx,%eax
  100894:	a3 44 86 10 00       	mov    %eax,0x108644
  100899:	b8 00 00 00 00       	mov    $0x0,%eax
  10089e:	e9 d9 00 00 00       	jmp    10097c <kbd_proc_data+0x17c>
  1008a3:	a1 44 86 10 00       	mov    0x108644,%eax
  1008a8:	83 e0 40             	and    $0x40,%eax
  1008ab:	85 c0                	test   %eax,%eax
  1008ad:	74 11                	je     1008c0 <kbd_proc_data+0xc0>
  1008af:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
  1008b3:	a1 44 86 10 00       	mov    0x108644,%eax
  1008b8:	83 e0 bf             	and    $0xffffffbf,%eax
  1008bb:	a3 44 86 10 00       	mov    %eax,0x108644
  1008c0:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1008c4:	0f b6 80 00 70 10 00 	movzbl 0x107000(%eax),%eax
  1008cb:	0f b6 d0             	movzbl %al,%edx
  1008ce:	a1 44 86 10 00       	mov    0x108644,%eax
  1008d3:	09 d0                	or     %edx,%eax
  1008d5:	a3 44 86 10 00       	mov    %eax,0x108644
  1008da:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1008de:	0f b6 80 00 71 10 00 	movzbl 0x107100(%eax),%eax
  1008e5:	0f b6 d0             	movzbl %al,%edx
  1008e8:	a1 44 86 10 00       	mov    0x108644,%eax
  1008ed:	31 d0                	xor    %edx,%eax
  1008ef:	a3 44 86 10 00       	mov    %eax,0x108644
  1008f4:	a1 44 86 10 00       	mov    0x108644,%eax
  1008f9:	83 e0 03             	and    $0x3,%eax
  1008fc:	8b 14 85 00 75 10 00 	mov    0x107500(,%eax,4),%edx
  100903:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  100907:	01 d0                	add    %edx,%eax
  100909:	0f b6 00             	movzbl (%eax),%eax
  10090c:	0f b6 c0             	movzbl %al,%eax
  10090f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100912:	a1 44 86 10 00       	mov    0x108644,%eax
  100917:	83 e0 08             	and    $0x8,%eax
  10091a:	85 c0                	test   %eax,%eax
  10091c:	74 22                	je     100940 <kbd_proc_data+0x140>
  10091e:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  100922:	7e 0c                	jle    100930 <kbd_proc_data+0x130>
  100924:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  100928:	7f 06                	jg     100930 <kbd_proc_data+0x130>
  10092a:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  10092e:	eb 10                	jmp    100940 <kbd_proc_data+0x140>
  100930:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  100934:	7e 0a                	jle    100940 <kbd_proc_data+0x140>
  100936:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  10093a:	7f 04                	jg     100940 <kbd_proc_data+0x140>
  10093c:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
  100940:	a1 44 86 10 00       	mov    0x108644,%eax
  100945:	f7 d0                	not    %eax
  100947:	83 e0 06             	and    $0x6,%eax
  10094a:	85 c0                	test   %eax,%eax
  10094c:	75 2b                	jne    100979 <kbd_proc_data+0x179>
  10094e:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  100955:	75 22                	jne    100979 <kbd_proc_data+0x179>
  100957:	83 ec 0c             	sub    $0xc,%esp
  10095a:	68 21 40 10 00       	push   $0x104021
  10095f:	e8 1c 0b 00 00       	call   101480 <dprintf>
  100964:	83 c4 10             	add    $0x10,%esp
  100967:	83 ec 08             	sub    $0x8,%esp
  10096a:	6a 03                	push   $0x3
  10096c:	68 92 00 00 00       	push   $0x92
  100971:	e8 e9 16 00 00       	call   10205f <outb>
  100976:	83 c4 10             	add    $0x10,%esp
  100979:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10097c:	c9                   	leave  
  10097d:	c3                   	ret    

0010097e <keyboard_intr>:
  10097e:	55                   	push   %ebp
  10097f:	89 e5                	mov    %esp,%ebp
  100981:	83 ec 08             	sub    $0x8,%esp
  100984:	83 ec 0c             	sub    $0xc,%esp
  100987:	68 00 08 10 00       	push   $0x100800
  10098c:	e8 07 fa ff ff       	call   100398 <cons_intr>
  100991:	83 c4 10             	add    $0x10,%esp
  100994:	90                   	nop
  100995:	c9                   	leave  
  100996:	c3                   	ret    

00100997 <devinit>:
  100997:	55                   	push   %ebp
  100998:	89 e5                	mov    %esp,%ebp
  10099a:	83 ec 08             	sub    $0x8,%esp
  10099d:	e8 80 0f 00 00       	call   101922 <seg_init>
  1009a2:	e8 43 15 00 00       	call   101eea <enable_sse>
  1009a7:	e8 c2 f9 ff ff       	call   10036e <cons_init>
  1009ac:	83 ec 04             	sub    $0x4,%esp
  1009af:	68 2d 40 10 00       	push   $0x10402d
  1009b4:	6a 10                	push   $0x10
  1009b6:	68 40 40 10 00       	push   $0x104040
  1009bb:	e8 59 08 00 00       	call   101219 <debug_normal>
  1009c0:	83 c4 10             	add    $0x10,%esp
  1009c3:	ff 75 08             	push   0x8(%ebp)
  1009c6:	68 53 40 10 00       	push   $0x104053
  1009cb:	6a 11                	push   $0x11
  1009cd:	68 40 40 10 00       	push   $0x104040
  1009d2:	e8 42 08 00 00       	call   101219 <debug_normal>
  1009d7:	83 c4 10             	add    $0x10,%esp
  1009da:	83 ec 0c             	sub    $0xc,%esp
  1009dd:	ff 75 08             	push   0x8(%ebp)
  1009e0:	e8 4b 03 00 00       	call   100d30 <pmmap_init>
  1009e5:	83 c4 10             	add    $0x10,%esp
  1009e8:	90                   	nop
  1009e9:	c9                   	leave  
  1009ea:	c3                   	ret    

001009eb <pmmap_alloc_slot>:
  1009eb:	55                   	push   %ebp
  1009ec:	89 e5                	mov    %esp,%ebp
  1009ee:	a1 60 90 10 00       	mov    0x109060,%eax
  1009f3:	3d 80 00 00 00       	cmp    $0x80,%eax
  1009f8:	0f 94 c0             	sete   %al
  1009fb:	0f b6 c0             	movzbl %al,%eax
  1009fe:	85 c0                	test   %eax,%eax
  100a00:	74 07                	je     100a09 <pmmap_alloc_slot+0x1e>
  100a02:	b8 00 00 00 00       	mov    $0x0,%eax
  100a07:	eb 1d                	jmp    100a26 <pmmap_alloc_slot+0x3b>
  100a09:	8b 15 60 90 10 00    	mov    0x109060,%edx
  100a0f:	8d 42 01             	lea    0x1(%edx),%eax
  100a12:	a3 60 90 10 00       	mov    %eax,0x109060
  100a17:	89 d0                	mov    %edx,%eax
  100a19:	c1 e0 02             	shl    $0x2,%eax
  100a1c:	01 d0                	add    %edx,%eax
  100a1e:	c1 e0 02             	shl    $0x2,%eax
  100a21:	05 60 86 10 00       	add    $0x108660,%eax
  100a26:	5d                   	pop    %ebp
  100a27:	c3                   	ret    

00100a28 <pmmap_insert>:
  100a28:	55                   	push   %ebp
  100a29:	89 e5                	mov    %esp,%ebp
  100a2b:	83 ec 18             	sub    $0x18,%esp
  100a2e:	e8 b8 ff ff ff       	call   1009eb <pmmap_alloc_slot>
  100a33:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100a36:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  100a3a:	75 17                	jne    100a53 <pmmap_insert+0x2b>
  100a3c:	83 ec 04             	sub    $0x4,%esp
  100a3f:	68 6c 40 10 00       	push   $0x10406c
  100a44:	6a 3b                	push   $0x3b
  100a46:	68 89 40 10 00       	push   $0x104089
  100a4b:	e8 69 08 00 00       	call   1012b9 <debug_panic>
  100a50:	83 c4 10             	add    $0x10,%esp
  100a53:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a56:	8b 55 08             	mov    0x8(%ebp),%edx
  100a59:	89 10                	mov    %edx,(%eax)
  100a5b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  100a61:	89 50 04             	mov    %edx,0x4(%eax)
  100a64:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a67:	8b 55 10             	mov    0x10(%ebp),%edx
  100a6a:	89 50 08             	mov    %edx,0x8(%eax)
  100a6d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  100a74:	a1 64 90 10 00       	mov    0x109064,%eax
  100a79:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100a7c:	eb 19                	jmp    100a97 <pmmap_insert+0x6f>
  100a7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a81:	8b 00                	mov    (%eax),%eax
  100a83:	39 45 08             	cmp    %eax,0x8(%ebp)
  100a86:	72 17                	jb     100a9f <pmmap_insert+0x77>
  100a88:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a8b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  100a8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a91:	8b 40 0c             	mov    0xc(%eax),%eax
  100a94:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100a97:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100a9b:	75 e1                	jne    100a7e <pmmap_insert+0x56>
  100a9d:	eb 01                	jmp    100aa0 <pmmap_insert+0x78>
  100a9f:	90                   	nop
  100aa0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100aa4:	75 16                	jne    100abc <pmmap_insert+0x94>
  100aa6:	8b 15 64 90 10 00    	mov    0x109064,%edx
  100aac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100aaf:	89 50 0c             	mov    %edx,0xc(%eax)
  100ab2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100ab5:	a3 64 90 10 00       	mov    %eax,0x109064
  100aba:	eb 15                	jmp    100ad1 <pmmap_insert+0xa9>
  100abc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100abf:	8b 50 0c             	mov    0xc(%eax),%edx
  100ac2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100ac5:	89 50 0c             	mov    %edx,0xc(%eax)
  100ac8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100acb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  100ace:	89 50 0c             	mov    %edx,0xc(%eax)
  100ad1:	90                   	nop
  100ad2:	c9                   	leave  
  100ad3:	c3                   	ret    

00100ad4 <pmmap_merge>:
  100ad4:	55                   	push   %ebp
  100ad5:	89 e5                	mov    %esp,%ebp
  100ad7:	83 ec 28             	sub    $0x28,%esp
  100ada:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  100ae1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  100ae8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  100aef:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100af6:	a1 64 90 10 00       	mov    0x109064,%eax
  100afb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100afe:	eb 73                	jmp    100b73 <pmmap_merge+0x9f>
  100b00:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b03:	8b 40 0c             	mov    0xc(%eax),%eax
  100b06:	89 45 f0             	mov    %eax,-0x10(%ebp)
  100b09:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100b0d:	74 6c                	je     100b7b <pmmap_merge+0xa7>
  100b0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b12:	8b 00                	mov    (%eax),%eax
  100b14:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100b17:	8b 12                	mov    (%edx),%edx
  100b19:	39 c2                	cmp    %eax,%edx
  100b1b:	72 4d                	jb     100b6a <pmmap_merge+0x96>
  100b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b20:	8b 50 04             	mov    0x4(%eax),%edx
  100b23:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b26:	8b 00                	mov    (%eax),%eax
  100b28:	39 c2                	cmp    %eax,%edx
  100b2a:	72 3e                	jb     100b6a <pmmap_merge+0x96>
  100b2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b2f:	8b 50 08             	mov    0x8(%eax),%edx
  100b32:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b35:	8b 40 08             	mov    0x8(%eax),%eax
  100b38:	39 c2                	cmp    %eax,%edx
  100b3a:	75 2e                	jne    100b6a <pmmap_merge+0x96>
  100b3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b3f:	8b 50 04             	mov    0x4(%eax),%edx
  100b42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b45:	8b 40 04             	mov    0x4(%eax),%eax
  100b48:	83 ec 08             	sub    $0x8,%esp
  100b4b:	52                   	push   %edx
  100b4c:	50                   	push   %eax
  100b4d:	e8 c9 12 00 00       	call   101e1b <max>
  100b52:	83 c4 10             	add    $0x10,%esp
  100b55:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b58:	89 42 04             	mov    %eax,0x4(%edx)
  100b5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b5e:	8b 40 0c             	mov    0xc(%eax),%eax
  100b61:	8b 50 0c             	mov    0xc(%eax),%edx
  100b64:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b67:	89 50 0c             	mov    %edx,0xc(%eax)
  100b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b6d:	8b 40 0c             	mov    0xc(%eax),%eax
  100b70:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100b73:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b77:	75 87                	jne    100b00 <pmmap_merge+0x2c>
  100b79:	eb 01                	jmp    100b7c <pmmap_merge+0xa8>
  100b7b:	90                   	nop
  100b7c:	a1 64 90 10 00       	mov    0x109064,%eax
  100b81:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100b84:	e9 c9 00 00 00       	jmp    100c52 <pmmap_merge+0x17e>
  100b89:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b8c:	8b 40 08             	mov    0x8(%eax),%eax
  100b8f:	83 f8 01             	cmp    $0x1,%eax
  100b92:	74 3d                	je     100bd1 <pmmap_merge+0xfd>
  100b94:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b97:	8b 40 08             	mov    0x8(%eax),%eax
  100b9a:	83 f8 02             	cmp    $0x2,%eax
  100b9d:	74 2b                	je     100bca <pmmap_merge+0xf6>
  100b9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ba2:	8b 40 08             	mov    0x8(%eax),%eax
  100ba5:	83 f8 03             	cmp    $0x3,%eax
  100ba8:	74 19                	je     100bc3 <pmmap_merge+0xef>
  100baa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bad:	8b 40 08             	mov    0x8(%eax),%eax
  100bb0:	83 f8 04             	cmp    $0x4,%eax
  100bb3:	75 07                	jne    100bbc <pmmap_merge+0xe8>
  100bb5:	b8 03 00 00 00       	mov    $0x3,%eax
  100bba:	eb 1a                	jmp    100bd6 <pmmap_merge+0x102>
  100bbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100bc1:	eb 13                	jmp    100bd6 <pmmap_merge+0x102>
  100bc3:	b8 02 00 00 00       	mov    $0x2,%eax
  100bc8:	eb 0c                	jmp    100bd6 <pmmap_merge+0x102>
  100bca:	b8 01 00 00 00       	mov    $0x1,%eax
  100bcf:	eb 05                	jmp    100bd6 <pmmap_merge+0x102>
  100bd1:	b8 00 00 00 00       	mov    $0x0,%eax
  100bd6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100bd9:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
  100bdd:	75 19                	jne    100bf8 <pmmap_merge+0x124>
  100bdf:	68 9a 40 10 00       	push   $0x10409a
  100be4:	68 ab 40 10 00       	push   $0x1040ab
  100be9:	6a 6a                	push   $0x6a
  100beb:	68 89 40 10 00       	push   $0x104089
  100bf0:	e8 c4 06 00 00       	call   1012b9 <debug_panic>
  100bf5:	83 c4 10             	add    $0x10,%esp
  100bf8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100bfb:	8b 44 85 dc          	mov    -0x24(%ebp,%eax,4),%eax
  100bff:	85 c0                	test   %eax,%eax
  100c01:	74 1f                	je     100c22 <pmmap_merge+0x14e>
  100c03:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100c06:	8b 44 85 dc          	mov    -0x24(%ebp,%eax,4),%eax
  100c0a:	8b 50 10             	mov    0x10(%eax),%edx
  100c0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c10:	89 50 10             	mov    %edx,0x10(%eax)
  100c13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100c16:	8b 44 85 dc          	mov    -0x24(%ebp,%eax,4),%eax
  100c1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c1d:	89 50 10             	mov    %edx,0x10(%eax)
  100c20:	eb 1d                	jmp    100c3f <pmmap_merge+0x16b>
  100c22:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100c25:	8b 14 85 68 90 10 00 	mov    0x109068(,%eax,4),%edx
  100c2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c2f:	89 50 10             	mov    %edx,0x10(%eax)
  100c32:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100c35:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c38:	89 14 85 68 90 10 00 	mov    %edx,0x109068(,%eax,4)
  100c3f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100c42:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c45:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
  100c49:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c4c:	8b 40 0c             	mov    0xc(%eax),%eax
  100c4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100c52:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100c56:	0f 85 2d ff ff ff    	jne    100b89 <pmmap_merge+0xb5>
  100c5c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100c5f:	85 c0                	test   %eax,%eax
  100c61:	74 0b                	je     100c6e <pmmap_merge+0x19a>
  100c63:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100c66:	8b 40 04             	mov    0x4(%eax),%eax
  100c69:	a3 78 90 10 00       	mov    %eax,0x109078
  100c6e:	90                   	nop
  100c6f:	c9                   	leave  
  100c70:	c3                   	ret    

00100c71 <pmmap_dump>:
  100c71:	55                   	push   %ebp
  100c72:	89 e5                	mov    %esp,%ebp
  100c74:	83 ec 18             	sub    $0x18,%esp
  100c77:	a1 64 90 10 00       	mov    0x109064,%eax
  100c7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100c7f:	e9 9e 00 00 00       	jmp    100d22 <pmmap_dump+0xb1>
  100c84:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c87:	8b 40 08             	mov    0x8(%eax),%eax
  100c8a:	83 f8 01             	cmp    $0x1,%eax
  100c8d:	74 3d                	je     100ccc <pmmap_dump+0x5b>
  100c8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c92:	8b 40 08             	mov    0x8(%eax),%eax
  100c95:	83 f8 02             	cmp    $0x2,%eax
  100c98:	74 2b                	je     100cc5 <pmmap_dump+0x54>
  100c9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c9d:	8b 40 08             	mov    0x8(%eax),%eax
  100ca0:	83 f8 03             	cmp    $0x3,%eax
  100ca3:	74 19                	je     100cbe <pmmap_dump+0x4d>
  100ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ca8:	8b 40 08             	mov    0x8(%eax),%eax
  100cab:	83 f8 04             	cmp    $0x4,%eax
  100cae:	75 07                	jne    100cb7 <pmmap_dump+0x46>
  100cb0:	ba c8 40 10 00       	mov    $0x1040c8,%edx
  100cb5:	eb 1a                	jmp    100cd1 <pmmap_dump+0x60>
  100cb7:	ba d1 40 10 00       	mov    $0x1040d1,%edx
  100cbc:	eb 13                	jmp    100cd1 <pmmap_dump+0x60>
  100cbe:	ba d9 40 10 00       	mov    $0x1040d9,%edx
  100cc3:	eb 0c                	jmp    100cd1 <pmmap_dump+0x60>
  100cc5:	ba e3 40 10 00       	mov    $0x1040e3,%edx
  100cca:	eb 05                	jmp    100cd1 <pmmap_dump+0x60>
  100ccc:	ba ec 40 10 00       	mov    $0x1040ec,%edx
  100cd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cd4:	8b 08                	mov    (%eax),%ecx
  100cd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cd9:	8b 40 04             	mov    0x4(%eax),%eax
  100cdc:	39 c1                	cmp    %eax,%ecx
  100cde:	75 08                	jne    100ce8 <pmmap_dump+0x77>
  100ce0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ce3:	8b 40 04             	mov    0x4(%eax),%eax
  100ce6:	eb 1c                	jmp    100d04 <pmmap_dump+0x93>
  100ce8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ceb:	8b 40 04             	mov    0x4(%eax),%eax
  100cee:	83 f8 ff             	cmp    $0xffffffff,%eax
  100cf1:	75 08                	jne    100cfb <pmmap_dump+0x8a>
  100cf3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cf6:	8b 40 04             	mov    0x4(%eax),%eax
  100cf9:	eb 09                	jmp    100d04 <pmmap_dump+0x93>
  100cfb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cfe:	8b 40 04             	mov    0x4(%eax),%eax
  100d01:	83 e8 01             	sub    $0x1,%eax
  100d04:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  100d07:	8b 09                	mov    (%ecx),%ecx
  100d09:	52                   	push   %edx
  100d0a:	50                   	push   %eax
  100d0b:	51                   	push   %ecx
  100d0c:	68 f4 40 10 00       	push   $0x1040f4
  100d11:	e8 e2 04 00 00       	call   1011f8 <debug_info>
  100d16:	83 c4 10             	add    $0x10,%esp
  100d19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d1c:	8b 40 0c             	mov    0xc(%eax),%eax
  100d1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100d22:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100d26:	0f 85 58 ff ff ff    	jne    100c84 <pmmap_dump+0x13>
  100d2c:	90                   	nop
  100d2d:	90                   	nop
  100d2e:	c9                   	leave  
  100d2f:	c3                   	ret    

00100d30 <pmmap_init>:
  100d30:	55                   	push   %ebp
  100d31:	89 e5                	mov    %esp,%ebp
  100d33:	83 ec 28             	sub    $0x28,%esp
  100d36:	83 ec 0c             	sub    $0xc,%esp
  100d39:	68 15 41 10 00       	push   $0x104115
  100d3e:	e8 b5 04 00 00       	call   1011f8 <debug_info>
  100d43:	83 c4 10             	add    $0x10,%esp
  100d46:	8b 45 08             	mov    0x8(%ebp),%eax
  100d49:	89 45 e8             	mov    %eax,-0x18(%ebp)
  100d4c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100d4f:	8b 40 30             	mov    0x30(%eax),%eax
  100d52:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100d55:	c7 05 64 90 10 00 00 	movl   $0x0,0x109064
  100d5c:	00 00 00 
  100d5f:	c7 05 68 90 10 00 00 	movl   $0x0,0x109068
  100d66:	00 00 00 
  100d69:	c7 05 6c 90 10 00 00 	movl   $0x0,0x10906c
  100d70:	00 00 00 
  100d73:	c7 05 70 90 10 00 00 	movl   $0x0,0x109070
  100d7a:	00 00 00 
  100d7d:	c7 05 74 90 10 00 00 	movl   $0x0,0x109074
  100d84:	00 00 00 
  100d87:	eb 6c                	jmp    100df5 <pmmap_init+0xc5>
  100d89:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d8c:	8b 40 08             	mov    0x8(%eax),%eax
  100d8f:	85 c0                	test   %eax,%eax
  100d91:	75 58                	jne    100deb <pmmap_init+0xbb>
  100d93:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d96:	8b 40 04             	mov    0x4(%eax),%eax
  100d99:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  100d9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d9f:	8b 40 10             	mov    0x10(%eax),%eax
  100da2:	85 c0                	test   %eax,%eax
  100da4:	75 0f                	jne    100db5 <pmmap_init+0x85>
  100da6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100da9:	8b 50 0c             	mov    0xc(%eax),%edx
  100dac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100daf:	f7 d0                	not    %eax
  100db1:	39 c2                	cmp    %eax,%edx
  100db3:	72 09                	jb     100dbe <pmmap_init+0x8e>
  100db5:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
  100dbc:	eb 0e                	jmp    100dcc <pmmap_init+0x9c>
  100dbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100dc1:	8b 50 0c             	mov    0xc(%eax),%edx
  100dc4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100dc7:	01 d0                	add    %edx,%eax
  100dc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  100dcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100dcf:	8b 40 14             	mov    0x14(%eax),%eax
  100dd2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  100dd5:	83 ec 04             	sub    $0x4,%esp
  100dd8:	ff 75 e0             	push   -0x20(%ebp)
  100ddb:	ff 75 f0             	push   -0x10(%ebp)
  100dde:	ff 75 e4             	push   -0x1c(%ebp)
  100de1:	e8 42 fc ff ff       	call   100a28 <pmmap_insert>
  100de6:	83 c4 10             	add    $0x10,%esp
  100de9:	eb 01                	jmp    100dec <pmmap_init+0xbc>
  100deb:	90                   	nop
  100dec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100def:	83 c0 18             	add    $0x18,%eax
  100df2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100df5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100df8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100dfb:	8b 40 30             	mov    0x30(%eax),%eax
  100dfe:	29 c2                	sub    %eax,%edx
  100e00:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100e03:	8b 40 2c             	mov    0x2c(%eax),%eax
  100e06:	39 c2                	cmp    %eax,%edx
  100e08:	0f 82 7b ff ff ff    	jb     100d89 <pmmap_init+0x59>
  100e0e:	e8 c1 fc ff ff       	call   100ad4 <pmmap_merge>
  100e13:	e8 59 fe ff ff       	call   100c71 <pmmap_dump>
  100e18:	a1 64 90 10 00       	mov    0x109064,%eax
  100e1d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100e20:	eb 16                	jmp    100e38 <pmmap_init+0x108>
  100e22:	a1 80 90 10 00       	mov    0x109080,%eax
  100e27:	83 c0 01             	add    $0x1,%eax
  100e2a:	a3 80 90 10 00       	mov    %eax,0x109080
  100e2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100e32:	8b 40 0c             	mov    0xc(%eax),%eax
  100e35:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100e38:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  100e3c:	75 e4                	jne    100e22 <pmmap_init+0xf2>
  100e3e:	a1 78 90 10 00       	mov    0x109078,%eax
  100e43:	83 ec 08             	sub    $0x8,%esp
  100e46:	68 00 10 00 00       	push   $0x1000
  100e4b:	50                   	push   %eax
  100e4c:	e8 ea 0f 00 00       	call   101e3b <rounddown>
  100e51:	83 c4 10             	add    $0x10,%esp
  100e54:	c1 e8 0c             	shr    $0xc,%eax
  100e57:	a3 7c 90 10 00       	mov    %eax,0x10907c
  100e5c:	90                   	nop
  100e5d:	c9                   	leave  
  100e5e:	c3                   	ret    

00100e5f <get_size>:
  100e5f:	55                   	push   %ebp
  100e60:	89 e5                	mov    %esp,%ebp
  100e62:	a1 80 90 10 00       	mov    0x109080,%eax
  100e67:	5d                   	pop    %ebp
  100e68:	c3                   	ret    

00100e69 <get_mms>:
  100e69:	55                   	push   %ebp
  100e6a:	89 e5                	mov    %esp,%ebp
  100e6c:	83 ec 10             	sub    $0x10,%esp
  100e6f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100e76:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  100e7d:	a1 64 90 10 00       	mov    0x109064,%eax
  100e82:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100e85:	eb 15                	jmp    100e9c <get_mms+0x33>
  100e87:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e8a:	3b 45 08             	cmp    0x8(%ebp),%eax
  100e8d:	74 15                	je     100ea4 <get_mms+0x3b>
  100e8f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100e93:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100e96:	8b 40 0c             	mov    0xc(%eax),%eax
  100e99:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100e9c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  100ea0:	75 e5                	jne    100e87 <get_mms+0x1e>
  100ea2:	eb 01                	jmp    100ea5 <get_mms+0x3c>
  100ea4:	90                   	nop
  100ea5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  100ea9:	74 0a                	je     100eb5 <get_mms+0x4c>
  100eab:	a1 80 90 10 00       	mov    0x109080,%eax
  100eb0:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  100eb3:	75 07                	jne    100ebc <get_mms+0x53>
  100eb5:	b8 00 00 00 00       	mov    $0x0,%eax
  100eba:	eb 05                	jmp    100ec1 <get_mms+0x58>
  100ebc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100ebf:	8b 00                	mov    (%eax),%eax
  100ec1:	c9                   	leave  
  100ec2:	c3                   	ret    

00100ec3 <get_mml>:
  100ec3:	55                   	push   %ebp
  100ec4:	89 e5                	mov    %esp,%ebp
  100ec6:	83 ec 10             	sub    $0x10,%esp
  100ec9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100ed0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  100ed7:	a1 64 90 10 00       	mov    0x109064,%eax
  100edc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100edf:	eb 15                	jmp    100ef6 <get_mml+0x33>
  100ee1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ee4:	3b 45 08             	cmp    0x8(%ebp),%eax
  100ee7:	74 15                	je     100efe <get_mml+0x3b>
  100ee9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100eed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100ef0:	8b 40 0c             	mov    0xc(%eax),%eax
  100ef3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100ef6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  100efa:	75 e5                	jne    100ee1 <get_mml+0x1e>
  100efc:	eb 01                	jmp    100eff <get_mml+0x3c>
  100efe:	90                   	nop
  100eff:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  100f03:	74 0a                	je     100f0f <get_mml+0x4c>
  100f05:	a1 80 90 10 00       	mov    0x109080,%eax
  100f0a:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  100f0d:	75 07                	jne    100f16 <get_mml+0x53>
  100f0f:	ba 00 00 00 00       	mov    $0x0,%edx
  100f14:	eb 0d                	jmp    100f23 <get_mml+0x60>
  100f16:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100f19:	8b 50 04             	mov    0x4(%eax),%edx
  100f1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100f1f:	8b 00                	mov    (%eax),%eax
  100f21:	29 c2                	sub    %eax,%edx
  100f23:	89 d0                	mov    %edx,%eax
  100f25:	c9                   	leave  
  100f26:	c3                   	ret    

00100f27 <is_usable>:
  100f27:	55                   	push   %ebp
  100f28:	89 e5                	mov    %esp,%ebp
  100f2a:	83 ec 10             	sub    $0x10,%esp
  100f2d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100f34:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  100f3b:	a1 64 90 10 00       	mov    0x109064,%eax
  100f40:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100f43:	eb 15                	jmp    100f5a <is_usable+0x33>
  100f45:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f48:	3b 45 08             	cmp    0x8(%ebp),%eax
  100f4b:	74 15                	je     100f62 <is_usable+0x3b>
  100f4d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100f51:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100f54:	8b 40 0c             	mov    0xc(%eax),%eax
  100f57:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100f5a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  100f5e:	75 e5                	jne    100f45 <is_usable+0x1e>
  100f60:	eb 01                	jmp    100f63 <is_usable+0x3c>
  100f62:	90                   	nop
  100f63:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  100f67:	74 0a                	je     100f73 <is_usable+0x4c>
  100f69:	a1 80 90 10 00       	mov    0x109080,%eax
  100f6e:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  100f71:	75 07                	jne    100f7a <is_usable+0x53>
  100f73:	b8 00 00 00 00       	mov    $0x0,%eax
  100f78:	eb 0f                	jmp    100f89 <is_usable+0x62>
  100f7a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100f7d:	8b 40 08             	mov    0x8(%eax),%eax
  100f80:	83 f8 01             	cmp    $0x1,%eax
  100f83:	0f 94 c0             	sete   %al
  100f86:	0f b6 c0             	movzbl %al,%eax
  100f89:	c9                   	leave  
  100f8a:	c3                   	ret    

00100f8b <memset>:
  100f8b:	55                   	push   %ebp
  100f8c:	89 e5                	mov    %esp,%ebp
  100f8e:	57                   	push   %edi
  100f8f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  100f93:	75 05                	jne    100f9a <memset+0xf>
  100f95:	8b 45 08             	mov    0x8(%ebp),%eax
  100f98:	eb 5c                	jmp    100ff6 <memset+0x6b>
  100f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  100f9d:	83 e0 03             	and    $0x3,%eax
  100fa0:	85 c0                	test   %eax,%eax
  100fa2:	75 41                	jne    100fe5 <memset+0x5a>
  100fa4:	8b 45 10             	mov    0x10(%ebp),%eax
  100fa7:	83 e0 03             	and    $0x3,%eax
  100faa:	85 c0                	test   %eax,%eax
  100fac:	75 37                	jne    100fe5 <memset+0x5a>
  100fae:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
  100fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  100fb8:	c1 e0 18             	shl    $0x18,%eax
  100fbb:	89 c2                	mov    %eax,%edx
  100fbd:	8b 45 0c             	mov    0xc(%ebp),%eax
  100fc0:	c1 e0 10             	shl    $0x10,%eax
  100fc3:	09 c2                	or     %eax,%edx
  100fc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  100fc8:	c1 e0 08             	shl    $0x8,%eax
  100fcb:	09 d0                	or     %edx,%eax
  100fcd:	09 45 0c             	or     %eax,0xc(%ebp)
  100fd0:	8b 45 10             	mov    0x10(%ebp),%eax
  100fd3:	c1 e8 02             	shr    $0x2,%eax
  100fd6:	89 c1                	mov    %eax,%ecx
  100fd8:	8b 55 08             	mov    0x8(%ebp),%edx
  100fdb:	8b 45 0c             	mov    0xc(%ebp),%eax
  100fde:	89 d7                	mov    %edx,%edi
  100fe0:	fc                   	cld    
  100fe1:	f3 ab                	rep stos %eax,%es:(%edi)
  100fe3:	eb 0e                	jmp    100ff3 <memset+0x68>
  100fe5:	8b 55 08             	mov    0x8(%ebp),%edx
  100fe8:	8b 45 0c             	mov    0xc(%ebp),%eax
  100feb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  100fee:	89 d7                	mov    %edx,%edi
  100ff0:	fc                   	cld    
  100ff1:	f3 aa                	rep stos %al,%es:(%edi)
  100ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  100ff6:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100ff9:	c9                   	leave  
  100ffa:	c3                   	ret    

00100ffb <memmove>:
  100ffb:	55                   	push   %ebp
  100ffc:	89 e5                	mov    %esp,%ebp
  100ffe:	57                   	push   %edi
  100fff:	56                   	push   %esi
  101000:	53                   	push   %ebx
  101001:	83 ec 10             	sub    $0x10,%esp
  101004:	8b 45 0c             	mov    0xc(%ebp),%eax
  101007:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10100a:	8b 45 08             	mov    0x8(%ebp),%eax
  10100d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  101010:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101013:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  101016:	73 6d                	jae    101085 <memmove+0x8a>
  101018:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10101b:	8b 45 10             	mov    0x10(%ebp),%eax
  10101e:	01 d0                	add    %edx,%eax
  101020:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  101023:	73 60                	jae    101085 <memmove+0x8a>
  101025:	8b 45 10             	mov    0x10(%ebp),%eax
  101028:	01 45 f0             	add    %eax,-0x10(%ebp)
  10102b:	8b 45 10             	mov    0x10(%ebp),%eax
  10102e:	01 45 ec             	add    %eax,-0x14(%ebp)
  101031:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101034:	83 e0 03             	and    $0x3,%eax
  101037:	85 c0                	test   %eax,%eax
  101039:	75 2f                	jne    10106a <memmove+0x6f>
  10103b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10103e:	83 e0 03             	and    $0x3,%eax
  101041:	85 c0                	test   %eax,%eax
  101043:	75 25                	jne    10106a <memmove+0x6f>
  101045:	8b 45 10             	mov    0x10(%ebp),%eax
  101048:	83 e0 03             	and    $0x3,%eax
  10104b:	85 c0                	test   %eax,%eax
  10104d:	75 1b                	jne    10106a <memmove+0x6f>
  10104f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101052:	83 e8 04             	sub    $0x4,%eax
  101055:	8b 55 f0             	mov    -0x10(%ebp),%edx
  101058:	83 ea 04             	sub    $0x4,%edx
  10105b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  10105e:	c1 e9 02             	shr    $0x2,%ecx
  101061:	89 c7                	mov    %eax,%edi
  101063:	89 d6                	mov    %edx,%esi
  101065:	fd                   	std    
  101066:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  101068:	eb 18                	jmp    101082 <memmove+0x87>
  10106a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10106d:	8d 50 ff             	lea    -0x1(%eax),%edx
  101070:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101073:	8d 58 ff             	lea    -0x1(%eax),%ebx
  101076:	8b 45 10             	mov    0x10(%ebp),%eax
  101079:	89 d7                	mov    %edx,%edi
  10107b:	89 de                	mov    %ebx,%esi
  10107d:	89 c1                	mov    %eax,%ecx
  10107f:	fd                   	std    
  101080:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  101082:	fc                   	cld    
  101083:	eb 45                	jmp    1010ca <memmove+0xcf>
  101085:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101088:	83 e0 03             	and    $0x3,%eax
  10108b:	85 c0                	test   %eax,%eax
  10108d:	75 2b                	jne    1010ba <memmove+0xbf>
  10108f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101092:	83 e0 03             	and    $0x3,%eax
  101095:	85 c0                	test   %eax,%eax
  101097:	75 21                	jne    1010ba <memmove+0xbf>
  101099:	8b 45 10             	mov    0x10(%ebp),%eax
  10109c:	83 e0 03             	and    $0x3,%eax
  10109f:	85 c0                	test   %eax,%eax
  1010a1:	75 17                	jne    1010ba <memmove+0xbf>
  1010a3:	8b 45 10             	mov    0x10(%ebp),%eax
  1010a6:	c1 e8 02             	shr    $0x2,%eax
  1010a9:	89 c1                	mov    %eax,%ecx
  1010ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1010ae:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1010b1:	89 c7                	mov    %eax,%edi
  1010b3:	89 d6                	mov    %edx,%esi
  1010b5:	fc                   	cld    
  1010b6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1010b8:	eb 10                	jmp    1010ca <memmove+0xcf>
  1010ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1010bd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1010c0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  1010c3:	89 c7                	mov    %eax,%edi
  1010c5:	89 d6                	mov    %edx,%esi
  1010c7:	fc                   	cld    
  1010c8:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  1010cd:	83 c4 10             	add    $0x10,%esp
  1010d0:	5b                   	pop    %ebx
  1010d1:	5e                   	pop    %esi
  1010d2:	5f                   	pop    %edi
  1010d3:	5d                   	pop    %ebp
  1010d4:	c3                   	ret    

001010d5 <memcpy>:
  1010d5:	55                   	push   %ebp
  1010d6:	89 e5                	mov    %esp,%ebp
  1010d8:	ff 75 10             	push   0x10(%ebp)
  1010db:	ff 75 0c             	push   0xc(%ebp)
  1010de:	ff 75 08             	push   0x8(%ebp)
  1010e1:	e8 15 ff ff ff       	call   100ffb <memmove>
  1010e6:	83 c4 0c             	add    $0xc,%esp
  1010e9:	c9                   	leave  
  1010ea:	c3                   	ret    

001010eb <strncmp>:
  1010eb:	55                   	push   %ebp
  1010ec:	89 e5                	mov    %esp,%ebp
  1010ee:	eb 0c                	jmp    1010fc <strncmp+0x11>
  1010f0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  1010f4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1010f8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  1010fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  101100:	74 1a                	je     10111c <strncmp+0x31>
  101102:	8b 45 08             	mov    0x8(%ebp),%eax
  101105:	0f b6 00             	movzbl (%eax),%eax
  101108:	84 c0                	test   %al,%al
  10110a:	74 10                	je     10111c <strncmp+0x31>
  10110c:	8b 45 08             	mov    0x8(%ebp),%eax
  10110f:	0f b6 10             	movzbl (%eax),%edx
  101112:	8b 45 0c             	mov    0xc(%ebp),%eax
  101115:	0f b6 00             	movzbl (%eax),%eax
  101118:	38 c2                	cmp    %al,%dl
  10111a:	74 d4                	je     1010f0 <strncmp+0x5>
  10111c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  101120:	75 07                	jne    101129 <strncmp+0x3e>
  101122:	ba 00 00 00 00       	mov    $0x0,%edx
  101127:	eb 14                	jmp    10113d <strncmp+0x52>
  101129:	8b 45 08             	mov    0x8(%ebp),%eax
  10112c:	0f b6 00             	movzbl (%eax),%eax
  10112f:	0f b6 d0             	movzbl %al,%edx
  101132:	8b 45 0c             	mov    0xc(%ebp),%eax
  101135:	0f b6 00             	movzbl (%eax),%eax
  101138:	0f b6 c0             	movzbl %al,%eax
  10113b:	29 c2                	sub    %eax,%edx
  10113d:	89 d0                	mov    %edx,%eax
  10113f:	5d                   	pop    %ebp
  101140:	c3                   	ret    

00101141 <strnlen>:
  101141:	55                   	push   %ebp
  101142:	89 e5                	mov    %esp,%ebp
  101144:	83 ec 10             	sub    $0x10,%esp
  101147:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10114e:	eb 0c                	jmp    10115c <strnlen+0x1b>
  101150:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101154:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  101158:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
  10115c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  101160:	74 0a                	je     10116c <strnlen+0x2b>
  101162:	8b 45 08             	mov    0x8(%ebp),%eax
  101165:	0f b6 00             	movzbl (%eax),%eax
  101168:	84 c0                	test   %al,%al
  10116a:	75 e4                	jne    101150 <strnlen+0xf>
  10116c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10116f:	c9                   	leave  
  101170:	c3                   	ret    

00101171 <strcmp>:
  101171:	55                   	push   %ebp
  101172:	89 e5                	mov    %esp,%ebp
  101174:	eb 08                	jmp    10117e <strcmp+0xd>
  101176:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10117a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  10117e:	8b 45 08             	mov    0x8(%ebp),%eax
  101181:	0f b6 00             	movzbl (%eax),%eax
  101184:	84 c0                	test   %al,%al
  101186:	74 10                	je     101198 <strcmp+0x27>
  101188:	8b 45 08             	mov    0x8(%ebp),%eax
  10118b:	0f b6 10             	movzbl (%eax),%edx
  10118e:	8b 45 0c             	mov    0xc(%ebp),%eax
  101191:	0f b6 00             	movzbl (%eax),%eax
  101194:	38 c2                	cmp    %al,%dl
  101196:	74 de                	je     101176 <strcmp+0x5>
  101198:	8b 45 08             	mov    0x8(%ebp),%eax
  10119b:	0f b6 00             	movzbl (%eax),%eax
  10119e:	0f b6 d0             	movzbl %al,%edx
  1011a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1011a4:	0f b6 00             	movzbl (%eax),%eax
  1011a7:	0f b6 c0             	movzbl %al,%eax
  1011aa:	29 c2                	sub    %eax,%edx
  1011ac:	89 d0                	mov    %edx,%eax
  1011ae:	5d                   	pop    %ebp
  1011af:	c3                   	ret    

001011b0 <strchr>:
  1011b0:	55                   	push   %ebp
  1011b1:	89 e5                	mov    %esp,%ebp
  1011b3:	83 ec 04             	sub    $0x4,%esp
  1011b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1011b9:	88 45 fc             	mov    %al,-0x4(%ebp)
  1011bc:	eb 14                	jmp    1011d2 <strchr+0x22>
  1011be:	8b 45 08             	mov    0x8(%ebp),%eax
  1011c1:	0f b6 00             	movzbl (%eax),%eax
  1011c4:	38 45 fc             	cmp    %al,-0x4(%ebp)
  1011c7:	75 05                	jne    1011ce <strchr+0x1e>
  1011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1011cc:	eb 13                	jmp    1011e1 <strchr+0x31>
  1011ce:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1011d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1011d5:	0f b6 00             	movzbl (%eax),%eax
  1011d8:	84 c0                	test   %al,%al
  1011da:	75 e2                	jne    1011be <strchr+0xe>
  1011dc:	b8 00 00 00 00       	mov    $0x0,%eax
  1011e1:	c9                   	leave  
  1011e2:	c3                   	ret    

001011e3 <memzero>:
  1011e3:	55                   	push   %ebp
  1011e4:	89 e5                	mov    %esp,%ebp
  1011e6:	ff 75 0c             	push   0xc(%ebp)
  1011e9:	6a 00                	push   $0x0
  1011eb:	ff 75 08             	push   0x8(%ebp)
  1011ee:	e8 98 fd ff ff       	call   100f8b <memset>
  1011f3:	83 c4 0c             	add    $0xc,%esp
  1011f6:	c9                   	leave  
  1011f7:	c3                   	ret    

001011f8 <debug_info>:
  1011f8:	55                   	push   %ebp
  1011f9:	89 e5                	mov    %esp,%ebp
  1011fb:	83 ec 18             	sub    $0x18,%esp
  1011fe:	8d 45 0c             	lea    0xc(%ebp),%eax
  101201:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101204:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101207:	83 ec 08             	sub    $0x8,%esp
  10120a:	50                   	push   %eax
  10120b:	ff 75 08             	push   0x8(%ebp)
  10120e:	e8 0b 02 00 00       	call   10141e <vdprintf>
  101213:	83 c4 10             	add    $0x10,%esp
  101216:	90                   	nop
  101217:	c9                   	leave  
  101218:	c3                   	ret    

00101219 <debug_normal>:
  101219:	55                   	push   %ebp
  10121a:	89 e5                	mov    %esp,%ebp
  10121c:	83 ec 18             	sub    $0x18,%esp
  10121f:	83 ec 04             	sub    $0x4,%esp
  101222:	ff 75 0c             	push   0xc(%ebp)
  101225:	ff 75 08             	push   0x8(%ebp)
  101228:	68 17 41 10 00       	push   $0x104117
  10122d:	e8 4e 02 00 00       	call   101480 <dprintf>
  101232:	83 c4 10             	add    $0x10,%esp
  101235:	8d 45 14             	lea    0x14(%ebp),%eax
  101238:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10123b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10123e:	83 ec 08             	sub    $0x8,%esp
  101241:	50                   	push   %eax
  101242:	ff 75 10             	push   0x10(%ebp)
  101245:	e8 d4 01 00 00       	call   10141e <vdprintf>
  10124a:	83 c4 10             	add    $0x10,%esp
  10124d:	90                   	nop
  10124e:	c9                   	leave  
  10124f:	c3                   	ret    

00101250 <debug_trace>:
  101250:	55                   	push   %ebp
  101251:	89 e5                	mov    %esp,%ebp
  101253:	83 ec 10             	sub    $0x10,%esp
  101256:	8b 45 08             	mov    0x8(%ebp),%eax
  101259:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10125c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101263:	eb 23                	jmp    101288 <debug_trace+0x38>
  101265:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101268:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  10126f:	8b 45 0c             	mov    0xc(%ebp),%eax
  101272:	01 c2                	add    %eax,%edx
  101274:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101277:	8b 40 04             	mov    0x4(%eax),%eax
  10127a:	89 02                	mov    %eax,(%edx)
  10127c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10127f:	8b 00                	mov    (%eax),%eax
  101281:	89 45 f8             	mov    %eax,-0x8(%ebp)
  101284:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101288:	83 7d fc 09          	cmpl   $0x9,-0x4(%ebp)
  10128c:	7f 21                	jg     1012af <debug_trace+0x5f>
  10128e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  101292:	75 d1                	jne    101265 <debug_trace+0x15>
  101294:	eb 19                	jmp    1012af <debug_trace+0x5f>
  101296:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101299:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  1012a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1012a3:	01 d0                	add    %edx,%eax
  1012a5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  1012ab:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1012af:	83 7d fc 09          	cmpl   $0x9,-0x4(%ebp)
  1012b3:	7e e1                	jle    101296 <debug_trace+0x46>
  1012b5:	90                   	nop
  1012b6:	90                   	nop
  1012b7:	c9                   	leave  
  1012b8:	c3                   	ret    

001012b9 <debug_panic>:
  1012b9:	55                   	push   %ebp
  1012ba:	89 e5                	mov    %esp,%ebp
  1012bc:	83 ec 48             	sub    $0x48,%esp
  1012bf:	83 ec 04             	sub    $0x4,%esp
  1012c2:	ff 75 0c             	push   0xc(%ebp)
  1012c5:	ff 75 08             	push   0x8(%ebp)
  1012c8:	68 23 41 10 00       	push   $0x104123
  1012cd:	e8 ae 01 00 00       	call   101480 <dprintf>
  1012d2:	83 c4 10             	add    $0x10,%esp
  1012d5:	8d 45 14             	lea    0x14(%ebp),%eax
  1012d8:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  1012db:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  1012de:	83 ec 08             	sub    $0x8,%esp
  1012e1:	50                   	push   %eax
  1012e2:	ff 75 10             	push   0x10(%ebp)
  1012e5:	e8 34 01 00 00       	call   10141e <vdprintf>
  1012ea:	83 c4 10             	add    $0x10,%esp
  1012ed:	89 e8                	mov    %ebp,%eax
  1012ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1012f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1012f5:	83 ec 08             	sub    $0x8,%esp
  1012f8:	8d 55 c8             	lea    -0x38(%ebp),%edx
  1012fb:	52                   	push   %edx
  1012fc:	50                   	push   %eax
  1012fd:	e8 4e ff ff ff       	call   101250 <debug_trace>
  101302:	83 c4 10             	add    $0x10,%esp
  101305:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  10130c:	eb 1c                	jmp    10132a <debug_panic+0x71>
  10130e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101311:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
  101315:	83 ec 08             	sub    $0x8,%esp
  101318:	50                   	push   %eax
  101319:	68 2f 41 10 00       	push   $0x10412f
  10131e:	e8 5d 01 00 00       	call   101480 <dprintf>
  101323:	83 c4 10             	add    $0x10,%esp
  101326:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  10132a:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
  10132e:	7f 0b                	jg     10133b <debug_panic+0x82>
  101330:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101333:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
  101337:	85 c0                	test   %eax,%eax
  101339:	75 d3                	jne    10130e <debug_panic+0x55>
  10133b:	83 ec 0c             	sub    $0xc,%esp
  10133e:	68 3d 41 10 00       	push   $0x10413d
  101343:	e8 38 01 00 00       	call   101480 <dprintf>
  101348:	83 c4 10             	add    $0x10,%esp
  10134b:	e8 7d 0b 00 00       	call   101ecd <halt>
  101350:	90                   	nop
  101351:	c9                   	leave  
  101352:	c3                   	ret    

00101353 <debug_warn>:
  101353:	55                   	push   %ebp
  101354:	89 e5                	mov    %esp,%ebp
  101356:	83 ec 18             	sub    $0x18,%esp
  101359:	83 ec 04             	sub    $0x4,%esp
  10135c:	ff 75 0c             	push   0xc(%ebp)
  10135f:	ff 75 08             	push   0x8(%ebp)
  101362:	68 4f 41 10 00       	push   $0x10414f
  101367:	e8 14 01 00 00       	call   101480 <dprintf>
  10136c:	83 c4 10             	add    $0x10,%esp
  10136f:	8d 45 14             	lea    0x14(%ebp),%eax
  101372:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101375:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101378:	83 ec 08             	sub    $0x8,%esp
  10137b:	50                   	push   %eax
  10137c:	ff 75 10             	push   0x10(%ebp)
  10137f:	e8 9a 00 00 00       	call   10141e <vdprintf>
  101384:	83 c4 10             	add    $0x10,%esp
  101387:	90                   	nop
  101388:	c9                   	leave  
  101389:	c3                   	ret    

0010138a <cputs>:
  10138a:	55                   	push   %ebp
  10138b:	89 e5                	mov    %esp,%ebp
  10138d:	83 ec 08             	sub    $0x8,%esp
  101390:	eb 19                	jmp    1013ab <cputs+0x21>
  101392:	8b 45 08             	mov    0x8(%ebp),%eax
  101395:	0f b6 00             	movzbl (%eax),%eax
  101398:	0f be c0             	movsbl %al,%eax
  10139b:	83 ec 0c             	sub    $0xc,%esp
  10139e:	50                   	push   %eax
  10139f:	e8 a0 f0 ff ff       	call   100444 <cons_putc>
  1013a4:	83 c4 10             	add    $0x10,%esp
  1013a7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1013ab:	8b 45 08             	mov    0x8(%ebp),%eax
  1013ae:	0f b6 00             	movzbl (%eax),%eax
  1013b1:	84 c0                	test   %al,%al
  1013b3:	75 dd                	jne    101392 <cputs+0x8>
  1013b5:	90                   	nop
  1013b6:	90                   	nop
  1013b7:	c9                   	leave  
  1013b8:	c3                   	ret    

001013b9 <putch>:
  1013b9:	55                   	push   %ebp
  1013ba:	89 e5                	mov    %esp,%ebp
  1013bc:	83 ec 08             	sub    $0x8,%esp
  1013bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1013c2:	8b 00                	mov    (%eax),%eax
  1013c4:	8d 48 01             	lea    0x1(%eax),%ecx
  1013c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  1013ca:	89 0a                	mov    %ecx,(%edx)
  1013cc:	8b 55 08             	mov    0x8(%ebp),%edx
  1013cf:	89 d1                	mov    %edx,%ecx
  1013d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  1013d4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
  1013d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1013db:	8b 00                	mov    (%eax),%eax
  1013dd:	3d ff 01 00 00       	cmp    $0x1ff,%eax
  1013e2:	75 28                	jne    10140c <putch+0x53>
  1013e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1013e7:	8b 00                	mov    (%eax),%eax
  1013e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  1013ec:	c6 44 02 08 00       	movb   $0x0,0x8(%edx,%eax,1)
  1013f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1013f4:	83 c0 08             	add    $0x8,%eax
  1013f7:	83 ec 0c             	sub    $0xc,%esp
  1013fa:	50                   	push   %eax
  1013fb:	e8 8a ff ff ff       	call   10138a <cputs>
  101400:	83 c4 10             	add    $0x10,%esp
  101403:	8b 45 0c             	mov    0xc(%ebp),%eax
  101406:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  10140c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10140f:	8b 40 04             	mov    0x4(%eax),%eax
  101412:	8d 50 01             	lea    0x1(%eax),%edx
  101415:	8b 45 0c             	mov    0xc(%ebp),%eax
  101418:	89 50 04             	mov    %edx,0x4(%eax)
  10141b:	90                   	nop
  10141c:	c9                   	leave  
  10141d:	c3                   	ret    

0010141e <vdprintf>:
  10141e:	55                   	push   %ebp
  10141f:	89 e5                	mov    %esp,%ebp
  101421:	81 ec 18 02 00 00    	sub    $0x218,%esp
  101427:	c7 85 f0 fd ff ff 00 	movl   $0x0,-0x210(%ebp)
  10142e:	00 00 00 
  101431:	c7 85 f4 fd ff ff 00 	movl   $0x0,-0x20c(%ebp)
  101438:	00 00 00 
  10143b:	ff 75 0c             	push   0xc(%ebp)
  10143e:	ff 75 08             	push   0x8(%ebp)
  101441:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  101447:	50                   	push   %eax
  101448:	68 b9 13 10 00       	push   $0x1013b9
  10144d:	e8 9e 01 00 00       	call   1015f0 <vprintfmt>
  101452:	83 c4 10             	add    $0x10,%esp
  101455:	8b 85 f0 fd ff ff    	mov    -0x210(%ebp),%eax
  10145b:	c6 84 05 f8 fd ff ff 	movb   $0x0,-0x208(%ebp,%eax,1)
  101462:	00 
  101463:	83 ec 0c             	sub    $0xc,%esp
  101466:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  10146c:	83 c0 08             	add    $0x8,%eax
  10146f:	50                   	push   %eax
  101470:	e8 15 ff ff ff       	call   10138a <cputs>
  101475:	83 c4 10             	add    $0x10,%esp
  101478:	8b 85 f4 fd ff ff    	mov    -0x20c(%ebp),%eax
  10147e:	c9                   	leave  
  10147f:	c3                   	ret    

00101480 <dprintf>:
  101480:	55                   	push   %ebp
  101481:	89 e5                	mov    %esp,%ebp
  101483:	83 ec 18             	sub    $0x18,%esp
  101486:	8d 45 0c             	lea    0xc(%ebp),%eax
  101489:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10148c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10148f:	83 ec 08             	sub    $0x8,%esp
  101492:	50                   	push   %eax
  101493:	ff 75 08             	push   0x8(%ebp)
  101496:	e8 83 ff ff ff       	call   10141e <vdprintf>
  10149b:	83 c4 10             	add    $0x10,%esp
  10149e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1014a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1014a4:	c9                   	leave  
  1014a5:	c3                   	ret    

001014a6 <printnum>:
  1014a6:	55                   	push   %ebp
  1014a7:	89 e5                	mov    %esp,%ebp
  1014a9:	53                   	push   %ebx
  1014aa:	83 ec 14             	sub    $0x14,%esp
  1014ad:	8b 45 10             	mov    0x10(%ebp),%eax
  1014b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1014b3:	8b 45 14             	mov    0x14(%ebp),%eax
  1014b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1014b9:	8b 45 18             	mov    0x18(%ebp),%eax
  1014bc:	ba 00 00 00 00       	mov    $0x0,%edx
  1014c1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  1014c4:	39 45 f0             	cmp    %eax,-0x10(%ebp)
  1014c7:	19 d1                	sbb    %edx,%ecx
  1014c9:	72 4b                	jb     101516 <printnum+0x70>
  1014cb:	8b 45 1c             	mov    0x1c(%ebp),%eax
  1014ce:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1014d1:	8b 45 18             	mov    0x18(%ebp),%eax
  1014d4:	ba 00 00 00 00       	mov    $0x0,%edx
  1014d9:	52                   	push   %edx
  1014da:	50                   	push   %eax
  1014db:	ff 75 f4             	push   -0xc(%ebp)
  1014de:	ff 75 f0             	push   -0x10(%ebp)
  1014e1:	e8 9a 19 00 00       	call   102e80 <__udivdi3>
  1014e6:	83 c4 10             	add    $0x10,%esp
  1014e9:	83 ec 04             	sub    $0x4,%esp
  1014ec:	ff 75 20             	push   0x20(%ebp)
  1014ef:	53                   	push   %ebx
  1014f0:	ff 75 18             	push   0x18(%ebp)
  1014f3:	52                   	push   %edx
  1014f4:	50                   	push   %eax
  1014f5:	ff 75 0c             	push   0xc(%ebp)
  1014f8:	ff 75 08             	push   0x8(%ebp)
  1014fb:	e8 a6 ff ff ff       	call   1014a6 <printnum>
  101500:	83 c4 20             	add    $0x20,%esp
  101503:	eb 1b                	jmp    101520 <printnum+0x7a>
  101505:	83 ec 08             	sub    $0x8,%esp
  101508:	ff 75 0c             	push   0xc(%ebp)
  10150b:	ff 75 20             	push   0x20(%ebp)
  10150e:	8b 45 08             	mov    0x8(%ebp),%eax
  101511:	ff d0                	call   *%eax
  101513:	83 c4 10             	add    $0x10,%esp
  101516:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  10151a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  10151e:	7f e5                	jg     101505 <printnum+0x5f>
  101520:	8b 4d 18             	mov    0x18(%ebp),%ecx
  101523:	bb 00 00 00 00       	mov    $0x0,%ebx
  101528:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10152b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10152e:	53                   	push   %ebx
  10152f:	51                   	push   %ecx
  101530:	52                   	push   %edx
  101531:	50                   	push   %eax
  101532:	e8 69 1a 00 00       	call   102fa0 <__umoddi3>
  101537:	83 c4 10             	add    $0x10,%esp
  10153a:	05 5c 41 10 00       	add    $0x10415c,%eax
  10153f:	0f b6 00             	movzbl (%eax),%eax
  101542:	0f be c0             	movsbl %al,%eax
  101545:	83 ec 08             	sub    $0x8,%esp
  101548:	ff 75 0c             	push   0xc(%ebp)
  10154b:	50                   	push   %eax
  10154c:	8b 45 08             	mov    0x8(%ebp),%eax
  10154f:	ff d0                	call   *%eax
  101551:	83 c4 10             	add    $0x10,%esp
  101554:	90                   	nop
  101555:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101558:	c9                   	leave  
  101559:	c3                   	ret    

0010155a <getuint>:
  10155a:	55                   	push   %ebp
  10155b:	89 e5                	mov    %esp,%ebp
  10155d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  101561:	7e 14                	jle    101577 <getuint+0x1d>
  101563:	8b 45 08             	mov    0x8(%ebp),%eax
  101566:	8b 00                	mov    (%eax),%eax
  101568:	8d 48 08             	lea    0x8(%eax),%ecx
  10156b:	8b 55 08             	mov    0x8(%ebp),%edx
  10156e:	89 0a                	mov    %ecx,(%edx)
  101570:	8b 50 04             	mov    0x4(%eax),%edx
  101573:	8b 00                	mov    (%eax),%eax
  101575:	eb 30                	jmp    1015a7 <getuint+0x4d>
  101577:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10157b:	74 16                	je     101593 <getuint+0x39>
  10157d:	8b 45 08             	mov    0x8(%ebp),%eax
  101580:	8b 00                	mov    (%eax),%eax
  101582:	8d 48 04             	lea    0x4(%eax),%ecx
  101585:	8b 55 08             	mov    0x8(%ebp),%edx
  101588:	89 0a                	mov    %ecx,(%edx)
  10158a:	8b 00                	mov    (%eax),%eax
  10158c:	ba 00 00 00 00       	mov    $0x0,%edx
  101591:	eb 14                	jmp    1015a7 <getuint+0x4d>
  101593:	8b 45 08             	mov    0x8(%ebp),%eax
  101596:	8b 00                	mov    (%eax),%eax
  101598:	8d 48 04             	lea    0x4(%eax),%ecx
  10159b:	8b 55 08             	mov    0x8(%ebp),%edx
  10159e:	89 0a                	mov    %ecx,(%edx)
  1015a0:	8b 00                	mov    (%eax),%eax
  1015a2:	ba 00 00 00 00       	mov    $0x0,%edx
  1015a7:	5d                   	pop    %ebp
  1015a8:	c3                   	ret    

001015a9 <getint>:
  1015a9:	55                   	push   %ebp
  1015aa:	89 e5                	mov    %esp,%ebp
  1015ac:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1015b0:	7e 14                	jle    1015c6 <getint+0x1d>
  1015b2:	8b 45 08             	mov    0x8(%ebp),%eax
  1015b5:	8b 00                	mov    (%eax),%eax
  1015b7:	8d 48 08             	lea    0x8(%eax),%ecx
  1015ba:	8b 55 08             	mov    0x8(%ebp),%edx
  1015bd:	89 0a                	mov    %ecx,(%edx)
  1015bf:	8b 50 04             	mov    0x4(%eax),%edx
  1015c2:	8b 00                	mov    (%eax),%eax
  1015c4:	eb 28                	jmp    1015ee <getint+0x45>
  1015c6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1015ca:	74 12                	je     1015de <getint+0x35>
  1015cc:	8b 45 08             	mov    0x8(%ebp),%eax
  1015cf:	8b 00                	mov    (%eax),%eax
  1015d1:	8d 48 04             	lea    0x4(%eax),%ecx
  1015d4:	8b 55 08             	mov    0x8(%ebp),%edx
  1015d7:	89 0a                	mov    %ecx,(%edx)
  1015d9:	8b 00                	mov    (%eax),%eax
  1015db:	99                   	cltd   
  1015dc:	eb 10                	jmp    1015ee <getint+0x45>
  1015de:	8b 45 08             	mov    0x8(%ebp),%eax
  1015e1:	8b 00                	mov    (%eax),%eax
  1015e3:	8d 48 04             	lea    0x4(%eax),%ecx
  1015e6:	8b 55 08             	mov    0x8(%ebp),%edx
  1015e9:	89 0a                	mov    %ecx,(%edx)
  1015eb:	8b 00                	mov    (%eax),%eax
  1015ed:	99                   	cltd   
  1015ee:	5d                   	pop    %ebp
  1015ef:	c3                   	ret    

001015f0 <vprintfmt>:
  1015f0:	55                   	push   %ebp
  1015f1:	89 e5                	mov    %esp,%ebp
  1015f3:	56                   	push   %esi
  1015f4:	53                   	push   %ebx
  1015f5:	83 ec 20             	sub    $0x20,%esp
  1015f8:	eb 17                	jmp    101611 <vprintfmt+0x21>
  1015fa:	85 db                	test   %ebx,%ebx
  1015fc:	0f 84 18 03 00 00    	je     10191a <vprintfmt+0x32a>
  101602:	83 ec 08             	sub    $0x8,%esp
  101605:	ff 75 0c             	push   0xc(%ebp)
  101608:	53                   	push   %ebx
  101609:	8b 45 08             	mov    0x8(%ebp),%eax
  10160c:	ff d0                	call   *%eax
  10160e:	83 c4 10             	add    $0x10,%esp
  101611:	8b 45 10             	mov    0x10(%ebp),%eax
  101614:	8d 50 01             	lea    0x1(%eax),%edx
  101617:	89 55 10             	mov    %edx,0x10(%ebp)
  10161a:	0f b6 00             	movzbl (%eax),%eax
  10161d:	0f b6 d8             	movzbl %al,%ebx
  101620:	83 fb 25             	cmp    $0x25,%ebx
  101623:	75 d5                	jne    1015fa <vprintfmt+0xa>
  101625:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
  101629:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  101630:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
  101637:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  10163e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  101645:	eb 04                	jmp    10164b <vprintfmt+0x5b>
  101647:	90                   	nop
  101648:	eb 01                	jmp    10164b <vprintfmt+0x5b>
  10164a:	90                   	nop
  10164b:	8b 45 10             	mov    0x10(%ebp),%eax
  10164e:	8d 50 01             	lea    0x1(%eax),%edx
  101651:	89 55 10             	mov    %edx,0x10(%ebp)
  101654:	0f b6 00             	movzbl (%eax),%eax
  101657:	0f b6 d8             	movzbl %al,%ebx
  10165a:	8d 43 dd             	lea    -0x23(%ebx),%eax
  10165d:	83 f8 55             	cmp    $0x55,%eax
  101660:	0f 87 87 02 00 00    	ja     1018ed <vprintfmt+0x2fd>
  101666:	8b 04 85 74 41 10 00 	mov    0x104174(,%eax,4),%eax
  10166d:	ff e0                	jmp    *%eax
  10166f:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
  101673:	eb d6                	jmp    10164b <vprintfmt+0x5b>
  101675:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
  101679:	eb d0                	jmp    10164b <vprintfmt+0x5b>
  10167b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  101682:	8b 55 e0             	mov    -0x20(%ebp),%edx
  101685:	89 d0                	mov    %edx,%eax
  101687:	c1 e0 02             	shl    $0x2,%eax
  10168a:	01 d0                	add    %edx,%eax
  10168c:	01 c0                	add    %eax,%eax
  10168e:	01 d8                	add    %ebx,%eax
  101690:	83 e8 30             	sub    $0x30,%eax
  101693:	89 45 e0             	mov    %eax,-0x20(%ebp)
  101696:	8b 45 10             	mov    0x10(%ebp),%eax
  101699:	0f b6 00             	movzbl (%eax),%eax
  10169c:	0f be d8             	movsbl %al,%ebx
  10169f:	83 fb 2f             	cmp    $0x2f,%ebx
  1016a2:	7e 39                	jle    1016dd <vprintfmt+0xed>
  1016a4:	83 fb 39             	cmp    $0x39,%ebx
  1016a7:	7f 34                	jg     1016dd <vprintfmt+0xed>
  1016a9:	83 45 10 01          	addl   $0x1,0x10(%ebp)
  1016ad:	eb d3                	jmp    101682 <vprintfmt+0x92>
  1016af:	8b 45 14             	mov    0x14(%ebp),%eax
  1016b2:	8d 50 04             	lea    0x4(%eax),%edx
  1016b5:	89 55 14             	mov    %edx,0x14(%ebp)
  1016b8:	8b 00                	mov    (%eax),%eax
  1016ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1016bd:	eb 1f                	jmp    1016de <vprintfmt+0xee>
  1016bf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  1016c3:	79 82                	jns    101647 <vprintfmt+0x57>
  1016c5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1016cc:	e9 76 ff ff ff       	jmp    101647 <vprintfmt+0x57>
  1016d1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
  1016d8:	e9 6e ff ff ff       	jmp    10164b <vprintfmt+0x5b>
  1016dd:	90                   	nop
  1016de:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  1016e2:	0f 89 62 ff ff ff    	jns    10164a <vprintfmt+0x5a>
  1016e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1016eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1016ee:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
  1016f5:	e9 50 ff ff ff       	jmp    10164a <vprintfmt+0x5a>
  1016fa:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  1016fe:	e9 48 ff ff ff       	jmp    10164b <vprintfmt+0x5b>
  101703:	8b 45 14             	mov    0x14(%ebp),%eax
  101706:	8d 50 04             	lea    0x4(%eax),%edx
  101709:	89 55 14             	mov    %edx,0x14(%ebp)
  10170c:	8b 00                	mov    (%eax),%eax
  10170e:	83 ec 08             	sub    $0x8,%esp
  101711:	ff 75 0c             	push   0xc(%ebp)
  101714:	50                   	push   %eax
  101715:	8b 45 08             	mov    0x8(%ebp),%eax
  101718:	ff d0                	call   *%eax
  10171a:	83 c4 10             	add    $0x10,%esp
  10171d:	e9 f3 01 00 00       	jmp    101915 <vprintfmt+0x325>
  101722:	8b 45 14             	mov    0x14(%ebp),%eax
  101725:	8d 50 04             	lea    0x4(%eax),%edx
  101728:	89 55 14             	mov    %edx,0x14(%ebp)
  10172b:	8b 30                	mov    (%eax),%esi
  10172d:	85 f6                	test   %esi,%esi
  10172f:	75 05                	jne    101736 <vprintfmt+0x146>
  101731:	be 6d 41 10 00       	mov    $0x10416d,%esi
  101736:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10173a:	7e 6f                	jle    1017ab <vprintfmt+0x1bb>
  10173c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  101740:	74 69                	je     1017ab <vprintfmt+0x1bb>
  101742:	8b 45 e0             	mov    -0x20(%ebp),%eax
  101745:	83 ec 08             	sub    $0x8,%esp
  101748:	50                   	push   %eax
  101749:	56                   	push   %esi
  10174a:	e8 f2 f9 ff ff       	call   101141 <strnlen>
  10174f:	83 c4 10             	add    $0x10,%esp
  101752:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  101755:	eb 17                	jmp    10176e <vprintfmt+0x17e>
  101757:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  10175b:	83 ec 08             	sub    $0x8,%esp
  10175e:	ff 75 0c             	push   0xc(%ebp)
  101761:	50                   	push   %eax
  101762:	8b 45 08             	mov    0x8(%ebp),%eax
  101765:	ff d0                	call   *%eax
  101767:	83 c4 10             	add    $0x10,%esp
  10176a:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  10176e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  101772:	7f e3                	jg     101757 <vprintfmt+0x167>
  101774:	eb 35                	jmp    1017ab <vprintfmt+0x1bb>
  101776:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  10177a:	74 1c                	je     101798 <vprintfmt+0x1a8>
  10177c:	83 fb 1f             	cmp    $0x1f,%ebx
  10177f:	7e 05                	jle    101786 <vprintfmt+0x196>
  101781:	83 fb 7e             	cmp    $0x7e,%ebx
  101784:	7e 12                	jle    101798 <vprintfmt+0x1a8>
  101786:	83 ec 08             	sub    $0x8,%esp
  101789:	ff 75 0c             	push   0xc(%ebp)
  10178c:	6a 3f                	push   $0x3f
  10178e:	8b 45 08             	mov    0x8(%ebp),%eax
  101791:	ff d0                	call   *%eax
  101793:	83 c4 10             	add    $0x10,%esp
  101796:	eb 0f                	jmp    1017a7 <vprintfmt+0x1b7>
  101798:	83 ec 08             	sub    $0x8,%esp
  10179b:	ff 75 0c             	push   0xc(%ebp)
  10179e:	53                   	push   %ebx
  10179f:	8b 45 08             	mov    0x8(%ebp),%eax
  1017a2:	ff d0                	call   *%eax
  1017a4:	83 c4 10             	add    $0x10,%esp
  1017a7:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  1017ab:	89 f0                	mov    %esi,%eax
  1017ad:	8d 70 01             	lea    0x1(%eax),%esi
  1017b0:	0f b6 00             	movzbl (%eax),%eax
  1017b3:	0f be d8             	movsbl %al,%ebx
  1017b6:	85 db                	test   %ebx,%ebx
  1017b8:	74 26                	je     1017e0 <vprintfmt+0x1f0>
  1017ba:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  1017be:	78 b6                	js     101776 <vprintfmt+0x186>
  1017c0:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
  1017c4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  1017c8:	79 ac                	jns    101776 <vprintfmt+0x186>
  1017ca:	eb 14                	jmp    1017e0 <vprintfmt+0x1f0>
  1017cc:	83 ec 08             	sub    $0x8,%esp
  1017cf:	ff 75 0c             	push   0xc(%ebp)
  1017d2:	6a 20                	push   $0x20
  1017d4:	8b 45 08             	mov    0x8(%ebp),%eax
  1017d7:	ff d0                	call   *%eax
  1017d9:	83 c4 10             	add    $0x10,%esp
  1017dc:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  1017e0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  1017e4:	7f e6                	jg     1017cc <vprintfmt+0x1dc>
  1017e6:	e9 2a 01 00 00       	jmp    101915 <vprintfmt+0x325>
  1017eb:	83 ec 08             	sub    $0x8,%esp
  1017ee:	ff 75 e8             	push   -0x18(%ebp)
  1017f1:	8d 45 14             	lea    0x14(%ebp),%eax
  1017f4:	50                   	push   %eax
  1017f5:	e8 af fd ff ff       	call   1015a9 <getint>
  1017fa:	83 c4 10             	add    $0x10,%esp
  1017fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  101800:	89 55 f4             	mov    %edx,-0xc(%ebp)
  101803:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101806:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101809:	85 d2                	test   %edx,%edx
  10180b:	79 23                	jns    101830 <vprintfmt+0x240>
  10180d:	83 ec 08             	sub    $0x8,%esp
  101810:	ff 75 0c             	push   0xc(%ebp)
  101813:	6a 2d                	push   $0x2d
  101815:	8b 45 08             	mov    0x8(%ebp),%eax
  101818:	ff d0                	call   *%eax
  10181a:	83 c4 10             	add    $0x10,%esp
  10181d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101820:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101823:	f7 d8                	neg    %eax
  101825:	83 d2 00             	adc    $0x0,%edx
  101828:	f7 da                	neg    %edx
  10182a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10182d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  101830:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
  101837:	eb 7e                	jmp    1018b7 <vprintfmt+0x2c7>
  101839:	83 ec 08             	sub    $0x8,%esp
  10183c:	ff 75 e8             	push   -0x18(%ebp)
  10183f:	8d 45 14             	lea    0x14(%ebp),%eax
  101842:	50                   	push   %eax
  101843:	e8 12 fd ff ff       	call   10155a <getuint>
  101848:	83 c4 10             	add    $0x10,%esp
  10184b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10184e:	89 55 f4             	mov    %edx,-0xc(%ebp)
  101851:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
  101858:	eb 5d                	jmp    1018b7 <vprintfmt+0x2c7>
  10185a:	83 ec 08             	sub    $0x8,%esp
  10185d:	ff 75 0c             	push   0xc(%ebp)
  101860:	6a 30                	push   $0x30
  101862:	8b 45 08             	mov    0x8(%ebp),%eax
  101865:	ff d0                	call   *%eax
  101867:	83 c4 10             	add    $0x10,%esp
  10186a:	83 ec 08             	sub    $0x8,%esp
  10186d:	ff 75 0c             	push   0xc(%ebp)
  101870:	6a 78                	push   $0x78
  101872:	8b 45 08             	mov    0x8(%ebp),%eax
  101875:	ff d0                	call   *%eax
  101877:	83 c4 10             	add    $0x10,%esp
  10187a:	8b 45 14             	mov    0x14(%ebp),%eax
  10187d:	8d 50 04             	lea    0x4(%eax),%edx
  101880:	89 55 14             	mov    %edx,0x14(%ebp)
  101883:	8b 00                	mov    (%eax),%eax
  101885:	89 45 f0             	mov    %eax,-0x10(%ebp)
  101888:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  10188f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
  101896:	eb 1f                	jmp    1018b7 <vprintfmt+0x2c7>
  101898:	83 ec 08             	sub    $0x8,%esp
  10189b:	ff 75 e8             	push   -0x18(%ebp)
  10189e:	8d 45 14             	lea    0x14(%ebp),%eax
  1018a1:	50                   	push   %eax
  1018a2:	e8 b3 fc ff ff       	call   10155a <getuint>
  1018a7:	83 c4 10             	add    $0x10,%esp
  1018aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1018ad:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1018b0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
  1018b7:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  1018bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1018be:	83 ec 04             	sub    $0x4,%esp
  1018c1:	52                   	push   %edx
  1018c2:	ff 75 e4             	push   -0x1c(%ebp)
  1018c5:	50                   	push   %eax
  1018c6:	ff 75 f4             	push   -0xc(%ebp)
  1018c9:	ff 75 f0             	push   -0x10(%ebp)
  1018cc:	ff 75 0c             	push   0xc(%ebp)
  1018cf:	ff 75 08             	push   0x8(%ebp)
  1018d2:	e8 cf fb ff ff       	call   1014a6 <printnum>
  1018d7:	83 c4 20             	add    $0x20,%esp
  1018da:	eb 39                	jmp    101915 <vprintfmt+0x325>
  1018dc:	83 ec 08             	sub    $0x8,%esp
  1018df:	ff 75 0c             	push   0xc(%ebp)
  1018e2:	53                   	push   %ebx
  1018e3:	8b 45 08             	mov    0x8(%ebp),%eax
  1018e6:	ff d0                	call   *%eax
  1018e8:	83 c4 10             	add    $0x10,%esp
  1018eb:	eb 28                	jmp    101915 <vprintfmt+0x325>
  1018ed:	83 ec 08             	sub    $0x8,%esp
  1018f0:	ff 75 0c             	push   0xc(%ebp)
  1018f3:	6a 25                	push   $0x25
  1018f5:	8b 45 08             	mov    0x8(%ebp),%eax
  1018f8:	ff d0                	call   *%eax
  1018fa:	83 c4 10             	add    $0x10,%esp
  1018fd:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  101901:	eb 04                	jmp    101907 <vprintfmt+0x317>
  101903:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  101907:	8b 45 10             	mov    0x10(%ebp),%eax
  10190a:	83 e8 01             	sub    $0x1,%eax
  10190d:	0f b6 00             	movzbl (%eax),%eax
  101910:	3c 25                	cmp    $0x25,%al
  101912:	75 ef                	jne    101903 <vprintfmt+0x313>
  101914:	90                   	nop
  101915:	e9 f7 fc ff ff       	jmp    101611 <vprintfmt+0x21>
  10191a:	90                   	nop
  10191b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  10191e:	5b                   	pop    %ebx
  10191f:	5e                   	pop    %esi
  101920:	5d                   	pop    %ebp
  101921:	c3                   	ret    

00101922 <seg_init>:
  101922:	55                   	push   %ebp
  101923:	89 e5                	mov    %esp,%ebp
  101925:	83 ec 18             	sub    $0x18,%esp
  101928:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  10192d:	2d 40 75 10 00       	sub    $0x107540,%eax
  101932:	83 ec 08             	sub    $0x8,%esp
  101935:	50                   	push   %eax
  101936:	68 40 75 10 00       	push   $0x107540
  10193b:	e8 a3 f8 ff ff       	call   1011e3 <memzero>
  101940:	83 c4 10             	add    $0x10,%esp
  101943:	b8 44 ec 94 00       	mov    $0x94ec44,%eax
  101948:	2d 00 a0 10 00       	sub    $0x10a000,%eax
  10194d:	2d 00 10 00 00       	sub    $0x1000,%eax
  101952:	89 c2                	mov    %eax,%edx
  101954:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  101959:	83 ec 08             	sub    $0x8,%esp
  10195c:	52                   	push   %edx
  10195d:	50                   	push   %eax
  10195e:	e8 80 f8 ff ff       	call   1011e3 <memzero>
  101963:	83 c4 10             	add    $0x10,%esp
  101966:	c7 05 00 b0 14 00 00 	movl   $0x0,0x14b000
  10196d:	00 00 00 
  101970:	c7 05 04 b0 14 00 00 	movl   $0x0,0x14b004
  101977:	00 00 00 
  10197a:	66 c7 05 08 b0 14 00 	movw   $0xffff,0x14b008
  101981:	ff ff 
  101983:	66 c7 05 0a b0 14 00 	movw   $0x0,0x14b00a
  10198a:	00 00 
  10198c:	c6 05 0c b0 14 00 00 	movb   $0x0,0x14b00c
  101993:	0f b6 05 0d b0 14 00 	movzbl 0x14b00d,%eax
  10199a:	83 e0 f0             	and    $0xfffffff0,%eax
  10199d:	83 c8 0a             	or     $0xa,%eax
  1019a0:	a2 0d b0 14 00       	mov    %al,0x14b00d
  1019a5:	0f b6 05 0d b0 14 00 	movzbl 0x14b00d,%eax
  1019ac:	83 c8 10             	or     $0x10,%eax
  1019af:	a2 0d b0 14 00       	mov    %al,0x14b00d
  1019b4:	0f b6 05 0d b0 14 00 	movzbl 0x14b00d,%eax
  1019bb:	83 e0 9f             	and    $0xffffff9f,%eax
  1019be:	a2 0d b0 14 00       	mov    %al,0x14b00d
  1019c3:	0f b6 05 0d b0 14 00 	movzbl 0x14b00d,%eax
  1019ca:	83 c8 80             	or     $0xffffff80,%eax
  1019cd:	a2 0d b0 14 00       	mov    %al,0x14b00d
  1019d2:	0f b6 05 0e b0 14 00 	movzbl 0x14b00e,%eax
  1019d9:	83 c8 0f             	or     $0xf,%eax
  1019dc:	a2 0e b0 14 00       	mov    %al,0x14b00e
  1019e1:	0f b6 05 0e b0 14 00 	movzbl 0x14b00e,%eax
  1019e8:	83 e0 ef             	and    $0xffffffef,%eax
  1019eb:	a2 0e b0 14 00       	mov    %al,0x14b00e
  1019f0:	0f b6 05 0e b0 14 00 	movzbl 0x14b00e,%eax
  1019f7:	83 e0 df             	and    $0xffffffdf,%eax
  1019fa:	a2 0e b0 14 00       	mov    %al,0x14b00e
  1019ff:	0f b6 05 0e b0 14 00 	movzbl 0x14b00e,%eax
  101a06:	83 c8 40             	or     $0x40,%eax
  101a09:	a2 0e b0 14 00       	mov    %al,0x14b00e
  101a0e:	0f b6 05 0e b0 14 00 	movzbl 0x14b00e,%eax
  101a15:	83 c8 80             	or     $0xffffff80,%eax
  101a18:	a2 0e b0 14 00       	mov    %al,0x14b00e
  101a1d:	c6 05 0f b0 14 00 00 	movb   $0x0,0x14b00f
  101a24:	66 c7 05 10 b0 14 00 	movw   $0xffff,0x14b010
  101a2b:	ff ff 
  101a2d:	66 c7 05 12 b0 14 00 	movw   $0x0,0x14b012
  101a34:	00 00 
  101a36:	c6 05 14 b0 14 00 00 	movb   $0x0,0x14b014
  101a3d:	0f b6 05 15 b0 14 00 	movzbl 0x14b015,%eax
  101a44:	83 e0 f0             	and    $0xfffffff0,%eax
  101a47:	83 c8 02             	or     $0x2,%eax
  101a4a:	a2 15 b0 14 00       	mov    %al,0x14b015
  101a4f:	0f b6 05 15 b0 14 00 	movzbl 0x14b015,%eax
  101a56:	83 c8 10             	or     $0x10,%eax
  101a59:	a2 15 b0 14 00       	mov    %al,0x14b015
  101a5e:	0f b6 05 15 b0 14 00 	movzbl 0x14b015,%eax
  101a65:	83 e0 9f             	and    $0xffffff9f,%eax
  101a68:	a2 15 b0 14 00       	mov    %al,0x14b015
  101a6d:	0f b6 05 15 b0 14 00 	movzbl 0x14b015,%eax
  101a74:	83 c8 80             	or     $0xffffff80,%eax
  101a77:	a2 15 b0 14 00       	mov    %al,0x14b015
  101a7c:	0f b6 05 16 b0 14 00 	movzbl 0x14b016,%eax
  101a83:	83 c8 0f             	or     $0xf,%eax
  101a86:	a2 16 b0 14 00       	mov    %al,0x14b016
  101a8b:	0f b6 05 16 b0 14 00 	movzbl 0x14b016,%eax
  101a92:	83 e0 ef             	and    $0xffffffef,%eax
  101a95:	a2 16 b0 14 00       	mov    %al,0x14b016
  101a9a:	0f b6 05 16 b0 14 00 	movzbl 0x14b016,%eax
  101aa1:	83 e0 df             	and    $0xffffffdf,%eax
  101aa4:	a2 16 b0 14 00       	mov    %al,0x14b016
  101aa9:	0f b6 05 16 b0 14 00 	movzbl 0x14b016,%eax
  101ab0:	83 c8 40             	or     $0x40,%eax
  101ab3:	a2 16 b0 14 00       	mov    %al,0x14b016
  101ab8:	0f b6 05 16 b0 14 00 	movzbl 0x14b016,%eax
  101abf:	83 c8 80             	or     $0xffffff80,%eax
  101ac2:	a2 16 b0 14 00       	mov    %al,0x14b016
  101ac7:	c6 05 17 b0 14 00 00 	movb   $0x0,0x14b017
  101ace:	66 c7 05 18 b0 14 00 	movw   $0xffff,0x14b018
  101ad5:	ff ff 
  101ad7:	66 c7 05 1a b0 14 00 	movw   $0x0,0x14b01a
  101ade:	00 00 
  101ae0:	c6 05 1c b0 14 00 00 	movb   $0x0,0x14b01c
  101ae7:	0f b6 05 1d b0 14 00 	movzbl 0x14b01d,%eax
  101aee:	83 e0 f0             	and    $0xfffffff0,%eax
  101af1:	83 c8 0a             	or     $0xa,%eax
  101af4:	a2 1d b0 14 00       	mov    %al,0x14b01d
  101af9:	0f b6 05 1d b0 14 00 	movzbl 0x14b01d,%eax
  101b00:	83 c8 10             	or     $0x10,%eax
  101b03:	a2 1d b0 14 00       	mov    %al,0x14b01d
  101b08:	0f b6 05 1d b0 14 00 	movzbl 0x14b01d,%eax
  101b0f:	83 c8 60             	or     $0x60,%eax
  101b12:	a2 1d b0 14 00       	mov    %al,0x14b01d
  101b17:	0f b6 05 1d b0 14 00 	movzbl 0x14b01d,%eax
  101b1e:	83 c8 80             	or     $0xffffff80,%eax
  101b21:	a2 1d b0 14 00       	mov    %al,0x14b01d
  101b26:	0f b6 05 1e b0 14 00 	movzbl 0x14b01e,%eax
  101b2d:	83 c8 0f             	or     $0xf,%eax
  101b30:	a2 1e b0 14 00       	mov    %al,0x14b01e
  101b35:	0f b6 05 1e b0 14 00 	movzbl 0x14b01e,%eax
  101b3c:	83 e0 ef             	and    $0xffffffef,%eax
  101b3f:	a2 1e b0 14 00       	mov    %al,0x14b01e
  101b44:	0f b6 05 1e b0 14 00 	movzbl 0x14b01e,%eax
  101b4b:	83 e0 df             	and    $0xffffffdf,%eax
  101b4e:	a2 1e b0 14 00       	mov    %al,0x14b01e
  101b53:	0f b6 05 1e b0 14 00 	movzbl 0x14b01e,%eax
  101b5a:	83 c8 40             	or     $0x40,%eax
  101b5d:	a2 1e b0 14 00       	mov    %al,0x14b01e
  101b62:	0f b6 05 1e b0 14 00 	movzbl 0x14b01e,%eax
  101b69:	83 c8 80             	or     $0xffffff80,%eax
  101b6c:	a2 1e b0 14 00       	mov    %al,0x14b01e
  101b71:	c6 05 1f b0 14 00 00 	movb   $0x0,0x14b01f
  101b78:	66 c7 05 20 b0 14 00 	movw   $0xffff,0x14b020
  101b7f:	ff ff 
  101b81:	66 c7 05 22 b0 14 00 	movw   $0x0,0x14b022
  101b88:	00 00 
  101b8a:	c6 05 24 b0 14 00 00 	movb   $0x0,0x14b024
  101b91:	0f b6 05 25 b0 14 00 	movzbl 0x14b025,%eax
  101b98:	83 e0 f0             	and    $0xfffffff0,%eax
  101b9b:	83 c8 02             	or     $0x2,%eax
  101b9e:	a2 25 b0 14 00       	mov    %al,0x14b025
  101ba3:	0f b6 05 25 b0 14 00 	movzbl 0x14b025,%eax
  101baa:	83 c8 10             	or     $0x10,%eax
  101bad:	a2 25 b0 14 00       	mov    %al,0x14b025
  101bb2:	0f b6 05 25 b0 14 00 	movzbl 0x14b025,%eax
  101bb9:	83 c8 60             	or     $0x60,%eax
  101bbc:	a2 25 b0 14 00       	mov    %al,0x14b025
  101bc1:	0f b6 05 25 b0 14 00 	movzbl 0x14b025,%eax
  101bc8:	83 c8 80             	or     $0xffffff80,%eax
  101bcb:	a2 25 b0 14 00       	mov    %al,0x14b025
  101bd0:	0f b6 05 26 b0 14 00 	movzbl 0x14b026,%eax
  101bd7:	83 c8 0f             	or     $0xf,%eax
  101bda:	a2 26 b0 14 00       	mov    %al,0x14b026
  101bdf:	0f b6 05 26 b0 14 00 	movzbl 0x14b026,%eax
  101be6:	83 e0 ef             	and    $0xffffffef,%eax
  101be9:	a2 26 b0 14 00       	mov    %al,0x14b026
  101bee:	0f b6 05 26 b0 14 00 	movzbl 0x14b026,%eax
  101bf5:	83 e0 df             	and    $0xffffffdf,%eax
  101bf8:	a2 26 b0 14 00       	mov    %al,0x14b026
  101bfd:	0f b6 05 26 b0 14 00 	movzbl 0x14b026,%eax
  101c04:	83 c8 40             	or     $0x40,%eax
  101c07:	a2 26 b0 14 00       	mov    %al,0x14b026
  101c0c:	0f b6 05 26 b0 14 00 	movzbl 0x14b026,%eax
  101c13:	83 c8 80             	or     $0xffffff80,%eax
  101c16:	a2 26 b0 14 00       	mov    %al,0x14b026
  101c1b:	c6 05 27 b0 14 00 00 	movb   $0x0,0x14b027
  101c22:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  101c27:	05 00 10 00 00       	add    $0x1000,%eax
  101c2c:	a3 44 eb 14 00       	mov    %eax,0x14eb44
  101c31:	66 c7 05 48 eb 14 00 	movw   $0x10,0x14eb48
  101c38:	10 00 
  101c3a:	66 c7 05 28 b0 14 00 	movw   $0xeb,0x14b028
  101c41:	eb 00 
  101c43:	b8 40 eb 14 00       	mov    $0x14eb40,%eax
  101c48:	66 a3 2a b0 14 00    	mov    %ax,0x14b02a
  101c4e:	b8 40 eb 14 00       	mov    $0x14eb40,%eax
  101c53:	c1 e8 10             	shr    $0x10,%eax
  101c56:	a2 2c b0 14 00       	mov    %al,0x14b02c
  101c5b:	0f b6 05 2d b0 14 00 	movzbl 0x14b02d,%eax
  101c62:	83 e0 f0             	and    $0xfffffff0,%eax
  101c65:	83 c8 09             	or     $0x9,%eax
  101c68:	a2 2d b0 14 00       	mov    %al,0x14b02d
  101c6d:	0f b6 05 2d b0 14 00 	movzbl 0x14b02d,%eax
  101c74:	83 c8 10             	or     $0x10,%eax
  101c77:	a2 2d b0 14 00       	mov    %al,0x14b02d
  101c7c:	0f b6 05 2d b0 14 00 	movzbl 0x14b02d,%eax
  101c83:	83 e0 9f             	and    $0xffffff9f,%eax
  101c86:	a2 2d b0 14 00       	mov    %al,0x14b02d
  101c8b:	0f b6 05 2d b0 14 00 	movzbl 0x14b02d,%eax
  101c92:	83 c8 80             	or     $0xffffff80,%eax
  101c95:	a2 2d b0 14 00       	mov    %al,0x14b02d
  101c9a:	0f b6 05 2e b0 14 00 	movzbl 0x14b02e,%eax
  101ca1:	83 e0 f0             	and    $0xfffffff0,%eax
  101ca4:	a2 2e b0 14 00       	mov    %al,0x14b02e
  101ca9:	0f b6 05 2e b0 14 00 	movzbl 0x14b02e,%eax
  101cb0:	83 e0 ef             	and    $0xffffffef,%eax
  101cb3:	a2 2e b0 14 00       	mov    %al,0x14b02e
  101cb8:	0f b6 05 2e b0 14 00 	movzbl 0x14b02e,%eax
  101cbf:	83 e0 df             	and    $0xffffffdf,%eax
  101cc2:	a2 2e b0 14 00       	mov    %al,0x14b02e
  101cc7:	0f b6 05 2e b0 14 00 	movzbl 0x14b02e,%eax
  101cce:	83 c8 40             	or     $0x40,%eax
  101cd1:	a2 2e b0 14 00       	mov    %al,0x14b02e
  101cd6:	0f b6 05 2e b0 14 00 	movzbl 0x14b02e,%eax
  101cdd:	83 e0 7f             	and    $0x7f,%eax
  101ce0:	a2 2e b0 14 00       	mov    %al,0x14b02e
  101ce5:	b8 40 eb 14 00       	mov    $0x14eb40,%eax
  101cea:	c1 e8 18             	shr    $0x18,%eax
  101ced:	a2 2f b0 14 00       	mov    %al,0x14b02f
  101cf2:	0f b6 05 2d b0 14 00 	movzbl 0x14b02d,%eax
  101cf9:	83 e0 ef             	and    $0xffffffef,%eax
  101cfc:	a2 2d b0 14 00       	mov    %al,0x14b02d
  101d01:	66 c7 45 ee 2f 00    	movw   $0x2f,-0x12(%ebp)
  101d07:	b8 00 b0 14 00       	mov    $0x14b000,%eax
  101d0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  101d0f:	0f 01 55 ee          	lgdtl  -0x12(%ebp)
  101d13:	b8 10 00 00 00       	mov    $0x10,%eax
  101d18:	8e e8                	mov    %eax,%gs
  101d1a:	b8 10 00 00 00       	mov    $0x10,%eax
  101d1f:	8e e0                	mov    %eax,%fs
  101d21:	b8 10 00 00 00       	mov    $0x10,%eax
  101d26:	8e c0                	mov    %eax,%es
  101d28:	b8 10 00 00 00       	mov    $0x10,%eax
  101d2d:	8e d8                	mov    %eax,%ds
  101d2f:	b8 10 00 00 00       	mov    $0x10,%eax
  101d34:	8e d0                	mov    %eax,%ss
  101d36:	ea 3d 1d 10 00 08 00 	ljmp   $0x8,$0x101d3d
  101d3d:	83 ec 0c             	sub    $0xc,%esp
  101d40:	6a 00                	push   $0x0
  101d42:	e8 25 01 00 00       	call   101e6c <lldt>
  101d47:	83 c4 10             	add    $0x10,%esp
  101d4a:	83 ec 0c             	sub    $0xc,%esp
  101d4d:	6a 28                	push   $0x28
  101d4f:	e8 62 02 00 00       	call   101fb6 <ltr>
  101d54:	83 c4 10             	add    $0x10,%esp
  101d57:	83 ec 08             	sub    $0x8,%esp
  101d5a:	68 00 3b 00 00       	push   $0x3b00
  101d5f:	68 40 b0 14 00       	push   $0x14b040
  101d64:	e8 7a f4 ff ff       	call   1011e3 <memzero>
  101d69:	83 c4 10             	add    $0x10,%esp
  101d6c:	83 ec 08             	sub    $0x8,%esp
  101d6f:	68 00 00 04 00       	push   $0x40000
  101d74:	68 00 b0 10 00       	push   $0x10b000
  101d79:	e8 65 f4 ff ff       	call   1011e3 <memzero>
  101d7e:	83 c4 10             	add    $0x10,%esp
  101d81:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101d88:	e9 81 00 00 00       	jmp    101e0e <seg_init+0x4ec>
  101d8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101d90:	c1 e0 0c             	shl    $0xc,%eax
  101d93:	05 00 b0 10 00       	add    $0x10b000,%eax
  101d98:	8d 90 00 10 00 00    	lea    0x1000(%eax),%edx
  101d9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101da1:	69 c0 ec 00 00 00    	imul   $0xec,%eax,%eax
  101da7:	05 44 b0 14 00       	add    $0x14b044,%eax
  101dac:	89 10                	mov    %edx,(%eax)
  101dae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101db1:	69 c0 ec 00 00 00    	imul   $0xec,%eax,%eax
  101db7:	05 48 b0 14 00       	add    $0x14b048,%eax
  101dbc:	66 c7 00 10 00       	movw   $0x10,(%eax)
  101dc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101dc4:	69 c0 ec 00 00 00    	imul   $0xec,%eax,%eax
  101dca:	05 a6 b0 14 00       	add    $0x14b0a6,%eax
  101dcf:	66 c7 00 68 00       	movw   $0x68,(%eax)
  101dd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101dd7:	69 c0 ec 00 00 00    	imul   $0xec,%eax,%eax
  101ddd:	83 c0 60             	add    $0x60,%eax
  101de0:	05 40 b0 14 00       	add    $0x14b040,%eax
  101de5:	83 c0 08             	add    $0x8,%eax
  101de8:	83 ec 08             	sub    $0x8,%esp
  101deb:	68 80 00 00 00       	push   $0x80
  101df0:	50                   	push   %eax
  101df1:	e8 ed f3 ff ff       	call   1011e3 <memzero>
  101df6:	83 c4 10             	add    $0x10,%esp
  101df9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101dfc:	69 c0 ec 00 00 00    	imul   $0xec,%eax,%eax
  101e02:	05 28 b1 14 00       	add    $0x14b128,%eax
  101e07:	c6 00 ff             	movb   $0xff,(%eax)
  101e0a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101e0e:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
  101e12:	0f 86 75 ff ff ff    	jbe    101d8d <seg_init+0x46b>
  101e18:	90                   	nop
  101e19:	c9                   	leave  
  101e1a:	c3                   	ret    

00101e1b <max>:
  101e1b:	55                   	push   %ebp
  101e1c:	89 e5                	mov    %esp,%ebp
  101e1e:	8b 55 0c             	mov    0xc(%ebp),%edx
  101e21:	8b 45 08             	mov    0x8(%ebp),%eax
  101e24:	39 c2                	cmp    %eax,%edx
  101e26:	0f 43 c2             	cmovae %edx,%eax
  101e29:	5d                   	pop    %ebp
  101e2a:	c3                   	ret    

00101e2b <min>:
  101e2b:	55                   	push   %ebp
  101e2c:	89 e5                	mov    %esp,%ebp
  101e2e:	8b 55 0c             	mov    0xc(%ebp),%edx
  101e31:	8b 45 08             	mov    0x8(%ebp),%eax
  101e34:	39 c2                	cmp    %eax,%edx
  101e36:	0f 46 c2             	cmovbe %edx,%eax
  101e39:	5d                   	pop    %ebp
  101e3a:	c3                   	ret    

00101e3b <rounddown>:
  101e3b:	55                   	push   %ebp
  101e3c:	89 e5                	mov    %esp,%ebp
  101e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  101e41:	ba 00 00 00 00       	mov    $0x0,%edx
  101e46:	f7 75 0c             	divl   0xc(%ebp)
  101e49:	8b 45 08             	mov    0x8(%ebp),%eax
  101e4c:	29 d0                	sub    %edx,%eax
  101e4e:	5d                   	pop    %ebp
  101e4f:	c3                   	ret    

00101e50 <roundup>:
  101e50:	55                   	push   %ebp
  101e51:	89 e5                	mov    %esp,%ebp
  101e53:	8b 55 08             	mov    0x8(%ebp),%edx
  101e56:	8b 45 0c             	mov    0xc(%ebp),%eax
  101e59:	01 d0                	add    %edx,%eax
  101e5b:	83 e8 01             	sub    $0x1,%eax
  101e5e:	ff 75 0c             	push   0xc(%ebp)
  101e61:	50                   	push   %eax
  101e62:	e8 d4 ff ff ff       	call   101e3b <rounddown>
  101e67:	83 c4 08             	add    $0x8,%esp
  101e6a:	c9                   	leave  
  101e6b:	c3                   	ret    

00101e6c <lldt>:
  101e6c:	55                   	push   %ebp
  101e6d:	89 e5                	mov    %esp,%ebp
  101e6f:	83 ec 04             	sub    $0x4,%esp
  101e72:	8b 45 08             	mov    0x8(%ebp),%eax
  101e75:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  101e79:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
  101e7d:	0f 00 d0             	lldt   %ax
  101e80:	90                   	nop
  101e81:	c9                   	leave  
  101e82:	c3                   	ret    

00101e83 <cli>:
  101e83:	55                   	push   %ebp
  101e84:	89 e5                	mov    %esp,%ebp
  101e86:	fa                   	cli    
  101e87:	90                   	nop
  101e88:	5d                   	pop    %ebp
  101e89:	c3                   	ret    

00101e8a <sti>:
  101e8a:	55                   	push   %ebp
  101e8b:	89 e5                	mov    %esp,%ebp
  101e8d:	fb                   	sti    
  101e8e:	90                   	nop
  101e8f:	90                   	nop
  101e90:	5d                   	pop    %ebp
  101e91:	c3                   	ret    

00101e92 <rdmsr>:
  101e92:	55                   	push   %ebp
  101e93:	89 e5                	mov    %esp,%ebp
  101e95:	83 ec 10             	sub    $0x10,%esp
  101e98:	8b 45 08             	mov    0x8(%ebp),%eax
  101e9b:	89 c1                	mov    %eax,%ecx
  101e9d:	0f 32                	rdmsr  
  101e9f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  101ea2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  101ea5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101ea8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101eab:	c9                   	leave  
  101eac:	c3                   	ret    

00101ead <wrmsr>:
  101ead:	55                   	push   %ebp
  101eae:	89 e5                	mov    %esp,%ebp
  101eb0:	83 ec 08             	sub    $0x8,%esp
  101eb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  101eb6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  101eb9:	8b 45 10             	mov    0x10(%ebp),%eax
  101ebc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  101ebf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101ec2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101ec5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  101ec8:	0f 30                	wrmsr  
  101eca:	90                   	nop
  101ecb:	c9                   	leave  
  101ecc:	c3                   	ret    

00101ecd <halt>:
  101ecd:	55                   	push   %ebp
  101ece:	89 e5                	mov    %esp,%ebp
  101ed0:	f4                   	hlt    
  101ed1:	90                   	nop
  101ed2:	5d                   	pop    %ebp
  101ed3:	c3                   	ret    

00101ed4 <rdtsc>:
  101ed4:	55                   	push   %ebp
  101ed5:	89 e5                	mov    %esp,%ebp
  101ed7:	83 ec 10             	sub    $0x10,%esp
  101eda:	0f 31                	rdtsc  
  101edc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  101edf:	89 55 fc             	mov    %edx,-0x4(%ebp)
  101ee2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101ee5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101ee8:	c9                   	leave  
  101ee9:	c3                   	ret    

00101eea <enable_sse>:
  101eea:	55                   	push   %ebp
  101eeb:	89 e5                	mov    %esp,%ebp
  101eed:	83 ec 20             	sub    $0x20,%esp
  101ef0:	0f 20 e0             	mov    %cr4,%eax
  101ef3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  101ef6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101ef9:	80 cc 06             	or     $0x6,%ah
  101efc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  101eff:	0f ae f0             	mfence 
  101f02:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101f05:	89 45 f0             	mov    %eax,-0x10(%ebp)
  101f08:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101f0b:	0f 22 e0             	mov    %eax,%cr4
  101f0e:	90                   	nop
  101f0f:	0f 20 c0             	mov    %cr0,%eax
  101f12:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101f15:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f18:	83 c8 02             	or     $0x2,%eax
  101f1b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  101f1e:	0f ae f0             	mfence 
  101f21:	83 65 f8 f3          	andl   $0xfffffff3,-0x8(%ebp)
  101f25:	90                   	nop
  101f26:	c9                   	leave  
  101f27:	c3                   	ret    

00101f28 <cpuid>:
  101f28:	55                   	push   %ebp
  101f29:	89 e5                	mov    %esp,%ebp
  101f2b:	53                   	push   %ebx
  101f2c:	83 ec 10             	sub    $0x10,%esp
  101f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  101f32:	0f a2                	cpuid  
  101f34:	89 45 f8             	mov    %eax,-0x8(%ebp)
  101f37:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  101f3a:	89 4d f0             	mov    %ecx,-0x10(%ebp)
  101f3d:	89 55 ec             	mov    %edx,-0x14(%ebp)
  101f40:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  101f44:	74 08                	je     101f4e <cpuid+0x26>
  101f46:	8b 45 0c             	mov    0xc(%ebp),%eax
  101f49:	8b 55 f8             	mov    -0x8(%ebp),%edx
  101f4c:	89 10                	mov    %edx,(%eax)
  101f4e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  101f52:	74 08                	je     101f5c <cpuid+0x34>
  101f54:	8b 45 10             	mov    0x10(%ebp),%eax
  101f57:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101f5a:	89 10                	mov    %edx,(%eax)
  101f5c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
  101f60:	74 08                	je     101f6a <cpuid+0x42>
  101f62:	8b 45 14             	mov    0x14(%ebp),%eax
  101f65:	8b 55 f0             	mov    -0x10(%ebp),%edx
  101f68:	89 10                	mov    %edx,(%eax)
  101f6a:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
  101f6e:	74 08                	je     101f78 <cpuid+0x50>
  101f70:	8b 45 18             	mov    0x18(%ebp),%eax
  101f73:	8b 55 ec             	mov    -0x14(%ebp),%edx
  101f76:	89 10                	mov    %edx,(%eax)
  101f78:	90                   	nop
  101f79:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101f7c:	c9                   	leave  
  101f7d:	c3                   	ret    

00101f7e <rcr3>:
  101f7e:	55                   	push   %ebp
  101f7f:	89 e5                	mov    %esp,%ebp
  101f81:	83 ec 10             	sub    $0x10,%esp
  101f84:	0f 20 d8             	mov    %cr3,%eax
  101f87:	89 45 fc             	mov    %eax,-0x4(%ebp)
  101f8a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101f8d:	c9                   	leave  
  101f8e:	c3                   	ret    

00101f8f <outl>:
  101f8f:	55                   	push   %ebp
  101f90:	89 e5                	mov    %esp,%ebp
  101f92:	8b 45 0c             	mov    0xc(%ebp),%eax
  101f95:	8b 55 08             	mov    0x8(%ebp),%edx
  101f98:	ef                   	out    %eax,(%dx)
  101f99:	90                   	nop
  101f9a:	5d                   	pop    %ebp
  101f9b:	c3                   	ret    

00101f9c <inl>:
  101f9c:	55                   	push   %ebp
  101f9d:	89 e5                	mov    %esp,%ebp
  101f9f:	83 ec 10             	sub    $0x10,%esp
  101fa2:	8b 45 08             	mov    0x8(%ebp),%eax
  101fa5:	89 c2                	mov    %eax,%edx
  101fa7:	ed                   	in     (%dx),%eax
  101fa8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  101fab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101fae:	c9                   	leave  
  101faf:	c3                   	ret    

00101fb0 <smp_wmb>:
  101fb0:	55                   	push   %ebp
  101fb1:	89 e5                	mov    %esp,%ebp
  101fb3:	90                   	nop
  101fb4:	5d                   	pop    %ebp
  101fb5:	c3                   	ret    

00101fb6 <ltr>:
  101fb6:	55                   	push   %ebp
  101fb7:	89 e5                	mov    %esp,%ebp
  101fb9:	83 ec 04             	sub    $0x4,%esp
  101fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  101fbf:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  101fc3:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
  101fc7:	0f 00 d8             	ltr    %ax
  101fca:	90                   	nop
  101fcb:	c9                   	leave  
  101fcc:	c3                   	ret    

00101fcd <lcr0>:
  101fcd:	55                   	push   %ebp
  101fce:	89 e5                	mov    %esp,%ebp
  101fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  101fd3:	0f 22 c0             	mov    %eax,%cr0
  101fd6:	90                   	nop
  101fd7:	5d                   	pop    %ebp
  101fd8:	c3                   	ret    

00101fd9 <rcr0>:
  101fd9:	55                   	push   %ebp
  101fda:	89 e5                	mov    %esp,%ebp
  101fdc:	83 ec 10             	sub    $0x10,%esp
  101fdf:	0f 20 c0             	mov    %cr0,%eax
  101fe2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  101fe5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101fe8:	c9                   	leave  
  101fe9:	c3                   	ret    

00101fea <rcr2>:
  101fea:	55                   	push   %ebp
  101feb:	89 e5                	mov    %esp,%ebp
  101fed:	83 ec 10             	sub    $0x10,%esp
  101ff0:	0f 20 d0             	mov    %cr2,%eax
  101ff3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  101ff6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101ff9:	c9                   	leave  
  101ffa:	c3                   	ret    

00101ffb <lcr3>:
  101ffb:	55                   	push   %ebp
  101ffc:	89 e5                	mov    %esp,%ebp
  101ffe:	8b 45 08             	mov    0x8(%ebp),%eax
  102001:	0f 22 d8             	mov    %eax,%cr3
  102004:	90                   	nop
  102005:	5d                   	pop    %ebp
  102006:	c3                   	ret    

00102007 <lcr4>:
  102007:	55                   	push   %ebp
  102008:	89 e5                	mov    %esp,%ebp
  10200a:	8b 45 08             	mov    0x8(%ebp),%eax
  10200d:	0f 22 e0             	mov    %eax,%cr4
  102010:	90                   	nop
  102011:	5d                   	pop    %ebp
  102012:	c3                   	ret    

00102013 <rcr4>:
  102013:	55                   	push   %ebp
  102014:	89 e5                	mov    %esp,%ebp
  102016:	83 ec 10             	sub    $0x10,%esp
  102019:	0f 20 e0             	mov    %cr4,%eax
  10201c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10201f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102022:	c9                   	leave  
  102023:	c3                   	ret    

00102024 <inb>:
  102024:	55                   	push   %ebp
  102025:	89 e5                	mov    %esp,%ebp
  102027:	83 ec 10             	sub    $0x10,%esp
  10202a:	8b 45 08             	mov    0x8(%ebp),%eax
  10202d:	89 c2                	mov    %eax,%edx
  10202f:	ec                   	in     (%dx),%al
  102030:	88 45 ff             	mov    %al,-0x1(%ebp)
  102033:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
  102037:	c9                   	leave  
  102038:	c3                   	ret    

00102039 <insl>:
  102039:	55                   	push   %ebp
  10203a:	89 e5                	mov    %esp,%ebp
  10203c:	57                   	push   %edi
  10203d:	53                   	push   %ebx
  10203e:	8b 55 08             	mov    0x8(%ebp),%edx
  102041:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  102044:	8b 45 10             	mov    0x10(%ebp),%eax
  102047:	89 cb                	mov    %ecx,%ebx
  102049:	89 df                	mov    %ebx,%edi
  10204b:	89 c1                	mov    %eax,%ecx
  10204d:	fc                   	cld    
  10204e:	f2 6d                	repnz insl (%dx),%es:(%edi)
  102050:	89 c8                	mov    %ecx,%eax
  102052:	89 fb                	mov    %edi,%ebx
  102054:	89 5d 0c             	mov    %ebx,0xc(%ebp)
  102057:	89 45 10             	mov    %eax,0x10(%ebp)
  10205a:	90                   	nop
  10205b:	5b                   	pop    %ebx
  10205c:	5f                   	pop    %edi
  10205d:	5d                   	pop    %ebp
  10205e:	c3                   	ret    

0010205f <outb>:
  10205f:	55                   	push   %ebp
  102060:	89 e5                	mov    %esp,%ebp
  102062:	83 ec 04             	sub    $0x4,%esp
  102065:	8b 45 0c             	mov    0xc(%ebp),%eax
  102068:	88 45 fc             	mov    %al,-0x4(%ebp)
  10206b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  10206f:	8b 55 08             	mov    0x8(%ebp),%edx
  102072:	ee                   	out    %al,(%dx)
  102073:	90                   	nop
  102074:	c9                   	leave  
  102075:	c3                   	ret    

00102076 <outsw>:
  102076:	55                   	push   %ebp
  102077:	89 e5                	mov    %esp,%ebp
  102079:	56                   	push   %esi
  10207a:	53                   	push   %ebx
  10207b:	8b 55 08             	mov    0x8(%ebp),%edx
  10207e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  102081:	8b 45 10             	mov    0x10(%ebp),%eax
  102084:	89 cb                	mov    %ecx,%ebx
  102086:	89 de                	mov    %ebx,%esi
  102088:	89 c1                	mov    %eax,%ecx
  10208a:	fc                   	cld    
  10208b:	f2 66 6f             	repnz outsw %ds:(%esi),(%dx)
  10208e:	89 c8                	mov    %ecx,%eax
  102090:	89 f3                	mov    %esi,%ebx
  102092:	89 5d 0c             	mov    %ebx,0xc(%ebp)
  102095:	89 45 10             	mov    %eax,0x10(%ebp)
  102098:	90                   	nop
  102099:	5b                   	pop    %ebx
  10209a:	5e                   	pop    %esi
  10209b:	5d                   	pop    %ebp
  10209c:	c3                   	ret    

0010209d <mon_help>:
  10209d:	55                   	push   %ebp
  10209e:	89 e5                	mov    %esp,%ebp
  1020a0:	83 ec 18             	sub    $0x18,%esp
  1020a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1020aa:	eb 3c                	jmp    1020e8 <mon_help+0x4b>
  1020ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1020af:	89 d0                	mov    %edx,%eax
  1020b1:	01 c0                	add    %eax,%eax
  1020b3:	01 d0                	add    %edx,%eax
  1020b5:	c1 e0 02             	shl    $0x2,%eax
  1020b8:	05 14 75 10 00       	add    $0x107514,%eax
  1020bd:	8b 08                	mov    (%eax),%ecx
  1020bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1020c2:	89 d0                	mov    %edx,%eax
  1020c4:	01 c0                	add    %eax,%eax
  1020c6:	01 d0                	add    %edx,%eax
  1020c8:	c1 e0 02             	shl    $0x2,%eax
  1020cb:	05 10 75 10 00       	add    $0x107510,%eax
  1020d0:	8b 00                	mov    (%eax),%eax
  1020d2:	83 ec 04             	sub    $0x4,%esp
  1020d5:	51                   	push   %ecx
  1020d6:	50                   	push   %eax
  1020d7:	68 1d 43 10 00       	push   $0x10431d
  1020dc:	e8 9f f3 ff ff       	call   101480 <dprintf>
  1020e1:	83 c4 10             	add    $0x10,%esp
  1020e4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1020e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1020eb:	83 f8 01             	cmp    $0x1,%eax
  1020ee:	76 bc                	jbe    1020ac <mon_help+0xf>
  1020f0:	b8 00 00 00 00       	mov    $0x0,%eax
  1020f5:	c9                   	leave  
  1020f6:	c3                   	ret    

001020f7 <mon_kerninfo>:
  1020f7:	55                   	push   %ebp
  1020f8:	89 e5                	mov    %esp,%ebp
  1020fa:	83 ec 18             	sub    $0x18,%esp
  1020fd:	83 ec 0c             	sub    $0xc,%esp
  102100:	68 26 43 10 00       	push   $0x104326
  102105:	e8 76 f3 ff ff       	call   101480 <dprintf>
  10210a:	83 c4 10             	add    $0x10,%esp
  10210d:	83 ec 08             	sub    $0x8,%esp
  102110:	68 e4 24 10 00       	push   $0x1024e4
  102115:	68 3f 43 10 00       	push   $0x10433f
  10211a:	e8 61 f3 ff ff       	call   101480 <dprintf>
  10211f:	83 c4 10             	add    $0x10,%esp
  102122:	83 ec 08             	sub    $0x8,%esp
  102125:	68 df 30 10 00       	push   $0x1030df
  10212a:	68 4e 43 10 00       	push   $0x10434e
  10212f:	e8 4c f3 ff ff       	call   101480 <dprintf>
  102134:	83 c4 10             	add    $0x10,%esp
  102137:	83 ec 08             	sub    $0x8,%esp
  10213a:	68 40 75 10 00       	push   $0x107540
  10213f:	68 5d 43 10 00       	push   $0x10435d
  102144:	e8 37 f3 ff ff       	call   101480 <dprintf>
  102149:	83 c4 10             	add    $0x10,%esp
  10214c:	83 ec 08             	sub    $0x8,%esp
  10214f:	68 44 ec 94 00       	push   $0x94ec44
  102154:	68 6c 43 10 00       	push   $0x10436c
  102159:	e8 22 f3 ff ff       	call   101480 <dprintf>
  10215e:	83 c4 10             	add    $0x10,%esp
  102161:	b8 44 ec 94 00       	mov    $0x94ec44,%eax
  102166:	2d e4 24 10 00       	sub    $0x1024e4,%eax
  10216b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10216e:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
  102175:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102178:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10217b:	01 d0                	add    %edx,%eax
  10217d:	83 e8 01             	sub    $0x1,%eax
  102180:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102183:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102186:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102189:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10218c:	99                   	cltd   
  10218d:	f7 7d e8             	idivl  -0x18(%ebp)
  102190:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102193:	29 d0                	sub    %edx,%eax
  102195:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  10219b:	85 c0                	test   %eax,%eax
  10219d:	0f 48 c2             	cmovs  %edx,%eax
  1021a0:	c1 f8 0a             	sar    $0xa,%eax
  1021a3:	83 ec 08             	sub    $0x8,%esp
  1021a6:	50                   	push   %eax
  1021a7:	68 7c 43 10 00       	push   $0x10437c
  1021ac:	e8 cf f2 ff ff       	call   101480 <dprintf>
  1021b1:	83 c4 10             	add    $0x10,%esp
  1021b4:	b8 00 00 00 00       	mov    $0x0,%eax
  1021b9:	c9                   	leave  
  1021ba:	c3                   	ret    

001021bb <mon_backtrace>:
  1021bb:	55                   	push   %ebp
  1021bc:	89 e5                	mov    %esp,%ebp
  1021be:	b8 00 00 00 00       	mov    $0x0,%eax
  1021c3:	5d                   	pop    %ebp
  1021c4:	c3                   	ret    

001021c5 <runcmd>:
  1021c5:	55                   	push   %ebp
  1021c6:	89 e5                	mov    %esp,%ebp
  1021c8:	83 ec 58             	sub    $0x58,%esp
  1021cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1021d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1021d5:	c7 44 85 b0 00 00 00 	movl   $0x0,-0x50(%ebp,%eax,4)
  1021dc:	00 
  1021dd:	eb 0c                	jmp    1021eb <runcmd+0x26>
  1021df:	8b 45 08             	mov    0x8(%ebp),%eax
  1021e2:	8d 50 01             	lea    0x1(%eax),%edx
  1021e5:	89 55 08             	mov    %edx,0x8(%ebp)
  1021e8:	c6 00 00             	movb   $0x0,(%eax)
  1021eb:	8b 45 08             	mov    0x8(%ebp),%eax
  1021ee:	0f b6 00             	movzbl (%eax),%eax
  1021f1:	84 c0                	test   %al,%al
  1021f3:	74 1e                	je     102213 <runcmd+0x4e>
  1021f5:	8b 45 08             	mov    0x8(%ebp),%eax
  1021f8:	0f b6 00             	movzbl (%eax),%eax
  1021fb:	0f be c0             	movsbl %al,%eax
  1021fe:	83 ec 08             	sub    $0x8,%esp
  102201:	50                   	push   %eax
  102202:	68 a6 43 10 00       	push   $0x1043a6
  102207:	e8 a4 ef ff ff       	call   1011b0 <strchr>
  10220c:	83 c4 10             	add    $0x10,%esp
  10220f:	85 c0                	test   %eax,%eax
  102211:	75 cc                	jne    1021df <runcmd+0x1a>
  102213:	8b 45 08             	mov    0x8(%ebp),%eax
  102216:	0f b6 00             	movzbl (%eax),%eax
  102219:	84 c0                	test   %al,%al
  10221b:	74 65                	je     102282 <runcmd+0xbd>
  10221d:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  102221:	75 1c                	jne    10223f <runcmd+0x7a>
  102223:	83 ec 08             	sub    $0x8,%esp
  102226:	6a 10                	push   $0x10
  102228:	68 ab 43 10 00       	push   $0x1043ab
  10222d:	e8 4e f2 ff ff       	call   101480 <dprintf>
  102232:	83 c4 10             	add    $0x10,%esp
  102235:	b8 00 00 00 00       	mov    $0x0,%eax
  10223a:	e9 d8 00 00 00       	jmp    102317 <runcmd+0x152>
  10223f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102242:	8d 50 01             	lea    0x1(%eax),%edx
  102245:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102248:	8b 55 08             	mov    0x8(%ebp),%edx
  10224b:	89 54 85 b0          	mov    %edx,-0x50(%ebp,%eax,4)
  10224f:	eb 04                	jmp    102255 <runcmd+0x90>
  102251:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102255:	8b 45 08             	mov    0x8(%ebp),%eax
  102258:	0f b6 00             	movzbl (%eax),%eax
  10225b:	84 c0                	test   %al,%al
  10225d:	74 8c                	je     1021eb <runcmd+0x26>
  10225f:	8b 45 08             	mov    0x8(%ebp),%eax
  102262:	0f b6 00             	movzbl (%eax),%eax
  102265:	0f be c0             	movsbl %al,%eax
  102268:	83 ec 08             	sub    $0x8,%esp
  10226b:	50                   	push   %eax
  10226c:	68 a6 43 10 00       	push   $0x1043a6
  102271:	e8 3a ef ff ff       	call   1011b0 <strchr>
  102276:	83 c4 10             	add    $0x10,%esp
  102279:	85 c0                	test   %eax,%eax
  10227b:	74 d4                	je     102251 <runcmd+0x8c>
  10227d:	e9 69 ff ff ff       	jmp    1021eb <runcmd+0x26>
  102282:	90                   	nop
  102283:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102286:	c7 44 85 b0 00 00 00 	movl   $0x0,-0x50(%ebp,%eax,4)
  10228d:	00 
  10228e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  102292:	75 07                	jne    10229b <runcmd+0xd6>
  102294:	b8 00 00 00 00       	mov    $0x0,%eax
  102299:	eb 7c                	jmp    102317 <runcmd+0x152>
  10229b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  1022a2:	eb 52                	jmp    1022f6 <runcmd+0x131>
  1022a4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1022a7:	89 d0                	mov    %edx,%eax
  1022a9:	01 c0                	add    %eax,%eax
  1022ab:	01 d0                	add    %edx,%eax
  1022ad:	c1 e0 02             	shl    $0x2,%eax
  1022b0:	05 10 75 10 00       	add    $0x107510,%eax
  1022b5:	8b 10                	mov    (%eax),%edx
  1022b7:	8b 45 b0             	mov    -0x50(%ebp),%eax
  1022ba:	83 ec 08             	sub    $0x8,%esp
  1022bd:	52                   	push   %edx
  1022be:	50                   	push   %eax
  1022bf:	e8 ad ee ff ff       	call   101171 <strcmp>
  1022c4:	83 c4 10             	add    $0x10,%esp
  1022c7:	85 c0                	test   %eax,%eax
  1022c9:	75 27                	jne    1022f2 <runcmd+0x12d>
  1022cb:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1022ce:	89 d0                	mov    %edx,%eax
  1022d0:	01 c0                	add    %eax,%eax
  1022d2:	01 d0                	add    %edx,%eax
  1022d4:	c1 e0 02             	shl    $0x2,%eax
  1022d7:	05 18 75 10 00       	add    $0x107518,%eax
  1022dc:	8b 00                	mov    (%eax),%eax
  1022de:	83 ec 04             	sub    $0x4,%esp
  1022e1:	ff 75 0c             	push   0xc(%ebp)
  1022e4:	8d 55 b0             	lea    -0x50(%ebp),%edx
  1022e7:	52                   	push   %edx
  1022e8:	ff 75 f4             	push   -0xc(%ebp)
  1022eb:	ff d0                	call   *%eax
  1022ed:	83 c4 10             	add    $0x10,%esp
  1022f0:	eb 25                	jmp    102317 <runcmd+0x152>
  1022f2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  1022f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1022f9:	83 f8 01             	cmp    $0x1,%eax
  1022fc:	76 a6                	jbe    1022a4 <runcmd+0xdf>
  1022fe:	8b 45 b0             	mov    -0x50(%ebp),%eax
  102301:	83 ec 08             	sub    $0x8,%esp
  102304:	50                   	push   %eax
  102305:	68 c8 43 10 00       	push   $0x1043c8
  10230a:	e8 71 f1 ff ff       	call   101480 <dprintf>
  10230f:	83 c4 10             	add    $0x10,%esp
  102312:	b8 00 00 00 00       	mov    $0x0,%eax
  102317:	c9                   	leave  
  102318:	c3                   	ret    

00102319 <monitor>:
  102319:	55                   	push   %ebp
  10231a:	89 e5                	mov    %esp,%ebp
  10231c:	83 ec 18             	sub    $0x18,%esp
  10231f:	83 ec 0c             	sub    $0xc,%esp
  102322:	68 e0 43 10 00       	push   $0x1043e0
  102327:	e8 54 f1 ff ff       	call   101480 <dprintf>
  10232c:	83 c4 10             	add    $0x10,%esp
  10232f:	83 ec 0c             	sub    $0xc,%esp
  102332:	68 0c 44 10 00       	push   $0x10440c
  102337:	e8 44 f1 ff ff       	call   101480 <dprintf>
  10233c:	83 c4 10             	add    $0x10,%esp
  10233f:	83 ec 0c             	sub    $0xc,%esp
  102342:	68 e0 43 10 00       	push   $0x1043e0
  102347:	e8 34 f1 ff ff       	call   101480 <dprintf>
  10234c:	83 c4 10             	add    $0x10,%esp
  10234f:	83 ec 0c             	sub    $0xc,%esp
  102352:	68 38 44 10 00       	push   $0x104438
  102357:	e8 24 f1 ff ff       	call   101480 <dprintf>
  10235c:	83 c4 10             	add    $0x10,%esp
  10235f:	83 ec 0c             	sub    $0xc,%esp
  102362:	68 5d 44 10 00       	push   $0x10445d
  102367:	e8 41 e1 ff ff       	call   1004ad <readline>
  10236c:	83 c4 10             	add    $0x10,%esp
  10236f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102372:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  102376:	74 e7                	je     10235f <monitor+0x46>
  102378:	83 ec 08             	sub    $0x8,%esp
  10237b:	ff 75 08             	push   0x8(%ebp)
  10237e:	ff 75 f4             	push   -0xc(%ebp)
  102381:	e8 3f fe ff ff       	call   1021c5 <runcmd>
  102386:	83 c4 10             	add    $0x10,%esp
  102389:	85 c0                	test   %eax,%eax
  10238b:	78 02                	js     10238f <monitor+0x76>
  10238d:	eb d0                	jmp    10235f <monitor+0x46>
  10238f:	90                   	nop
  102390:	90                   	nop
  102391:	c9                   	leave  
  102392:	c3                   	ret    
  102393:	66 90                	xchg   %ax,%ax
  102395:	66 90                	xchg   %ax,%ax
  102397:	66 90                	xchg   %ax,%ax
  102399:	66 90                	xchg   %ax,%ax
  10239b:	66 90                	xchg   %ax,%ax
  10239d:	66 90                	xchg   %ax,%ax
  10239f:	90                   	nop

001023a0 <kern_init>:

    monitor(NULL);
}

void kern_init(uintptr_t mbi_addr)
{
  1023a0:	83 ec 18             	sub    $0x18,%esp
    pmem_init(mbi_addr);
  1023a3:	ff 74 24 1c          	push   0x1c(%esp)
  1023a7:	e8 a4 05 00 00       	call   102950 <pmem_init>

    KERN_DEBUG("Kernel initialized.\n");
  1023ac:	83 c4 0c             	add    $0xc,%esp
  1023af:	68 61 44 10 00       	push   $0x104461
  1023b4:	6a 31                	push   $0x31
  1023b6:	68 76 44 10 00       	push   $0x104476
  1023bb:	e8 59 ee ff ff       	call   101219 <debug_normal>
    KERN_DEBUG("In kernel main.\n\n");
  1023c0:	83 c4 0c             	add    $0xc,%esp
  1023c3:	68 87 44 10 00       	push   $0x104487
  1023c8:	6a 11                	push   $0x11
  1023ca:	68 76 44 10 00       	push   $0x104476
  1023cf:	e8 45 ee ff ff       	call   101219 <debug_normal>
    dprintf("Testing the MATIntro layer...\n");
  1023d4:	c7 04 24 f4 44 10 00 	movl   $0x1044f4,(%esp)
  1023db:	e8 a0 f0 ff ff       	call   101480 <dprintf>
    if (test_MATIntro() == 0)
  1023e0:	e8 4b 05 00 00       	call   102930 <test_MATIntro>
  1023e5:	83 c4 10             	add    $0x10,%esp
  1023e8:	84 c0                	test   %al,%al
  1023ea:	0f 85 a0 00 00 00    	jne    102490 <kern_init+0xf0>
        dprintf("All tests passed.\n");
  1023f0:	83 ec 0c             	sub    $0xc,%esp
  1023f3:	68 99 44 10 00       	push   $0x104499
  1023f8:	e8 83 f0 ff ff       	call   101480 <dprintf>
  1023fd:	83 c4 10             	add    $0x10,%esp
    dprintf("\n");
  102400:	83 ec 0c             	sub    $0xc,%esp
  102403:	68 97 44 10 00       	push   $0x104497
  102408:	e8 73 f0 ff ff       	call   101480 <dprintf>
    dprintf("Testing the MATInit layer...\n");
  10240d:	c7 04 24 ba 44 10 00 	movl   $0x1044ba,(%esp)
  102414:	e8 67 f0 ff ff       	call   101480 <dprintf>
    if (test_MATInit() == 0)
  102419:	e8 d2 07 00 00       	call   102bf0 <test_MATInit>
  10241e:	83 c4 10             	add    $0x10,%esp
  102421:	84 c0                	test   %al,%al
  102423:	0f 85 97 00 00 00    	jne    1024c0 <kern_init+0x120>
        dprintf("All tests passed.\n");
  102429:	83 ec 0c             	sub    $0xc,%esp
  10242c:	68 99 44 10 00       	push   $0x104499
  102431:	e8 4a f0 ff ff       	call   101480 <dprintf>
  102436:	83 c4 10             	add    $0x10,%esp
    dprintf("\n");
  102439:	83 ec 0c             	sub    $0xc,%esp
  10243c:	68 97 44 10 00       	push   $0x104497
  102441:	e8 3a f0 ff ff       	call   101480 <dprintf>
    dprintf("Testing the MATOp layer...\n");
  102446:	c7 04 24 d8 44 10 00 	movl   $0x1044d8,(%esp)
  10244d:	e8 2e f0 ff ff       	call   101480 <dprintf>
    if (test_MATOp() == 0)
  102452:	e8 19 0a 00 00       	call   102e70 <test_MATOp>
  102457:	83 c4 10             	add    $0x10,%esp
  10245a:	84 c0                	test   %al,%al
  10245c:	75 4a                	jne    1024a8 <kern_init+0x108>
        dprintf("All tests passed.\n");
  10245e:	83 ec 0c             	sub    $0xc,%esp
  102461:	68 99 44 10 00       	push   $0x104499
  102466:	e8 15 f0 ff ff       	call   101480 <dprintf>
  10246b:	83 c4 10             	add    $0x10,%esp
    dprintf("\n");
  10246e:	83 ec 0c             	sub    $0xc,%esp
  102471:	68 97 44 10 00       	push   $0x104497
  102476:	e8 05 f0 ff ff       	call   101480 <dprintf>
    monitor(NULL);
  10247b:	c7 44 24 20 00 00 00 	movl   $0x0,0x20(%esp)
  102482:	00 

    kern_main();
}
  102483:	83 c4 1c             	add    $0x1c,%esp
    monitor(NULL);
  102486:	e9 8e fe ff ff       	jmp    102319 <monitor>
  10248b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10248f:	90                   	nop
        dprintf("Test failed.\n");
  102490:	83 ec 0c             	sub    $0xc,%esp
  102493:	68 ac 44 10 00       	push   $0x1044ac
  102498:	e8 e3 ef ff ff       	call   101480 <dprintf>
  10249d:	83 c4 10             	add    $0x10,%esp
  1024a0:	e9 5b ff ff ff       	jmp    102400 <kern_init+0x60>
  1024a5:	8d 76 00             	lea    0x0(%esi),%esi
        dprintf("Test failed.\n");
  1024a8:	83 ec 0c             	sub    $0xc,%esp
  1024ab:	68 ac 44 10 00       	push   $0x1044ac
  1024b0:	e8 cb ef ff ff       	call   101480 <dprintf>
  1024b5:	83 c4 10             	add    $0x10,%esp
  1024b8:	eb b4                	jmp    10246e <kern_init+0xce>
  1024ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        dprintf("Test failed.\n");
  1024c0:	83 ec 0c             	sub    $0xc,%esp
  1024c3:	68 ac 44 10 00       	push   $0x1044ac
  1024c8:	e8 b3 ef ff ff       	call   101480 <dprintf>
  1024cd:	83 c4 10             	add    $0x10,%esp
  1024d0:	e9 64 ff ff ff       	jmp    102439 <kern_init+0x99>
  1024d5:	66 90                	xchg   %ax,%ax
  1024d7:	90                   	nop
  1024d8:	02 b0 ad 1b 03 00    	add    0x31bad(%eax),%dh
  1024de:	00 00                	add    %al,(%eax)
  1024e0:	fb                   	sti    
  1024e1:	4f                   	dec    %edi
  1024e2:	52                   	push   %edx
  1024e3:	e4                   	.byte 0xe4

001024e4 <start>:
  1024e4:	fa                   	cli    
  1024e5:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
  1024ea:	75 27                	jne    102513 <spin>
  1024ec:	89 1d 14 25 10 00    	mov    %ebx,0x102514
  1024f2:	66 c7 05 72 04 00 00 	movw   $0x1234,0x472
  1024f9:	34 12 
  1024fb:	6a 02                	push   $0x2
  1024fd:	9d                   	popf   
  1024fe:	bd 00 00 00 00       	mov    $0x0,%ebp
  102503:	bc 00 b0 10 00       	mov    $0x10b000,%esp
  102508:	ff 35 14 25 10 00    	push   0x102514
  10250e:	e8 8d fe ff ff       	call   1023a0 <kern_init>

00102513 <spin>:
  102513:	f4                   	hlt    

00102514 <multiboot_ptr>:
  102514:	00 00                	add    %al,(%eax)
  102516:	00 00                	add    %al,(%eax)
  102518:	66 90                	xchg   %ax,%ax
  10251a:	66 90                	xchg   %ax,%ax
  10251c:	66 90                	xchg   %ax,%ax
  10251e:	66 90                	xchg   %ax,%ax

00102520 <get_nps>:

// The getter function for NUM_PAGES.
unsigned int get_nps(void)
{
    return NUM_PAGES;
}
  102520:	a1 40 ec 94 00       	mov    0x94ec40,%eax
  102525:	c3                   	ret    
  102526:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10252d:	8d 76 00             	lea    0x0(%esi),%esi

00102530 <set_nps>:

// The setter function for NUM_PAGES.
void set_nps(unsigned int nps)
{
    NUM_PAGES = nps;
  102530:	8b 44 24 04          	mov    0x4(%esp),%eax
  102534:	a3 40 ec 94 00       	mov    %eax,0x94ec40
}
  102539:	c3                   	ret    
  10253a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102540 <at_is_norm>:
 * If the page with the given index has the normal permission,
 * then returns 1, otherwise returns 0.
 */
unsigned int at_is_norm(unsigned int page_index)
{
    if (AT[page_index].perm > 1) {
  102540:	8b 44 24 04          	mov    0x4(%esp),%eax
  102544:	83 3c c5 40 ec 14 00 	cmpl   $0x1,0x14ec40(,%eax,8)
  10254b:	01 
  10254c:	0f 97 c0             	seta   %al
  10254f:	0f b6 c0             	movzbl %al,%eax
        return 1;
    } else {
        return 0;
    }
}
  102552:	c3                   	ret    
  102553:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10255a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102560 <at_set_perm>:
 * The setter function for the physical page permission.
 * Sets the permission of the page with given index.
 * It also marks the page as unallocated.
 */
void at_set_perm(unsigned int page_index, unsigned int perm)
{
  102560:	8b 44 24 04          	mov    0x4(%esp),%eax
    AT[page_index].perm = perm;
  102564:	8b 54 24 08          	mov    0x8(%esp),%edx
    AT[page_index].allocated = 0;
  102568:	c7 04 c5 44 ec 14 00 	movl   $0x0,0x14ec44(,%eax,8)
  10256f:	00 00 00 00 
    AT[page_index].perm = perm;
  102573:	89 14 c5 40 ec 14 00 	mov    %edx,0x14ec40(,%eax,8)
    return;
}
  10257a:	c3                   	ret    
  10257b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10257f:	90                   	nop

00102580 <at_is_allocated>:
 * The getter function for the physical page allocation flag.
 * Returns 0 if the page is not allocated, otherwise returns 1.
 */
unsigned int at_is_allocated(unsigned int page_index)
{
    if (AT[page_index].allocated == 0) {
  102580:	8b 44 24 04          	mov    0x4(%esp),%eax
  102584:	8b 04 c5 44 ec 14 00 	mov    0x14ec44(,%eax,8),%eax
  10258b:	85 c0                	test   %eax,%eax
  10258d:	0f 95 c0             	setne  %al
  102590:	0f b6 c0             	movzbl %al,%eax
        return 0;
    } else {
        return 1;
    }
}
  102593:	c3                   	ret    
  102594:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10259b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10259f:	90                   	nop

001025a0 <at_set_allocated>:
 * The setter function for the physical page allocation flag.
 * Set the flag of the page with given index to the given value.
 */
void at_set_allocated(unsigned int page_index, unsigned int allocated)
{
    AT[page_index].allocated = allocated;
  1025a0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1025a4:	8b 54 24 08          	mov    0x8(%esp),%edx
  1025a8:	89 14 c5 44 ec 14 00 	mov    %edx,0x14ec44(,%eax,8)
    return;
}
  1025af:	c3                   	ret    

001025b0 <MATIntro_test1>:
#include <lib/debug.h>
#include "export.h"

int MATIntro_test1()
{
  1025b0:	57                   	push   %edi
  1025b1:	56                   	push   %esi
  1025b2:	53                   	push   %ebx
    int rn10[] = { 1, 3, 5, 6, 78, 3576, 32, 8, 0, 100 };
    int i;
    int nps = get_nps();
    for (i = 0; i < 10; i++) {
  1025b3:	31 db                	xor    %ebx,%ebx
{
  1025b5:	83 ec 30             	sub    $0x30,%esp
    int rn10[] = { 1, 3, 5, 6, 78, 3576, 32, 8, 0, 100 };
  1025b8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  1025bf:	00 
  1025c0:	c7 44 24 0c 03 00 00 	movl   $0x3,0xc(%esp)
  1025c7:	00 
  1025c8:	c7 44 24 10 05 00 00 	movl   $0x5,0x10(%esp)
  1025cf:	00 
  1025d0:	c7 44 24 14 06 00 00 	movl   $0x6,0x14(%esp)
  1025d7:	00 
  1025d8:	c7 44 24 18 4e 00 00 	movl   $0x4e,0x18(%esp)
  1025df:	00 
  1025e0:	c7 44 24 1c f8 0d 00 	movl   $0xdf8,0x1c(%esp)
  1025e7:	00 
  1025e8:	c7 44 24 20 20 00 00 	movl   $0x20,0x20(%esp)
  1025ef:	00 
  1025f0:	c7 44 24 24 08 00 00 	movl   $0x8,0x24(%esp)
  1025f7:	00 
  1025f8:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  1025ff:	00 
  102600:	c7 44 24 2c 64 00 00 	movl   $0x64,0x2c(%esp)
  102607:	00 
    int nps = get_nps();
  102608:	e8 13 ff ff ff       	call   102520 <get_nps>
  10260d:	89 c7                	mov    %eax,%edi
    for (i = 0; i < 10; i++) {
  10260f:	90                   	nop
        set_nps(rn10[i]);
  102610:	8b 74 9c 08          	mov    0x8(%esp,%ebx,4),%esi
  102614:	83 ec 0c             	sub    $0xc,%esp
  102617:	56                   	push   %esi
  102618:	e8 13 ff ff ff       	call   102530 <set_nps>
        if (get_nps() != rn10[i]) {
  10261d:	e8 fe fe ff ff       	call   102520 <get_nps>
  102622:	83 c4 10             	add    $0x10,%esp
  102625:	39 c6                	cmp    %eax,%esi
  102627:	75 2f                	jne    102658 <MATIntro_test1+0xa8>
    for (i = 0; i < 10; i++) {
  102629:	83 c3 01             	add    $0x1,%ebx
  10262c:	83 fb 0a             	cmp    $0xa,%ebx
  10262f:	75 df                	jne    102610 <MATIntro_test1+0x60>
            dprintf("test 1.1 failed (i = %d): (%d != %d)\n", i, get_nps(), rn10[i]);
            set_nps(nps);
            return 1;
        }
    }
    set_nps(nps);
  102631:	83 ec 0c             	sub    $0xc,%esp
  102634:	57                   	push   %edi
  102635:	e8 f6 fe ff ff       	call   102530 <set_nps>
    dprintf("test 1 passed.\n");
  10263a:	c7 04 24 db 45 10 00 	movl   $0x1045db,(%esp)
  102641:	e8 3a ee ff ff       	call   101480 <dprintf>
    return 0;
  102646:	83 c4 10             	add    $0x10,%esp
  102649:	31 c0                	xor    %eax,%eax
}
  10264b:	83 c4 30             	add    $0x30,%esp
  10264e:	5b                   	pop    %ebx
  10264f:	5e                   	pop    %esi
  102650:	5f                   	pop    %edi
  102651:	c3                   	ret    
  102652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            dprintf("test 1.1 failed (i = %d): (%d != %d)\n", i, get_nps(), rn10[i]);
  102658:	e8 c3 fe ff ff       	call   102520 <get_nps>
  10265d:	56                   	push   %esi
  10265e:	50                   	push   %eax
  10265f:	53                   	push   %ebx
  102660:	68 14 45 10 00       	push   $0x104514
  102665:	e8 16 ee ff ff       	call   101480 <dprintf>
            set_nps(nps);
  10266a:	89 3c 24             	mov    %edi,(%esp)
  10266d:	e8 be fe ff ff       	call   102530 <set_nps>
            return 1;
  102672:	83 c4 10             	add    $0x10,%esp
  102675:	b8 01 00 00 00       	mov    $0x1,%eax
}
  10267a:	83 c4 30             	add    $0x30,%esp
  10267d:	5b                   	pop    %ebx
  10267e:	5e                   	pop    %esi
  10267f:	5f                   	pop    %edi
  102680:	c3                   	ret    
  102681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10268f:	90                   	nop

00102690 <MATIntro_test2>:

int MATIntro_test2()
{
  102690:	53                   	push   %ebx
  102691:	83 ec 10             	sub    $0x10,%esp
    at_set_perm(0, 0);
  102694:	6a 00                	push   $0x0
  102696:	6a 00                	push   $0x0
  102698:	e8 c3 fe ff ff       	call   102560 <at_set_perm>
    if (at_is_norm(0) != 0 || at_is_allocated(0) != 0) {
  10269d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1026a4:	e8 97 fe ff ff       	call   102540 <at_is_norm>
  1026a9:	83 c4 10             	add    $0x10,%esp
  1026ac:	85 c0                	test   %eax,%eax
  1026ae:	75 11                	jne    1026c1 <MATIntro_test2+0x31>
  1026b0:	83 ec 0c             	sub    $0xc,%esp
  1026b3:	6a 00                	push   $0x0
  1026b5:	e8 c6 fe ff ff       	call   102580 <at_is_allocated>
  1026ba:	83 c4 10             	add    $0x10,%esp
  1026bd:	85 c0                	test   %eax,%eax
  1026bf:	74 3f                	je     102700 <MATIntro_test2+0x70>
        dprintf("test 2.1 failed: (%d != 0 || %d != 0)\n", at_is_norm(0), at_is_allocated(0));
  1026c1:	83 ec 0c             	sub    $0xc,%esp
  1026c4:	6a 00                	push   $0x0
  1026c6:	e8 b5 fe ff ff       	call   102580 <at_is_allocated>
  1026cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1026d2:	89 c3                	mov    %eax,%ebx
  1026d4:	e8 67 fe ff ff       	call   102540 <at_is_norm>
  1026d9:	83 c4 0c             	add    $0xc,%esp
  1026dc:	53                   	push   %ebx
  1026dd:	50                   	push   %eax
  1026de:	68 3c 45 10 00       	push   $0x10453c
        at_set_perm(0, 0);
        return 1;
    }
    at_set_perm(0, 1);
    if (at_is_norm(0) != 0 || at_is_allocated(0) != 0) {
        dprintf("test 2.2 failed: (%d != 0 || %d != 0)\n", at_is_norm(0), at_is_allocated(0));
  1026e3:	e8 98 ed ff ff       	call   101480 <dprintf>
        at_set_perm(0, 0);
  1026e8:	58                   	pop    %eax
  1026e9:	5a                   	pop    %edx
  1026ea:	6a 00                	push   $0x0
  1026ec:	6a 00                	push   $0x0
  1026ee:	e8 6d fe ff ff       	call   102560 <at_set_perm>
        return 1;
  1026f3:	83 c4 10             	add    $0x10,%esp
        return 1;
  1026f6:	b8 01 00 00 00       	mov    $0x1,%eax
        return 1;
    }
    at_set_perm(0, 0);
    dprintf("test 2 passed.\n");
    return 0;
}
  1026fb:	83 c4 08             	add    $0x8,%esp
  1026fe:	5b                   	pop    %ebx
  1026ff:	c3                   	ret    
    at_set_perm(0, 1);
  102700:	83 ec 08             	sub    $0x8,%esp
  102703:	6a 01                	push   $0x1
  102705:	6a 00                	push   $0x0
  102707:	e8 54 fe ff ff       	call   102560 <at_set_perm>
    if (at_is_norm(0) != 0 || at_is_allocated(0) != 0) {
  10270c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  102713:	e8 28 fe ff ff       	call   102540 <at_is_norm>
  102718:	83 c4 10             	add    $0x10,%esp
  10271b:	85 c0                	test   %eax,%eax
  10271d:	75 11                	jne    102730 <MATIntro_test2+0xa0>
  10271f:	83 ec 0c             	sub    $0xc,%esp
  102722:	6a 00                	push   $0x0
  102724:	e8 57 fe ff ff       	call   102580 <at_is_allocated>
  102729:	83 c4 10             	add    $0x10,%esp
  10272c:	85 c0                	test   %eax,%eax
  10272e:	74 28                	je     102758 <MATIntro_test2+0xc8>
        dprintf("test 2.2 failed: (%d != 0 || %d != 0)\n", at_is_norm(0), at_is_allocated(0));
  102730:	83 ec 0c             	sub    $0xc,%esp
  102733:	6a 00                	push   $0x0
  102735:	e8 46 fe ff ff       	call   102580 <at_is_allocated>
  10273a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  102741:	89 c3                	mov    %eax,%ebx
  102743:	e8 f8 fd ff ff       	call   102540 <at_is_norm>
  102748:	83 c4 0c             	add    $0xc,%esp
  10274b:	53                   	push   %ebx
  10274c:	50                   	push   %eax
  10274d:	68 64 45 10 00       	push   $0x104564
  102752:	eb 8f                	jmp    1026e3 <MATIntro_test2+0x53>
  102754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    at_set_perm(0, 2);
  102758:	83 ec 08             	sub    $0x8,%esp
  10275b:	6a 02                	push   $0x2
  10275d:	6a 00                	push   $0x0
  10275f:	e8 fc fd ff ff       	call   102560 <at_set_perm>
    if (at_is_norm(0) != 1 || at_is_allocated(0) != 0) {
  102764:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10276b:	e8 d0 fd ff ff       	call   102540 <at_is_norm>
  102770:	83 c4 10             	add    $0x10,%esp
  102773:	83 f8 01             	cmp    $0x1,%eax
  102776:	75 11                	jne    102789 <MATIntro_test2+0xf9>
  102778:	83 ec 0c             	sub    $0xc,%esp
  10277b:	6a 00                	push   $0x0
  10277d:	e8 fe fd ff ff       	call   102580 <at_is_allocated>
  102782:	83 c4 10             	add    $0x10,%esp
  102785:	85 c0                	test   %eax,%eax
  102787:	74 27                	je     1027b0 <MATIntro_test2+0x120>
        dprintf("test 2.3 failed: (%d != 1 || %d != 0)\n", at_is_norm(0), at_is_allocated(0));
  102789:	83 ec 0c             	sub    $0xc,%esp
  10278c:	6a 00                	push   $0x0
  10278e:	e8 ed fd ff ff       	call   102580 <at_is_allocated>
  102793:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10279a:	89 c3                	mov    %eax,%ebx
  10279c:	e8 9f fd ff ff       	call   102540 <at_is_norm>
  1027a1:	83 c4 0c             	add    $0xc,%esp
  1027a4:	53                   	push   %ebx
  1027a5:	50                   	push   %eax
  1027a6:	68 8c 45 10 00       	push   $0x10458c
  1027ab:	e9 33 ff ff ff       	jmp    1026e3 <MATIntro_test2+0x53>
    at_set_perm(0, 100);
  1027b0:	83 ec 08             	sub    $0x8,%esp
  1027b3:	6a 64                	push   $0x64
  1027b5:	6a 00                	push   $0x0
  1027b7:	e8 a4 fd ff ff       	call   102560 <at_set_perm>
    if (at_is_norm(0) != 1 || at_is_allocated(0) != 0) {
  1027bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1027c3:	e8 78 fd ff ff       	call   102540 <at_is_norm>
  1027c8:	83 c4 10             	add    $0x10,%esp
  1027cb:	83 f8 01             	cmp    $0x1,%eax
  1027ce:	75 38                	jne    102808 <MATIntro_test2+0x178>
  1027d0:	83 ec 0c             	sub    $0xc,%esp
  1027d3:	6a 00                	push   $0x0
  1027d5:	e8 a6 fd ff ff       	call   102580 <at_is_allocated>
  1027da:	83 c4 10             	add    $0x10,%esp
  1027dd:	85 c0                	test   %eax,%eax
  1027df:	75 27                	jne    102808 <MATIntro_test2+0x178>
    at_set_perm(0, 0);
  1027e1:	83 ec 08             	sub    $0x8,%esp
  1027e4:	6a 00                	push   $0x0
  1027e6:	6a 00                	push   $0x0
  1027e8:	e8 73 fd ff ff       	call   102560 <at_set_perm>
    dprintf("test 2 passed.\n");
  1027ed:	c7 04 24 eb 45 10 00 	movl   $0x1045eb,(%esp)
  1027f4:	e8 87 ec ff ff       	call   101480 <dprintf>
    return 0;
  1027f9:	83 c4 10             	add    $0x10,%esp
  1027fc:	31 c0                	xor    %eax,%eax
  1027fe:	e9 f8 fe ff ff       	jmp    1026fb <MATIntro_test2+0x6b>
  102803:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102807:	90                   	nop
        dprintf("test 2.4 failed: (%d != 1 || %d != 0)\n", at_is_norm(0), at_is_allocated(0));
  102808:	83 ec 0c             	sub    $0xc,%esp
  10280b:	6a 00                	push   $0x0
  10280d:	e8 6e fd ff ff       	call   102580 <at_is_allocated>
  102812:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  102819:	89 c3                	mov    %eax,%ebx
  10281b:	e8 20 fd ff ff       	call   102540 <at_is_norm>
  102820:	83 c4 0c             	add    $0xc,%esp
  102823:	53                   	push   %ebx
  102824:	50                   	push   %eax
  102825:	68 b4 45 10 00       	push   $0x1045b4
  10282a:	e9 b4 fe ff ff       	jmp    1026e3 <MATIntro_test2+0x53>
  10282f:	90                   	nop

00102830 <MATIntro_test3>:

int MATIntro_test3()
{
  102830:	83 ec 14             	sub    $0x14,%esp
    at_set_allocated(1, 0);
  102833:	6a 00                	push   $0x0
  102835:	6a 01                	push   $0x1
  102837:	e8 64 fd ff ff       	call   1025a0 <at_set_allocated>
    if (at_is_allocated(1) != 0) {
  10283c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  102843:	e8 38 fd ff ff       	call   102580 <at_is_allocated>
  102848:	83 c4 10             	add    $0x10,%esp
  10284b:	85 c0                	test   %eax,%eax
  10284d:	0f 85 8d 00 00 00    	jne    1028e0 <MATIntro_test3+0xb0>
        dprintf("test 3.1 failed: (%d != 0)\n", at_is_allocated(1));
        at_set_allocated(1, 0);
        return 1;
    }
    at_set_allocated(1, 1);
  102853:	83 ec 08             	sub    $0x8,%esp
  102856:	6a 01                	push   $0x1
  102858:	6a 01                	push   $0x1
  10285a:	e8 41 fd ff ff       	call   1025a0 <at_set_allocated>
    if (at_is_allocated(1) != 1) {
  10285f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  102866:	e8 15 fd ff ff       	call   102580 <at_is_allocated>
  10286b:	83 c4 10             	add    $0x10,%esp
  10286e:	83 f8 01             	cmp    $0x1,%eax
  102871:	74 35                	je     1028a8 <MATIntro_test3+0x78>
        dprintf("test 3.2 failed: (%d != 1)\n", at_is_allocated(1));
  102873:	83 ec 0c             	sub    $0xc,%esp
  102876:	6a 01                	push   $0x1
  102878:	e8 03 fd ff ff       	call   102580 <at_is_allocated>
  10287d:	59                   	pop    %ecx
  10287e:	5a                   	pop    %edx
  10287f:	50                   	push   %eax
  102880:	68 17 46 10 00       	push   $0x104617
  102885:	e8 f6 eb ff ff       	call   101480 <dprintf>
        at_set_allocated(1, 0);
  10288a:	58                   	pop    %eax
  10288b:	5a                   	pop    %edx
  10288c:	6a 00                	push   $0x0
  10288e:	6a 01                	push   $0x1
  102890:	e8 0b fd ff ff       	call   1025a0 <at_set_allocated>
        return 1;
  102895:	83 c4 10             	add    $0x10,%esp
        return 1;
  102898:	b8 01 00 00 00       	mov    $0x1,%eax
        return 1;
    }
    at_set_allocated(1, 0);
    dprintf("test 3 passed.\n");
    return 0;
}
  10289d:	83 c4 0c             	add    $0xc,%esp
  1028a0:	c3                   	ret    
  1028a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    at_set_allocated(1, 100);
  1028a8:	83 ec 08             	sub    $0x8,%esp
  1028ab:	6a 64                	push   $0x64
  1028ad:	6a 01                	push   $0x1
  1028af:	e8 ec fc ff ff       	call   1025a0 <at_set_allocated>
    if (at_is_allocated(1) != 1) {
  1028b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1028bb:	e8 c0 fc ff ff       	call   102580 <at_is_allocated>
  1028c0:	83 c4 10             	add    $0x10,%esp
  1028c3:	83 f8 01             	cmp    $0x1,%eax
  1028c6:	74 30                	je     1028f8 <MATIntro_test3+0xc8>
        dprintf("test 3.3 failed: (%d != 1)\n", at_is_allocated(1));
  1028c8:	83 ec 0c             	sub    $0xc,%esp
  1028cb:	6a 01                	push   $0x1
  1028cd:	e8 ae fc ff ff       	call   102580 <at_is_allocated>
  1028d2:	5a                   	pop    %edx
  1028d3:	59                   	pop    %ecx
  1028d4:	50                   	push   %eax
  1028d5:	68 33 46 10 00       	push   $0x104633
  1028da:	eb a9                	jmp    102885 <MATIntro_test3+0x55>
  1028dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        dprintf("test 3.1 failed: (%d != 0)\n", at_is_allocated(1));
  1028e0:	83 ec 0c             	sub    $0xc,%esp
  1028e3:	6a 01                	push   $0x1
  1028e5:	e8 96 fc ff ff       	call   102580 <at_is_allocated>
  1028ea:	59                   	pop    %ecx
  1028eb:	5a                   	pop    %edx
  1028ec:	50                   	push   %eax
  1028ed:	68 fb 45 10 00       	push   $0x1045fb
  1028f2:	eb 91                	jmp    102885 <MATIntro_test3+0x55>
  1028f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    at_set_allocated(1, 0);
  1028f8:	83 ec 08             	sub    $0x8,%esp
  1028fb:	6a 00                	push   $0x0
  1028fd:	6a 01                	push   $0x1
  1028ff:	e8 9c fc ff ff       	call   1025a0 <at_set_allocated>
    dprintf("test 3 passed.\n");
  102904:	c7 04 24 4f 46 10 00 	movl   $0x10464f,(%esp)
  10290b:	e8 70 eb ff ff       	call   101480 <dprintf>
    return 0;
  102910:	83 c4 10             	add    $0x10,%esp
  102913:	31 c0                	xor    %eax,%eax
}
  102915:	83 c4 0c             	add    $0xc,%esp
  102918:	c3                   	ret    
  102919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102920 <MATIntro_test_own>:
int MATIntro_test_own()
{
    // TODO (optional)
    // dprintf("own test passed.\n");
    return 0;
}
  102920:	31 c0                	xor    %eax,%eax
  102922:	c3                   	ret    
  102923:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10292a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102930 <test_MATIntro>:

int test_MATIntro()
{
  102930:	53                   	push   %ebx
  102931:	83 ec 08             	sub    $0x8,%esp
    return MATIntro_test1() + MATIntro_test2() + MATIntro_test3() + MATIntro_test_own();
  102934:	e8 77 fc ff ff       	call   1025b0 <MATIntro_test1>
  102939:	89 c3                	mov    %eax,%ebx
  10293b:	e8 50 fd ff ff       	call   102690 <MATIntro_test2>
  102940:	01 c3                	add    %eax,%ebx
  102942:	e8 e9 fe ff ff       	call   102830 <MATIntro_test3>
}
  102947:	83 c4 08             	add    $0x8,%esp
    return MATIntro_test1() + MATIntro_test2() + MATIntro_test3() + MATIntro_test_own();
  10294a:	01 d8                	add    %ebx,%eax
}
  10294c:	5b                   	pop    %ebx
  10294d:	c3                   	ret    
  10294e:	66 90                	xchg   %ax,%ax

00102950 <pmem_init>:
 *    based on the information available in the physical memory map table.
 *    Review import.h in the current directory for the list of available
 *    getter and setter functions.
 */
void pmem_init(unsigned int mbi_addr)
{
  102950:	55                   	push   %ebp
  102951:	57                   	push   %edi
     * store it into the local variable nps.
     * Hint: Think of it as the highest address in the ranges of the memory map table,
     *       divided by the page size.
     */
    pmm_table_length = get_size();
    highest_phy_address = 0;
  102952:	31 ff                	xor    %edi,%edi
{
  102954:	56                   	push   %esi
    for (unsigned int i = 0; i < get_size(); i++) {
  102955:	31 f6                	xor    %esi,%esi
{
  102957:	53                   	push   %ebx
  102958:	83 ec 28             	sub    $0x28,%esp
    devinit(mbi_addr);
  10295b:	ff 74 24 3c          	push   0x3c(%esp)
  10295f:	e8 33 e0 ff ff       	call   100997 <devinit>
    pmm_table_length = get_size();
  102964:	e8 f6 e4 ff ff       	call   100e5f <get_size>
  102969:	89 44 24 14          	mov    %eax,0x14(%esp)
    for (unsigned int i = 0; i < get_size(); i++) {
  10296d:	83 c4 10             	add    $0x10,%esp
  102970:	eb 09                	jmp    10297b <pmem_init+0x2b>
  102972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102978:	83 c6 01             	add    $0x1,%esi
  10297b:	e8 df e4 ff ff       	call   100e5f <get_size>
  102980:	39 c6                	cmp    %eax,%esi
  102982:	73 36                	jae    1029ba <pmem_init+0x6a>
        if (get_mms(i) + get_mml(i) > highest_phy_address) {
  102984:	83 ec 0c             	sub    $0xc,%esp
  102987:	56                   	push   %esi
  102988:	e8 dc e4 ff ff       	call   100e69 <get_mms>
  10298d:	89 34 24             	mov    %esi,(%esp)
  102990:	89 c3                	mov    %eax,%ebx
  102992:	e8 2c e5 ff ff       	call   100ec3 <get_mml>
  102997:	83 c4 10             	add    $0x10,%esp
  10299a:	01 c3                	add    %eax,%ebx
  10299c:	39 df                	cmp    %ebx,%edi
  10299e:	73 d8                	jae    102978 <pmem_init+0x28>
            highest_phy_address = get_mms(i) + get_mml(i);
  1029a0:	83 ec 0c             	sub    $0xc,%esp
  1029a3:	56                   	push   %esi
  1029a4:	e8 c0 e4 ff ff       	call   100e69 <get_mms>
  1029a9:	89 34 24             	mov    %esi,(%esp)
  1029ac:	89 c7                	mov    %eax,%edi
  1029ae:	e8 10 e5 ff ff       	call   100ec3 <get_mml>
  1029b3:	83 c4 10             	add    $0x10,%esp
  1029b6:	01 c7                	add    %eax,%edi
  1029b8:	eb be                	jmp    102978 <pmem_init+0x28>
        }
    }
    nps = highest_phy_address/PAGESIZE + ((highest_phy_address % PAGESIZE) != 0); // TODO: Do we need to do ceiling instead of just raw division? 
  1029ba:	31 c0                	xor    %eax,%eax
  1029bc:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
  1029c2:	0f 95 c0             	setne  %al
  1029c5:	c1 ef 0c             	shr    $0xc,%edi
    set_nps(nps);  // Setting the value computed above to NUM_PAGES.
  1029c8:	83 ec 0c             	sub    $0xc,%esp
     *    so in that case, you should consider those pages as unavailable.
     */


    // Pages: 0 to VM_USERLO_PI - 1 are reserved by the kernel, so set permissions to 1.
    unsigned int page_index = 0;
  1029cb:	31 db                	xor    %ebx,%ebx
    nps = highest_phy_address/PAGESIZE + ((highest_phy_address % PAGESIZE) != 0); // TODO: Do we need to do ceiling instead of just raw division? 
  1029cd:	8d 2c 38             	lea    (%eax,%edi,1),%ebp
    set_nps(nps);  // Setting the value computed above to NUM_PAGES.
  1029d0:	55                   	push   %ebp
  1029d1:	e8 5a fb ff ff       	call   102530 <set_nps>
  1029d6:	83 c4 10             	add    $0x10,%esp
  1029d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (;page_index < VM_USERLO_PI; page_index++) {
        at_set_perm(page_index, 1);
  1029e0:	83 ec 08             	sub    $0x8,%esp
  1029e3:	6a 01                	push   $0x1
  1029e5:	53                   	push   %ebx
    for (;page_index < VM_USERLO_PI; page_index++) {
  1029e6:	83 c3 01             	add    $0x1,%ebx
        at_set_perm(page_index, 1);
  1029e9:	e8 72 fb ff ff       	call   102560 <at_set_perm>
    for (;page_index < VM_USERLO_PI; page_index++) {
  1029ee:	83 c4 10             	add    $0x10,%esp
  1029f1:	81 fb 00 00 04 00    	cmp    $0x40000,%ebx
  1029f7:	75 e7                	jne    1029e0 <pmem_init+0x90>
  1029f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }

    // Blanket cover everything with perm 0, then fill in holes later
    for (;page_index < VM_USERHI_PI; page_index++) {
        at_set_perm(page_index, 0);
  102a00:	83 ec 08             	sub    $0x8,%esp
  102a03:	6a 00                	push   $0x0
  102a05:	53                   	push   %ebx
    for (;page_index < VM_USERHI_PI; page_index++) {
  102a06:	83 c3 01             	add    $0x1,%ebx
        at_set_perm(page_index, 0);
  102a09:	e8 52 fb ff ff       	call   102560 <at_set_perm>
    for (;page_index < VM_USERHI_PI; page_index++) {
  102a0e:	83 c4 10             	add    $0x10,%esp
  102a11:	81 fb 00 00 0f 00    	cmp    $0xf0000,%ebx
  102a17:	75 e7                	jne    102a00 <pmem_init+0xb0>
    }

    // Iterate through pmm table to fill 
    unsigned int range_start, range_end, potential_page_start;
    for (unsigned int pmm_table_index = 0; pmm_table_index < pmm_table_length; pmm_table_index++) {
  102a19:	8b 44 24 04          	mov    0x4(%esp),%eax
            }
        }
    }
    
    // VM_USERHI_PI to NUM_PAGES - 1 are reserved by the kernel, so set permissions to 1 
    for (page_index = VM_USERHI_PI; page_index < nps - 1; page_index++) {
  102a1d:	83 ed 01             	sub    $0x1,%ebp
    for (unsigned int pmm_table_index = 0; pmm_table_index < pmm_table_length; pmm_table_index++) {
  102a20:	31 ff                	xor    %edi,%edi
  102a22:	85 c0                	test   %eax,%eax
  102a24:	0f 84 aa 00 00 00    	je     102ad4 <pmem_init+0x184>
  102a2a:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  102a2e:	eb 0d                	jmp    102a3d <pmem_init+0xed>
  102a30:	83 c7 01             	add    $0x1,%edi
  102a33:	39 7c 24 04          	cmp    %edi,0x4(%esp)
  102a37:	0f 84 93 00 00 00    	je     102ad0 <pmem_init+0x180>
        if (is_usable(pmm_table_index)) {
  102a3d:	83 ec 0c             	sub    $0xc,%esp
  102a40:	57                   	push   %edi
  102a41:	e8 e1 e4 ff ff       	call   100f27 <is_usable>
  102a46:	83 c4 10             	add    $0x10,%esp
  102a49:	85 c0                	test   %eax,%eax
  102a4b:	74 e3                	je     102a30 <pmem_init+0xe0>
            range_start = get_mms(pmm_table_index);
  102a4d:	83 ec 0c             	sub    $0xc,%esp
            potential_page_start = range_start/PAGESIZE + ((range_start % PAGESIZE) != 0); // Ceiling so that don't deal with partial pages
  102a50:	31 db                	xor    %ebx,%ebx
            range_start = get_mms(pmm_table_index);
  102a52:	57                   	push   %edi
  102a53:	e8 11 e4 ff ff       	call   100e69 <get_mms>
            range_end = range_start + get_mml(pmm_table_index);
  102a58:	89 3c 24             	mov    %edi,(%esp)
            range_start = get_mms(pmm_table_index);
  102a5b:	89 44 24 18          	mov    %eax,0x18(%esp)
            range_end = range_start + get_mml(pmm_table_index);
  102a5f:	e8 5f e4 ff ff       	call   100ec3 <get_mml>
  102a64:	8b 4c 24 18          	mov    0x18(%esp),%ecx
            potential_page_start = range_start/PAGESIZE + ((range_start % PAGESIZE) != 0); // Ceiling so that don't deal with partial pages
  102a68:	f7 c1 ff 0f 00 00    	test   $0xfff,%ecx
            range_end = range_start + get_mml(pmm_table_index);
  102a6e:	8d 34 08             	lea    (%eax,%ecx,1),%esi
            potential_page_start = range_start/PAGESIZE + ((range_start % PAGESIZE) != 0); // Ceiling so that don't deal with partial pages
  102a71:	58                   	pop    %eax
  102a72:	89 c8                	mov    %ecx,%eax
  102a74:	5a                   	pop    %edx
            dprintf("range_start: 0x%x\n", range_start);
  102a75:	51                   	push   %ecx
            potential_page_start = range_start/PAGESIZE + ((range_start % PAGESIZE) != 0); // Ceiling so that don't deal with partial pages
  102a76:	0f 95 c3             	setne  %bl
  102a79:	c1 e8 0c             	shr    $0xc,%eax
            dprintf("range_start: 0x%x\n", range_start);
  102a7c:	68 5f 46 10 00       	push   $0x10465f
            potential_page_start = range_start/PAGESIZE + ((range_start % PAGESIZE) != 0); // Ceiling so that don't deal with partial pages
  102a81:	01 c3                	add    %eax,%ebx
            dprintf("range_start: 0x%x\n", range_start);
  102a83:	e8 f8 e9 ff ff       	call   101480 <dprintf>
            dprintf("potential start page: 0x%x\n", potential_page_start);
  102a88:	59                   	pop    %ecx
  102a89:	58                   	pop    %eax
  102a8a:	53                   	push   %ebx
  102a8b:	68 72 46 10 00       	push   $0x104672
  102a90:	e8 eb e9 ff ff       	call   101480 <dprintf>
            while ((potential_page_start < nps - 1) && (((potential_page_start + 1) * PAGESIZE) <= range_end)) {
  102a95:	83 c4 10             	add    $0x10,%esp
  102a98:	39 eb                	cmp    %ebp,%ebx
  102a9a:	72 08                	jb     102aa4 <pmem_init+0x154>
  102a9c:	eb 92                	jmp    102a30 <pmem_init+0xe0>
  102a9e:	66 90                	xchg   %ax,%ax
  102aa0:	39 dd                	cmp    %ebx,%ebp
  102aa2:	74 8c                	je     102a30 <pmem_init+0xe0>
  102aa4:	83 c3 01             	add    $0x1,%ebx
  102aa7:	89 d8                	mov    %ebx,%eax
  102aa9:	c1 e0 0c             	shl    $0xc,%eax
  102aac:	39 c6                	cmp    %eax,%esi
  102aae:	72 80                	jb     102a30 <pmem_init+0xe0>
                if ((potential_page_start >= VM_USERLO_PI) && (potential_page_start < VM_USERHI_PI)) {
  102ab0:	8d 83 ff ff fb ff    	lea    -0x40001(%ebx),%eax
  102ab6:	3d ff ff 0a 00       	cmp    $0xaffff,%eax
  102abb:	77 e3                	ja     102aa0 <pmem_init+0x150>
                    at_set_perm(potential_page_start, 2);
  102abd:	83 ec 08             	sub    $0x8,%esp
  102ac0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  102ac3:	6a 02                	push   $0x2
  102ac5:	50                   	push   %eax
  102ac6:	e8 95 fa ff ff       	call   102560 <at_set_perm>
  102acb:	83 c4 10             	add    $0x10,%esp
  102ace:	eb d0                	jmp    102aa0 <pmem_init+0x150>
  102ad0:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
    for (page_index = VM_USERHI_PI; page_index < nps - 1; page_index++) {
  102ad4:	81 fd 00 00 0f 00    	cmp    $0xf0000,%ebp
  102ada:	76 19                	jbe    102af5 <pmem_init+0x1a5>
  102adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        at_set_perm(page_index, 1); 
  102ae0:	83 ec 08             	sub    $0x8,%esp
  102ae3:	6a 01                	push   $0x1
  102ae5:	53                   	push   %ebx
    for (page_index = VM_USERHI_PI; page_index < nps - 1; page_index++) {
  102ae6:	83 c3 01             	add    $0x1,%ebx
        at_set_perm(page_index, 1); 
  102ae9:	e8 72 fa ff ff       	call   102560 <at_set_perm>
    for (page_index = VM_USERHI_PI; page_index < nps - 1; page_index++) {
  102aee:	83 c4 10             	add    $0x10,%esp
  102af1:	39 eb                	cmp    %ebp,%ebx
  102af3:	75 eb                	jne    102ae0 <pmem_init+0x190>
    }
}
  102af5:	83 c4 1c             	add    $0x1c,%esp
  102af8:	5b                   	pop    %ebx
  102af9:	5e                   	pop    %esi
  102afa:	5f                   	pop    %edi
  102afb:	5d                   	pop    %ebp
  102afc:	c3                   	ret    
  102afd:	66 90                	xchg   %ax,%ax
  102aff:	90                   	nop

00102b00 <MATInit_test1>:
#define VM_USERHI    0xF0000000
#define VM_USERLO_PI (VM_USERLO / PAGESIZE)
#define VM_USERHI_PI (VM_USERHI / PAGESIZE)

int MATInit_test1()
{
  102b00:	56                   	push   %esi
  102b01:	53                   	push   %ebx
  102b02:	31 db                	xor    %ebx,%ebx
  102b04:	83 ec 04             	sub    $0x4,%esp
    int i;
    int nps = get_nps();
  102b07:	e8 14 fa ff ff       	call   102520 <get_nps>
  102b0c:	89 c6                	mov    %eax,%esi
    if (nps <= 1000) {
  102b0e:	3d e8 03 00 00       	cmp    $0x3e8,%eax
  102b13:	7f 12                	jg     102b27 <MATInit_test1+0x27>
  102b15:	e9 a6 00 00 00       	jmp    102bc0 <MATInit_test1+0xc0>
  102b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        dprintf("test 1.1 failed: (%d <= 1000)\n", nps);
        return 1;
    }
    for (i = 0; i < nps; i++) {
  102b20:	83 c3 01             	add    $0x1,%ebx
  102b23:	39 de                	cmp    %ebx,%esi
  102b25:	74 51                	je     102b78 <MATInit_test1+0x78>
        if (at_is_allocated(i) != 0) {
  102b27:	83 ec 0c             	sub    $0xc,%esp
  102b2a:	53                   	push   %ebx
  102b2b:	e8 50 fa ff ff       	call   102580 <at_is_allocated>
  102b30:	83 c4 10             	add    $0x10,%esp
  102b33:	85 c0                	test   %eax,%eax
  102b35:	75 59                	jne    102b90 <MATInit_test1+0x90>
            dprintf("test 1.2 failed (i = %d): (%d != 0)\n", i, at_is_allocated(i));
            return 1;
        }
        if ((i < VM_USERLO_PI || VM_USERHI_PI <= i)
  102b37:	8d 83 00 00 fc ff    	lea    -0x40000(%ebx),%eax
  102b3d:	3d ff ff 0a 00       	cmp    $0xaffff,%eax
  102b42:	76 dc                	jbe    102b20 <MATInit_test1+0x20>
            && at_is_norm(i) != 0) {
  102b44:	83 ec 0c             	sub    $0xc,%esp
  102b47:	53                   	push   %ebx
  102b48:	e8 f3 f9 ff ff       	call   102540 <at_is_norm>
  102b4d:	83 c4 10             	add    $0x10,%esp
  102b50:	85 c0                	test   %eax,%eax
  102b52:	74 cc                	je     102b20 <MATInit_test1+0x20>
            dprintf("test 1.3 failed (i = %d): (%d != 0)\n", i, at_is_norm(i));
  102b54:	83 ec 0c             	sub    $0xc,%esp
  102b57:	53                   	push   %ebx
  102b58:	e8 e3 f9 ff ff       	call   102540 <at_is_norm>
  102b5d:	83 c4 0c             	add    $0xc,%esp
  102b60:	50                   	push   %eax
  102b61:	53                   	push   %ebx
  102b62:	68 d8 46 10 00       	push   $0x1046d8
  102b67:	e8 14 e9 ff ff       	call   101480 <dprintf>
            return 1;
  102b6c:	83 c4 10             	add    $0x10,%esp
  102b6f:	eb 3a                	jmp    102bab <MATInit_test1+0xab>
  102b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
    }
    dprintf("test 1 passed.\n");
  102b78:	83 ec 0c             	sub    $0xc,%esp
  102b7b:	68 db 45 10 00       	push   $0x1045db
  102b80:	e8 fb e8 ff ff       	call   101480 <dprintf>
    return 0;
  102b85:	83 c4 10             	add    $0x10,%esp
  102b88:	31 c0                	xor    %eax,%eax
}
  102b8a:	83 c4 04             	add    $0x4,%esp
  102b8d:	5b                   	pop    %ebx
  102b8e:	5e                   	pop    %esi
  102b8f:	c3                   	ret    
            dprintf("test 1.2 failed (i = %d): (%d != 0)\n", i, at_is_allocated(i));
  102b90:	83 ec 0c             	sub    $0xc,%esp
  102b93:	53                   	push   %ebx
  102b94:	e8 e7 f9 ff ff       	call   102580 <at_is_allocated>
  102b99:	83 c4 0c             	add    $0xc,%esp
  102b9c:	50                   	push   %eax
  102b9d:	53                   	push   %ebx
  102b9e:	68 b0 46 10 00       	push   $0x1046b0
  102ba3:	e8 d8 e8 ff ff       	call   101480 <dprintf>
            return 1;
  102ba8:	83 c4 10             	add    $0x10,%esp
}
  102bab:	83 c4 04             	add    $0x4,%esp
        return 1;
  102bae:	b8 01 00 00 00       	mov    $0x1,%eax
}
  102bb3:	5b                   	pop    %ebx
  102bb4:	5e                   	pop    %esi
  102bb5:	c3                   	ret    
  102bb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102bbd:	8d 76 00             	lea    0x0(%esi),%esi
        dprintf("test 1.1 failed: (%d <= 1000)\n", nps);
  102bc0:	83 ec 08             	sub    $0x8,%esp
  102bc3:	50                   	push   %eax
  102bc4:	68 90 46 10 00       	push   $0x104690
  102bc9:	e8 b2 e8 ff ff       	call   101480 <dprintf>
        return 1;
  102bce:	83 c4 10             	add    $0x10,%esp
  102bd1:	eb d8                	jmp    102bab <MATInit_test1+0xab>
  102bd3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102be0 <MATInit_test_own>:
int MATInit_test_own()
{
    // TODO (optional)
    // dprintf("own test passed.\n");
    return 0;
}
  102be0:	31 c0                	xor    %eax,%eax
  102be2:	c3                   	ret    
  102be3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102bf0 <test_MATInit>:

int test_MATInit()
{
    return MATInit_test1() + MATInit_test_own();
  102bf0:	e9 0b ff ff ff       	jmp    102b00 <MATInit_test1>
  102bf5:	66 90                	xchg   %ax,%ax
  102bf7:	66 90                	xchg   %ax,%ax
  102bf9:	66 90                	xchg   %ax,%ax
  102bfb:	66 90                	xchg   %ax,%ax
  102bfd:	66 90                	xchg   %ax,%ax
  102bff:	90                   	nop

00102c00 <palloc>:
 */

unsigned int prev_pi = VM_USERLO_PI;
unsigned int cache[] = {UINT_MAX,UINT_MAX,UINT_MAX,UINT_MAX,UINT_MAX};
unsigned int palloc()
{
  102c00:	53                   	push   %ebx
    // Check cache
    for (unsigned int i = 0; i < CACHE_LEN; i++) {
  102c01:	31 c0                	xor    %eax,%eax
{
  102c03:	83 ec 08             	sub    $0x8,%esp
        if (cache[i] != UINT_MAX) {
  102c06:	8b 1c 85 28 75 10 00 	mov    0x107528(,%eax,4),%ebx
  102c0d:	83 fb ff             	cmp    $0xffffffff,%ebx
  102c10:	0f 85 e2 00 00 00    	jne    102cf8 <palloc+0xf8>
    for (unsigned int i = 0; i < CACHE_LEN; i++) {
  102c16:	83 c0 01             	add    $0x1,%eax
  102c19:	83 f8 05             	cmp    $0x5,%eax
  102c1c:	75 e8                	jne    102c06 <palloc+0x6>
            return cache_hit;
        }
    }

    // Start linear scan from previous scan end
    for (unsigned int pi = prev_pi; pi < VM_USERHI_PI; pi++) {
  102c1e:	8b 1d 3c 75 10 00    	mov    0x10753c,%ebx
  102c24:	81 fb ff ff 0e 00    	cmp    $0xeffff,%ebx
  102c2a:	76 0f                	jbe    102c3b <palloc+0x3b>
  102c2c:	eb 56                	jmp    102c84 <palloc+0x84>
  102c2e:	66 90                	xchg   %ax,%ax
  102c30:	83 c3 01             	add    $0x1,%ebx
  102c33:	81 fb 00 00 0f 00    	cmp    $0xf0000,%ebx
  102c39:	74 3d                	je     102c78 <palloc+0x78>
        if (at_is_allocated(pi) == 0 && at_is_norm(pi) == 1) {
  102c3b:	83 ec 0c             	sub    $0xc,%esp
  102c3e:	53                   	push   %ebx
  102c3f:	e8 3c f9 ff ff       	call   102580 <at_is_allocated>
  102c44:	83 c4 10             	add    $0x10,%esp
  102c47:	85 c0                	test   %eax,%eax
  102c49:	75 e5                	jne    102c30 <palloc+0x30>
  102c4b:	83 ec 0c             	sub    $0xc,%esp
  102c4e:	53                   	push   %ebx
  102c4f:	e8 ec f8 ff ff       	call   102540 <at_is_norm>
  102c54:	83 c4 10             	add    $0x10,%esp
  102c57:	83 f8 01             	cmp    $0x1,%eax
  102c5a:	75 d4                	jne    102c30 <palloc+0x30>
            at_set_allocated(pi, 1);
  102c5c:	83 ec 08             	sub    $0x8,%esp
  102c5f:	6a 01                	push   $0x1
  102c61:	53                   	push   %ebx
  102c62:	e8 39 f9 ff ff       	call   1025a0 <at_set_allocated>
            return pi;
  102c67:	83 c4 10             	add    $0x10,%esp
    }

    prev_pi = VM_USERLO_PI; // Save index ended scanning at 

    return 0;
}
  102c6a:	89 d8                	mov    %ebx,%eax
  102c6c:	83 c4 08             	add    $0x8,%esp
  102c6f:	5b                   	pop    %ebx
  102c70:	c3                   	ret    
  102c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (unsigned int pi = VM_USERLO_PI; pi < prev_pi; pi++) {
  102c78:	81 3d 3c 75 10 00 00 	cmpl   $0x40000,0x10753c
  102c7f:	00 04 00 
  102c82:	76 5c                	jbe    102ce0 <palloc+0xe0>
  102c84:	bb 00 00 04 00       	mov    $0x40000,%ebx
  102c89:	eb 10                	jmp    102c9b <palloc+0x9b>
  102c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102c8f:	90                   	nop
  102c90:	83 c3 01             	add    $0x1,%ebx
  102c93:	3b 1d 3c 75 10 00    	cmp    0x10753c,%ebx
  102c99:	73 45                	jae    102ce0 <palloc+0xe0>
        if (at_is_allocated(pi) == 0 && at_is_norm(pi) == 1) {
  102c9b:	83 ec 0c             	sub    $0xc,%esp
  102c9e:	53                   	push   %ebx
  102c9f:	e8 dc f8 ff ff       	call   102580 <at_is_allocated>
  102ca4:	83 c4 10             	add    $0x10,%esp
  102ca7:	85 c0                	test   %eax,%eax
  102ca9:	75 e5                	jne    102c90 <palloc+0x90>
  102cab:	83 ec 0c             	sub    $0xc,%esp
  102cae:	53                   	push   %ebx
  102caf:	e8 8c f8 ff ff       	call   102540 <at_is_norm>
  102cb4:	83 c4 10             	add    $0x10,%esp
  102cb7:	83 f8 01             	cmp    $0x1,%eax
  102cba:	75 d4                	jne    102c90 <palloc+0x90>
            at_set_allocated(pi, 1);
  102cbc:	83 ec 08             	sub    $0x8,%esp
  102cbf:	6a 01                	push   $0x1
  102cc1:	53                   	push   %ebx
  102cc2:	e8 d9 f8 ff ff       	call   1025a0 <at_set_allocated>
            return pi;
  102cc7:	83 c4 10             	add    $0x10,%esp
            prev_pi = pi;
  102cca:	89 1d 3c 75 10 00    	mov    %ebx,0x10753c
}
  102cd0:	89 d8                	mov    %ebx,%eax
  102cd2:	83 c4 08             	add    $0x8,%esp
  102cd5:	5b                   	pop    %ebx
  102cd6:	c3                   	ret    
  102cd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102cde:	66 90                	xchg   %ax,%ax
    prev_pi = VM_USERLO_PI; // Save index ended scanning at 
  102ce0:	c7 05 3c 75 10 00 00 	movl   $0x40000,0x10753c
  102ce7:	00 04 00 
    return 0;
  102cea:	31 db                	xor    %ebx,%ebx
}
  102cec:	83 c4 08             	add    $0x8,%esp
  102cef:	89 d8                	mov    %ebx,%eax
  102cf1:	5b                   	pop    %ebx
  102cf2:	c3                   	ret    
  102cf3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102cf7:	90                   	nop
            cache[i] = UINT_MAX;
  102cf8:	c7 04 85 28 75 10 00 	movl   $0xffffffff,0x107528(,%eax,4)
  102cff:	ff ff ff ff 
}
  102d03:	83 c4 08             	add    $0x8,%esp
  102d06:	89 d8                	mov    %ebx,%eax
  102d08:	5b                   	pop    %ebx
  102d09:	c3                   	ret    
  102d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102d10 <pfree>:
 * in the allocation table.
 *
 * Hint: Simple.
 */
void pfree(unsigned int pfree_index)
{
  102d10:	83 ec 0c             	sub    $0xc,%esp
    // Add to cache 
    for (unsigned int i = 0; i < CACHE_LEN; i++) {
  102d13:	31 c0                	xor    %eax,%eax
{
  102d15:	8b 54 24 10          	mov    0x10(%esp),%edx
  102d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (cache[i] == UINT_MAX) {
  102d20:	83 3c 85 28 75 10 00 	cmpl   $0xffffffff,0x107528(,%eax,4)
  102d27:	ff 
  102d28:	75 07                	jne    102d31 <pfree+0x21>
            cache[i] = pfree_index;
  102d2a:	89 14 85 28 75 10 00 	mov    %edx,0x107528(,%eax,4)
    for (unsigned int i = 0; i < CACHE_LEN; i++) {
  102d31:	83 c0 01             	add    $0x1,%eax
  102d34:	83 f8 05             	cmp    $0x5,%eax
  102d37:	75 e7                	jne    102d20 <pfree+0x10>
        }
    }
    at_set_allocated(pfree_index, 0);
  102d39:	83 ec 08             	sub    $0x8,%esp
  102d3c:	6a 00                	push   $0x0
  102d3e:	52                   	push   %edx
  102d3f:	e8 5c f8 ff ff       	call   1025a0 <at_set_allocated>
}
  102d44:	83 c4 1c             	add    $0x1c,%esp
  102d47:	c3                   	ret    
  102d48:	66 90                	xchg   %ax,%ax
  102d4a:	66 90                	xchg   %ax,%ax
  102d4c:	66 90                	xchg   %ax,%ax
  102d4e:	66 90                	xchg   %ax,%ax

00102d50 <MATOp_test1>:
#define VM_USERHI    0xF0000000
#define VM_USERLO_PI (VM_USERLO / PAGESIZE)
#define VM_USERHI_PI (VM_USERHI / PAGESIZE)

int MATOp_test1()
{
  102d50:	53                   	push   %ebx
  102d51:	83 ec 08             	sub    $0x8,%esp
    int page_index = palloc();
  102d54:	e8 a7 fe ff ff       	call   102c00 <palloc>
  102d59:	89 c3                	mov    %eax,%ebx
    if (page_index < VM_USERLO_PI || VM_USERHI_PI <= page_index) {
  102d5b:	2d 00 00 04 00       	sub    $0x40000,%eax
  102d60:	3d ff ff 0a 00       	cmp    $0xaffff,%eax
  102d65:	0f 87 95 00 00 00    	ja     102e00 <MATOp_test1+0xb0>
        dprintf("test 1.1 failed: (%d < VM_USERLO_PI || VM_USERHI_PI <= %d)\n", page_index, page_index);
        dprintf("test page index: 0x%x\n", page_index);
        pfree(page_index);
        return 1;
    }
    if (at_is_norm(page_index) != 1) {
  102d6b:	83 ec 0c             	sub    $0xc,%esp
  102d6e:	53                   	push   %ebx
  102d6f:	e8 cc f7 ff ff       	call   102540 <at_is_norm>
  102d74:	83 c4 10             	add    $0x10,%esp
  102d77:	83 f8 01             	cmp    $0x1,%eax
  102d7a:	74 3c                	je     102db8 <MATOp_test1+0x68>
        dprintf("test 1.2 failed: (%d != 1)\n", at_is_norm(page_index));
  102d7c:	83 ec 0c             	sub    $0xc,%esp
  102d7f:	53                   	push   %ebx
  102d80:	e8 bb f7 ff ff       	call   102540 <at_is_norm>
  102d85:	5a                   	pop    %edx
  102d86:	59                   	pop    %ecx
  102d87:	50                   	push   %eax
  102d88:	68 53 47 10 00       	push   $0x104753
  102d8d:	e8 ee e6 ff ff       	call   101480 <dprintf>
        dprintf("test page index: 0x%x\n", page_index);
  102d92:	59                   	pop    %ecx
  102d93:	58                   	pop    %eax
  102d94:	53                   	push   %ebx
  102d95:	68 3c 47 10 00       	push   $0x10473c
  102d9a:	e8 e1 e6 ff ff       	call   101480 <dprintf>
        pfree(page_index);
  102d9f:	89 1c 24             	mov    %ebx,(%esp)
  102da2:	e8 69 ff ff ff       	call   102d10 <pfree>
        return 1;
  102da7:	83 c4 10             	add    $0x10,%esp
        dprintf("test page index: 0x%x\n", page_index);
        return 1;
    }
    dprintf("test 1 passed.\n");
    return 0;
}
  102daa:	83 c4 08             	add    $0x8,%esp
        return 1;
  102dad:	b8 01 00 00 00       	mov    $0x1,%eax
}
  102db2:	5b                   	pop    %ebx
  102db3:	c3                   	ret    
  102db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (at_is_allocated(page_index) != 1) {
  102db8:	83 ec 0c             	sub    $0xc,%esp
  102dbb:	53                   	push   %ebx
  102dbc:	e8 bf f7 ff ff       	call   102580 <at_is_allocated>
  102dc1:	83 c4 10             	add    $0x10,%esp
  102dc4:	83 f8 01             	cmp    $0x1,%eax
  102dc7:	75 47                	jne    102e10 <MATOp_test1+0xc0>
    pfree(page_index);
  102dc9:	83 ec 0c             	sub    $0xc,%esp
  102dcc:	53                   	push   %ebx
  102dcd:	e8 3e ff ff ff       	call   102d10 <pfree>
    if (at_is_allocated(page_index) != 0) {
  102dd2:	89 1c 24             	mov    %ebx,(%esp)
  102dd5:	e8 a6 f7 ff ff       	call   102580 <at_is_allocated>
  102dda:	83 c4 10             	add    $0x10,%esp
  102ddd:	85 c0                	test   %eax,%eax
  102ddf:	75 4f                	jne    102e30 <MATOp_test1+0xe0>
    dprintf("test 1 passed.\n");
  102de1:	83 ec 0c             	sub    $0xc,%esp
  102de4:	68 db 45 10 00       	push   $0x1045db
  102de9:	e8 92 e6 ff ff       	call   101480 <dprintf>
    return 0;
  102dee:	83 c4 10             	add    $0x10,%esp
  102df1:	31 c0                	xor    %eax,%eax
}
  102df3:	83 c4 08             	add    $0x8,%esp
  102df6:	5b                   	pop    %ebx
  102df7:	c3                   	ret    
  102df8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102dff:	90                   	nop
        dprintf("test 1.1 failed: (%d < VM_USERLO_PI || VM_USERHI_PI <= %d)\n", page_index, page_index);
  102e00:	83 ec 04             	sub    $0x4,%esp
  102e03:	53                   	push   %ebx
  102e04:	53                   	push   %ebx
  102e05:	68 00 47 10 00       	push   $0x104700
  102e0a:	eb 81                	jmp    102d8d <MATOp_test1+0x3d>
  102e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        dprintf("test 1.3 failed: (%d != 1)\n", at_is_allocated(page_index));
  102e10:	83 ec 0c             	sub    $0xc,%esp
  102e13:	53                   	push   %ebx
  102e14:	e8 67 f7 ff ff       	call   102580 <at_is_allocated>
  102e19:	59                   	pop    %ecx
  102e1a:	5a                   	pop    %edx
  102e1b:	50                   	push   %eax
  102e1c:	68 6f 47 10 00       	push   $0x10476f
  102e21:	e9 67 ff ff ff       	jmp    102d8d <MATOp_test1+0x3d>
  102e26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102e2d:	8d 76 00             	lea    0x0(%esi),%esi
        dprintf("test 1.4 failed: (%d != 0)\n", at_is_allocated(page_index));
  102e30:	83 ec 0c             	sub    $0xc,%esp
  102e33:	53                   	push   %ebx
  102e34:	e8 47 f7 ff ff       	call   102580 <at_is_allocated>
  102e39:	5a                   	pop    %edx
  102e3a:	59                   	pop    %ecx
  102e3b:	50                   	push   %eax
  102e3c:	68 8b 47 10 00       	push   $0x10478b
  102e41:	e8 3a e6 ff ff       	call   101480 <dprintf>
        dprintf("test page index: 0x%x\n", page_index);
  102e46:	58                   	pop    %eax
  102e47:	5a                   	pop    %edx
  102e48:	53                   	push   %ebx
  102e49:	68 3c 47 10 00       	push   $0x10473c
  102e4e:	e8 2d e6 ff ff       	call   101480 <dprintf>
        return 1;
  102e53:	83 c4 10             	add    $0x10,%esp
  102e56:	e9 4f ff ff ff       	jmp    102daa <MATOp_test1+0x5a>
  102e5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102e5f:	90                   	nop

00102e60 <MATOp_test_own>:
int MATOp_test_own()
{
    // TODO (optional)
    // dprintf("own test passed.\n");
    return 0;
}
  102e60:	31 c0                	xor    %eax,%eax
  102e62:	c3                   	ret    
  102e63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102e70 <test_MATOp>:

int test_MATOp()
{
    return MATOp_test1() + MATOp_test_own();
  102e70:	e9 db fe ff ff       	jmp    102d50 <MATOp_test1>
  102e75:	66 90                	xchg   %ax,%ax
  102e77:	66 90                	xchg   %ax,%ax
  102e79:	66 90                	xchg   %ax,%ax
  102e7b:	66 90                	xchg   %ax,%ax
  102e7d:	66 90                	xchg   %ax,%ax
  102e7f:	90                   	nop

00102e80 <__udivdi3>:
  102e80:	f3 0f 1e fb          	endbr32 
  102e84:	55                   	push   %ebp
  102e85:	57                   	push   %edi
  102e86:	56                   	push   %esi
  102e87:	53                   	push   %ebx
  102e88:	83 ec 1c             	sub    $0x1c,%esp
  102e8b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  102e8f:	8b 6c 24 30          	mov    0x30(%esp),%ebp
  102e93:	8b 74 24 34          	mov    0x34(%esp),%esi
  102e97:	8b 5c 24 38          	mov    0x38(%esp),%ebx
  102e9b:	85 c0                	test   %eax,%eax
  102e9d:	75 19                	jne    102eb8 <__udivdi3+0x38>
  102e9f:	39 de                	cmp    %ebx,%esi
  102ea1:	73 4d                	jae    102ef0 <__udivdi3+0x70>
  102ea3:	31 ff                	xor    %edi,%edi
  102ea5:	89 e8                	mov    %ebp,%eax
  102ea7:	89 f2                	mov    %esi,%edx
  102ea9:	f7 f3                	div    %ebx
  102eab:	89 fa                	mov    %edi,%edx
  102ead:	83 c4 1c             	add    $0x1c,%esp
  102eb0:	5b                   	pop    %ebx
  102eb1:	5e                   	pop    %esi
  102eb2:	5f                   	pop    %edi
  102eb3:	5d                   	pop    %ebp
  102eb4:	c3                   	ret    
  102eb5:	8d 76 00             	lea    0x0(%esi),%esi
  102eb8:	39 c6                	cmp    %eax,%esi
  102eba:	73 14                	jae    102ed0 <__udivdi3+0x50>
  102ebc:	31 ff                	xor    %edi,%edi
  102ebe:	31 c0                	xor    %eax,%eax
  102ec0:	89 fa                	mov    %edi,%edx
  102ec2:	83 c4 1c             	add    $0x1c,%esp
  102ec5:	5b                   	pop    %ebx
  102ec6:	5e                   	pop    %esi
  102ec7:	5f                   	pop    %edi
  102ec8:	5d                   	pop    %ebp
  102ec9:	c3                   	ret    
  102eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102ed0:	0f bd f8             	bsr    %eax,%edi
  102ed3:	83 f7 1f             	xor    $0x1f,%edi
  102ed6:	75 48                	jne    102f20 <__udivdi3+0xa0>
  102ed8:	39 f0                	cmp    %esi,%eax
  102eda:	72 06                	jb     102ee2 <__udivdi3+0x62>
  102edc:	31 c0                	xor    %eax,%eax
  102ede:	39 dd                	cmp    %ebx,%ebp
  102ee0:	72 de                	jb     102ec0 <__udivdi3+0x40>
  102ee2:	b8 01 00 00 00       	mov    $0x1,%eax
  102ee7:	eb d7                	jmp    102ec0 <__udivdi3+0x40>
  102ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102ef0:	89 d9                	mov    %ebx,%ecx
  102ef2:	85 db                	test   %ebx,%ebx
  102ef4:	75 0b                	jne    102f01 <__udivdi3+0x81>
  102ef6:	b8 01 00 00 00       	mov    $0x1,%eax
  102efb:	31 d2                	xor    %edx,%edx
  102efd:	f7 f3                	div    %ebx
  102eff:	89 c1                	mov    %eax,%ecx
  102f01:	31 d2                	xor    %edx,%edx
  102f03:	89 f0                	mov    %esi,%eax
  102f05:	f7 f1                	div    %ecx
  102f07:	89 c6                	mov    %eax,%esi
  102f09:	89 e8                	mov    %ebp,%eax
  102f0b:	89 f7                	mov    %esi,%edi
  102f0d:	f7 f1                	div    %ecx
  102f0f:	89 fa                	mov    %edi,%edx
  102f11:	83 c4 1c             	add    $0x1c,%esp
  102f14:	5b                   	pop    %ebx
  102f15:	5e                   	pop    %esi
  102f16:	5f                   	pop    %edi
  102f17:	5d                   	pop    %ebp
  102f18:	c3                   	ret    
  102f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102f20:	89 f9                	mov    %edi,%ecx
  102f22:	ba 20 00 00 00       	mov    $0x20,%edx
  102f27:	29 fa                	sub    %edi,%edx
  102f29:	d3 e0                	shl    %cl,%eax
  102f2b:	89 44 24 08          	mov    %eax,0x8(%esp)
  102f2f:	89 d1                	mov    %edx,%ecx
  102f31:	89 d8                	mov    %ebx,%eax
  102f33:	d3 e8                	shr    %cl,%eax
  102f35:	89 c1                	mov    %eax,%ecx
  102f37:	8b 44 24 08          	mov    0x8(%esp),%eax
  102f3b:	09 c1                	or     %eax,%ecx
  102f3d:	89 f0                	mov    %esi,%eax
  102f3f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  102f43:	89 f9                	mov    %edi,%ecx
  102f45:	d3 e3                	shl    %cl,%ebx
  102f47:	89 d1                	mov    %edx,%ecx
  102f49:	d3 e8                	shr    %cl,%eax
  102f4b:	89 f9                	mov    %edi,%ecx
  102f4d:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  102f51:	89 eb                	mov    %ebp,%ebx
  102f53:	d3 e6                	shl    %cl,%esi
  102f55:	89 d1                	mov    %edx,%ecx
  102f57:	d3 eb                	shr    %cl,%ebx
  102f59:	09 f3                	or     %esi,%ebx
  102f5b:	89 c6                	mov    %eax,%esi
  102f5d:	89 f2                	mov    %esi,%edx
  102f5f:	89 d8                	mov    %ebx,%eax
  102f61:	f7 74 24 08          	divl   0x8(%esp)
  102f65:	89 d6                	mov    %edx,%esi
  102f67:	89 c3                	mov    %eax,%ebx
  102f69:	f7 64 24 0c          	mull   0xc(%esp)
  102f6d:	39 d6                	cmp    %edx,%esi
  102f6f:	72 1f                	jb     102f90 <__udivdi3+0x110>
  102f71:	89 f9                	mov    %edi,%ecx
  102f73:	d3 e5                	shl    %cl,%ebp
  102f75:	39 c5                	cmp    %eax,%ebp
  102f77:	73 04                	jae    102f7d <__udivdi3+0xfd>
  102f79:	39 d6                	cmp    %edx,%esi
  102f7b:	74 13                	je     102f90 <__udivdi3+0x110>
  102f7d:	89 d8                	mov    %ebx,%eax
  102f7f:	31 ff                	xor    %edi,%edi
  102f81:	e9 3a ff ff ff       	jmp    102ec0 <__udivdi3+0x40>
  102f86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102f8d:	8d 76 00             	lea    0x0(%esi),%esi
  102f90:	8d 43 ff             	lea    -0x1(%ebx),%eax
  102f93:	31 ff                	xor    %edi,%edi
  102f95:	e9 26 ff ff ff       	jmp    102ec0 <__udivdi3+0x40>
  102f9a:	66 90                	xchg   %ax,%ax
  102f9c:	66 90                	xchg   %ax,%ax
  102f9e:	66 90                	xchg   %ax,%ax

00102fa0 <__umoddi3>:
  102fa0:	f3 0f 1e fb          	endbr32 
  102fa4:	55                   	push   %ebp
  102fa5:	57                   	push   %edi
  102fa6:	56                   	push   %esi
  102fa7:	53                   	push   %ebx
  102fa8:	83 ec 1c             	sub    $0x1c,%esp
  102fab:	8b 5c 24 34          	mov    0x34(%esp),%ebx
  102faf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  102fb3:	8b 74 24 30          	mov    0x30(%esp),%esi
  102fb7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  102fbb:	89 da                	mov    %ebx,%edx
  102fbd:	85 c0                	test   %eax,%eax
  102fbf:	75 17                	jne    102fd8 <__umoddi3+0x38>
  102fc1:	39 fb                	cmp    %edi,%ebx
  102fc3:	73 53                	jae    103018 <__umoddi3+0x78>
  102fc5:	89 f0                	mov    %esi,%eax
  102fc7:	f7 f7                	div    %edi
  102fc9:	89 d0                	mov    %edx,%eax
  102fcb:	31 d2                	xor    %edx,%edx
  102fcd:	83 c4 1c             	add    $0x1c,%esp
  102fd0:	5b                   	pop    %ebx
  102fd1:	5e                   	pop    %esi
  102fd2:	5f                   	pop    %edi
  102fd3:	5d                   	pop    %ebp
  102fd4:	c3                   	ret    
  102fd5:	8d 76 00             	lea    0x0(%esi),%esi
  102fd8:	89 f1                	mov    %esi,%ecx
  102fda:	39 c3                	cmp    %eax,%ebx
  102fdc:	73 12                	jae    102ff0 <__umoddi3+0x50>
  102fde:	89 f0                	mov    %esi,%eax
  102fe0:	83 c4 1c             	add    $0x1c,%esp
  102fe3:	5b                   	pop    %ebx
  102fe4:	5e                   	pop    %esi
  102fe5:	5f                   	pop    %edi
  102fe6:	5d                   	pop    %ebp
  102fe7:	c3                   	ret    
  102fe8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102fef:	90                   	nop
  102ff0:	0f bd e8             	bsr    %eax,%ebp
  102ff3:	83 f5 1f             	xor    $0x1f,%ebp
  102ff6:	75 48                	jne    103040 <__umoddi3+0xa0>
  102ff8:	39 d8                	cmp    %ebx,%eax
  102ffa:	0f 82 d0 00 00 00    	jb     1030d0 <__umoddi3+0x130>
  103000:	39 fe                	cmp    %edi,%esi
  103002:	0f 83 c8 00 00 00    	jae    1030d0 <__umoddi3+0x130>
  103008:	89 c8                	mov    %ecx,%eax
  10300a:	83 c4 1c             	add    $0x1c,%esp
  10300d:	5b                   	pop    %ebx
  10300e:	5e                   	pop    %esi
  10300f:	5f                   	pop    %edi
  103010:	5d                   	pop    %ebp
  103011:	c3                   	ret    
  103012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103018:	89 f9                	mov    %edi,%ecx
  10301a:	85 ff                	test   %edi,%edi
  10301c:	75 0b                	jne    103029 <__umoddi3+0x89>
  10301e:	b8 01 00 00 00       	mov    $0x1,%eax
  103023:	31 d2                	xor    %edx,%edx
  103025:	f7 f7                	div    %edi
  103027:	89 c1                	mov    %eax,%ecx
  103029:	89 d8                	mov    %ebx,%eax
  10302b:	31 d2                	xor    %edx,%edx
  10302d:	f7 f1                	div    %ecx
  10302f:	89 f0                	mov    %esi,%eax
  103031:	f7 f1                	div    %ecx
  103033:	89 d0                	mov    %edx,%eax
  103035:	31 d2                	xor    %edx,%edx
  103037:	eb 94                	jmp    102fcd <__umoddi3+0x2d>
  103039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103040:	89 e9                	mov    %ebp,%ecx
  103042:	ba 20 00 00 00       	mov    $0x20,%edx
  103047:	29 ea                	sub    %ebp,%edx
  103049:	d3 e0                	shl    %cl,%eax
  10304b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10304f:	89 d1                	mov    %edx,%ecx
  103051:	89 f8                	mov    %edi,%eax
  103053:	d3 e8                	shr    %cl,%eax
  103055:	89 54 24 04          	mov    %edx,0x4(%esp)
  103059:	8b 54 24 04          	mov    0x4(%esp),%edx
  10305d:	89 c1                	mov    %eax,%ecx
  10305f:	8b 44 24 08          	mov    0x8(%esp),%eax
  103063:	09 c1                	or     %eax,%ecx
  103065:	89 d8                	mov    %ebx,%eax
  103067:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  10306b:	89 e9                	mov    %ebp,%ecx
  10306d:	d3 e7                	shl    %cl,%edi
  10306f:	89 d1                	mov    %edx,%ecx
  103071:	d3 e8                	shr    %cl,%eax
  103073:	89 e9                	mov    %ebp,%ecx
  103075:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  103079:	d3 e3                	shl    %cl,%ebx
  10307b:	89 c7                	mov    %eax,%edi
  10307d:	89 d1                	mov    %edx,%ecx
  10307f:	89 f0                	mov    %esi,%eax
  103081:	d3 e8                	shr    %cl,%eax
  103083:	89 fa                	mov    %edi,%edx
  103085:	89 e9                	mov    %ebp,%ecx
  103087:	09 d8                	or     %ebx,%eax
  103089:	d3 e6                	shl    %cl,%esi
  10308b:	f7 74 24 08          	divl   0x8(%esp)
  10308f:	89 d3                	mov    %edx,%ebx
  103091:	f7 64 24 0c          	mull   0xc(%esp)
  103095:	89 c7                	mov    %eax,%edi
  103097:	89 d1                	mov    %edx,%ecx
  103099:	39 d3                	cmp    %edx,%ebx
  10309b:	72 06                	jb     1030a3 <__umoddi3+0x103>
  10309d:	75 10                	jne    1030af <__umoddi3+0x10f>
  10309f:	39 c6                	cmp    %eax,%esi
  1030a1:	73 0c                	jae    1030af <__umoddi3+0x10f>
  1030a3:	2b 44 24 0c          	sub    0xc(%esp),%eax
  1030a7:	1b 54 24 08          	sbb    0x8(%esp),%edx
  1030ab:	89 d1                	mov    %edx,%ecx
  1030ad:	89 c7                	mov    %eax,%edi
  1030af:	89 f2                	mov    %esi,%edx
  1030b1:	29 fa                	sub    %edi,%edx
  1030b3:	19 cb                	sbb    %ecx,%ebx
  1030b5:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
  1030ba:	89 d8                	mov    %ebx,%eax
  1030bc:	d3 e0                	shl    %cl,%eax
  1030be:	89 e9                	mov    %ebp,%ecx
  1030c0:	d3 ea                	shr    %cl,%edx
  1030c2:	d3 eb                	shr    %cl,%ebx
  1030c4:	09 d0                	or     %edx,%eax
  1030c6:	89 da                	mov    %ebx,%edx
  1030c8:	83 c4 1c             	add    $0x1c,%esp
  1030cb:	5b                   	pop    %ebx
  1030cc:	5e                   	pop    %esi
  1030cd:	5f                   	pop    %edi
  1030ce:	5d                   	pop    %ebp
  1030cf:	c3                   	ret    
  1030d0:	89 da                	mov    %ebx,%edx
  1030d2:	89 f1                	mov    %esi,%ecx
  1030d4:	29 f9                	sub    %edi,%ecx
  1030d6:	19 c2                	sbb    %eax,%edx
  1030d8:	89 c8                	mov    %ecx,%eax
  1030da:	e9 2b ff ff ff       	jmp    10300a <__umoddi3+0x6a>
