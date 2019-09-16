
class SummaryInfo {
  double income;
  double expense;
  int incomeTotal;
  int expenseTotal;

  SummaryInfo({this.income,this.expense, this.incomeTotal, this.expenseTotal});
  factory SummaryInfo.fromJson(Map<String, dynamic> json) {
  return SummaryInfo(
      income: double.parse(json['income'].toString()),
      expense: double.parse(json['expense'].toString()),
      incomeTotal: int.parse(json['incomeTotal'].toString()),
      expenseTotal: int.parse(json['expenseTotal'].toString()),
  );
}


  

  
}