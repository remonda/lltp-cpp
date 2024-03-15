BUILD_DIR=build

TARGET_DIR=bin

TARGET_EXEC=${TARGET_DIR}/target

LOG_DIR=./logs

SRC_DIR=src

INC_DIR=.

TEST_DIR=test

SRCS=$(shell find ${SRC_DIR} -name '*.cpp' -or -name '*.c')

TESTS=$(shell find ${TEST_DIR} -name '*.cpp' -or -name '*.c')

OBJS=$(SRCS:%.cpp=${BUILD_DIR}/%.o)

TEST_TARGET_DIR=${TARGET_DIR}/test

BUILD_TEST_DIR=${BUILD_DIR}/test

TEST_TARGET_EXEC=$(TESTS:%.cpp=${TARGET_DIR}/%.test)

INC_FLAGS=$(addprefix -I, ${INC_DIR})

INC_FLAGS+= -I/usr/local/include 

LD_FLAGS= -L/usr/local/lib -L/usr/local/opt/llvm/lib -lpthread -lglog -lgflags

TEST_LD_FLAGS= ${LD_FLAGS} -lgtest

CXX=g++

CXXFLAGS= -std=c++17 -g -Wall -Wextra -fPIC

CXXFLAGS+= ${INC_FLAGS}

.PHONY: all clean build test

all:
	${MAKE} build && ${MAKE} test
# build phase
build: ${TARGET_EXEC}
	echo "build successful"

${TARGET_EXEC}: ${OBJS}
	mkdir -p $(dir $@)
	${CXX} ${OBJS} -o $@ ${LD_FLAGS}

${BUILD_DIR}/%.o: %.cpp
	mkdir -p $(dir $@)
	${CXX} ${CXXFLAGS} -c $< -o $@


# build test files phase
test: ${TEST_TARGET_EXEC}
	echo "test files build successful"

${TEST_TARGET_DIR}/%.test: ${BUILD_TEST_DIR}/%.o
	mkdir -p $(dir $@)
	${CXX} $< -o $@ ${TEST_LD_FLAGS}

${BUILD_TEST_DIR}/%.o: ${TEST_DIR}%.cpp
	mkdir -p $(dir $@)
	${CXX} ${CXXFLAGS} -c $< -o $@ ${TEST_LD_FLAGS}

clean:
	rm -r ${BUILD_DIR}
	rm -r ${TARGET_DIR}
	rm -r ${LOG_DIR}/*
	
