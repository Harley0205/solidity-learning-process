# solidity-欺诈攻击(拒绝服务攻击)

Wallet钱包合约可以存入ETH，但是只有拥有者可以提取，并且是提取到拥有者的地址。  
## 使用说明：  
1. 使用账户编译部署Wallet合约，需要注意的是部署Wallet合约前，需要设置VALUE为10 Ether，再部署。 查看Wallet合约，余额显示： Balance: 10 ETH
2. 使用和Wallet合约同一个账户部署Attack合约，并且需要使用Wallet合约地址部署Attack合约。  
3. 调用Attack.attack()，再次查看Wallet合约的余额，发现 Balance: 0 ETH。明明合约拥有者没有调用transfer(),可是合约中的余额哪去了？？  
4. 欺诈攻击，只是欺骗了合约拥有者才能执行的transfer()，但是余额并没有丢失，余额仍然转到了拥有者的账户中。


## 解决办法  
使用msg.sender替换tx.origin即可。