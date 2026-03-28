---
title: "C语言字符串处理完全指南"
date: 2026-03-28
tags: ["C语言", "字符串", "数据处理"]
categories: ["C语言"]
draft: false
---

# C语言字符串处理完全指南

字符串是程序中最常用的数据类型之一。C语言中，字符串本质上是字符数组，以空字符 `\0` 结尾。本文将详细介绍字符串的各种操作和处理技巧。

## 字符串基础

### 字符串的定义

```c
// 方式1：字符数组
char str1[] = "Hello";      // 自动计算长度，包含\0
char str2[20] = "World";    // 指定大小
char str3[6] = {'H', 'e', 'l', 'l', 'o', '\0'};  // 手动添加\0

// 方式2：字符指针（指向字符串常量）
const char *str4 = "Hello";  // 指向只读内存
```

```
字符串在内存中的表示：

char str[] = "Hello";

内存布局：
┌───┬───┬───┬───┬───┬─────┐
│ H │ e │ l │ l │ o │ \0  │
└───┴───┴───┴───┴───┴─────┘
  0   1   2   3   4   5   索引

注意：字符串必须以 \0 结尾！
```

### 常见错误

```c
// ❌ 错误1：忘记 \0
char str[5] = {'H', 'e', 'l', 'l', 'o'};  // 缺少 \0

// ❌ 错误2：数组大小不够
char str[5] = "Hello";  // 需要6个字节（5字符 + \0）

// ❌ 错误3：修改字符串常量
char *str = "Hello";
str[0] = 'h';  // 运行时错误！字符串常量是只读的

// ✅ 正确做法
char str[6] = "Hello";  // 足够的空间
str[0] = 'h';  // 可以修改
```

## 标准字符串函数

### strlen：字符串长度

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str[] = "Hello World";

    size_t len = strlen(str);
    printf("字符串长度：%zu\n", len);  // 11

    // 手动实现strlen
    size_t my_strlen(const char *s) {
        size_t count = 0;
        while (s[count] != '\0') {
            count++;
        }
        return count;
    }

    printf("手动计算的长度：%zu\n", my_strlen(str));
    return 0;
}
```

### strcpy：字符串复制

```c
#include <stdio.h>
#include <string.h>

int main() {
    char src[] = "Hello";
    char dest[20];

    // strcpy复制字符串（包括\0）
    strcpy(dest, src);
    printf("复制结果：%s\n", dest);  // Hello

    // 手动实现strcpy
    void my_strcpy(char *dest, const char *src) {
        int i = 0;
        while (src[i] != '\0') {
            dest[i] = src[i];
            i++;
        }
        dest[i] = '\0';  // 添加终止符
    }

    char dest2[20];
    my_strcpy(dest2, src);
    printf("手动复制结果：%s\n", dest2);

    return 0;
}
```

### strncpy：安全的字符串复制

```c
#include <stdio.h>
#include <string.h>

int main() {
    char src[] = "Hello World";
    char dest[6];  // 只能存储5个字符 + \0

    // strncpy更安全，可以指定最大长度
    strncpy(dest, src, sizeof(dest) - 1);
    dest[sizeof(dest) - 1] = '\0';  // 确保终止符

    printf("安全复制结果：%s\n", dest);  // Hello

    return 0;
}
```

### strcat：字符串连接

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str1[20] = "Hello ";
    char str2[] = "World";

    strcat(str1, str2);
    printf("连接结果：%s\n", str1);  // Hello World

    // 手动实现strcat
    void my_strcat(char *dest, const char *src) {
        int i = 0, j = 0;
        while (dest[i] != '\0') i++;  // 找到dest的末尾
        while (src[j] != '\0') {
            dest[i++] = src[j++];
        }
        dest[i] = '\0';
    }

    char str3[20] = "Good ";
    char str4[] = "Morning";
    my_strcat(str3, str4);
    printf("手动连接结果：%s\n", str3);

    return 0;
}
```

