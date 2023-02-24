// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";



contract randomGenarator is VRFConsumerBaseV2 {
    event requestSent(uint256 requestId, uint32 numWords);
    event requestFulfilled(uint256 requestId, uint256[] randomWords);


    //uint256[] randomWords;
    address admin;

    VRFCoordinatorV2Interface coordinator;

    LinkTokenInterface Token;

    address token_contract = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
    
    uint64 subId;

    uint public lastRequestId;

    uint32 gasLimit = 100000;

    uint256[] public requestIds;

    bytes32 keyHash;

    uint16 requestConfirm = 3;

    uint32 numWords = 2;

    uint256[] public randomResult;

    uint price = 150 gwei;
    

    constructor() VRFConsumerBaseV2(0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D)
        //ConfirmedOwner(msg.sender)
    {
        Token = LinkTokenInterface(token_contract);
        subId = 10103;
        coordinator = VRFCoordinatorV2Interface(0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D);
        keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15;
        admin = msg.sender;
    }

///@dev func. to send request for random values to chainlink VRF ///// Will revert if subscription is not set and funded.
     function requestRandomWords()external returns (uint256 requestId){
        require(
            Token.balanceOf(address(this)) > price,
            "Insufficient Links"
        );
        requestId = coordinator.requestRandomWords(keyHash, subId, requestConfirm, gasLimit, numWords);
        requestIds.push(requestId);
        lastRequestId = requestId;
        emit requestSent(requestId, numWords);
        return requestId;
    }

///@dev Chainlink VRF fulfills the request and returns the random values in a callback 
    function fulfillRandomWords(uint256 _requestId, uint256[] memory _randomWords) internal override {
        randomResult = _randomWords;
        emit requestFulfilled(_requestId, _randomWords);
    }


    function withdraw(uint256 amount, address to) external {
         Token.transfer(to, amount);
    }


    
}







































































