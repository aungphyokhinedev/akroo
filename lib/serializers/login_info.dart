
class LoginInfo {
  String name;
  String email;
  String photoUrl;
  String providerId;
  String provider;
  String photo;
  String id;

  LoginInfo({this.name,this.email,this.photoUrl,
  this.providerId,this.provider,this.photo,this.id, 
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
  return LoginInfo(
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
      providerId: json['providerId'] as String,
      provider: json['provider'] as String,
      photo: json['photo'] as String,
      id: json['_id'] as String,
  );
}


  

  
}