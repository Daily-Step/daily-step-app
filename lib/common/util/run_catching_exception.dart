import '../../data/api/result/api_error.dart';
import '../../data/api/result/simple_result.dart';
import 'custom_exception.dart';

Future<SimpleResult<T, CustomExceptions>> runCatchingExceptions<T>(
    Future<T> Function() action) async {
  try {
    final result = await action();
    return SimpleResult.success(result);
  } catch (error) {
    CustomExceptions customException;

    if (error is ApiError) {
      customException = CustomExceptions.apiError(error);
    } else if (error is CustomExceptions) {
      customException = error; // 이미 CustomExceptions 타입인 경우
    } else {
      customException = CustomExceptions.genericError(error.toString());
    }
    return SimpleResult.failure(customException);
  }
}