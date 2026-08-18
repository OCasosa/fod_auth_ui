import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:easy_localization/easy_localization.dart";
import "package:fintech_on_demand_onboarding_flutter/features/fod_onboarding.dart";
import "package:fintech_on_demand_onboarding_flutter/features/shared/business/entities/onboarding_data_entity.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:fod_auth_flutter/features/fod_features.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import "../../../../core/constants/theme/app_separators.dart";
import "../../../../fod_auth_ui.dart";
import "../../../shared/presentation/widgets/app_version_text.dart";
import "../../../shared/presentation/widgets/form_section.dart";
import "../../../shared/presentation/widgets/sign_in_background.dart";

part "../forms/password_login_input_form.dart";
part "../pages/password_input_page.dart";
