// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleEscrow {
    address public buyer;
    address public seller;
    address public arbiter;
    uint256 public funds;

    constructor(address _seller, address _arbiter) {
        buyer = msg.sender;
        seller = _seller;
        arbiter = _arbiter;
    }

    function depositFunds() public payable {
        require(msg.sender == buyer, "Only the buyer can deposit funds");
        funds += msg.value;
    }

    function releaseFundsToSeller() public {
        require(msg.sender == arbiter, "Only the arbiter can release funds");
        seller.transfer(funds);
        funds = 0;
    }

    function refundBuyer() public {
        require(msg.sender == arbiter, "Only the arbiter can refund the buyer");
        buyer.transfer(funds);
        funds = 0;
    }
}

