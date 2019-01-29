// Tiny implementation of a basic blockchain with Processing
// Florent D.

Blockchain bc = new Blockchain();

void setup() {
  //fullScreen();
}


void draw() {
  // We claer the background for each block
  background(0);
  
  // A block is created at each call. We slow down the process for visualization.
  frameRate(0.5);

  // Create a set of 3 random transactions (for the sake of it);
  for (int j = 0; j < 3; j++) {
    bc.createTransaction(new Transaction(Participants.BOB, Participants.ALICE, 100));
  }
  
  // Mine block and increase difficulty
  bc.minePendingTransactions(Participants.BOB);
  bc.difficulty++;

  //Log blockchain
  println(bc.toString());
  
  if (frameCount == 3){
    noLoop();
  }
  
}
