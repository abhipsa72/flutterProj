import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zel_app/common/loading.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/model/langauge.dart';

class LanguageSelectionProvider extends Loading {
  List<String> _languages = List();
  String selectedLanguage;

  setSelectedLanguage(String lang) {
    this.selectedLanguage = lang;
    getSelectedLanguage(lang);
  }

  final DataManagerRepository _repository;

  List<String> get languages => _languages;

  LanguageSelectionProvider(this._repository) {
    getLanguages();
  }

  Future getLanguages() async {
    try {
      final result = await _repository.languages();
      _languages = languageFromJson(result.data);
      notifyListeners();
    } on DioError catch (error) {
      print(error);
    }
  }

  void getSelectedLanguage(String lang) async {
    setLoading(true);
    try {
      final languages = await Hive.openBox(languagesBox);
      final result = await _repository.selectedLanguage(lang);
      final keysAndValues = selectedLanguageFromJson(result.data);
      keysAndValues.forEach((element) {
        languages.put(element.key, element.value);
      });
      setLoading(false);
    } on DioError catch (error) {
      debugPrint(error.toString());
      setLoading(false);
    }
  }
}
