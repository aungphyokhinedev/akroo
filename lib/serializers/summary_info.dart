
class SummaryInfo {
  double income;
  double expense;
  int incomeTotal;
  int expenseTotal;
  String catId;

  SummaryInfo({this.income,this.expense, this.incomeTotal, this.expenseTotal, this.catId});
  factory SummaryInfo.fromJson(Map<String, dynamic> json) {
  return SummaryInfo(
      income: double.parse(json['income'].toString()),
      expense: double.parse(json['expense'].toString()),
      incomeTotal: int.parse(json['incomeTotal'].toString()),
      expenseTotal: int.parse(json['expenseTotal'].toString()),
      catId: json['catId'].toString(),
  );
}


  

  
}