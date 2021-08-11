# 常用SQL语句（以LeetCode题目为例）
## SELECT
数据获取一般只涉及SQL增改删查中的查，即只会用到SELECT。
用法：
```sql
SELECT 表名.字段名 FROM 表名;
```
如果需要表中的所有字段可以用 * 表示，如：
```sql
SELECT * FROM 表名;
```

## JOIN--关联两张表
LeetCode: 175. 组合两个表

https://leetcode-cn.com/problems/combine-two-tables/

```sql
SELECT p.FirstName, p.LastName, a.City, a.State FROM Person p
LEFT JOIN Address a 
ON p.PersonId = a.PersonId
```
JOIN 分 LEFT JOIN， RIGHT JOIN，FULL JOIN， INNER JOIN，区别为：

**LEFT JOIN：** 取FROM的表的全集，把JOIN表里的内容对上去，JOIN表里没有就输出空值

**RIGHT JOIN：** 取JOIN的表的全集，把FROM表里的内容对上去，FROM表里没有就输出空值

**FULL JOIN：** 取两个表的并集

**INNER JOIN：** 取两个表的交集

**ON** 后面写的是两张要关联表中共同存在的列

SQL中的JOIN和Python Pandas 中merge的对应：

SQL JOIN 的on 相当于 merge 参数中的 on

SQL JOIN 的 LEFT、RIGHT 等 在merge 参数中相当于 how

上述SQL用Python Pandas 的merge写：
```python
Person = pd.merge(Person, Address, on='PersonId', how='left')
```

## ORDER BY--排序
LeetCode: 176. 第二高的薪水

https://leetcode-cn.com/problems/second-highest-salary/

第二高的薪水的思路为降序排列后取第二个

排序使用ORDER BY

数据：

Salary

|Id|Salary|
|---|---|
|1|100|
|2|200|
|3|300|

```sql
SELECT * FROM Salary
ORDER BY Salary;
```
输出：
|Id|Salary|
|---|---|
|3|300|
|2|200|
|1|100|

升序和降序可以在ORDER BY语句最后加：

**升序**：ASC

**降序**：DESC

默认**降序**

如：
```sql
SELECT * FROM Salary
ORDER BY Salary DESC;
```

## LIMIT OFFSET--截取数据
LeetCode: 176. 第二高的薪水

https://leetcode-cn.com/problems/second-highest-salary/

截取使用LIMIT OFFSET

数据：

Salary
|Id|Salary|
|---|---|
|1|100|
|2|200|
|3|300|

```sql
SELECT * FROM Salary
ORDER BY Salary
LIMIT 1 OFFSET 1;
```
输出：

|Id|Salary|
|---|---|
|2|200|

截取数据需要两个参数：

截取几行数据：LIMIT N

跳过几行数据开始截取：OFFSET M

OFFSET可省略，

LIMIT N OFFSET M → LIMIT M, N

参数数字会**颠倒**

## DISTINCT--去重
LeetCode: 176. 第二高的薪水

https://leetcode-cn.com/problems/second-highest-salary/

当数据出现重复时，只排序和截取会出错

数据：

Salary
|Id|Salary|
|---|---|
|1|100|
|2|200|
|3|300|
|4|300|

此时第二高的薪水依然是200，但按照上面的SQL写
```sql
SELECT * FROM Salary
ORDER BY Salary
LIMIT 1 OFFSET 1;
```
输出：
|Id|Salary|
|---|---|
|3|300|

所以需要对数据进行去重之后再做排序

```sql
SELECT DISTINCT * FROM Salary
ORDER BY Salary
LIMIT 1 OFFSET 1;
```

## IFNULL()--空值判断

## IF()--条件判断



