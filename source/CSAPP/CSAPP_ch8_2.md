### 阻塞和解除阻塞信号

**隐式阻塞**： 内核默认阻塞  当前处理程序正在处理的类型的待处理信号。就是连续收到两个相同的信号，第二个信号收到的时候 第一个信号的处理函数还没有返回，这样就会阻塞掉。

**显示阻塞**：应用程序可以使用sigprocmask函数和它的辅助函数明确的阻塞和解除阻塞选定的信号。这些都是signal.h文件里面声明的函数，如sigprocmask sigemptyset  sigfillset sigaddset sigdelset 等。

### 编写信号处理程序
1. **安全的信号处理**  
信号程序和主程序是并行的执行，所以如果出资源竞争的现象，就会很麻烦。
a. 处理程序要尽可能的简单  
b. 处理程序中只调用异步信号安全的函数。  
c. 保存和恢复errno。  
d. 阻塞所有信号，保护对共享全局数据结构的访问。 
e. 用volatile 声明全局变量，考虑一个处理程序和main函数它们共享一个全局变量。  
f. 使用sig_atomic_t 声明标志。   

2. **正确的信号处理**  
未处理的信号是不排队的，如果信号被阻塞了，第二个信号直接被丢弃掉。如有有一个未处理的信号，就表明，至少有一个信号到达了。
3. **可移植的信号处理**  
在不同的系统中信号处理的语义各有不同，系统调用可以被中断等等。  
signal包装函数设置了一个信号处理程序，其信号处理语义如下：   
！只要这个信号处理程序当前正在处理的那种类型的信号被阻塞。    
！和所有信号一样，信号不会排队等待。   
！只要有可能，被中断的系统调用会自动重启。  
！一旦设置了信号处理程序，它就会一直保持，直到signal函数的参数为sig_ign或sig_dfl被调用。  

### 非本地跳转
是一种用户级的异常控制流形式。控制直接从一个函数转移到另一个当前正在执行的函数，而不需要正常的调用返回序列。通过setjmp 和longjmp来实现。

###操作进程的工具
**strace** 打印一个正在运行的程序和它子进程调用的每一个系统调用轨迹  对于一个好奇的学生而言 这是一个令人着迷的工具 使用-static 编译你的程序，能得到一个更干净的 不带大量与共享库相关输出的轨迹。  
**ps** 列出当前系统中所有的进程，包括僵尸进程。  
**top** 打印出当前系统中进程资源使用的信息。  
**PMAP** 显示进程的内存映射  
**/proc** 一个虚拟文件系统，以ASCII码文本格式输出大量内核数据结构的内容，用户进程可以读这些数据，比如 输入 cat /proc/loadavg  就能看到Linux系统上当前的平均负载。