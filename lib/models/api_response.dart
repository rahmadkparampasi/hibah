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

class APIResponseOrganisasi<T> {
  T? data;
  bool error;
  String? errorMessage;
  int? status;
  APIResponseOrganisasi({
    this.data,
    this.error = false,
    this.errorMessage,
    this.status = 500,
  });
}

class APIResponsePengOrganisasi<T> {
  T? data;
  bool error;
  String? errorMessage;
  int? status;
  APIResponsePengOrganisasi({
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

class APIResponse<T> {
  T? data;
  bool error;
  String? errorMessage;
  int? status;
  DialogType dialog;
  APIResponse({
    this.data,
    this.errorMessage,
    this.error = false,
    this.status = 500,
    this.dialog = DialogType.SUCCES,
  });
}
