# minifirm
A template to build a 3DS firmware binary which has an Arm9 and Arm11 section out of the box.

## Install dependencies

```
$ sudo apt install gcc-arm-none-eabi binutils-arm-none-eabi python3-pip
$ pip3 install -U git+https://github.com/TuxSH/firmtool.git
```

## Build
```
git clone https://github.com/HIDE810/minifirm.git
cd minifirm
make
```

## License
This project is licensed under the GNU General Public License v2.0. Refer to the `license.txt` file for more information.

## Credits

- [firm_linux_loader](https://github.com/linux-3ds/firm_linux_loader) - for being great help in the development of this project