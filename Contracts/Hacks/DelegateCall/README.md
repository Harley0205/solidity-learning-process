# solidity-delegatecall漏洞

  
## 使用说明：  
1. 编译部署Lib合约（称为账户A）
2. 继续使用账户A编译部署合约HackMe，需要注意的是HackMe中构造器需要传入第一步Lib合约的地址，也就是初始化HackMe合约中的Lib。  
3. 使用另一个账户编译部署Attack攻击合约，需要注意的是Attac中构造器需要传入第二步HackMe的合约地址(部署Attack的账户称为账户B)  
4. 切换到账户A，查看HackMe合约的Lib和owner的值，Lib的值是Lib合约的地址，owner值为空，也就是初始化的值 0x0000000000000000000000000000000000000000  
5. 切换到账户B，调用Attach合约的attack方法进行攻击，执行后查看HackMe合约中Lib的owner值的变化，可以发现攻击后HackMe合约中Lib和owner的值都变成了Attack合约的地址。到此delegatecall漏洞攻击完成。

## 题外拓展  
1. 如果我们直接调用HackMe合约中的doSomething()并且传入一个值112  
2. 查看HackMe合约的状态变量someNumber发现结果是0，查看Lib合约的状态变量someNumber发现值也是0，但是当我们查看HackMe中lib状态变量的值时，发现lib的值居然是 0x0000000000000000000000000000000000000070 （16进制70的值就是10进制的112）  
3. 想要进一步的学习delegatecall，可以参考脚本callTest.sol，也可以去网上搜索。

## 攻击成功的原因
当Attack调用attack()方法时，执行过程说明如下：  
1. 需要注意的是HackMe合约中的状态变量和Lib合约中的状态变量定义不相同  
2. 如果是HackMe合约调用doSomething()，最终改变的却是lib的值。Attack合约调用HackMe中的doSomething()，传入的是Attack合约的地址，所以最终HackMe合约的lib值变成了传入的参数，也就是Attack合约的地址。  
3. Attack合约中attack方法，第二次调用了doSomething(),其实调用的是Attack.doSomething() 然后改变了owner的值


## 注意   
学习此节内容之前，您需要了解solidity中状态变量在存储中的布局。

## 解决办法
后续再补充。