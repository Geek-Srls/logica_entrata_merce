import 'package:logica_entrata_merce/helper/dialog_helper.dart';
import 'package:logica_entrata_merce/services/app_exceptions.dart';

class BaseController {
  void handleError(error) {
    hideLoading();
    if (error is BadRequestException) {
      //Show dialog
      var message = error.message;
      DialogHelper.showErrorDialog(description: message!);
    } else if (error is FetchDataException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message!);
    } else if (error is ApiNotRespondingException) {
      DialogHelper.showErrorDialog(
          description: 'Oops! It took longer to respond.');
    }
  }

  static showLoading([String? message]) {
    DialogHelper.showLoading(message);
  }

  static hideLoading() {
    DialogHelper.hideLoading();
  }
}
