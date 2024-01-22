import 'package:bolid/core/failure.dart';

class FailureData extends Failure {
  final Object errorStr;

  FailureData({required this.errorStr});

  @override
  String toString() {
    return 'FailureData errorStr = ${errorStr.toString()}';
  }
}
