#include "draw.h"
#include "hid.h"
#include "i2c.h"

__attribute__((noreturn))
static void mcu_poweroff()
{
	i2cWriteRegister(I2C_DEV_MCU, 0x20, 1 << 0);
	while (1) ;
}

static void wait_any_key_pressed()
{
	while (~HID_PAD & BUTTON_NONE)
		;

	while (!(~HID_PAD & BUTTON_NONE))
		;
}

static void wait_any_key_poweroff()
{
	wait_any_key_pressed();
	mcu_poweroff();
}

int main(int argc, char *argv[])
{
	InitScreenFbs(argc, argv);
	ClearScreenFull(true, true);
	DebugClear();

	Debug("Hello, World!");
	wait_any_key_poweroff();
}
