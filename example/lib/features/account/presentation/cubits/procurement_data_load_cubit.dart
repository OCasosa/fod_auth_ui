import "package:fintech_on_demand_onboarding_flutter/features/general/business/entities/provisioning_entity.dart";
import "package:fintech_on_demand_onboarding_flutter/features/general/business/repositories/general_repository.dart";
import "package:fintech_on_demand_onboarding_flutter/features/general/business/use_cases/get_procurement_data_use_case.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:get_it/get_it.dart";

/// Cubit for loading procurement data.
class ProcurementDataLoadCubit extends GetInfoCubit<ProvisioningEntity> {
  @override
  Future<Either<Failure, ProvisioningEntity>> callUseCase() =>
      GetProcurementDataUseCase(
        repository: GetIt.I<GeneralRepository>(),
      ).call(
        params: const NoParams(),
      );
}
