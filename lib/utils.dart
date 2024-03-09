import 'package:oktoast/oktoast.dart';

class Utils {
  /// 显示 Toast 消息
  static toast(msg,
      {Duration duration,
      ToastPosition position = ToastPosition.bottom,
      bool dismissOtherToast}) {
    if (msg == null) return;
    showToast('$msg',
        position: position,
        duration: duration,
        dismissOtherToast: dismissOtherToast);
  }
}
