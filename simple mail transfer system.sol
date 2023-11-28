// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SmartMailContract {
    address public owner;

    struct Mail {
        address sender;
        address receiver;
        uint256 mailId;
        bool transferred;
    }

    mapping(uint256 => Mail) public mails;

    event MailTransferred(address indexed sender, address indexed receiver, uint256 indexed mailId);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function transferMail(address _receiver, uint256 _mailId) public {
        require(!mails[_mailId].transferred, "Mail already transferred");
        require(msg.sender == mails[_mailId].sender, "Not the mail sender");

        mails[_mailId].receiver = _receiver;
        mails[_mailId].transferred = true;

        emit MailTransferred(msg.sender, _receiver, _mailId);
    }
}
