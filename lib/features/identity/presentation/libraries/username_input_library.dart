import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:fod_auth_flutter/features/identity/presentation/controllers/identity_controller.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:form_builder_validators/form_builder_validators.dart";

import "../../../../core/constants/theme/app_separators.dart";
import "../../../../core/routes/fod_auth_ui_router.gr.dart";
import "../../../shared/presentation/widgets/form_section.dart";
import "../../../shared/presentation/widgets/sign_in_background.dart";

part "../forms/user_login_input_form.dart";
part "../pages/username_input_page.dart";
