
// /https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=0cd8809a19f743849546d5ce34110c3a



//https://newsapi.org/v2/everything?q=tesla&from=2021-10-29&sortBy=publishedAt&apiKey=0cd8809a19f743849546d5ce34110c3a


import 'package:social_app/modules/social-app/social_login/social_login_screen.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import 'components.dart';

void signOut(context){
  CacheHelper.removeData(key: 'uId')!.then((value){
    if(value){
      navigateAndFinish(context, SocialLoginScreen());
    }
  }
  );
  print(uId);

}

void printFullText(String text)
{
  final pattern =RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

String? uId='';