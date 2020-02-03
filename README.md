# System Call
## 1. Initial configuration:
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
### 2. Move to working directory
> cd /usr/src
### 3. Download latest kernel version
> wget https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.17.4.tar.xz
### 4. Extract
> sudo tar -xvf linux-4.17.4.tar.xz
### 5. Move to extracted files
> cd linux-4.17.4
### 6. Create directory to write our sys_call function
> mkdir printint   
> cd printint
### 7. Create file for our syscall
> nano printint.c
### 8. Write function:
> SYSCALL_DEFINE1(my_printint_1, int, a)  
{  
    printk("My number to print is : %d\n", a);  
    return 0;  
}  
### 9. Create Makefile
> nano Makefile
### 10. Add this line:
> obj-y := printint.o
### 11. Return to previous directory and open Makefile
> cd ../  
> nano Makefile
### 12. add printint/ to the kernel’s Makefile.
> Search (crtl^ w) for: core-y (on the second match)
#### add " printint/" the end of this line: core-y += kernel/ mm/ fs/ ipc/ security/ crypto/ block/ 
> core-y += kernel/ mm/ fs/ ipc/ security/ crypto/ block/ printint/"
### 13. Add the system call to the system call table:
#### move to this directory: 
> cd arch/x86/entry/syscalls/  
> nano syscall_64.tbl  
#### add a new line: 
> (next id)     common     my_printint_1     __x64_sys_my_printint_1  
### 14. add the system call to the system call's header file
#### move to this directory:  
> cd include/linux/  
> nano syscalls.h  
#### add the following line at the end of the file and rigt before "#endif"
> asmlinkage long sys_my_printint_1(int);  
> #endif
### 15. Last update 
> sudo apt-get update  
> sudo apt-get upgrade  
### 16. from linux-4.17.4/ directory
> make menuconfig
> make
### 17.wait ... ... ... ... ... 
> ...  
> ...  
### 18. update Kernel
> sudo make modules_install install  
