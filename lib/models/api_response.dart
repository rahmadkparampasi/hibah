import 'package:SimhegaM/models/hibah_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class APIResponseHibah<T> {
  T? data;
  bool error;
  String? errorMessage;
  int? status;
  APIResponseHibah({
    this.data,
    this.error = false,
    this.errorMessage,
    this.status = 500,
  });
}

class APIResponseMasuk<T> {
  T? data;
  bool error;
  String? errorMessage;
  int? status;
  DialogType dialog;
  APIResponseMasuk({
    this.data,
    this.errorMessage,
    this.error = false,
    this.status = 500,
    this.dialog = DialogType.SUCCES,
  });
}
