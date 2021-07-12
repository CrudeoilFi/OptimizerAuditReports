pragma solidity ^0.6.12;
interface Refinery {

function set(
        uint256 _pid,
        uint256 _allocPoint,
        bool _withUpdate
    ) external;

    function add(
        uint256 _allocPoint,
        address _want,
        address _strat,
        bool _withUpdate
    ) external;

function inCaseTokensGetStuck(address _token, uint256 _amount)external;
 function transferOwnership(address newOwner) external;
 function setMintRate(uint256 _CRUDEPerBlock) external;

}
contract Multisig{
/////////////////////////////////////////////////////////////////////////
    address public signer1 = 0xdF7E22e7d0DD75760C9F3a559F6e5c5e81F9A6F5;
    address public signer2 = 0xBe252C3805D782Dd4607d2bB6848c232a93cD6D6;
    address public signer3 = 0xA78dB5B852C9822d9096Afb4d7E1Aec2C34c6647;
    address public CRUDERefinery = 0xb3A635B85F5e34565eC239953ff61064B50674A8;
/////////////////////////////////////////////////////////////////////////
    mapping (address=>bool) public signMintRateVoted;
    mapping (address=>bool) public signAddPoolVoted;
    mapping (address=>bool) public signSetPoolVoted;
    mapping (address=>bool) public transferOwnershipVoted;
    mapping (address=>bool) public tokenStuckVoted;
    uint256 public signMintRateVote;
    uint256 public signAddPoolVote;
    uint256 public signSetPoolVote;
    uint256 public transferOwnershipVote;
    uint256 public tokenStuckVote;
/////////////////////////////////////////////////////////////////////////
    modifier onlySigner(){
        require(msg.sender==signer1 || msg.sender==signer2 || msg.sender==signer3,"Not Allowed");_;
    }
/////////////////////////////////////////////////////////////////////////
    function signChangeMintRate() external onlySigner {
        require(signMintRateVoted[msg.sender]==false,"Already voted");
        signMintRateVoted[msg.sender] = true;
        signMintRateVote+=1;
    }
     function signAddPool() external onlySigner {
        require(signAddPoolVoted[msg.sender]==false,"Already voted");
        signAddPoolVoted[msg.sender] = true;
        signAddPoolVote+=1;
    }

      function signSetPool() external onlySigner {
        require(signSetPoolVoted[msg.sender]==false,"Already voted");
        signSetPoolVoted[msg.sender] = true;
        signSetPoolVote+=1;
    }
        function signTokenStuck() external onlySigner {
        require(tokenStuckVoted[msg.sender]==false,"Already voted");
        tokenStuckVoted[msg.sender] = true;
        tokenStuckVote+=1;
    }
        function signTransferOwner() external onlySigner {
        require(transferOwnershipVoted[msg.sender]==false,"Already voted");
        transferOwnershipVoted[msg.sender] = true;
        transferOwnershipVote+=1;
    }
////////////////////////////////////////////////////////////////////////
    function changeMintRate(uint256 _CRUDEPerBlock) external onlySigner{
        require(signMintRateVote>1,"Not Enough Signs");
        Refinery(CRUDERefinery).setMintRate(_CRUDEPerBlock);
        signMintRateVoted[signer1] = false;
        signMintRateVoted[signer2] = false;
        signMintRateVoted[signer3] = false;
        signMintRateVote=0;
    }   
    function addPool(uint256 _allocPoint,address _want,address _strat,bool _withUpdate) external onlySigner{
        require(signAddPoolVote>1,"Not Enough Signs");
        Refinery(CRUDERefinery).add(_allocPoint, _want, _strat, _withUpdate);
        signAddPoolVoted[signer1] = false;
        signAddPoolVoted[signer2] = false;
        signAddPoolVoted[signer3] = false;
        signAddPoolVote=0;
    }  
    function setPool(uint256 _pid, uint256 _allocPoint,bool _withUpdate) external onlySigner{
        require(signSetPoolVote>1,"Not Enough Signs");
        Refinery(CRUDERefinery).set(_pid, _allocPoint, _withUpdate);
        signSetPoolVoted[signer1] = false;
        signSetPoolVoted[signer2] = false;
        signSetPoolVoted[signer3] = false;
        signSetPoolVote=0;
    }

    function getTokenStuck(address _token, uint256 _amount) external onlySigner{
        require(tokenStuckVote>1,"Not Enough Signs");
        Refinery(CRUDERefinery).inCaseTokensGetStuck(_token, _amount);
        tokenStuckVoted[signer1] = false;
        tokenStuckVoted[signer2] = false;
        tokenStuckVoted[signer3] = false;
        tokenStuckVote=0;
    }
    function transferOwner(address newOwner) external onlySigner{
        require(transferOwnershipVote>1,"Not Enough Signs");
        Refinery(CRUDERefinery).transferOwnership(newOwner);
        transferOwnershipVoted[signer1] = false;
        transferOwnershipVoted[signer2] = false;
        transferOwnershipVoted[signer3] = false;
        transferOwnershipVote=0;
    }
/////////////////////////////////////////////////////////////////////////

}