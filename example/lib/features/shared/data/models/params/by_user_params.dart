import "package:flutter_common_classes/constants/classes/params.dart";

/// Parameters to fetch an endpoint by user
class ByUserParams extends Params {
  /// Parameters to fetch an endpoint by user
  ByUserParams({
    required this.user,
  });

  /// User to retrieve the data
  final String user;

  @override
  Map<String, dynamic> queries() => {
        "username": user,
      };

  @override
  Map<String, dynamic> body() => {};
}
