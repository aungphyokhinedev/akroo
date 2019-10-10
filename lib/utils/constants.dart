class Constants {
  static final String baseUrl =
  // "http://192.168.100.4:3030";
   'https://li1765-242.members.linode.com/akroo';

  static String newsUrl(int newsId) {
    return 'https://hacker-news.firebaseio.com/v0/item/$newsId.json';
  }

  static  final int defaultFiltertype = 1;

  static final int timestampOptionDay = 0;
  static final int timestampOptionMonth = 1;
  static final int timestampOptionYear = 2;

  static final int transactionExpense = 0;
  static final int transactionIncome = 1;

}