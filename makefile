src:=./src
bin:=./bin
assemblerdefinition:=avr
microcontroller:=atmega328p
defines:=define avr-gcc define $(microcontroller)
outasmFile:=out.S
outbinFile:=out.elf
hexfile:=out.hex
includes:=inc ./avrlibrary

all: init build

init:
	git submodule update --init
	mkdir -p $(bin)

build: compile assembly tohexfile

tohexfile:
	avr-objcopy -j .text -j .data -O ihex $(bin)/$(outbinFile) $(bin)/$(hexfile)

assembly:
	avr-gcc -nostartfiles -mmcu=$(microcontroller) -o $(bin)/$(outbinFile) $(bin)/$(outasmFile)

compile:
	yama build ao $(bin)/$(outasmFile) $(defines) def $(assemblerdefinition) inc $(src) $(includes)

clean:
	rm -rf $(bin)

