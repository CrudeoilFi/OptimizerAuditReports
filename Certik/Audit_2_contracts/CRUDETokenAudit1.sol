pragma solidity ^0.6.12;
contract CrudeToken is ERC20,Ownable{
    constructor () public ERC20("CrudeToken", "CRUDE") {
        _mint(msg.sender, 30000 * (10 ** uint256(decimals())));
    }
        function mint(address _user, uint256 _amount) external onlyOwner{
        _mint(_user,_amount);
    }
    
    function burn(uint256 _amount) external{
        _burn(msg.sender,_amount);
    }
}