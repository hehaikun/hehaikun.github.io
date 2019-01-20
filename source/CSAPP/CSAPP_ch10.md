

## 系统级IO

### 什么是IO？Linux中的文件
IO就是输入输出，这个输入输出的对象是针对主存来说的，往主存上复制数据就是输入，从主存上往外部设备上复制就是输出。这些外部设备包括磁盘驱动器，终端和网络等。对于Unix系统来说，一切都被抽象成文件，对于IO操作，实际上就是对文件进行操作。

### Linux下的文件
Linux下的每一个文件都有一个类型，用来表明他在文件中所扮演的角色。   
Linux下的文件类型一共有七类。普通文件，目录文件，套接字文件，管道文件，链接文件，字符设备文件，块设备文件。  
对于文件的路径分为绝对路径和相对路径。
绝对路径不受任何因素的影响，可以直接使用，缺点就是路径太长太复杂。  
相对路径比较短，但是受当前的工作路径影响，当前的工作路径变化了，相对路径就会跟着变化。  

### 打开和关闭文件，文件描述符的变化
进程可以通过open函数进行打开一个已经存在的文件或者创建一个不存在的文件。  

    #include <sys/types.h>
    #include <sys/stat.h>
    #include <fcntl.h>
    int open(char *filename, int flags, mode_t mode); 
            若成功返回新文件描述符，失败返回-1。
  
flags参数就是指明进程以哪种方式进行访问文件。  
mode用来指定新文件的访问权限。  

进程可以通过close函数关闭一个已经打开的文件。

    #include <unistd.h>
    int close(int fd);
            成功返回0，失败返回-1。

文件描述符是非负整数，其中0，1，2这三个已经被系统占用，分别是标准输入，标准输出，标准错误。如果再打开一个文件，那么新的文件描述符就是3，这样依次往上之后增加。  
细节注意：被关闭的文件描述符的值没有被清除为-1。程序如下：  

    #include <stdio.h>
    #include <sys/types.h>
    #include <sys/stat.h>
    #include <fcntl.h>
    #include <unistd.h>
    int main()
    {
        int fd1 = -1, fd2 = -1, fd3 = -1;
        fd1 = open("foo.txt", O_RDONLY, 0);
        fd2 = open("fxx.txt", O_RDONLY, 0);

        close(fd1);
        printf("fd1= %d \n", fd1);
        printf("fd2= %d \n", fd2);
        printf("fd3= %d \n", fd3);

        fd3 = open("fyy.txt", O_RDONLY, 0);
        
        printf("fd1= %d \n", fd1);
        printf("fd2= %d \n", fd2);
        printf("fd3= %d \n", fd3);
        
        fd1 = open("foo.txt", O_RDONLY, 0);
        printf("fd1= %d \n", fd1);
        printf("fd2= %d \n", fd2);
        printf("fd3= %d \n", fd3);
        
        close(fd1);
        close(fd2);
        close(fd3);
        return 0; 
    }

输出结果：

    hehk@hehk:~/test/C/io_test$ ./a.out 
    fd1= 3 
    fd2= 4 
    fd3= -1 
    fd1= 3 
    fd2= 4 
    fd3= 3 
    fd1= 5 
    fd2= 4 
    fd3= 3 


### 关于文件的操作

读写文件：使用read和write函数进行对文件的读写。  
读取文件元数据：使用stat和fstat函数获取关于文件的信息。  
读取目录内容：使用opendir和closedir函数。  

### 共享文件
内核使用三个相关的数据结构来表示打开的文件。
文件描述符，文件表，v-node表。  
通常一个进程中一个文件描述符指向一个文件表项，然后对应一个v-node表项。不同的文件描述符可以对应同一个文件，这样的文件就是共享文件，被两个文件描述符共享，当然还可以被两个进程共享。



