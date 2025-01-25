import 'package:britam/core/di/beneficiary_di.dart';
import 'package:britam/core/di/britam_lob_di.dart';
import 'package:britam/core/di/core_repo_di.dart';
import 'package:britam/core/di/dashboard_di.dart';
import 'package:britam/core/di/general_di.dart';
import 'package:britam/core/di/holding_di.dart';
import 'package:britam/core/di/loan_application_di.dart';
import 'package:britam/core/di/make_contribution_di.dart';
import 'package:britam/core/di/milele_di.dart';
import 'package:britam/core/di/mmf_di.dart';
import 'package:britam/core/di/partial_withdrawal_di.dart';
import 'package:britam/core/di/payments_di.dart';
import 'package:britam/core/di/payouts_di.dart';
import 'package:britam/core/di/person_details_di.dart';
import 'package:britam/core/di/policy_di.dart';
import 'package:britam/core/di/products/mpesa_di.dart';
import 'package:britam/core/di/products/sr_di.dart';
import 'package:britam/core/di/raise_request_di.dart';
import 'package:britam/core/di/products/gi_di.dart';
import 'package:britam/core/di/products/investments_di.dart';
import 'package:britam/core/di/products/life_di.dart';
import 'package:britam/core/di/products/pension_di.dart';
import 'package:britam/core/di/request_callback_di.dart';
import 'package:britam/core/di/set_target_di.dart';
import 'package:britam/core/di/settings_di.dart';
import 'package:britam/core/di/soma_sure_di.dart';
import 'package:britam/core/di/sr_di.dart';
import 'package:britam/core/di/statement_di.dart';
import 'package:britam/core/di/story_view_di.dart';
import 'package:britam/core/di/supported_life_di.dart';
import 'package:britam/core/di/switch_funds_di.dart';
import 'package:britam/core/di/tax_di.dart';
import 'package:britam/core/di/top_up_di.dart';
import 'package:britam/core/di/transfer_funds_di.dart';
import 'package:britam/core/di/withdrawal_di.dart';
import 'package:get_it/get_it.dart';
import 'auto_debit_di.dart';
import 'britam_products_di.dart';
import 'card_di.dart';
import 'di_barrel.dart';
import 'product_detail_di.dart';
import 'hospital_di.dart';
import 'imarika_di.dart';
import 'onboarding_di.dart';

final locator = GetIt.instance;

Future<void> setUpLocator({String? myBaseUrl}) async {
  await invokeCoreDI(locator: locator);
  invokeOnboardingDI(locator: locator);
  invokeCoreRepoDI(locator: locator);
  invokeDashboardDI(locator: locator);
  invokeBeneficiaryDI(locator: locator);
  invokeTaxDI(locator: locator);
  invokePolicyDI(locator: locator);
  invokeSignUpDI(locator: locator);
  invokeLogInDI(locator: locator);
  invokeForgotPasswordDI(locator: locator);
  invokeOtpDI(locator: locator);
  invokeProfileDI(locator: locator);
  invokeStatementDI(locator: locator);
  invokeRequestCallbackDI(locator: locator);
  invokeBritamProductsDI(locator: locator);
  invokePartialWithdrawalDI(locator: locator);
  invokePayoutsDI(locator: locator);
  invokeLoanApplicationDI(locator: locator);
  invokeRaiseRequestDI(locator: locator);
  invokeTopUpDI(locator: locator);
  invokeWithdrawalDI(locator: locator);
  invokeSetTargetDI(locator: locator);
  invokeSwitchFundsDI(locator: locator);
  invokeTransferFundsDI(locator: locator);
  invokeMakeContributionDI(locator: locator);
  invokeAutoDebitDI(locator: locator);

  /// Products DI
  invokePensionDI(locator: locator);
  invokeLifeDI(locator: locator);
  invokeGiDI(locator: locator);
  invokeInvestmentsDI(locator: locator);
  invokeSRDI(locator: locator);
  invokeMpesaDI(locator: locator);

  /// MMF
  invokeMMFDI(locator: locator);

  invokeBritamLobDI(locator: locator);
  invokePersonalDetailsDI(locator: locator);
  invokeHoldingDetailsDI(locator: locator);
  invokeStoryViewDI(locator: locator);

  invokeCardDI(locator: locator);

  /// Settings
  await invokeSettingsDI(locator: locator);

  invokeImarikaDI(locator: locator);
  invokeMileleDI(locator: locator);
  invokeSupportedLIfeDI(locator: locator);
  invokeGeneralDI(locator: locator);
  invokeSomaSureDI(locator: locator);

  // global
  invokePaymentsDI(locator: locator);
  invokeSrDI(locator: locator);
  invokeHospitalDI(locator: locator);
  invokeProductDetailDI(locator: locator);
}
