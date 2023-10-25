.syntax unified
.thumb
.text

@ Simbolos exportados --> No olvidar de colocar los nombres de las funciones aquí
.global asm_promedio

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   int32_t asm_promedio (int32_t * vectorIn, uint32_t longitud);
@
@ Parametros recibidos:
@   r0: vector_in
@   r1: longitud
@   r2:
@   r3:
@
.thumb_func
    asm_promedio:
    	@ Guardas de seguridad. Tener mas en cuenta para divisiones por 0
    	// cbz r0, exit_asm_promedio
    	// cbz r1, exit_asm_promedio
    	push {r4} 	  @ mando al stack r4 (variable auxiliar)
    	mov r3, #0	  @ guardo en r3 el valor de 0 (para iniciar la suma)
		mov r4, r1	  @	guardo en r4 el valor de longitur del vector


    	loop_asm_promedio:
    		subs r1, #1 @ Decremento en uno el "contador" (longitud) y afecto flag Zero
			ldr r2, [r0, r1, LSL #2] @ Guardo en r2 *(r0 + (r1<<4)) = r2
    							 	 @ LSL #2 desplazamiento de 4 bytes
    		add r3, r2				 @ r3 = r3 + r2
    		cbz r1, exit_prom1		 @ compara y salta a exit_max1 si r1 llega a cero
			b loop_asm_promedio		 @ si no, retorna al inicio de loop_asm_promedio

		exit_prom1:
			sdiv r0, r3, r4 		@ salva en r0 el promedio que retornara la funcion
			pop {r4} @ recupero del stack el valor de r4

    	exit_asm_promedio:
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
