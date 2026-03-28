---
title: "C语言数组详解：从基础到进阶"
date: 2026-03-28
tags: ["C语言", "数组", "数据结构"]
categories: ["C语言"]
draft: false
---

# C语言数组详解：从基础到进阶

数组是C语言中最基本的数据结构之一，用于存储相同类型的多个数据。本文将全面介绍数组的各种用法和技巧。

## 一维数组

### 声明和初始化

```c
// 声明数组
int scores[5];              // 声明一个包含5个元素的int数组

// 初始化数组
int arr1[5] = {10, 20, 30, 40, 50};  // 完全初始化
int arr2[] = {1, 2, 3, 4, 5};        // 自动计算长度
int arr3[5] = {1, 2, 3};             // 部分初始化，其余为0
int arr4[5] = {0};                   // 全部初始化为0

// 不同类型的数组
char name[20] = "Hello";             // 字符数组
double prices[10];                   // double数组
```

### 数组在内存中的布局

```
int arr[5] = {10, 20, 30, 40, 50};

内存视图（假设int占4字节）：
┌────────┬────────┬────────┬────────┬────────┐
│ arr[0] │ arr[1] │ arr[2] │ arr[3] │ arr[4] │
│  10    │  20    │  30    │  40    │  50    │
└────────┴────────┴────────┴────────┴────────┘
  地址A    地址A+4   地址A+8   地址A+12  地址A+16
```

```c
#include <stdio.h>

int main() {
    int arr[5] = {10, 20, 30, 40, 50};

    printf("数组大小：%zu 字节\n", sizeof(arr));        // 20字节
    printf("元素个数：%zu\n", sizeof(arr) / sizeof(arr[0]));  // 5个

    // 遍历数组
    for (int i = 0; i < 5; i++) {
        printf("arr[%d] = %d, 地址 = %p\n", i, arr[i], &arr[i]);
    }

    return 0;
}
```

### 数组作为函数参数

```c
// 数组作为参数时会退化为指针
void printArray(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

// 等价写法
void printArray2(int *arr, int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);  // 或 *(arr + i)
    }
}

int main() {
    int arr[] = {1, 2, 3, 4, 5};
    printArray(arr, 5);  // 输出：1 2 3 4 5
    return 0;
}
```

## 二维数组

### 声明和初始化

```c
// 声明二维数组
int matrix[3][4];  // 3行4列

// 初始化方式1：完全初始化
int matrix1[2][3] = {
    {1, 2, 3},
    {4, 5, 6}
};

// 初始化方式2：平面初始化
int matrix2[2][3] = {1, 2, 3, 4, 5, 6};

// 初始化方式3：部分初始化
int matrix3[3][4] = {
    {1, 2},
    {3, 4, 5},
    {6}
};
```

### 二维数组内存布局

```
int matrix[2][3] = {
    {1, 2, 3},
    {4, 5, 6}
};

逻辑视图：
        列0  列1  列2
      ┌────┬────┬────┐
行 0  │ 1  │ 2  │ 3  │
      ├────┼────┼────┤
行 1  │ 4  │ 5  │ 6  │
      └────┴────┴────┘

内存视图（行优先存储）：
┌────┬────┬────┬────┬────┬────┐
│ 1  │ 2  │ 3  │ 4  │ 5  │ 6  │
└────┴────┴────┴────┴────┴────┘
  A   A+4  A+8  A+12 A+16 A+20
```

### 二维数组操作示例

```c
#include <stdio.h>

int main() {
    int matrix[3][4] = {
        {1, 2, 3, 4},
        {5, 6, 7, 8},
        {9, 10, 11, 12}
    };

    // 遍历二维数组
    printf("矩阵内容：\n");
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 4; j++) {
            printf("%3d ", matrix[i][j]);
        }
        printf("\n");
    }

    // 计算每行和
    for (int i = 0; i < 3; i++) {
        int sum = 0;
        for (int j = 0; j < 4; j++) {
            sum += matrix[i][j];
        }
        printf("第%d行和：%d\n", i + 1, sum);
    }

    return 0;
}
```

