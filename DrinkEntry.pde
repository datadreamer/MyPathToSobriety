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
