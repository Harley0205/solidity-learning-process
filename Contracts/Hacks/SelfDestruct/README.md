# solidity-自毁函数攻击

EtherGame合约可以存入和提取ETH，但是只有胜利者可以提取。  
## 使用说明：  
1. 编译部署EtherGame合约（称为账户A）
2. 调用EtherGame合约的deposit()方法，需要设置Value=1 Ether存到合约，EtherGame合约Balance: 1 ETH，账户A减少1 Ether，winner无胜者地址。（此时操作的还是账户A）  
3. 编译Normal合约，用第一步EtherGame合约地址作为参数传入然后部署Normal合约（此步骤需要更换一个新的Account，称为账户B）  
4. 调用Normal合约的deposit()方法，模拟正常用户存入1 Ether，此时账户B的余额减少1 Ether，EtherGame合约Balance: 2 ETH（此步骤是用第三步的Account操作）  
5. 编译Attack合约，用第一步EtherGame合约地址作为参数传入然后部署Attack攻击合约（此步骤需要更换一个新的Account，称为账户C）  
6. 调用Attack合约的attack()方法，并传入1 Wei，结果发现EtherGame合约账户Balance: 2.000000000000000001 ETH
7. 切换账户B，调用Normal合约的deposit()方法存入1 Ether，发现无法和第四步一样正常存入1 Ether,而且此时EtherGame合约也没有winner赢家。  
8. 最终导致EtherGame合约中的余额无法达到预期targetAmount的3 ether。正常账户无法再转入，也无法产生新的赢家取出余额并开始下一轮游戏。

## 自毁函数攻击成功的原因
当Attack调用attack()方法时，启动了自毁函数，强行将 1 Wei转账给了EtherGame合约，即便EtherGame合约没有fallback和receive函数。  

## 解决办法  
解决方案在SelfDestructGuard.sol