import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:easy_localization/easy_localization.dart";
import "package:fintech_on_demand_onboarding_flutter/features/general/business/entities/provisioning_entity.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fod_auth_flutter/features/auth/presentation/cubits/last_login_load_cubit.dart";
import "package:fod_auth_flutter/features/biometrics/business/use_cases/get_biometric_enrollment.dart";
import "package:fod_auth_ui/features/account/presentation/widgets/last_login_text.dart";
import "package:fod_auth_ui/features/biometrics/presentation/forms/register_biometrics_form.dart";
import "package:fod_auth_ui/features/biometrics/presentation/widgets/overlays/biometrics_register_bottomsheet.dart";
import "package:fod_auth_ui/fod_auth_ui.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get_it/get_it.dart";

import "../../../../core/constants/theme/app_separators.dart";
import "../../../../core/routes/app_router.gr.dart";
import "../../../shared/presentation/widgets/appbars/clean_appbar.dart";
import "../cubits/procurement_data_load_cubit.dart";
import "../widgets/account_circle_avatar.dart";

part "../pages/account_menu_page.dart";
part "../widgets/account_header_info.dart";
part "../widgets/account_list_tile.dart";
part "../widgets/account_switch_list_tile.dart";
