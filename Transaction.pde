/**
 * A particpant wires founds to another participant based on its address 
 */
class Transaction {
  Participants fromAddress;
  Participants toAddress;
  float amount;

  public Transaction(Participants fromAddress, Participants toAddress, float amount) {
    this.fromAddress = fromAddress;
    this.toAddress = toAddress;
    this.amount = amount;
  }

  public String toString() {
    return this.amount + " transfered from: " + this.fromAddress + " to: " + this.toAddress;
  }
}