### strcmp：字符串比较

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str1[] = "Apple";
    char str2[] = "Apple";
    char str3[] = "Banana";

    int result1 = strcmp(str1, str2);
    int result2 = strcmp(str1, str3);

    printf("strcmp(\"%s\", \"%s\") = %d\n", str1, str2, result1);  // 0
    printf("strcmp(\"%s\", \"%s\") = %d\n", str1, str3, result2);  // 负数

    // 比较结果
    if (result1 == 0) {
        printf("str1 和 str2 相同\n");
    }
    if (result2 < 0) {
        printf("str1 在字典序上小于 str3\n");
    }

    // 手动实现strcmp
    int my_strcmp(const char *s1, const char *s2) {
        while (*s1 && (*s1 == *s2)) {
            s1++;
            s2++;
        }
        return *(const unsigned char*)s1 - *(const unsigned char*)s2;
    }

    return 0;
}
```

### strchr 和 strstr：字符串查找

```c
#include <stdio.h>
#include <string.h>

int main() {
    char str[] = "Hello World";

    // strchr：查找字符
    char *ptr = strchr(str, 'o');
    if (ptr != NULL) {
        printf("找到字符 'o' 在位置：%ld\n", ptr - str);  // 4
    }

    // strstr：查找子字符串
    char *sub = strstr(str, "World");
    if (sub != NULL) {
        printf("找到子字符串 \"%s\" 在位置：%ld\n", sub, sub - str);  // 6
    }

    return 0;
}
```

## 字符串转换函数

### 字符串转数字

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    char str1[] = "12345";
    char str2[] = "3.14159";
    char str3[] = "255";

    // atoi：字符串转int
    int num1 = atoi(str1);
    printf("atoi(\"%s\") = %d\n", str1, num1);  // 12345

    // atof：字符串转double
    double num2 = atof(str2);
    printf("atof(\"%s\") = %.5f\n", str2, num2);  // 3.14159

    // strtol：更强大的转换，可以处理不同进制
    long num3 = strtol(str3, NULL, 10);  // 十进制
    long num4 = strtol(str3, NULL, 16);  // 十六进制
    printf("strtol(\"%s\", 10) = %ld\n", str3, num3);  // 255
    printf("strtol(\"%s\", 16) = %ld\n", str3, num4);  // 597

    return 0;
}
```

### 数字转字符串

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int num = 12345;
    char str[20];

    // sprintf：格式化到字符串
    sprintf(str, "%d", num);
    printf("sprintf结果：%s\n", str);  // 12345

    // 浮点数
    double pi = 3.14159;
    sprintf(str, "%.2f", pi);
    printf("格式化浮点数：%s\n", str);  // 3.14

    return 0;
}
```

## 实用字符串处理函数

### 反转字符串

```c
#include <stdio.h>
#include <string.h>

void reverseString(char *str) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        char temp = str[i];
        str[i] = str[len - 1 - i];
        str[len - 1 - i] = temp;
    }
}

int main() {
    char str[] = "Hello World";

    printf("原字符串：%s\n", str);
    reverseString(str);
    printf("反转后：%s\n", str);  // dlroW olleH

    return 0;
}
```

```
字符串反转过程：

"Hello World"
   ↓
  交换第0和第10个字符：H ↔ d
  交换第1和第9个字符：  e ↔ l
  交换第2和第8个字符：   l ↔ r
  交换第3和第7个字符：    l ↔ o
  交换第4和第6个字符：     o ↔ W
   ↓
"dlroW olleH"
```

### 删除字符串中的字符

```c
#include <stdio.h>
#include <string.h>

void removeChar(char *str, char ch) {
    int j = 0;
    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] != ch) {
            str[j++] = str[i];
        }
    }
    str[j] = '\0';
}

int main() {
    char str[] = "Hello World";

    printf("原字符串：%s\n", str);
    removeChar(str, 'l');
    printf("删除'l'后：%s\n", str);  // Heo Word

    return 0;
}
```

### 统计字符频率

```c
#include <stdio.h>
#include <string.h>
#include <ctype.h>

