import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:fintech_on_demand_onboarding_flutter/features/fod_onboarding.dart";
import "package:fintech_on_demand_onboarding_flutter/features/shared/business/entities/onboarding_data_entity.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fod_auth_flutter/features/password/business/forms/recover_password_form_entity.dart";
import "package:fod_auth_flutter/features/password/presentation/controllers/password_controller.dart";
import "package:fod_auth_flutter/features/shared/business/forms/otp_form_entity.dart";
import "package:fod_auth_flutter/features/token/presentation/controllers/token_controller.dart";

import "../../../../core/constants/theme/app_separators.dart";

import "../../../../core/routes/fod_auth_ui_router.gr.dart";
import "../../../../fod_auth_ui.dart";
import "../../../shared/presentation/widgets/appbars/clean_appbar.dart";
import "../forms/password_recover_form.dart";

part "../pages/password_recover_page.dart";
