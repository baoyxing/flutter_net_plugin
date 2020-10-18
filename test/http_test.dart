import 'package:net_plugin/data_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:net_plugin/http_manager.dart';
import 'package:simple_logger/simple_logger.dart';

void main(){
  test("测试网络请求",()async{
    final logger = SimpleLogger();
    logger.setLevel(
        Level.INFO,
      includeCallerInfo: true
    );
    var temParams = DataHelper.getBaseMap();
    temParams["mobile"] = "18675866967";
    temParams["sendType"] = "1";
    await HttpManager.getInstance('http://127.0.0.1:4001/').postHttp(
     "v1/sendCode",
     signKey:"sznc_zhl_2020",
     parameters: temParams,
     onSuccess: (data) {
       logger.info("成功");
     },
     onError:(error) {
       logger.info("失败");
     }
   );
  });
}