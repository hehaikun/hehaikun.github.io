---
title: "C语言函数与递归：从基础到高级"
date: 2026-03-28
tags: ["C语言", "函数", "递归", "算法"]
categories: ["C语言"]
draft: false
---

# C语言函数与递归：从基础到高级

函数是C语言模块化编程的核心，而递归则是解决复杂问题的强大工具。本文将详细介绍函数的定义、参数传递方式以及递归的应用。

## 函数基础

### 函数的定义和声明

```c
// 函数声明（原型）
int add(int a, int b);  // 告诉编译器函数存在

// 函数定义
int add(int a, int b) {
    return a + b;
}
```

### 函数的组成

```
┌─────────────────────────────────────┐
│ 返回类型  函数名 (参数列表)          │
├─────────────────────────────────────┤
│ int        add   (int a, int b)    │
│ {                                  │
│     // 函数体                       │
│     return a + b;                   │
│ }                                  │
└─────────────────────────────────────┘
```

### 完整示例

```c
#include <stdio.h>

// 函数声明
int calculate(int a, int b, char op);
void printResult(int result);

int main() {
    int num1 = 10, num2 = 5;
    char operation = '+';

    // 调用函数
    int result = calculate(num1, num2, operation);
    printResult(result);

    return 0;
}

// 函数定义：计算器
int calculate(int a, int b, char op) {
    switch (op) {
        case '+': return a + b;
        case '-': return a - b;
        case '*': return a * b;
        case '/':
            if (b != 0) return a / b;
            else {
                printf("错误：除数不能为0\n");
                return 0;
            }
        default:
            printf("错误：不支持的操作符\n");
            return 0;
    }
}

// 函数定义：打印结果
void printResult(int result) {
    printf("计算结果：%d\n", result);
}
```

## 参数传递方式

### 1. 值传递（默认方式）

```c
void modifyValue(int x) {
    x = 100;  // 修改的是副本，不影响原变量
}

int main() {
    int a = 10;
    modifyValue(a);
    printf("a的值：%d\n", a);  // 输出：10（原值未改变）
    return 0;
}
```

```
值传递示意图：
┌─────────┐
│ main()  │
│  a = 10 │
└────┬────┘
     │ 调用 modifyValue(a)
     │ 传递 a 的副本
     ↓
┌──────────────┐
│modifyValue() │
│   x = 10     │ ← x是a的副本
│   x = 100    │ ← 只修改x
└──────────────┘
```

### 2. 指针传递（引用传递）

```c
void modifyValue(int *x) {
    *x = 100;  // 通过指针修改原变量
}

int main() {
    int a = 10;
    modifyValue(&a);
    printf("a的值：%d\n", a);  // 输出：100（原值已改变）
    return 0;
}
```

```
指针传递示意图：
┌─────────┐
│ main()  │
│  a = 10 │
└────┬────┘
     │ 调用 modifyValue(&a)
     │ 传递 a 的地址
     ↓
┌──────────────┐
│modifyValue() │
│   x = &a     │ ← x存储a的地址
│  *x = 100    │ ← 通过地址修改a
└──────────────┘
        ↓
    ┌─────┐
    │ a=100│ ← a被修改
    └─────┘
```

### 实际应用：交换两个数

```c
// ❌ 错误的写法（值传递）
void swapBad(int a, int b) {
    int temp = a;
    a = b;
    b = temp;
}

// ✅ 正确的写法（指针传递）
void swapGood(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int main() {
    int x = 5, y = 10;

    swapBad(x, y);
    printf("swapBad后：x=%d, y=%d\n", x, y);  // x=5, y=10（未交换）

    swapGood(&x, &y);
    printf("swapGood后：x=%d, y=%d\n", x, y); // x=10, y=5（已交换）

    return 0;
}
```

## 递归函数

### 什么是递归？

递归是函数调用自身的过程。递归函数需要满足两个条件：
1. **基准情况（Base Case）**：递归的终止条件
2. **递归情况（Recursive Case）**：向基准情况推进

### 经典示例：阶乘

```c
long factorial(int n) {
    // 基准情况
    if (n <= 1) {
        return 1;
    }
    // 递归情况
    return n * factorial(n - 1);
}
```

```
递归调用过程（factorial(4)）：

factorial(4)
├─ return 4 * factorial(3)
│    └─ factorial(3)
│         └─ return 3 * factorial(2)
│              └─ factorial(2)
│                   └─ return 2 * factorial(1)
│                        └─ factorial(1)
│                             └─ return 1  ← 基准情况
│                   return 2 * 1 = 2
│              return 3 * 2 = 6
│         return 4 * 6 = 24
```

