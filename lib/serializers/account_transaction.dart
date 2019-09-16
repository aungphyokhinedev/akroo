
class AccountTransaction {
  String id;
  String title;
  int type;
  DateTime time;
  String cid;
  double amount;

  AccountTransaction({this.id,this.title,this.type, this.time, this.cid, this.amount});
  factory AccountTransaction.fromJson(Map<String, dynamic> json) {
  return AccountTransaction(
      id: json['_id'] as String,
      title: json['title'] as String,
      type: int.parse( json['type']),
      time:new DateTime.fromMillisecondsSinceEpoch(int.parse(json['time'])) ,
      cid: json['cid'] as String,
      amount: double.parse( json['amount']),
  );
}


  

  
}