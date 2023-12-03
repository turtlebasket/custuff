SHELL = /bin/bash
.DEFAULT_GOAL := 01

bin:
	mkdir -p bin/

01: bin
	nvcc 01-vecAdd.cu -o bin/01-vecAdd
02: bin
	nvcc 02-matMul.cu -o bin/02-matMul

01st: bin
	g++ 01-vecAddSt.cpp -o bin/01-vecAddSt

01cmp: bin 01st 01
	@echo
	@echo SINGLE THREADED
	@echo ===============
	@time ./bin/01-vecAddSt > /dev/null
	@echo
	@echo CUDA OPTIMIZED
	@echo ==============
	@time ./bin/01-vecAdd > /dev/null
