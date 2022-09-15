class CheckMasuk {
  String user;
  String pass;

  CheckMasuk({required this.user, required this.pass});

  Map<String, dynamic> toJson() {
    return {"user": user, "pass": pass};
  }
}

class FeedBackMasuk {
  String token;
  String message;
  String response;
  String type;
  FeedBackMasuk(
      {required this.token,
      required this.message,
      required this.response,
      required this.type});

  factory FeedBackMasuk.fromJson(Map<String, dynamic> item) {
    return FeedBackMasuk(
      token: item['token'],
      message: item['message'],
      type: item['type'],
      response: item['response'],
    );
  }
}

class ChangeUslT {
  String uslIdEx;
  String uslT;
  String uslThn;
  ChangeUslT({required this.uslIdEx, required this.uslT, required this.uslThn});
  Map<String, dynamic> toJson() {
    return {"usl_id_exjns": uslIdEx, "usl_t": uslT, "usl_thn": uslThn};
  }
}

class FeedBackUsl {
  String message;
  String response;
  String type;
  FeedBackUsl({
    required this.message,
    required this.response,
    required this.type,
  });

  factory FeedBackUsl.fromJson(Map<String, dynamic> item) {
    return FeedBackUsl(
      message: item['message'],
      type: item['type'],
      response: item['response'],
    );
  }
}
