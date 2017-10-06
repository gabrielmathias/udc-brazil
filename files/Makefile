FILES = $(wildcard *.txt)

all: convert

convert: $(FILES)
	ls -al $(FILES)
	@echo $(foreach FILE, $(FILES), $(shell sh -c "../fix.sh  $(FILE)  ../fix/$(FILE) " ))

