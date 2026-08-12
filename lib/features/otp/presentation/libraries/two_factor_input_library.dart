import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:easy_localization/easy_localization.dart";
import "package:fintech_on_demand_onboarding_flutter/features/fod_onboarding.dart";
import "package:fintech_on_demand_onboarding_flutter/features/shared/business/entities/onboarding_data_entity.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fod_auth_flutter/features/biometrics/business/use_cases/get_biometric_prompt_flag.dart";
import "package:fod_auth_flutter/features/fod_features.dart";
import "package:get_it/get_it.dart";

import "../../../../core/constants/theme/app_separators.dart";
import "../../../../core/routes/fod_auth_ui_router.gr.dart";
import "../../../../fod_auth_ui.dart";
import "../../../biometrics/presentation/widgets/overlays/biometrics_register_bottomsheet.dart";
import "../../../communication/widgets/bottomsheets/communication_channel_select_bottom_sheet.dart";
import "../../../shared/presentation/widgets/appbars/clean_appbar.dart";
import "../forms/otp_form.dart";

part "../pages/two_factor_input_page.dart";
