TARGET		= $(notdir $(CURDIR))
SOURCES		= source
INCLUDES	= include

SFILES	= $(foreach dir, $(SOURCES), $(wildcard $(dir)/*.s))
CFILES	= $(foreach dir, $(SOURCES), $(wildcard $(dir)/*.c))

OBJS	= $(SFILES:.s=.o) $(CFILES:.c=.o)
DEPS	= $(OBJS:.o=.d)
INCLUDE	= $(foreach dir, $(INCLUDES), -I$(CURDIR)/$(dir))

ARCH	= -mcpu=arm946e-s -march=armv5te -mlittle-endian -mthumb-interwork
ASFLAGS	= $(ARCH) $(COMMON_ARCH) $(INCLUDE)
CFLAGS	= -Wall -Os -fno-builtin $(ARCH) $(INCLUDE) -fno-stack-protector

CC		= arm-none-eabi-gcc

.PHONY: all clean copy

all: $(TARGET).elf

$(TARGET).elf: $(OBJS)
	@$(CC) -T link.ld -Wl,--nmagic $^ -o $@ -nostartfiles -specs=nano.specs -specs=nosys.specs
%.o: %.c
	@echo [$(notdir $(CURDIR))] $(notdir $<)
	@$(CC) $(CFLAGS) -MMD -MP -c $< -o $@
%.o: %.s
	@echo [$(notdir $(CURDIR))] $(notdir $<)
	@$(CC) $(ASFLAGS) -MMD -MP -c $< -o $@

clean:
	@rm -f $(OBJS) $(TARGET).elf $(DEPS)

-include $(DEPS)
