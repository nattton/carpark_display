import 'package:carpark_display/common/config/constant.dart';
import 'package:carpark_display/domain/model/last_gate.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: kHostUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/api/gate_logs/last")
  Future<LastGate> getLastGate();
}
