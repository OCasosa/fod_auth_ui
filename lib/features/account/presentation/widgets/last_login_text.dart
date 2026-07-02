import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/extensions/string_extension.dart";
import "package:flutter_common_classes/extensions/theme_extension.dart";
import "package:flutter_common_classes/widgets/cubit_widget_state_builder.dart";
import "package:fod_auth_flutter/features/auth/presentation/cubits/last_login_load_cubit.dart";

/// This widget displays the last login date and time of the user.
class LastLoginText extends StatelessWidget {
  /// This widget displays the last login date and time of the user.
  const LastLoginText({super.key});

  @override
  Widget build(BuildContext context) =>
      CubitWidgetStateBuilder<LastLoginLoadCubit, String>(
        onSuccess: (info) => Text(
          "${"loginRecent".tr().toCapitalized()}: $info",
          textAlign: TextAlign.center,
        ),
        onLoading: Text("${"loading".tr()}..."),
        onFailure: (failure) => Text(
          failure.message,
          style: TextStyle(
            color: context.colorScheme.error,
          ),
        ),
      );
}
