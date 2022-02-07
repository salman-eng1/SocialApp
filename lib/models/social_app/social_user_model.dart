class SocialUserModel
{
   String? name;
   String? email;
   String? phone;
   String? uId;
   String? image;
   String? cover;
   String? bio;
   late bool isEmailVerified;

   SocialUserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
     required this.isEmailVerified,
     required this.image,
     required this.cover,
     required this.bio,

   });
  SocialUserModel.fromJson(Map<String,dynamic>? json)
  {
    email=json!['email'];
    name=json['name'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    isEmailVerified=json['isEmailVerified'];
  }
  Map<String,dynamic> toMap()
  {
    return {
      'name': name,
      'email':email,
      'phone': phone,
      'uId':uId,
      'image':image,
      'bio': bio,
      'cover':cover,
      'isEmailVerified':isEmailVerified,

    };
  }
}