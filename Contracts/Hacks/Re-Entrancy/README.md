# solidity-重入攻击

Reentranct合约可以存入和提取ETH，此合约容易受到重入攻击。  
## 使用说明：  
1. 编译部署Reentranct合约（称为账户A）
2. 调用Reentranct合约的deposit()方法，需要设置Value=1 Ether存到合约，Reentranct合约Balance: 1 ETH，账户A减少1 Ether（此时操作的还是账户A）  
3. 编译Normal合约，用第一步Reentranct合约地址作为参数传入然后部署Normal合约（此步骤需要更换一个新的Account，称为账户B）  
4. 调用Normal合约的deposit()方法，模拟正常用户存入1 Ether，此时账户B的余额减少1 Ether，Reentranct合约Balance: 2 ETH（此步骤是用第三步的Account操作）  
5. 编译Attack合约，用第一步Reentranct合约地址作为参数传入然后部署Attack攻击合约（此步骤需要更换一个新的Account，称为账户C）  
6. 调用Attack合约的attack()方法，并传入1 Ether，结果发现Attack合约账户Balance: 3 ETH（包含第二、四步存入的1 Ether还有第六步存入的1 Ether）  
7. 切换账户B，调用Normal合约的withdraw()方法，发现无法提取第四步存取的1 Ether，因为该金额已经被Attack合约提走了。  

## 重入攻击成功的原因
当Attack调用attack()方法时，执行过程为：  
1. 先调用reentranct.deposit{value: 1 ether}() 存入了1 Ether  
2. 然后调用reentranct.withdraw() 取出余额
3. 但是Attack中有fallback()，当第二部结束后不会调用Reentranct合约中取钱的这一段代码：balances[msg.sender] = 0; 而是直接调用fallback()中的代码继续取钱，直到Reentranct合约中Ether不足再执行balances[msg.sender] = 0;

## 解决办法  
应对重入攻击的解决办法有很多种，这里只列举一种。详细代码参考ReEntrancyGuard.sol