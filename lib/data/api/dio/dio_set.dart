import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
final dioSet = Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL']!));