```c
#include <stdio.h>

long factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int main() {
    for (int i = 1; i <= 10; i++) {
        printf("%d! = %ld\n", i, factorial(i));
    }
    return 0;
}
```

### 斐波那契数列

```c
int fibonacci(int n) {
    // 基准情况
    if (n <= 1) {
        return n;
    }
    // 递归情况
    return fibonacci(n - 1) + fibonacci(n - 2);
}
```

```
递归树（fibonacci(4)）：

             fib(4)
           /        \
        fib(3)     fib(2)
        /    \      /    \
    fib(2) fib(1) fib(1) fib(0)
    /   \    |     |      |
fib(1)fib(0) 1     1      0
  |     |
  1     0

结果：1+0+1+1+0 = 3
```

### 汉诺塔问题

```c
void hanoi(int n, char from, char to, char aux) {
    // 基准情况：只有一个盘子
    if (n == 1) {
        printf("将盘子 1 从 %c 移到 %c\n", from, to);
        return;
    }

    // 递归情况
    hanoi(n - 1, from, aux, to);      // 将n-1个盘子从from移到aux
    printf("将盘子 %d 从 %c 移到 %c\n", n, from, to);
    hanoi(n - 1, aux, to, from);      // 将n-1个盘子从aux移到to
}

int main() {
    int n = 3;
    printf("%d个盘子的汉诺塔解法：\n", n);
    hanoi(n, 'A', 'C', 'B');
    return 0;
}
```

```
汉诺塔示意图（3个盘子）：

初始状态：      目标状态：
    A  B  C          A  B  C
   [3]               [3]
   [2]      →        [2]
   [1]               [1]

移动步骤：
1. 将盘子1从A移到C
2. 将盘子2从A移到B
3. 将盘子1从C移到B
4. 将盘子3从A移到C
5. 将盘子1从B移到A
6. 将盘子2从B移到C
7. 将盘子1从A移到C
```

## 函数的高级特性

### 默认参数（C99变长参数）

```c
#include <stdio.h>
#include <stdarg.h>

// 变长参数函数
double average(int count, ...) {
    va_list args;
    double sum = 0;

    va_start(args, count);
    for (int i = 0; i < count; i++) {
        sum += va_arg(args, int);
    }
    va_end(args);

    return sum / count;
}

int main() {
    printf("平均值：%.2f\n", average(3, 10, 20, 30));  // 20.00
    printf("平均值：%.2f\n", average(5, 1, 2, 3, 4, 5));  // 3.00
    return 0;
}
```

### 函数指针

```c
#include <stdio.h>

int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }

int main() {
    // 声明函数指针
    int (*operation)(int, int);

    // 指向add函数
    operation = add;
    printf("加法：%d\n", operation(5, 3));  // 8

    // 指向subtract函数
    operation = subtract;
    printf("减法：%d\n", operation(5, 3));  // 2

    return 0;
}
```

## 递归 vs 迭代

### 阶乘的两种实现

```c
// 递归版本
long factorialRecursive(int n) {
    if (n <= 1) return 1;
    return n * factorialRecursive(n - 1);
}

// 迭代版本
long factorialIterative(int n) {
    long result = 1;
    for (int i = 2; i <= n; i++) {
        result *= i;
    }
    return result;
}
```

| 特性 | 递归 | 迭代 |
|------|------|------|
| 代码简洁性 | ✅ 更简洁 | ❌ 相对复杂 |
| 内存使用 | ❌ 较高（栈空间） | ✅ 较低 |
| 执行效率 | ❌ 较慢（函数调用开销） | ✅ 较快 |
| 可读性 | ✅ 逻辑清晰 | ❌ 需要跟踪状态 |
| 栈溢出风险 | ❌ 存在 | ✅ 不存在 |

## 最佳实践

1. **选择合适的参数传递方式**
   - 小类型：值传递
   - 大数据：指针传递
   - 需要修改：指针传递

2. **递归使用注意事项**
   - 确保有基准情况
   - 确保递归向基准情况推进
   - 注意栈溢出风险（大递归深度时用迭代替代）

3. **函数设计原则**
   - 单一职责原则
   - 函数名清晰表达功能
   - 参数数量不宜过多

## 总结

函数和递归是C语言编程的重要组成部分：

- 理解值传递和指针传递的区别
- 掌握递归的设计要点（基准情况和递归情况）
- 知道何时使用递归，何时使用迭代
- 了解函数指针等高级特性

通过不断练习，你会发现函数和递归是解决复杂问题的有力工具！
