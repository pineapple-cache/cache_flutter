String getTimeOfDay() {
  DateTime now = DateTime.now();
  int hour = now.hour;
  
 if (hour < 12) {
    return "아침";
  } else if (hour < 18) {
    return "점심";
  } else {
    return "저녁";
  }
}
