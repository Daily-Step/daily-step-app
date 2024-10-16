import '../../data/api/result/api_error.dart';

class CustomExceptions {
  final String message;

  CustomExceptions(this.message);

  factory CustomExceptions.apiError(ApiError apiError) {
    return CustomExceptions('API Error: ${apiError.message}');
  }

  factory CustomExceptions.genericError(String message) {
    return CustomExceptions('Error: $message');
  }

  @override
  String toString() {
    return message;
  }
}
