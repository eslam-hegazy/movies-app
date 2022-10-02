import 'package:second_project/core/network/error_message_model.dart';

class ServerExceptions implements Exception {
  final ErrorMessageModel errorMessageModel;
  ServerExceptions({
    required this.errorMessageModel,
  });
}

class LocalDataBaseException implements Exception {
  final ErrorMessageModel errorMessageModel;
  LocalDataBaseException({
    required this.errorMessageModel,
  });
}