## 字符数组与字符串

### 字符数组基础

```c
// 声明字符数组
char str1[20] = "Hello";           // 包含null终止符
char str2[] = "World";             // 自动计算长度
char str3[10] = {'H', 'e', 'l', 'l', 'o', '\0'};  // 手动添加\0

printf("str1: %s\n", str1);       // 输出：Hello
printf("长度: %zu\n", strlen(str1));  // 输出：5
```

### 字符串操作函数

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str1[20] = "Hello";
    char str2[] = "World";
    char str3[30];

    // strcpy：字符串复制
    strcpy(str3, str1);
    printf("strcpy: %s\n", str3);  // 输出：Hello

    // strcat：字符串连接
    strcat(str3, " ");
    strcat(str3, str2);
    printf("strcat: %s\n", str3);  // 输出：Hello World

    // strcmp：字符串比较
    printf("strcmp: %d\n", strcmp("abc", "abc"));   // 输出：0
    printf("strcmp: %d\n", strcmp("abc", "abd"));   // 输出：负数

    // strlen：字符串长度
    printf("strlen: %zu\n", strlen(str3));  // 输出：11

    return 0;
}
```

## 动态数组

### 使用malloc分配动态数组

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int n;
    printf("请输入数组大小：");
    scanf("%d", &n);

    // 动态分配内存
    int *arr = (int*)malloc(n * sizeof(int));

    if (arr == NULL) {
        printf("内存分配失败！\n");
        return 1;
    }

    // 输入数组元素
    for (int i = 0; i < n; i++) {
        printf("请输入第%d个元素：", i + 1);
        scanf("%d", &arr[i]);
    }

    // 输出数组元素
    printf("数组内容：");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    // 释放内存
    free(arr);

    return 0;
}
```

### 动态调整数组大小（realloc）

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int *arr = malloc(3 * sizeof(int));
    arr[0] = 10;
    arr[1] = 20;
    arr[2] = 30;

    printf("调整前：");
    for (int i = 0; i < 3; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    // 扩展数组到5个元素
    arr = realloc(arr, 5 * sizeof(int));
    arr[3] = 40;
    arr[4] = 50;

    printf("调整后：");
    for (int i = 0; i < 5; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    free(arr);
    return 0;
}
```

## 数组常见应用

### 1. 冒泡排序

```c
void bubbleSort(int arr[], int n) {
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                // 交换
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}
```

### 2. 数组查找

```c
int linearSearch(int arr[], int n, int target) {
    for (int i = 0; i < n; i++) {
        if (arr[i] == target) {
            return i;  // 找到，返回索引
        }
    }
    return -1;  // 未找到
}
```

## 注意事项

1. **数组越界**：访问超出数组索引的元素是未定义行为
2. **数组大小**：声明数组时大小必须是常量表达式（C99之前）
3. **数组赋值**：不能直接用 `=` 赋值数组，需要逐个元素复制或使用memcpy
4. **字符串终止符**：字符数组作为字符串时必须包含 `\0`

```c
int arr[5] = {1, 2, 3, 4, 5};
arr[10] = 100;  // ❌ 数组越界！危险！

int arr1[5] = {1, 2, 3, 4, 5};
int arr2[5];
arr2 = arr1;    // ❌ 不能这样赋值
memcpy(arr2, arr1, sizeof(arr1));  // ✅ 正确
```

## 总结

数组是C语言中最常用的数据结构之一，掌握好数组的使用技巧对编程非常重要：

- 理解数组的内存布局
- 掌握一维、二维数组的声明和使用
- 熟练使用字符串操作函数
- 了解动态数组的使用方法
- 避免常见的数组错误

多练习、多实践，你会发现数组在很多场景下都非常有用！
