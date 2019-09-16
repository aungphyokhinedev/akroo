
class AccountCategory {
  String id;
  String name;
  int color;
  int logo;
  bool isAdd;
  double dailyLimit;
  double monthlyLimit;


  AccountCategory({
    this.id,
    this.name, 
    this.color, 
    this.logo,  
    this.isAdd,
    this.dailyLimit,
    this.monthlyLimit
    });
  factory AccountCategory.fromJson(Map<String, dynamic> json) {
  return AccountCategory(
      id: json['_id'] as String,
      name: json['name'] as String,
      color: int.parse(json['color']),
      logo: int.parse(json['logo']),
      dailyLimit: json['daily_limit'] != null ? double.parse(json['daily_limit']): 0.0,
      monthlyLimit:json['monthly_limit'] != null ?  double.parse(json['monthly_limit']): 0.0,
      isAdd: false
  );
}


  

  
}