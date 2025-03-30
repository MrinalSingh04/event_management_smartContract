// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract EventManagement {
    struct Event {
        address organizer;
        string name;
        uint date;
        uint price;
        uint capacity;
        uint ticketsSold;
        bool isCanceled;
    }
    
    mapping(uint => Event) public events;
    mapping(uint => mapping(address => uint)) public tickets;
    uint public eventCount;

    event EventCreated(uint eventId, string name, uint date, uint price, uint capacity);
    event TicketPurchased(uint eventId, address buyer, uint quantity);
    event EventCanceled(uint eventId);
    event FundsWithdrawn(uint eventId, address organizer, uint amount);
    event RefundClaimed(uint eventId, address attendee, uint amount);

    modifier eventExists(uint eventId) {
        require(events[eventId].date != 0, "Event does not exist");
        _;
    }

    modifier onlyOrganizer(uint eventId) {
        require(events[eventId].organizer == msg.sender, "Not the event organizer");
        _;
    }

    function createEvent(string memory name, uint date, uint price, uint capacity) external {
        require(date > block.timestamp, "Event date must be in the future");
        require(capacity > 0, "Capacity must be greater than zero");

        eventCount++;
        events[eventCount] = Event(msg.sender, name, date, price, capacity, 0, false);
        emit EventCreated(eventCount, name, date, price, capacity);
    }

    function buyTicket(uint eventId, uint quantity) external payable eventExists(eventId) {
        Event storage _event = events[eventId];
        require(!_event.isCanceled, "Event has been canceled");
        require(block.timestamp < _event.date, "Event has already happened");
        require(quantity > 0, "Must buy at least one ticket");
        require(msg.value == _event.price * quantity, "Incorrect ETH sent");
        require(_event.ticketsSold + quantity <= _event.capacity, "Not enough tickets available");

        tickets[eventId][msg.sender] += quantity;
        _event.ticketsSold += quantity;
        emit TicketPurchased(eventId, msg.sender, quantity);
    }

    function cancelEvent(uint eventId) external onlyOrganizer(eventId) eventExists(eventId) {
        Event storage _event = events[eventId];
        require(!_event.isCanceled, "Event already canceled");

        _event.isCanceled = true;
        emit EventCanceled(eventId);
    }

    function claimRefund(uint eventId) external eventExists(eventId) {
        Event storage _event = events[eventId];
        require(_event.isCanceled, "Event is not canceled");
        require(tickets[eventId][msg.sender] > 0, "No tickets purchased");

        uint refundAmount = tickets[eventId][msg.sender] * _event.price;
        tickets[eventId][msg.sender] = 0;
        payable(msg.sender).transfer(refundAmount);
        emit RefundClaimed(eventId, msg.sender, refundAmount);
    }

    function withdrawFunds(uint eventId) external onlyOrganizer(eventId) eventExists(eventId) {
        Event storage _event = events[eventId];
        require(!_event.isCanceled, "Cannot withdraw funds from a canceled event");
        require(block.timestamp > _event.date, "Event has not yet occurred");

        uint amount = _event.ticketsSold * _event.price;
        _event.ticketsSold = 0; 
        payable(msg.sender).transfer(amount);
        emit FundsWithdrawn(eventId, msg.sender, amount);
    }
}
