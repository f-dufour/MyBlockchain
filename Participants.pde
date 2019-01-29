/**
 * Those are the virtual participants taking place in the currency exchange
 * <p>
 * PArticpants should be identifies with their public key.
 */
enum Participants {
  ROBIN("Rob"), 
    ALICE("Alice"), 
    MINER("Miner");

  private final String name;

  private Participants(String name) {
    this.name = name;
  }

  public String getName() {
    return this.name;
  }

  public String toString() {
    return this.name();
  }
}