void countChars(const char *str) {
    int freq[256] = {0};  // ASCII字符表

    for (int i = 0; str[i] != '\0'; i++) {
        freq[(unsigned char)str[i]]++;
    }

    printf("字符统计：\n");
    for (int i = 0; i < 256; i++) {
        if (isprint(i) && freq[i] > 0) {
            printf("'%c': %d\n", i, freq[i]);
        }
    }
}

int main() {
    char str[] = "Hello World";

    countChars(str);

    return 0;
}
```

## 字符串分割

### 简单的字符串分割（按空格）

```c
#include <stdio.h>
#include <string.h>

void splitString(const char *str) {
    char buffer[100];
    strcpy(buffer, str);  // 复制字符串（strtok会修改原字符串）

    char *token = strtok(buffer, " ");
    int count = 1;

    while (token != NULL) {
        printf("单词%d：%s\n", count++, token);
        token = strtok(NULL, " ");
    }
}

int main() {
    char str[] = "Hello World This is C Programming";

    printf("原始字符串：%s\n", str);
    printf("分割结果：\n");
    splitString(str);

    return 0;
}
```

### 多字符分割

```c
#include <stdio.h>
#include <string.h>

void multiSplit(const char *str, const char *delimiters) {
    char buffer[100];
    strcpy(buffer, str);

    char *token = strtok(buffer, delimiters);
    int count = 1;

    while (token != NULL) {
        printf("部分%d：%s\n", count++, token);
        token = strtok(NULL, delimiters);
    }
}

int main() {
    char str[] = "apple,banana;orange|grape";

    printf("原始字符串：%s\n", str);
    printf("多字符分割结果：\n");
    multiSplit(str, ",;|");

    return 0;
}
```

## 实战应用：字符串处理函数库

### 实现一个简单的字符串工具库

```c
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>

// 字符串工具函数库

// 判断是否为回文
bool isPalindrome(const char *str) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        if (tolower(str[i]) != tolower(str[len - 1 - i])) {
            return false;
        }
    }
    return true;
}

// 删除所有空格
void removeSpaces(char *str) {
    int j = 0;
    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] != ' ') {
            str[j++] = str[i];
        }
    }
    str[j] = '\0';
}

// 转换为大写
void toUpperCase(char *str) {
    for (int i = 0; str[i] != '\0'; i++) {
        str[i] = toupper(str[i]);
    }
}

// 转换为小写
void toLowerCase(char *str) {
    for (int i = 0; str[i] != '\0'; i++) {
        str[i] = tolower(str[i]);
    }
}

int main() {
    // 测试回文
    char str1[] = "A man a plan a canal Panama";
    removeSpaces(str1);
    toLowerCase(str1);

    if (isPalindrome(str1)) {
        printf("\"%s\" 是回文\n", str1);
    }

    // 测试大小写转换
    char str2[] = "Hello World";
    toUpperCase(str2);
    printf("大写：%s\n", str2);

    toLowerCase(str2);
    printf("小写：%s\n", str2);

    return 0;
}
```

## 注意事项和最佳实践

1. **缓冲区溢出**
   ```c
   char dest[10];
   strcpy(dest, "This is too long");  // ❌ 危险！
   ```

   安全做法：
   ```c
   strncpy(dest, src, sizeof(dest) - 1);
   dest[sizeof(dest) - 1] = '\0';
   ```

2. **检查字符串函数返回值**
   ```c
   if (ptr == NULL) {
       // 处理错误情况
   }
   ```

3. **内存管理**
   ```c
   char *str = malloc(100);
   if (str != NULL) {
       // 使用字符串
       free(str);  // 记得释放内存
   }
   ```

4. **字符串常量是只读的**
   ```c
   char *str = "Hello";
   str[0] = 'h';  // ❌ 错误！
   ```

## 总结

字符串处理是C语言编程中的基础技能：

- 理解字符串在内存中的表示方式
- 熟练使用标准字符串函数（strlen, strcpy, strcmp等）
- 掌握字符串转换和分割技巧
- 注意缓冲区溢出等安全问题

通过不断练习，你将能够熟练处理各种字符串操作场景！
