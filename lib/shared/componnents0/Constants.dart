




import 'package:firebase1/bloc/Social_layout.dart';
import 'package:firebase1/shared/componnents0/components.dart';
import 'package:firebase1/shared/network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, Socail_layout());
    }
  });
}
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
dynamic uId=CacheHelper.getData(key: 'uid');