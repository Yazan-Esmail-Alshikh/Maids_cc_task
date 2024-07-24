import 'package:maids_cc_task/presentation/resources/string_manger.dart';

String? emptyValid(String? value) {
  if (value == null || value.isEmpty) {
    return AppStrings.thisFiledIsRequired;
  }
  return null;
}
