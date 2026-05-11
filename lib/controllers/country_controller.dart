import 'package:get/get.dart';

import '../models/country_model.dart';
import '../services/country_service.dart';

class CountryController extends GetxController
    with StateMixin<List<CountryModel>> {
  final CountryService _service = CountryService();

  @override
  void onInit() {
    super.onInit();

    fetchCountries();
  }

  Future<void> fetchCountries() async {
    change([], status: RxStatus.loading());

    try {
      final countries = await _service.fetchCountries();

      change(countries, status: RxStatus.success());
    } catch (e) {
      final message = e.toString().replaceFirst("Exception: ", "");

      change([], status: RxStatus.error(message));
    }
  }
}
