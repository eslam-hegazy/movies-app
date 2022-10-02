class ErrorMessageModel {
  final int status_code;
  final String status_message;
  final bool success;
  ErrorMessageModel({
    required this.status_code,
    required this.status_message,
    required this.success,
  });
  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) =>
      ErrorMessageModel(
        status_code: json['status_code'],
        status_message: json['status_message'],
        success: json['success'],
      );
}
