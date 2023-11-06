#include "fir.h"

void __attribute__ ( ( section ( ".mprjram" ) ) ) initfir() {
	//initial your fir
	for(int i=0;i<N;i++){
	    inputbuffer[i]=0;
	    outputsignal[i]=0;	
	}
}

int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
	initfir();
	//write down your fir
	for(int i =0;i<N;i++){
	     inputbuffer[i]=inputsignal[i];
       	for(int j =0;j<N;j++){
       	  if((i-j)>=0){
	         outputsignal[i]+=taps[j]*inputbuffer[i-j];
	         }
	   }	
	}
	
	
	
	return outputsignal;
}
		
