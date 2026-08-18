import "dart:async";
import "dart:io";

import "package:auto_route/auto_route.dart";
import "package:easy_localization/easy_localization.dart";
import "package:fintech_on_demand_onboarding_flutter/features/fod_onboarding.dart";
import "package:fintech_on_demand_onboarding_flutter/features/shared/business/entities/onboarding_data_entity.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fod_auth_flutter/features/auth/business/entities/auth_password_page_info_entity.dart";
import "package:fod_auth_flutter/features/auth/data/models/params/login_params.dart";
import "package:fod_auth_flutter/features/auth/presentation/controllers/auth_controller.dart";
import "package:fod_auth_flutter/features/auth/presentation/cubits/auth_info_state_cubit.dart";
import "package:fod_auth_flutter/features/token/presentation/controllers/token_controller.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import "../../../../core/constants/theme/app_separators.dart";
import "../../../../fod_auth_ui.dart";
import "../../../shared/presentation/widgets/app_version_text.dart";
import "../../../shared/presentation/widgets/form_section.dart";
import "../../../shared/presentation/widgets/sign_in_background.dart";

part "../pages/biometric_input_page.dart";
