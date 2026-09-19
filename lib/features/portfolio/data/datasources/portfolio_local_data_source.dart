import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/error/exceptions.dart';
import '../models/portfolio_response_model.dart';

abstract class PortfolioLocalDataSource {
  Future<PortfolioResponseModel> getPortfolio();
}

/// Reads the portfolio response from the bundled local JSON file.
///
/// This is intentionally shaped like a data source so it can later be
/// replaced by a remote REST data source without changing the repository,
/// domain, or presentation layers.
class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  static const _assetPath = 'assets/mock_api/portfolio.json';

  @override
  Future<PortfolioResponseModel> getPortfolio() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      final jsonString = await rootBundle.loadString(_assetPath);
      final decoded = jsonDecode(jsonString);

      if (decoded is! Map<String, dynamic>) {
        throw const DataParsingException('Portfolio response is invalid.');
      }

      return PortfolioResponseModel.fromJson(decoded);
    } on AppException {
      rethrow;
    } on FormatException catch (error) {
      throw DataParsingException('Invalid portfolio JSON: ${error.message}');
    } on FlutterError catch (error) {
      throw LocalDataSourceException('Unable to read portfolio data: ${error.message}');
    }
  }
}
