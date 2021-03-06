# Steps for configuring your own System Call
## 1. Initial configuration:
### Prepare 
```
> sudo su  
apt-get update && apt-get upgrade  
apt-get -y install curl  
apt-get install xz-utils  
apt-get install nano  
apt-get install make  
sudo apt-get install gcc  
sudo apt-get install libncurses5-dev  
sudo apt-get install bison  
sudo apt-get install flex  
sudo apt-get install libssl-dev  
sudo apt-get install libelf-dev 
```
### 2. Move to working directory
```
> cd /usr/src
```
### 3. Download latest kernel version
```
> wget https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.17.4.tar.xz
```
### 4. Extract
```
> sudo tar -xvf linux-4.17.4.tar.xz
```
### 5. Move to new extracted path (linux-4.17.4)
```
> cd linux-4.17.4
```
### 6. Create directory to write our sys_call function and move into this new directory
```
> mkdir printint   
> cd printint
```
### 7. Create file for our syscall
```
> nano printint.c
```
### 8. Write function inside printint.c:
#### Understanding the function:
>
SYSCALL_DEFINE1 is a macro for functions with 1 parameter. The number represents the quantity of paremeters that it accepts.
```
SYSCALL_DEFINE1(my_printint_1, int, a)  
{  
    printk("My number to print is : %d\n", a);  
    return 0;  
}  
```
### 9. Create Makefile
```
> nano Makefile
```
### 10. Add this line:
```
> obj-y := printint.o
```
### 11. Return to previous directory and open Makefile
```
> cd ../  
nano Makefile
```
### 12. add printint/ to the kernel’s Makefile.
#### search for core-y using crtl^ w
#### on the second match add the path to the end of the line.
> add " printint/" the end of this line: core-y += kernel/ mm/ fs/ ipc/ security/ crypto/ block/ 
```
> core-y += kernel/ mm/ fs/ ipc/ security/ crypto/ block/ printint/
```
### 13. Add the system call to the system call table:
#### move to syscalls directory and open syscall_64.tbl: 
```
> cd arch/x86/entry/syscalls/  
nano syscall_64.tbl  
```
#### add a new line at the end:
```
> (next id)     common     my_printint_1     __x64_sys_my_printint_1  
```
### 14. add the system call to the system call's header file
#### move to this directory:  
```
> cd include/linux/  
nano syscalls.h  
```
#### add the following line at the end of the file and rigt before "#endif"
```
> asmlinkage long sys_my_printint_1(int);  
#endif
```
### 15. Last update 
```
> sudo apt-get update  
sudo apt-get upgrade  
```
### 16. from your linux-4.17.4/ directory run: (you can run:  "make -jn" in order to use n (remember to replace a number instead of n) cores of your cpu to compile faster) 
```
> make menuconfig
make
```
### 17. Wait for the kernel to compile
```
...  wait
...  keep waiting
```
### 18. update Kernel
```
> sudo make modules_install install  
```
### 19. Reboot system to update changes in kernel. 
```
> shutdown -r now
```
### 20. Verify the version of the kernel
```
uname -r
```
#### This command should display the version of the kernel that we just updated and modified. (4.17.4)

## Why does this doesn't work on Docker
This excercise will not function in a Docker container since docker containers work on top of the host's kernel. So after we reboot the container, the kernel versions remains unchanged. Since docker works on a closed environment (sandbox) it is unable to make changes to the kernel
