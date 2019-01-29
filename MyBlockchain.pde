// Tiny implementation of a basic blockchain with Processing.
// Florent D.
// 29 January 2019

Blockchain bc = new Blockchain();

void setup() {
  //fullScreen();
}


void draw() {
  // We clear the background for each block
  background(0);

  // A block is created at each call. We slow down the process for visualization.
  frameRate(0.5);

  // Create a set ofrandom transactions: we assume that each block contains 6 transactions.
  bc.addPendingTransactions(generateRandomTransactions(5));

  // Mine block and increase difficulty
  bc.minePendingTransactions(Participants.BOB);
  bc.difficulty++;

  //Log blockchain
  println(bc.toString());

  if (frameCount == 2) {
    noLoop();
  }
}

ArrayList<Transaction> generateRandomTransactions(int numberOfTransactions) {
  ArrayList<Transaction> randomTransactions = new ArrayList<Transaction>();
  Participants fromAddress;
  Participants toAddress;
  for (int i = 0; i < numberOfTransactions; i++) {
    float amount = random(10, 300);
    float probability = random(1);
    if (probability < 0.5) {
      fromAddress = Participants.BOB;
      toAddress = Participants.ALICE;
    } else {
      fromAddress = Participants.ALICE;
      toAddress = Participants.BOB;
    }
    randomTransactions.add(new Transaction(fromAddress, toAddress, amount));
  }
  return randomTransactions;
}
