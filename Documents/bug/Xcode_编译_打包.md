# 编译

## 打包时报错normal armv7 objective-c++ com.apple.compilers.llvm.clang.1_0.compiler

错误信息：

```
Project/Mateline/Business/Database/MLFMDatabaseQueue.m:18:13: error: 
      use of undeclared identifier '_db'
    return [_db setKey:key];
            ^
1 error generated.
```

原因：安全升级修改FMDB和SQLCipher版本，导致不同的版本无该接口