#pragma once

#include <stdint.h>


void asm_ecovector(int16_t *vectorIn, int16_t *vectorOut, uint32_t longitud, uint32_t msegRetardo);

void asm_ecovectorSIMD(int16_t *vectorIn, int16_t *vectorOut, uint32_t longitud, uint32_t msegRetardo);
