class BaseResponse<T> {
  bool isSuccess;
  String? message;
  T? data;

  BaseResponse({required this.isSuccess, this.message, this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json, {required T Function(dynamic) dataMapper}) {
    return BaseResponse(
      isSuccess: json['status'],
      message: json['message'],
      data: json.containsKey('data') ? dataMapper(json['data']) : null,
    );
  }

  factory BaseResponse.error(String errorMessage) {
    return BaseResponse(
      isSuccess: false,
      message: errorMessage,
    );
  }
}