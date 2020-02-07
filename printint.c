SYSCALL_DEFINE1(my_printint_1, int, a)  
{  
    printk("Number to print is : %d\n", a);  
    return 0;  
}  
