import 'app_constants.dart';

extension NotNullableString on String? {
  String orEmpty() {
    if (this == null) {
      return AppConstants.emptyStr;
    } else {
      return this!;
    }
  }
}

extension NotNullableInt on int? {
  int orEmpty() {
    if (this == null) {
      return AppConstants.zero;
    } else {
      return this!;
    }
  }
}
