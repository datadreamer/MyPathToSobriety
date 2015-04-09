/**
MyPathToSobriety.pde by Aaron Siegel (datadreamer.com) (4/9/2015)<br/>
Based on the /r/dataisbeautiful post My Path to Sobriety by /u/ERAU<br/>
http://www.reddit.com/r/dataisbeautiful/comments/31zv8n/my_path_to_sobriety_oc/<br/>
<br/>
Loads in a cleaned up CSV version of OPs excel sheet and creates a minimalist chart.
**/

ArrayList<DrinkEntry> drinkEntries = new ArrayList<DrinkEntry>();
float xSpacing;
float ySpacing;
float margin = 20;
PFont tinyFont;
String[] monthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
color dailyColor = color(255, 150, 50);
color weeklyColor = color(255, 150, 50, 50);

void setup(){
  size(1600,750);
  frameRate(60);
  String[] lines = loadStrings("drinks.csv");
  boolean first = true;
  for(String line : lines){
    if(first){
      first = false;  // skip header line
    } else {
      drinkEntries.add(new DrinkEntry(line));
    }
  }
  xSpacing = (width - (margin * 2)) / drinkEntries.size();
  ySpacing = ((height - (margin * 2)) - 30) / 7;
  println(PFont.list());
  tinyFont = createFont("Arial", 8);
  labelFont = createFont("Arial", 12);
}

void draw(){
  background(255);
  textFont(labelFont);
  
  // draw measurement lines in background
  pushMatrix();
  translate(0,height-50);
  stroke(230);
  fill(0);
  float ypos = 0;
  textAlign(RIGHT);
  for(int i=0; i<8; i++){
    text(i*5, margin - 5, ypos + 3);
    noFill();
    beginShape();
    vertex(margin, int(ypos)-0.5);
    vertex(width - margin, int(ypos)-0.5);
    endShape();
    ypos -= ySpacing;
  }
  popMatrix();
  
  // connect callibrated weekly total
  float xpos = 0;
  beginShape();
  fill(weeklyColor);
  noStroke();
  vertex(margin, height-50);
  for(DrinkEntry de : drinkEntries){
    vertex(margin + xpos, (height-50) - ySpacing * de.weeklyTotal/5);
    xpos += xSpacing;
  }
  vertex(width-margin, height-50);
  endShape();
  
  textAlign(LEFT);
  textFont(tinyFont);
  float xpos = 0;
  for(DrinkEntry de : drinkEntries){
    
    pushMatrix();
    // highlight weekends
    translate(margin + xpos, height-50);
    if(de.weekend){
      noStroke();
      fill(230);
      rect(0, 0, xSpacing-1, 20);
    }
    
    // draw dates along the bottom
    pushMatrix();
    rotate(radians(90));
    fill(0);
    noSmooth();
    text(de.date.getDate(), 2, -1);
    popMatrix();
    if(de.date.getDate() == 1){
      textFont(labelFont);
      text(monthNames[de.date.getMonth()], 2, 35);
      textFont(tinyFont);
    }
    
    // draw daily totals
    fill(dailyColor);
    float barHeight = ySpacing * de.dailyTotal/5;
    rect(0, 0-barHeight, xSpacing-1, barHeight);
    //text(de.dailyTotal, 0, 0-barHeight);
    
    xpos += xSpacing;
    popMatrix();
  }
  
  // draw legend in upper right corner
  pushMatrix();
  textFont(labelFont);
  translate(width-margin-(ySpacing*2), margin);
  stroke(220);
  fill(255);
  rect(0, 0, ySpacing*2, 50);
  noStroke();
  fill(dailyColor);
  rect(10, 10, xSpacing, xSpacing);
  fill(weeklyColor);
  rect(10, 30, xSpacing, xSpacing);
  fill(0);
  text("Number of Drinks Per Day", 20 + xSpacing, 19);
  text("Running Weekly Average", 20 + xSpacing, 39);
  popMatrix();
  
  
}
class DrinkEntry{
  
  Date date;
  float wine, beer, shots, dailyTotal, weeklyTotal, oneWeek, twoWeeks, threeWeeks;
  String dateString;
  String day;
  boolean weekend = false;
  
  DrinkEntry(String data){
    String[] d = data.split(",");
    date = new Date(d[0]);
    String[] ds = date.toString().split(" ");
    dateString = ds[1] + " "+ ds[2];
    if(ds[0].equals("Sat") || ds[0].equals("Sun")){
      weekend = true;
    }
    
    wine = float(d[1]);
    beer = float(d[2]);
    shots = float(d[3]);
    dailyTotal = float(d[4]);
    weeklyTotal = float(d[5]);
    oneWeek = float(d[6]);
    twoWeeks = float(d[7]);
    threeWeeks = float(d[8]);
  }
}

