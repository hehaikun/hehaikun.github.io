#异常控制流学习笔记

###什么是异常？
异常是异常控制流的一种形式，一部分有硬件实现，一部分有软件实现。
系统中每一种可能的异常都分配了一个非负整数的异常号，异常号是异常表的索引，就像数字的下标那样，异常表是一个跳转表，包含异常号对应异常处理程序代码的地址。异常表的其实地址放在一个异常表基址寄存器的CPU特殊寄存器里面。

###程序发生异常后会系统会怎么处理？
当程序发生异常的时候，处理器将一些额外的处理状态压到栈里面，然后跳转到异常控制处理程序中执行，在处理程序返回的时候，重新恢复被中断的程，同时将被压在栈里面的状态恢复。
如果程序转移到内核，所有的项目都被压到内核栈里面去，而不是压到用户栈里面。

###异常的类型有哪些？

异常的类型有中断，陷阱，故障，终止。
中断：来之I/O设备的信号，是异步发生的，中断总是返回到下一条指令。
陷阱：是有意的异常，一般用于系统调用syscall，同步发生的，总是返回到下一条指令。
终止：是不可恢复的错误，是不可返回的，直接退出程序。
不同的异常号对应不同的异常类别，比如异常号0对应的是除法错误，当结果目标值相对于操作数太大的时候，就会发生除法错误。这种除法错误直接终止程序的运行。
可修复的故障如缺页故障，异常号14，处理程序将磁盘上的虚拟内存映射到物理内存中的一个页面，然后重新返回到当前的这条故障指令，进行重新执行。

###什么是进程？
进程是代码程序执行的一个实例。一份代码程序可以有多个实例，也就是多线程。多线程的实现就是基于异常控制流来使CPU“同时”执行多份代码。逻辑控制流就是程序计数器值得序列。
进程提供给应用程序的抽象：
1.独立的逻辑控制流，（好像是程序独占CPU）。
2.私有地址空间，（好像是程序独占内存系统）。 

###并发流
一个逻辑流在执行的时间上和另一个逻辑流有重叠，被称为是并发流。也就是说一个流在另一个流开始之后结束之前开始，这两个流就是并发流。多流并发执行称为并发，一个进程和其他进程轮流执行被称为多任务，执行的每一个时间段称为时间片。

###内核模式 用户模式
处理器通过控制寄存器的模式来限制程序可执行的指令和可访问的地址空间范围。
模式位描述了进程的特权，设置了模式位就是内核模式，没有设置模式位就是用户模式。
用户程序必须通过系统调用来间接访问内核代码和数据。
/proc 文件系统 可以访问到内核的数据结构内容。
/sys 输出系统总线和设备的额外底层信息。

###上下文切换
内核为每一个进程维持一个上下文，内核抢占当前进程并开是一个先前被抢占的进程，这种决策叫调度，由内核中的调度器的代码来处理。
抢占当前的进程，并使用一种叫上下文切换的基址来转移到新的进程。分为两个步：
1.保存当前进程的上下文，2.恢复先前被抢占时保存的上下文。
中断也能引发上下文的切换，内核模式下也有可能进行调度。

###进程控制
获取pid和ppid  
创建进程fork  返回值==-1的时候调用出错  返回值==0的时候是子进程  返回值为非零正整数的时候是父进程 
进程退出  收到 SIGKILL等终止进程的信号时会退出   从主程序中退出  调用了exit函数 

###回收子进程  
当进程退出的时候会发送个器父进程一个信号，通知父进程子进程退出，父进程进行回收子进程的资源，子进程退出后 资源回收之前被称为僵尸进程。
父进程使用waitpid的函数进程回收，还有一个简化版的wait函数。
程序不会以特定的顺序进行回收子进程的资源

###加载并运行程序
使用的函数是execve(char * filenanme, char * argv[], char *envp[]);
filename 是可执行目标程序  
argv 是传输的参数  
envp 是环境变量

###程序和进程之间的区别
程序是一堆代码和数据，可以存储在磁盘上，或者作为段存在地址空间中，
进程是执行中程序的一个实例，程序总是运行在某个进行的上下文中，
fork是在新的子进程的上下文中加载相同的程序，新的子进程是父进程的一个复制品
execve函数是在当前进程的上下文中加载并运行一个新的程序。它会覆盖当前进程的地址空间，但是没有创建一个新进程，继承调用execve函数之前打开的所有文件描述符。

我们可以使用fork和execve函数配合，来执行一个加载新程序的子进程。
我们fork一个子进程之后，在子进程退出的时候，我们要记得使用waitpid函数进行回收子进程的资源。当一个子进程退出的时候，内核会给其父进程发送17号信号 SIGCHLD信号，通知父进程有子进程退出。

###信号
一个信号就是一条小消息，通知进程系统中发生了一个某种类型的事件。
传送一个信号到目的进程是由两个不同的步骤组成的：
发送信号过程  --- 内核通过更新目的进程的上下文中的某个状态，发送一个信号给目的进程，  发送信号有两种方式1是内核检测到一个系统事件，一个错误或者子进程终止等。2是一个进程调用了kill函数，显式的要求内核发送一个信号给目的进程，一个进程可以发送信号给自己。
接收信号过程  ---  当进程被内核强迫以某种方式对信号做错反应，它就是接收了这个信号。进程可一个忽略，终止或者以一个自己定义的程序来对信号做出反应。

发送信号：
进程组，一个子进程和其父进程属于同一个进程组 通过 setpgid（pid  gid）来改变进程的组。
如果参数都是0 新建一个进程组将当前进程加入进去，进程组号等于进程号
1.使用/bin/kill 发送信号  
2.从键盘发送信号---  ctl+c 发送SIGINT信号，ctl+z 发送一个SIGTSTP信号等。。。。
3.使用kill函数进行发送信号。int kill（pid  sig）
4.使用alarm函数进行发送信号，发送SIGALRM信号给自己。参数是时间
