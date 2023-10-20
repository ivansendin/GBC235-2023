// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/**
  @title sillyERC20

  This is a naive ERC20 implementation of ERC20 interface available at

  https://ethereum.org/en/developers/docs/standards/tokens/erc-20/

  (with  some modifications).


  Your task is to finish the work...many verifications  are missing.
*/

interface IERC20 {
  //function name() public view returns (string);
  //function symbol() public view returns (string);
  //function decimals() public view returns (uint8);
  function totalSupply() external view returns (uint256);
  function balanceOf(address _owner) external view returns (uint256 balance);
  function transfer(address _to, uint256 _value) external returns (bool success);
  function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
  function approve(address _spender, uint256 _value) external returns (bool success);
  function allowance(address _owner, address _spender) external view returns (uint256 remaining);
}


contract ERC20 is IERC20 {
    
    uint256 public tokenSupply;
    mapping(address => uint256) public balance;
    mapping(address => mapping(address => uint256)) public allowances;

    string public name;
    string public symbol;

    constructor (string memory tokenName, string memory tokenSymbol, uint256 initialSupply) public  {
      name=tokenName;
      symbol=tokenSymbol;
      tokenSupply = initialSupply;
      balance[msg.sender] = initialSupply;
    }

    function transfer(address recipient, uint256 amount) external  override returns (bool) {
        if (balance[msg.sender]<amount) {
          return false;
        }
        balance[msg.sender] -= amount;
        balance[recipient] += amount;

        return true;
    }

    function approve(address spender, uint amount) external  override returns (bool) {
        allowances[msg.sender][spender] = amount;

        return true;
    }

    function transferFrom(address sender,address recipient,uint amount) external  override returns (bool) {
        allowances[sender][msg.sender] -= amount;
        balance[sender] -= amount;
        balance[recipient] += amount;

        return true;
    }

    function totalSupply() external view  override  returns (uint256) {
      return tokenSupply;
    }

    function balanceOf(address account) external view  override  returns (uint256) {
      return balance[account];
    }

    function allowance(address owner, address spender) external view override returns (uint256) {
      return allowances[owner][spender];
    }

 
}
