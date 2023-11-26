SHELL = /bin/bash
.DEFAULT_GOAL := 01

bin:
	mkdir -p bin/

01: bin
	nvcc 01-vecAdd.cu -o bin/01-vecAdd
02: bin
	nvcc 02-matMul.cu -o bin/02-matMul
