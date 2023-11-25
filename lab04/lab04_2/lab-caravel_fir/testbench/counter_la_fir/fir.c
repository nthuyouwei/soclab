#include <stdint.h>
#include <stdbool.h>

#define N 64

int outputsignal[N];
// AP control
#define reg_fir_control (*(volatile uint32_t*)0x30000000)

// FIR input X, FIR output Y
#define reg_fir_x (*(volatile uint32_t*)0x30000080)
#define reg_fir_y (*(volatile uint32_t*)0x30000084)



int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){ 
	// initial first
	// initfir();
	reg_fir_control = 1; //set ap_start, bit[0] = 1

	for (int i=0; i<64; i++){
		while((reg_fir_control >> 4) & 1 != 1); // external signal x[n] ready, wait until bit[4] = 1
		reg_fir_x = i;
		while((reg_fir_control >> 5) & 1 != 1); // external signal y[n] ready, wait until bit[5] = 1
		outputsignal[i] = reg_fir_y;
	}
	while((reg_fir_control >> 1) & 1 != 1); // read ap_done, bit[1] = 1

	return &outputsignal[63];
}
		