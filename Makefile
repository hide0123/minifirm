TARGET		= mini
ARM9_ELF	= arm9/arm9.elf

export CC	= arm-none-eabi-gcc

.PHONY: all clean send

all: $(TARGET).firm

$(TARGET).firm: $(ARM9_ELF)
	@echo [FIRM] $@
	@firmtool build $@ -D $(ARM9_ELF) -C NDMA -i

$(ARM9_ELF):
	@$(MAKE) --no-print-directory -C arm9

clean:
	@$(MAKE) --no-print-directory -C arm9 clean
	@rm -f $(TARGET).firm

send: $(TARGET).firm
ifeq ($(IP),)
	@echo [ERROR] Please set "IP"
else
	@curl -T $< ftp://$(IP):5000/gm9/payloads/
endif
