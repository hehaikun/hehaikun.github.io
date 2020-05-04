# 跳跃游戏II

> 欢迎关注公众号：HeaiKun 更过技术干货等着你哟！

![](http://m.qpic.cn/psc?/V137cELJ2urL45/uUnjQtxoKSmXQ5.YSnl4gPaGsLHlQHA87yDObMpSDyhYqfCAbkYR1YiU6y1qKbyg3OvVnrPNYfAU4jjty0BFnw!!/b&bo=WAFYAQAAAAARBzA!&rf=viewer_4)


## 题目

给定一个非负整数数组，你最初位于数组的第一个位置。

数组中的每个元素代表你在该位置可以跳跃的最大长度。

你的目标是使用最少的跳跃次数到达数组的最后一个位置。

示例:


```
输入: [2,3,1,1,4]
输出: 2
解释: 跳到最后一个位置的最小跳跃数是 2。
     从下标为 0 跳到下标为 1 的位置，跳 1 步，然后跳 3 步到达数组的最后一个位置。
```

说明:

假设你总是可以到达数组的最后一个位置。


## 解题思路

这个题使用贪心算法效率很高，第一次接触贪心算法。
这里解释一下**贪心算法**：  

百度百科上是这样解释的：在对问题求解时，总是做出在当前看来是最好的选择。也就是说，不从整体最优上加以考虑，他所做出的是在某种意义上的局部最优解。  

**贪心策略适用的前提是：局部最优策略能导致产生全局最优解。**

这一题的思路是这样的：  
1.  在当前可跳的范围内找出能跳的最远的那个，然后记录这个最远的值。
2.  当当前的可跳范围里遍历完之后，也就是到了一开始的边界值，将最远的那个值当成新的边界值继续找跳的最远值。然后步数加一。
3.  当遍历完所有的之后，当前的步数就是最短的。

如下图：
先找出当前可跳范围内最远的范围，将这个最远的范围当成下一步的边界值，然后继续找。
![](http://m.qpic.cn/psc?/V137cELJ2urL45/uUnjQtxoKSmXQ5.YSnl4gPjLa*lAMEWH2GMcRqtpUXAcdqgTfgxN6vLh639m0FwaqUw3sizwkIJb0TiTBQwOJw!!/b&bo=WALQAAAAAAADB6g!&rf=viewer_4)
![](http://m.qpic.cn/psc?/V137cELJ2urL45/43eWRH6lLSncPe1pJhVzbQNkojM0N*JeIJEtRmFxkUllkdRDvOcYtPqrVChbrk9OgxW2.L45TEs19X8.om4KBOfS4YMHmMfYX7W.KuJkWKQ!/b&bo=7QKlAAAAAAADF3g!&rf=viewer_4)

## 答案代码

```
class Solution {
public:
    int jump(vector<int>& nums) {
        int step = 0;
        int max = 0;
        int end = 0;
        for(int i=0; i< nums.size()-1; i++)
        {
            int currmax = nums[i]+i;
            max = max > currmax ? max : currmax;
            if(i == end)
            {
                end = max;
                step++;
            } 
        }

        return step;
    }
};
```