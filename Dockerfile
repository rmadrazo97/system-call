#Download  ubuntu v16.04
FROM ubuntu:16.0

# Update & upgrade Ubuntu
RUN apt-get update

# get tools
RUN sudo su
RUN apt-get -y install curl
RUN apt-get install xz-utils
RUN apt-get install nano
RUN apt-get install make
RUN sudo apt-get install gcc
RUN sudo apt-get install libncurses5-dev
RUN sudo apt-get install bison
RUN sudo apt-get install flex
RUN sudo apt-get install libssl-dev
RUN sudo apt-get install libelf-dev

# move to working dir
RUN cd /usr/src

# download latest kernel version
RUN wget https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.17.4.tar.xz

#unzip kernel & move to new directory
RUN tar -xvf linux-4.17.4.tar.xz
RUN cd linux-4.17.4

#create directories for sistem call
RUN mkdir printint
RUN cd printint
RUN nano printint.c
RUN echo "SYSCALL_DEFINE1(my_printint_1, int, a) {" >> printint.c
RUN echo "printk('My number to print is : %d\n', a);" >> printint.c
RUN echo "return 0;}" >> printint.c

#create makefile
RUN nano Makefile
RUN echo "obj-y := printint.o" >> Makefile
