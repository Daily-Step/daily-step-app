import 'dart:async';

class SimpleResult<SuccessType, FailureType> {
  bool get isFailure => this is _Failure<SuccessType, FailureType>;
  bool get isSuccess => this is _Success<SuccessType, FailureType>;

  FailureType get failureData {
    if (isFailure) {
      final data = (this as _Failure<SuccessType, FailureType>).data;
      if (data == null) {
        throw DataNotExistException('Failure data not exist');
      }
      return data;
    }
    throw InvalidTypeException('This is not a Failure type');
  }

  SuccessType get successData {
    if (isSuccess) {
      final data = (this as _Success<SuccessType, FailureType>).data;
      if (data == null) {
        throw DataNotExistException('Success data not exist');
      }
      return data;
    }
    throw InvalidTypeException('This is not a Success type');
  }

  FailureType? get nullableFailureData => isFailure ? (this as _Failure<SuccessType, FailureType>).data : null;
  SuccessType? get nullableSuccessData => isSuccess ? (this as _Success<SuccessType, FailureType>).data : null;

  SimpleResult<SuccessType, FailureType> runIfSuccess(
      FutureOr<void> Function(SuccessType? data) function) {
    _runSuccess(function);
    return this;
  }

  SimpleResult<SuccessType, FailureType> runIfFailure(
      FutureOr<void> Function(FailureType? error) function) {
    _runFailure(function);
    return this;
  }

  Future<SimpleResult<SuccessType, FailureType>> runIfSuccessAsync(
      FutureOr<void> Function(SuccessType? data) function) async {
    await _runSuccess(function);
    return this;
  }

  Future<SimpleResult<SuccessType, FailureType>> runIfFailureAsync(
      FutureOr<void> Function(FailureType? error) function) async {
    await _runFailure(function);
    return this;
  }

  Future<void> _runSuccess(FutureOr<void> Function(SuccessType? data) function) async {
    if (isSuccess) {
      await function(nullableSuccessData);
    }
  }

  Future<void> _runFailure(FutureOr<void> Function(FailureType? error) function) async {
    if (isFailure) {
      await function(nullableFailureData);
    }
  }

  static _Failure<SuccessType, FailureType> failure<SuccessType, FailureType>(
      [FailureType? data]) {
    return _Failure<SuccessType, FailureType>(data);
  }

  static _Success<SuccessType, FailureType> success<SuccessType, FailureType>(
      [SuccessType? data]) {
    return _Success<SuccessType, FailureType>(data);
  }
}

class _Success<SuccessType, FailureType>
    extends SimpleResult<SuccessType, FailureType> {
  final SuccessType? data;
  _Success(this.data);
}

class _Failure<SuccessType, FailureType>
    extends SimpleResult<SuccessType, FailureType> {
  final FailureType? data;
  _Failure(this.data);
}

class DataNotExistException implements Exception {
  final String message;
  DataNotExistException(this.message);
}

class InvalidTypeException implements Exception {
  final String message;
  InvalidTypeException(this.message);
}
