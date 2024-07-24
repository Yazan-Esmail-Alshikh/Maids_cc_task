import 'package:fluttertoast/fluttertoast.dart';
import 'package:maids_cc_task/presentation/resources/color_manger.dart';

showToast({
  required String title,
  bool isGreen = false,
}) {
  Fluttertoast.showToast(
    msg: title,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    webPosition: 'right',
    backgroundColor: isGreen ? ColorManger.primary : ColorManger.red,
    textColor: ColorManger.white,
    fontSize: 16.0,
  );
}
