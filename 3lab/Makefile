SOURCE_DIR=${PWD}/src
OBJ_DIR=${PWD}/obj
INSTALL_DIR=${PWD}/bin
CFLAGS_OPT=

TARGET=3lab

all: install

install: ${INSTALL_DIR}/${TARGET}

${INSTALL_DIR}/${TARGET}: ${OBJ_DIR}/${TARGET}.o
	gcc ${OBJ_DIR}/${TARGET}.o -o ${INSTALL_DIR}/${TARGET} -lm

${OBJ_DIR}/${TARGET}.o: ${SOURCE_DIR}/${TARGET}.c
	gcc -c ${CFLAGS_OPT} ${SOURCE_DIR}/${TARGET}.c -o ${OBJ_DIR}/${TARGET}.o


clean:
	rm ${INSTALL_DIR}/* ${OBJ_DIR}/* Rplots.pdf cache_test
