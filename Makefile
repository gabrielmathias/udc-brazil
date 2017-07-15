FILES = $(wildcard data/*txt)

all: cdu alltests fails

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

alltests: cdutests coordinationtests consecutivetests relationtests tests

cdutests:
	@echo "1" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "2" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "3" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "11" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "22" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "33" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123." | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123.4" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123.45" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123.456" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123.456." | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123.456.7" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123.456.78" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123.456.789" | ./cdu > /dev/null && echo "." || echo "FAILED!";

coordinationtests:
	@echo "123+456" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123.123+456" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123+456.456" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123+456" | ./cdu > /dev/null && echo "." || echo "FAILED!";

consecutivetests:
	@echo "123.456/123.456" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123.456/.457" | ./cdu > /dev/null && echo "." || echo "FAILED!";

relationtests:
	@echo "123:456" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123.123:456" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123:456.456" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123.123:456.456" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123.123:456.456/.777" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123::456" | ./cdu > /dev/null && echo "." || echo "FAILED!";


ordertests:
	@echo "123::456" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123.123::456.456" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123::456 comtexto" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123::456 e com texto" | ./cdu > /dev/null && echo "." || echo "FAILED!";
	@echo "123::456 e com texto ! ! ! !" | ./cdu > /dev/null && echo "." || echo "FAILED!";

tests: exttests

exttests:
	@echo "123*kg15" | ./cdu > /dev/null && echo "." || echo "FAILED!";
fails:
	@echo ".1" | ./cdu 2> /dev/null && echo "FAILED!" || echo ".";
	@echo ".2" | ./cdu 2> /dev/null && echo "FAILED!" || echo ".";
	@echo ".3" | ./cdu 2> /dev/null && echo "FAILED!" || echo ".";
	@echo ".12" | ./cdu 2> /dev/null && echo "FAILED!" || echo ".";
	@echo ".23" | ./cdu 2> /dev/null && echo "FAILED!" || echo ".";
	@echo ".123" | ./cdu 2> /dev/null && echo "FAILED!" || echo ".";
