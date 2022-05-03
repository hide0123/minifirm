TARGET		= mini
ARM9_ELF	= arm9/arm9.elf
ARM11_ELF   = arm11/arm11.elf

export CC	= arm-none-eabi-gcc

.PHONY: all clean send

all: $(TARGET).firm

$(TARGET).firm: $(ARM9_ELF) $(ARM11_ELF)
	@echo [FIRM] $@
	@firmtool build $@ -D $(ARM11_ELF) $(ARM9_ELF) -C XDMA NDMA -A 0x20000000 -i

$(ARM9_ELF):
	@$(MAKE) --no-print-directory -C arm9

$(ARM11_ELF):
	@$(MAKE) --no-print-directory -C arm11

clean:
	@$(MAKE) --no-print-directory -C arm9 clean
	@$(MAKE) --no-print-directory -C arm11 clean
	@rm -f $(TARGET).firm

send: $(TARGET).firm
ifeq ($(IP),)
	@echo [ERROR] Please set "IP"
else
	@curl -T $< ftp://$(IP):5000/gm9/payloads/
endif

verify:
	firmtool parse $(TARGET).firm