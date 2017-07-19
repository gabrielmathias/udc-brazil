FILES = $(wildcard data/*txt)
GOOD_TESTS = $(wildcard good_tests/*txt)
BAD_TESTS = $(wildcard bad_tests/*txt)

all: cdu tests

build/cdu.tab.c build/cdu.tab.h:	src/cdu.y
	cd build ; bison -d ../src/cdu.y ; cd -

build/lex.yy.c: src/cdu.l build/cdu.tab.h
	flex -o build/lex.yy.c src/cdu.l

cdu: build/lex.yy.c build/cdu.tab.c build/cdu.tab.h
	gcc -o cdu build/cdu.tab.c build/lex.yy.c

clean:
	rm cdu build/cdu.tab.c build/lex.yy.c build/cdu.tab.h good_tests/*done

convert: $(FILES)
	ls -al $(FILES)

tests: goodtests badtests

goodtests:
	@echo "Good Tests"
	@echo $(foreach GOOD, $(GOOD_TESTS), $(shell sh -c "./testgood.sh $(GOOD) " ))

badtests:
	@echo "Bad Tests"
	@echo $(foreach BAD, $(BAD_TESTS), $(shell sh -c "./testbad.sh  $(BAD) " ))

