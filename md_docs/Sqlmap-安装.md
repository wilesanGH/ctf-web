### 1. 下载和解压 SQLMap：

SQLMap官网：https://sqlmap.org/

**下载链接**: [SQLMap 下载](https://codeload.github.com/sqlmapproject/sqlmap/legacy.zip/refs/heads/master)

将 ZIP 文件下载并解压后，进入解压的文件夹，确保你已经安装了 Python 环境。

### 2. 安装 Python 和依赖：

SQLMap 需要 Python 环境来运行，通常情况下，它与 Python 3.x 兼容。如果你的系统上没有安装 Python，可以从 [Python 官网](https://www.python.org/downloads/)下载安装。

### 3. 启动 SQLMap：

进入 SQLMap 解压的文件夹后，可以通过命令行执行 SQLMap：

```
python sqlmap.py -h
```

这将显示 SQLMap 的帮助信息，列出所有可用的命令和选项。

**更新到最新的版本**

```python
python sqlmap.py --update
```

### 4. 基本使用：

最常见的 SQLMap 用法是针对目标 URL 进行 SQL 注入测试。以下是一个基本的命令：

```
python sqlmap.py -u "http://example.com/vulnerable_page?id=1" --batch
```

`-u` 后面跟的是你要测试的 URL。

`--batch` 用于自动接受所有默认选项，以避免交互式输入。

如果 URL 存在 SQL 注入漏洞，SQLMap 将自动检测并报告。

### 5. 其他常见功能：

**检测数据库类型**: 使用 `--dbs` 来列出数据库系统：

```
python sqlmap.py -u "http://example.com/vulnerable_page?id=1" --dbs
```

**列出数据库中的表**: 如果 SQLMap 能够访问数据库，还可以列出表：

```
python sqlmap.py -u "http://example.com/vulnerable_page?id=1" -D database_name --tables
```

**获取数据**: 例如，获取特定表中的数据：

```
python sqlmap.py -u "http://example.com/vulnerable_page?id=1" -D database_name -T table_name --dump
```

## --risk 和--level

`--risk` 和 `--level` 是两个非常重要的选项，它们用来控制 **SQLMap** 扫描的深度和复杂度。理解这两个选项能够帮助你更好地定制 SQLMap 的扫描行为，尤其是在对目标网站进行渗透测试时。

### 1. **`--risk` 参数**

**`--risk`** 选项控制 SQLMap 执行攻击的“风险”级别。它的值决定了 SQLMap 在扫描时执行多少种潜在的危险操作（如尝试不同的注入载体、对目标进行更深入的攻击等）。风险越高，SQLMap 就会尝试更多不同的技术和漏洞，这可能会导致更多的干扰、错误或甚至破坏。

#### `--risk` 的取值范围：

> **0**: 最低风险。SQLMap 会只执行基本的注入尝试，不会使用较为激进或危险的攻击技术。
>
> **1**: 默认风险级别，执行一些常见的基础测试，但不会尝试更为复杂的攻击方式。
>
> **2**: 中等风险。SQLMap 会执行更多的尝试，比如一些更复杂的注入方法，但不会进行太多极端的攻击。
>
> **3**: 高风险。SQLMap 会尝试所有可能的注入方式，甚至可能包括一些高破坏性的攻击（如布尔盲注、时间盲注、二次注入等）。

#### 举例：

> 使用 `--risk=0` 时，SQLMap 只会做一些基本的 SQL 注入检测，适合于快速检测且不影响网站正常运行。
>
> 使用 `--risk=3` 时，SQLMap 会进行全面的扫描，尝试各种高级注入技巧，适合深入渗透测试，但可能会对目标站点产生一定的压力。

#### 适用场景：

> **低风险（`--risk=0`）**：适用于初步检测，或者你不想对目标站点产生较大影响的场景。
>
> **中高风险（`--risk=2` 和 `--risk=3`）**：适用于渗透测试中的深度扫描，尤其是需要查找复杂漏洞时。

------

### 2. **`--level` 参数**

**`--level`** 选项控制 SQLMap 执行的“扫描深度”。它决定了 SQLMap 在扫描时的“检测精度”，也就是说，设置较高的 `--level` 值时，SQLMap 会执行更多的注入尝试，包括尝试更复杂的 SQL 注入载体和漏洞检测。

#### `--level` 的取值范围：

> **1** 最低扫描深度。SQLMap 会进行非常基础的扫描，尝试一些简单的注入方法。
>
> **2**: 默认深度。SQLMap 会进行常规扫描，尝试多种常见的注入方式。
>
> **3**: 中等深度。会对目标进行更多的扫描，涵盖更多的注入载体、技术和漏洞。
>
> **4**: 高深度。SQLMap 会进行更为全面和深入的测试，尝试多种高级注入技巧。
>
> **5**: 最深度扫描。SQLMap 会尝试各种复杂的注入方式，适合全面渗透测试，涵盖非常多的注入载体和策略。

#### 举例：

> 使用 `--level=1` 时，SQLMap 只会尝试最基本的 SQL 注入技术，适合快速检测。
>
> 使用 `--level=5` 时，SQLMap 会进行全面的扫描，测试各种可能的注入方式，适合详细的渗透测试。

#### 适用场景：

> **低级别（`--level=1`）**：适用于初步的快速扫描，不希望测试过于深入或对目标产生较大影响。
>
> **高级别（`--level=5`）**：适用于深入的渗透测试，需要尽可能覆盖所有注入技术和漏洞检测。