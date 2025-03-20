// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenizedEventPlanning {
    struct Event {
        uint256 id;
        string name;
        address payable organizer;
        uint256 totalFunds;
        mapping(address => uint256) contributions;
    }
    
    mapping(uint256 => Event) public events;
    uint256 public nextEventId;
    
    event EventCreated(uint256 id, string name, address organizer);
    event ContributionMade(uint256 eventId, address contributor, uint256 amount);

    function createEvent(string memory name) public {
        events[nextEventId].id = nextEventId;
        events[nextEventId].name = name;
        events[nextEventId].organizer = payable(msg.sender);
        events[nextEventId].totalFunds = 0;
        
        emit EventCreated(nextEventId, name, msg.sender);
        nextEventId++;
    }

    function contribute(uint256 eventId) public payable {
        require(msg.value > 0, "Contribution must be greater than zero");
        events[eventId].contributions[msg.sender] += msg.value;
        events[eventId].totalFunds += msg.value;
        
        emit ContributionMade(eventId, msg.sender, msg.value);
    }
}
