import 'package:equatable/equatable.dart';

/// Domain-facing representation of an operation failure.
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class DataFailure extends Failure {
  const DataFailure(super.message);
}
