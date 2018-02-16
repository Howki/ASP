SOURCE_DIR=${PWD}/src
OBJ_DIR=${PWD}/obj
INSTALL_DIR=${PWD}/bin
CFLAGS_OPT=-O2 -ftree-vectorize -msse2

TARGET=2lab

all: install

install: ${INSTALL_DIR}/${TARGET}

${INSTALL_DIR}/${TARGET}: ${OBJ_DIR}/${TARGET}.o
	gcc ${OBJ_DIR}/${TARGET}.o -o ${INSTALL_DIR}/${TARGET} -lm -fopenmp

${OBJ_DIR}/${TARGET}.o: ${SOURCE_DIR}/${TARGET}.c
	gcc -c ${CFLAGS_OPT} ${SOURCE_DIR}/${TARGET}.c -o ${OBJ_DIR}/${TARGET}.o -fopenmp


clean:
	rm ${INSTALL_DIR}/* ${OBJ_DIR}/* 
