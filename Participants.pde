// Consider adding public/private keys components
// This is a Processinf floavoured enum
enum Participants {
  BOB("Bob"), 
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
