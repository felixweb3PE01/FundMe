// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
import {PriceConverter} from "./library.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


error NotOwner();


contract FundMe {

    uint256 public constant MINIMUMUSD = 5e18;

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;
    using PriceConverter for uint256;
    address public immutable i_owner;

    constructor()payable {
        i_owner= msg.sender;
    }


    function fund() public payable {
          require(msg.value.getConversionRate() >= MINIMUMUSD, "Not enough ETH");
          funders.push(msg.sender);
          addressToAmountFunded[msg.sender] += msg.value;
    }
        

    function WalletBalance() public view returns(uint256) {
        return address(this).balance;
    

    }
    
    function getversion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();

    }
     function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.
        latestRoundData();
        return uint256(price * 1e10) ;}

    function conversionToUsd() public view returns (uint256) {
    uint256 wBalance = WalletBalance(); // wei
    uint256 ethPrice = getPrice();      // 18 decimals

    // Multiply then divide to get USD amount in normal units (without extra 1e18)
    uint256 balanceInUsd = (wBalance * ethPrice) / 1e36; // divide by 1e18 (wei) * 1e18 (price)
    return balanceInUsd; // now returns approx 4 for 0.0025 ETH at $1900
}


    function withdraw() cond public{
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);


        // transfer
        // payable(msg.sender).transfer(address(this).balance);
        //send `
        // bool sendStatus= payable(msg.sender).send(address(this).balance);
        // require(sendStatus , "Send failed");
        // call 
        (bool callSuccess, ) =payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Send Failed");
    }

    modifier cond(){
        // require(msg.sender==i_owner, "Must be owner") ;
        
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }

    receive() external payable { 
        fund();
    }
    fallback() external payable {
        fund();
     }
    }