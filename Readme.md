# Introduction

This is a tiny implementation of a blockchain. It randomly generates transactions between virtual participants and draws a visual representation of the blockchain. It is written in Java using the [Processing](https://processing.org/) environment. 


In this implementation, the proof of work is the magic number to be computed for each block. It goes increasing by one 0 one block at the time.

# Depedencies

Dependencies have to be saved within the `code` directory with the sketch.

* **For SHA 256 Hashing**: commons-codec-1.11.jar. (Although it could have been possible to use `java.security.MessageDigest.getInstance("SHA-256")`, the Apache library is more convenient to use and better handle streams conversions.
* **For the public/private key generation**: *Not implemented yet...*

# Run and visualize

1. Clone the repository
1. Make sure the sketch contains the  dependency:`./code/commons-codec-1.11.jar` 
1. Open the project in processing and run or launch it via the command line `processing-java --run --sketch=MyBlockchain`
1. The sketch will be drawn on a new window, fullscreen.

# Graphical acceleration

It is possible to consider running the algorithms on the graphical card using the P2D renderer. However, differences in performances have not been assessed already. 

# Work in progress and issues to address

**Related to the blockchain**:

- [ ] Current immplementation does not check for balance of a participant before accepting a transaction
- [ ] Current implementation permits to easily add  a transaction within a block
- [ ] Current implementation does not suport P2P
- [ ] Current implementation does not make use of public/private key for participants
- [ ] The genesis block is never mined. Is that normal?

**Related to the code**:

- [ ] Consider adding public/private keywords for the variables and method fields (is not a concern with processing's pre-processor)
- [ ] Consider implementing try-catching
- [ ] Consider adding unitary tests
