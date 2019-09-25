
class CalendarData {

  String date;
  String weekday;
  String year;
  String sabbath;
  String yatyaza;
  String pyathada;
  String nagahle;
  String mahabote;
  String astro;
  String astro2;
  String chronicle;
String holidays;
String holidays2;
  CalendarData({
    this.date,
    this.weekday,
    this.year, 
    this.sabbath, 
    this.yatyaza, 
    this.pyathada,
    this.nagahle,
    this.mahabote,
    this.astro,
    this.astro2,
    this.chronicle,
    this.holidays,
    this.holidays2,
    });
  factory CalendarData.fromJson(Map<String, dynamic> json) {
  return CalendarData(
      date: json['date'] as String,
      weekday: json['weekday'] as String,
      year: json['year'] as String,
      sabbath: json['sabbath'] as String,
      yatyaza: json['yatyaza'] as String,
      pyathada: json['pyathada'] as String,
      nagahle: json['nagahle'] as String,
      mahabote: json['mahabote'] as String,
      astro: json['astro'] as String,
      astro2: json['astro2'] as String,
      chronicle: json['chronicle'] as String,
      holidays:json['holidays'] as String,
      holidays2:json['holidays2'] as String,
  );
}


  

  
}