
class Pagination {
  int total;
  int limit;
  int skip;

  Pagination({this.total,this.limit,this.skip});


  bool hasNext() {
    return this.total >= this.skip + this.limit;
  }
  void next(){
    this.skip = this.skip + this.limit;
  }

  factory Pagination.fromJson(Map<String, dynamic> json) {
  return Pagination(
      total: json['total'] as int,
      limit: json['limit'] as int,
      skip: json['skip'] as int,
  );
}


  

  
}