
import 'package:get/get.dart';
import 'package:lawmax/global/global.dart';

class OrderController extends GetxController {
  // final ApiRepository _apiRepository = Get.find();
  final selectedDate = DateTime.now().obs;
  final selectedTime = "".obs;
  Util util = Util();

  createOrder(String lawyerId, String type) async {
    try {
      // final res = await _apiRepository.createOrder(
      //     selectedDate.value.millisecondsSinceEpoch, lawyerId, "60", type);
      // Get.to(() => AlertView(
      //     status: 'success',
      //     text:
      //         'Таны сонгосон хуульчтайгаа 2020/07/13-ны өдрийн 14:00 дуудлагаа хийнэ үү '));
      // print(res);
    } catch (e) {
      util.mainSnackbar(e.toString(), SnackbarType.error);
    }
  }

  
}
