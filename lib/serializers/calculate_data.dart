class CalculateData {
  static const int TYPE_EXPRESSION = 0;
  static const  int TYPE_BREAK = 1;
  static const  int TYPE_RESULT = 2;

  String id;
  String name;
  String expression;
  int serial;
  int type;

  String groupId;


  CalculateData({
    this.id,
    this.name, 
    this.expression,
    this.serial,
    this.type,
    this.groupId,
    });
  factory CalculateData.fromJson(Map<String, dynamic> json) {
  return CalculateData(
      id: json['_id'] as String,
      name: json['name'] as String,
      expression: json['expression'] as String,
      serial: json['serial'],
      type: json['type'],
      groupId: json['groupId'] != null? json['groupId'] as String : '' ,
  );
  }

   toJson() {
    return {
      'id': id,
      'name': name,
      'expression': expression,
      'serial': serial,
      'type': type,
    };
  }
}