
class TaskCategory {
  String id;
  String name;
  int color;
  int logo;
  bool isAdd;
  double dailyLimit;
  double monthlyLimit;


  TaskCategory({
    this.id,
    this.name, 
    this.color, 
    this.logo,  
    this.isAdd,
    this.dailyLimit,
    this.monthlyLimit
    });
  factory TaskCategory.fromJson(Map<String, dynamic> json) {
  return TaskCategory(
      id: json['_id'] as String,
      name: json['name'] as String,
      color: int.parse(json['color']),
      logo: int.parse(json['logo']),
      dailyLimit: json['daily_limit'] != null ? double.parse(json['daily_limit']): 0.0,
      monthlyLimit:json['monthly_limit'] != null ?  int.parse(json['monthly_limit']): 0.0,
      isAdd: false
  );
}


  

  
}