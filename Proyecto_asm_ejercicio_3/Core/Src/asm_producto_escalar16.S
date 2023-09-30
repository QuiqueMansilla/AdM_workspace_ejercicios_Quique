.syntax unified
.thumb
.text

@ Simbolos exportados --> No olvidar de colocar los nombres de las funciones aquí
.global asm_producto_escalar16

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_producto_escalar32(uint16_t* vector_in, uint16_t* vector_out,
@								uint32_t longitud, uint16_t escalar);
@
@ Parametros recibidos:
@   r0: vector_in
@   r1: vector_out
@   r2: longitud
@   r3: escalar
@
.thumb_func
    asm_producto_escalar16:
    	@ Guardas de seguridad. Tener mas en cuenta para divisiones por 0
    	// cbz r0, exit_producto_escalar16
    	// cbz r1, exit_producto_escalar16
    	// cbz r2, exit_producto_escalar16
    	// cbz r3, exit_producto_escalar16

    	push {r4} @ mando al stack r4 (variable auxiliar)

    	loop_producto_escalar16:
    		subs r2, #1 @ Decremento en uno el "contador" (longitud) y afecto flag Zero

    		ldrh r4, [r0, r2, LSL #1] @ Guardo en r4 (auxiliar) *(r0 + (r2<<2)) = r4
    								  @ usamos ldrh porque trabajamos con 16 bits (half word)
    								  @ LSL #1 desplazamiento de 2 bytes

    		@mul Rd, Rn, Rm -> Rd = Rn*Rm
    		mul r4, r4, r3 @ r4 = r4*r3 (r3 escalar o factor)
    		strh r4, [r1, r2, LSL #1] @ r4 --> *(r1 + (r2<<2)) (equivalente a decir que escribo
    								 @ el producto por un escalar contenido en r4 en el elemento
    								 @ correspondiente en el vector de salida) desplazamiento
    								 @ LSL #1 es de a dos bytes porque estamos con 16 bits por
    								 @ eso usamos strh

    		bne loop_producto_escalar16 @ cuando "subs" hace llegar a 0 en valor de r2 se activa
    									@ el flag Zero y "bne" sale del loop


		pop {r4} @ recupero del stack el valor de r4

    	exit_producto_escalar16:
	        bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
	                    @ es la direccion, en el codigo del programa, de la
	                    @ instruccion "bl asm_sum" usada para saltar a
	                    @ esta funcion, entonces "lr" contiene ese "pc" + 4).
	                    @ el valor de retorno debe quedar en el registro r0.
	                    @ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
