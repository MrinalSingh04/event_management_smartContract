# 🎟️ Event Management Smart Contract 🚀

## 📌 Introduction

This project is a **decentralized event management system** built using Solidity. It allows event organizers to create events, sell tickets, and manage attendees in a transparent and secure way using blockchain technology.

## ❓ Why This Project?

Traditional event management platforms often suffer from issues such as:

- ❌ **High fees** imposed by third-party platforms.
- 🎭 **Scalping and fraud** where tickets are resold at unfair prices.
- 🏢 **Centralized control**, leading to lack of transparency.

By using a **smart contract**, we eliminate intermediaries, ensuring that ticket sales, refunds, and event management are handled **securely, transparently, and efficiently** on the Ethereum blockchain.

## ⭐ Features

### 1. 🎫 **Event Creation**

- Organizers can create events by providing details such as **event name, date, ticket price, and capacity**.
- Each event is assigned a **unique ID**.

### 2. 🛒 **Ticket Purchase**

- Users can **buy tickets** by sending ETH equivalent to the ticket price.
- The smart contract ensures **correct pricing** and **availability of tickets**.

### 3. 📋 **Attendee Management**

- The contract keeps track of **who has purchased tickets**.

### 4. 💰 **Funds Withdrawal**

- After the event, the organizer can **withdraw funds** collected from ticket sales.

### 5. ❌ **Event Cancellation & Refunds**

- The event organizer can **cancel an event**.
- If canceled, ticket holders can be refunded (future enhancement).

## 🛠️ Smart Contract Breakdown

### 1. **Data Structures**

- `Event`: Stores event details (organizer, name, date, price, capacity, tickets sold).
- `events`: A mapping that stores all created events.
- `tickets`: A nested mapping that tracks ticket purchases by attendees.

### 2. **Key Functions**

#### 📌 `createEvent(name, date, price, capacity)`

Creates a new event with specified details.

#### 🎟️ `buyTicket(eventId, quantity)`

Allows users to purchase tickets by sending ETH.

#### 💸 `withdrawFunds(eventId)`

Allows the organizer to withdraw earnings after the event.

#### ❌ `cancelEvent(eventId)`

Allows the organizer to cancel an event.

## 🚀 How to Deploy

1. **Set up Remix IDE**

   - Go to [Remix](https://remix.ethereum.org/).
   - Create a new Solidity file and paste the contract code.

2. **Compile & Deploy**

   - Select a Solidity compiler (0.8.x recommended).
   - Deploy using Injected Web3 (MetaMask) or Remix VM.

3. **Interact with the Contract**
   - Use `createEvent` to register an event.
   - Use `buyTicket` to purchase tickets.
   - Use `withdrawFunds` after the event date.

## 🏁 Conclusion

This smart contract provides a **decentralized, secure, and fair** way to manage events and ticketing, reducing fraud and eliminating intermediaries. 🎟️🚀

## 📜 License

This project is licensed under the **MIT License**. Feel free to use, modify, and distribute it for your needs!

---


