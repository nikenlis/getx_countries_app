import 'package:dio/dio.dart';

import '../models/country_model.dart';
import 'dio_client.dart';

class CountryService {
  final DioClient _client = DioClient();

  Future<List<CountryModel>> fetchCountries() async {
    try {
      final response = await _client.dio.get("/all?fields=name,capital,flags");

      return (response.data as List)
          .map<CountryModel>((json) => CountryModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.error.toString());
    }
  }
}
