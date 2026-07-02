import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:easy_localization/easy_localization.dart";
import "package:fintech_on_demand_onboarding_flutter/features/fod_onboarding.dart";
import "package:fintech_on_demand_onboarding_flutter/features/shared/business/entities/onboarding_data_entity.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fod_auth_flutter/features/fod_features.dart";

import "../../../../core/constants/theme/app_separators.dart";
import "../../../core/routes/fod_auth_ui_router.gr.dart";
import "../../../fod_auth_ui.dart";
import "../../otp/presentation/forms/otp_form.dart";
import "../../shared/presentation/widgets/appbars/clean_appbar.dart";

part "../pages/communication_channel_verification_page.dart";
