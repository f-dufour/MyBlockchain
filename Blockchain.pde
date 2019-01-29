/** //<>//
 * This is the proper chain of blocks.
 * <p>
 * Pending transations are mined and added within the next block of the chain.
 */
class Blockchain {
  ArrayList<Block> chain; 
  ArrayList<Transaction> pendingTransactions;
  int difficulty;
  float miningReward;

  Blockchain() {
    this.chain = new ArrayList<Block>();
    chain.add(createGenesisBlock()); // Initialize the chain with the very first block. True for all blockchains
    this.pendingTransactions = new ArrayList<Transaction>();
    this.difficulty = 1; // The number of 0s the magic number has to start with to prove the work
    this.miningReward = 50.0; // Arbitrary reward for the miner
  }

  /**
   * Generates the very first block of the blockchain. 
   */
  Block createGenesisBlock() {
    Block genesisBlock = new Block(1, new ArrayList<Transaction>());
    genesisBlock.previousHash = String.format("%0" + 64 + "d", 0);
    genesisBlock.computeBlockHash();
    return genesisBlock;
  }

  /**
   * Gives the last added block to the blockchain.
   */
  Block getLastBlock() {
    return this.chain.get(this.chain.size() - 1);
  }

  /**
   * Adds a block to the blockchain after computing proper hashes.
   * <p>
   * Still have to implement more checks before adding a block and set the number of transactions a block should contain.
   */
  void minePendingTransactions(Participants miningRewardAddress) {

    // Drop transactions inside a new block
    int newBlockIndex = this.chain.size() + 1;
    Block block = new Block(newBlockIndex, this.pendingTransactions); // Shouldn't add all the transaction. Should choose what transactions to include.

    // Mine according to difficulty
    block.mineBlock(this.difficulty);

    // Add block to chain, clear pendings and prepare miner's reward
    block.previousHash = getLastBlock().hash;
    this.chain.add(block);
    this.pendingTransactions = new ArrayList<Transaction>(); // Reset pending transactions (TODO: mind garbage collection)
    this.pendingTransactions.add(new Transaction(null, miningRewardAddress, this.miningReward)); // Prepare reward for the miner at the next round
  }

  /**
   * Adds a transaction to the pending transactions
   */
  void addPendingTransactions(ArrayList<Transaction> transactions) {
    this.pendingTransactions.addAll(transactions);
  }

  /**
   * Reads the transactions in the blockchain and returns the balance of a user
   */
  float getBalanceOfAddress(Participants address) {
    float balance = 0;
    for (Block b : this.chain) {
      for (Transaction t : b.transactions) {

        if (address.getName() == t.fromAddress.getName()) {
          balance -= t.amount;
        }

        if (address.getName() == t.toAddress.getName()) {
          balance += t.amount;
        }
      }
    }
    return balance;
  }

  /**
   * Verifies the integrity of the chain based on the hash values.
   */
  boolean isChainValid() {
    for (int i = 1; i < this.chain.size(); i++) { // Skip the first
      Block currentBlock = chain.get(i);
      Block previousBlock = chain.get(i - 1);

      // We verify that the hash written in each block is valid
      if (!currentBlock.hash.equals(currentBlock.getBlockHash())) {
        return false;
      }

      // Verify that each block points to the previous
      if (!currentBlock.previousHash.equals(previousBlock.hash)) {
        return false;
      }
    }
    return true;
  }

  String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("======== Chain length: " + this.chain.size() + " blocks ========\n");
    for (Block b : this.chain) {
      sb.append(b.toString());
    }
    return sb.toString();
  }
}
