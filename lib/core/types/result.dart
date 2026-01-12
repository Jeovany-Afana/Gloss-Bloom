import 'package:gloss_bloom/core/error/failures.dart';

/// Represents the result of an operation that can either succeed or fail
sealed class Result<T> {
  const Result();
}

/// Represents a successful result containing data of type [T]
class Success<T> extends Result<T> {
  final T data;
  
  const Success(this.data);
}

/// Represents a failed result containing a [Failure]
class Error<T> extends Result<T> {
  final Failure failure;
  
  const Error(this.failure);
}

/// Extensions to make working with Result easier
extension ResultExtensions<T> on Result<T> {
  /// Returns true if the result is a success
  bool get isSuccess => this is Success<T>;
  
  /// Returns true if the result is an error
  bool get isError => this is Error<T>;
  
  /// Returns the data if success, null if error
  T? get dataOrNull => switch (this) {
    Success<T> success => success.data,
    Error<T> _ => null,
  };
  
  /// Returns the failure if error, null if success
  Failure? get failureOrNull => switch (this) {
    Success<T> _ => null,
    Error<T> error => error.failure,
  };
  
  /// Transforms the data if success, preserves error if error
  Result<R> map<R>(R Function(T data) transform) => switch (this) {
    Success<T> success => Success(transform(success.data)),
    Error<T> error => Error(error.failure),
  };
  
  /// Executes the appropriate callback based on result type
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) error,
  }) => switch (this) {
    Success<T> s => success(s.data),
    Error<T> e => error(e.failure),
  };
}