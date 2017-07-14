FILES = $(wildcard data/*txt)

all: cdu

build/cdu.tab.c build/cdu.tab.h:	src/cdu.y
	cd build ; bison -d ../src/cdu.y ; cd -

build/lex.yy.c: src/cdu.l build/cdu.tab.h
	flex -o build/lex.yy.c src/cdu.l

cdu: build/lex.yy.c build/cdu.tab.c build/cdu.tab.h
	gcc -o cdu build/cdu.tab.c build/lex.yy.c

clean:
	rm cdu build/cdu.tab.c build/lex.yy.c build/cdu.tab.h

convert: $(FILES)
	ls -al $(FILES)

