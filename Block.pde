/**
 * A block contains transactions. Blocks are chained in a blockchain.
 */
class Block {
  int index;
  ArrayList<Transaction> transactions; // Can be a data field as well for secure data exchange
  java.util.Date timestamp;
  String previousHash;
  String hash;
  long nonce; // For the pow

  Block(int index, ArrayList<Transaction> transactions) {
    this.index = index;
    this.transactions = transactions;
    this.timestamp = new java.util.Date();
    this.hash = this.getBlockHash(); // TODO: Keep it in the constructor?
    this.nonce = 0;
  }
  
  void computeBlockHash(){
    String toDigest = this.timestamp.toString() + this.transactions + this.previousHash + this.nonce;
    this.hash = DigestUtils.sha256Hex((toDigest));
  }
  
  String getBlockHash() {
    String toDigest = this.timestamp.toString() + this.transactions + this.previousHash + this.nonce;
    return DigestUtils.sha256Hex((toDigest));
  }

  /**
   * Sends the reward to the address if it successfully mined the block
   */
  void mineBlock(int difficulty) {
    String targetHashStart = String.format("%0" + difficulty + "d", 0);
    do {
      this.hash = this.getBlockHash();
      this.nonce++;
    } while (!this.hash.startsWith(targetHashStart));
  }

  String toString() {
    StringBuilder sb = new StringBuilder(); 
    sb.append("\nBlock index: " + this.index);
    sb.append("\n\ttimestamp: " + this.timestamp.toString());
    sb.append("\n\tnumber of transactions: " + transactions.size());
    for (Transaction t : transactions) {
      sb.append("\n\t\ttransaction: " + t.toString());
    }
    sb.append("\n\tpreviousHash: " + this.previousHash); 
    sb.append("\n\thash: " + this.hash);  
    return sb.toString();
  }
}
