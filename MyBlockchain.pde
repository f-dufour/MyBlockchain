// Tiny implementation of a basic blockchain with Processing.
// Florent D.
// 29 January 2019

Blockchain bc = new Blockchain();
PFont font;

void setup() {
  size(1050, 600);
  background(0);
  font = createFont("Courier", 12);
  textFont(font);
  textAlign(CENTER, CENTER);
}


void draw() {

  // A block is created at each call. We slow down the process for visualization.
  frameRate(0.5);

  // Create a set ofrandom transactions: we assume that each block contains 6 transactions.
  bc.addPendingTransactions(generateRandomTransactions(5));

  // Mine block and increase difficulty
  bc.minePendingTransactions(Participants.MINER);
  bc.difficulty++;

  // Draw the visual representation of the bc on the screen
  drawBlockchain();
  saveFrame("./out/###.tif");

  //Log blockchain
  println(bc.toString());

}

ArrayList<Transaction> generateRandomTransactions(int numberOfTransactions) {
  ArrayList<Transaction> randomTransactions = new ArrayList<Transaction>();
  Participants fromAddress;
  Participants toAddress;
  for (int i = 0; i < numberOfTransactions; i++) {
    float amount = floor(random(100, 300));
    float probability = random(1);
    if (probability < 0.5) {
      fromAddress = Participants.ROBIN;
      toAddress = Participants.ALICE;
    } else {
      fromAddress = Participants.ALICE;
      toAddress = Participants.ROBIN;
    }
    randomTransactions.add(new Transaction(fromAddress, toAddress, amount));
  }
  return randomTransactions;
}

void drawBlockchain() {
  // Init canvas and variables
  strokeWeight(2);
  stroke(255);
  line(0, height/2, width, height/2);
  int numberOfBlocks = bc.chain.size();
  final int blockWidth = 200;
  final int blockHeight = 500;
  final int blockGap = 50;

  // Draw each block
  for (int i = 0; i < numberOfBlocks; i++) {
    Block currentBlock = bc.chain.get(i);
    pushMatrix();

    // Draw the outter box
    translate((i+1) * blockGap + i * blockWidth, blockGap);
    text(currentBlock.index, 0, -13);
    fill(0);
    rect(0, 0, blockWidth, blockHeight);
    fill(255);

    // Showh hashes
    text(currentBlock.previousHash.substring(0, 22) + "...", blockWidth/2, 13);
    text(currentBlock.hash.substring(0, 22) + "...", blockWidth/2, blockHeight-13);

    // Show timestamp
    text("Timestamp:\n" + currentBlock.timestamp, 10, 0, blockWidth-10, blockHeight/2);    

    // Show transactions
    StringBuilder sb = new StringBuilder();
    sb.append(currentBlock.transactions.size() + " transactions:\n");
    for (Transaction t : currentBlock.transactions) {
      sb.append(t.toString() + "\n");
    }
    text(sb.toString(), 10, blockHeight/2, blockWidth-10, blockHeight/2);  // Text wraps within text box
    popMatrix();
  }
}
