![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F27%2F12-59-45-9869421179df9137177597fe738a4696-20250427125943811-60304a.png)

### 2. 加密过程

加密过程由公钥完成，假设明文消息为 M（一个整数，且 M<n），则加密过程如下：
$$
C=M^e(mod n)
$$

> M 是明文消息。
>
> e 是公钥的指数。
>
> n 是公钥的模数。
>
> C 是密文。

### 3. 解密过程

解密过程由私钥完成，给定密文 C，使用私钥指数 ddd 进行解密：
$$
M=C^d(mod n)
$$

> C 是密文。
>
> d 是私钥的指数。
>
> n 是模数。
>
> M 是解密后的明文。



```python

import gmpy2
import hashlib

# 给定参数
p = 1325465431
q = 152317153
e = 65537

# 计算phi和d
phi = (p-1)*(q-1)
d = gmpy2.invert(e, phi)

print(f"d = {d}")

# MD5加密
d_md5 = hashlib.md5(str(d).encode()).hexdigest()
print(f"MD5(d) = {d_md5}")

# 输出flag
print(f"Flag: SLCTF{{{d_md5}}}")
```

