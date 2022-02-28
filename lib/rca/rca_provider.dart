import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/rca/Region/region_model.dart';
import 'package:zel_app/rca/Section/section_model.dart';
import 'package:zel_app/rca/SubCategory/subCategory_model.dart';
import 'package:zel_app/rca/category/category_model.dart';
import 'package:zel_app/rca/m.dart';
import 'package:zel_app/rca/products/rca_bar_model.dart';
import 'package:zel_app/rca/products/remark_model.dart';
import 'package:zel_app/rca/store/store_model.dart';

import 'Department/department_model.dart';

class RCAProvider extends ChangeNotifier {
  final _storeListController = BehaviorSubject<List<Store>>();
  final _storeController = BehaviorSubject<Store>();
  final _regionListController = BehaviorSubject<List<Region>>();
  final _loadingController = BehaviorSubject<bool>();
  final _regionController = BehaviorSubject<Region>();
  final _deptListController = BehaviorSubject<List<Dept>>();
  final _deptController = BehaviorSubject<Dept>();
  final _sectionListController = BehaviorSubject<List<Section>>();
  final _sectionController = BehaviorSubject<Section>();
  final _categoryListController = BehaviorSubject<List<Category>>();
  final _categoryController = BehaviorSubject<Category>();
  final _subcategoryListController = BehaviorSubject<List<Subcategory>>();
  final _subcategoryController = BehaviorSubject<Subcategory>();
  final _remarkListController = BehaviorSubject<List<Product>>();
  final _remarkController = BehaviorSubject<Product>();
  final _barProductController = BehaviorSubject<List<Result>>();
  String errorMessage = "";

  String _authToken;
  String _selectedRegion;
  String _selectedStore;
  final DataManagerRepository _repository;

  List<Map> getAll() => _nigeria;

  getLocalByState(String state) => _nigeria
      .map((map) => StateModel.fromJson(map))
      .where((item) => item.state == state)
      .map((item) => item.lgas)
      .expand((i) => i)
      .toList();

  List<String> getStates() => _nigeria
      .map((map) => StateModel.fromJson(map))
      .map((item) => item.state)
      .toList();

  List _nigeria = [
    {
      "state": "Adamawa",
      "alias": "adamawa",
      "lgas": [
        "Demsa",
        "Ganye",
        "Gayuk",
      ]
    },
    {
      "state": "Akwa Ibom",
      "alias": "akwa_ibom",
      "lgas": [
        "Abak",
        "Eastern Obolo",
        "Eket",
      ]
    }
  ];

  RCAProvider(this._repository);

  String get selectedStore => _selectedStore;

  String get selectedRegion => _selectedRegion;

  set setStore(Store store) {
    this.storeSink.add(store);
  }

  set setRegion(Region rg) {
    this.regionSink.add(rg);
  }

  set setDept(Dept dept) {
    this.deptSink.add(dept);
  }

  set setSection(Section sec) {
    this.secSink.add(sec);
  }

  set setCategory(Category category) {
    this.categorySink.add(category);
  }

  set setSubCategory(Subcategory subcategory) {
    this.subcategorySink.add(subcategory);
  }

  setAuthTokenAndCompanyId(String token) {
    _authToken = token;
    getRegion();
  }

  //

  Stream<bool> get isLoadingStream => _loadingController.stream;

  StreamSink<bool> get isLoadingSink => _loadingController.sink;
  Stream<List<Region>> get regionListStream => _regionListController.stream;

  StreamSink<List<Region>> get regionListSink => _regionListController.sink;

  Stream<List<Store>> get storeListStream => _storeListController.stream;

  StreamSink<List<Store>> get storeListSink => _storeListController.sink;

  Stream<List<Dept>> get deptListStream => _deptListController.stream;

  StreamSink<List<Dept>> get deptListSink => _deptListController.sink;

  Stream<Dept> get deptStream => _deptController.stream;

  StreamSink<Dept> get deptSink => _deptController.sink;

  Stream<List<Section>> get secListStream => _sectionListController.stream;

  StreamSink<List<Section>> get secListSink => _sectionListController.sink;

  Stream<Section> get secStream => _sectionController.stream;

  StreamSink<Section> get secSink => _sectionController.sink;

  Stream<Store> get storeStream => _storeController.stream;

  StreamSink<Store> get storeSink => _storeController.sink;

  Stream<Region> get regionStream => _regionController.stream;

  StreamSink<Region> get regionSink => _regionController.sink;

  Stream<List<Category>> get categoryListStream =>
      _categoryListController.stream;

  StreamSink<List<Category>> get categoryListSink =>
      _categoryListController.sink;

  Stream<Category> get categoryStream => _categoryController.stream;

  StreamSink<Category> get categorySink => _categoryController.sink;

  Stream<List<Subcategory>> get subcategoryListStream =>
      _subcategoryListController.stream;

  StreamSink<List<Subcategory>> get subcategoryListSink =>
      _subcategoryListController.sink;

  Stream<Subcategory> get subcategoryStream => _subcategoryController.stream;

  StreamSink<Subcategory> get subcategorySink => _subcategoryController.sink;

  Stream<List<Product>> get remarkListStream => _remarkListController.stream;

  StreamSink<List<Product>> get remarkListSink => _remarkListController.sink;

  Stream<Product> get remarkStream => _remarkController.stream;

  StreamSink<Product> get remarkSink => _remarkController.sink;

  Stream<List<Result>> get barChartStream => _barProductController.stream;

  StreamSink<List<Result>> get barChartSink => _barProductController.sink;

  getRegion() async {
    isLoadingSink.add(true);
    try {
      final result = await _repository.getRcaRegion(_authToken);
      RegionModel region = regionModelFromJson(result.data);
      regionListSink.add(region.regions);
    } on DioError catch (error) {
      storeListSink.addError(error);
    }
  }

  getStore(String Id) async {
    isLoadingSink.add(true);
    storeListSink.add(List<Store>());
    try {
      final result = await _repository.storeByRegion(_authToken, Id);
      StoreModel stores = storeModelFromJson(result.data);
      storeListSink.add(stores.stores);
    } on DioError catch (error) {
      storeListSink.addError(error);
    }
  }

  getDepartment(String Id) async {
    isLoadingSink.add(true);
    deptListSink.add(List<Dept>());
    try {
      final result = await _repository.departmentByStore(_authToken, Id);
      DepartmentModel department = departmentModelFromJson(result.data);
      deptListSink.add(department.dept);
    } on DioError catch (error) {
      deptListSink.addError(error);
    }
  }

  getSection(String Id, String dId) async {
    isLoadingSink.add(true);
    secListSink.add(List<Section>());
    try {
      final result = await _repository.section(_authToken, Id, dId);
      SectionModel section = sectionModelFromJson(result.data);
      secListSink.add(section.section);
    } on DioError catch (error) {
      secListSink.addError(error);
    }
  }

  getCategory(String Id, String sectionId) async {
    isLoadingSink.add(true);
    categoryListSink.add(List<Category>());
    try {
      final result = await _repository.category(_authToken, Id, sectionId);
      CategoryModel category = categoryModelFromJson(result.data);
      categoryListSink.add(category.category);
    } on DioError catch (error) {
      categoryListSink.addError(error);
    }
  }

  getSubCategory(String Id, String cId) async {
    isLoadingSink.add(true);
    subcategoryListSink.add(List<Subcategory>());
    try {
      final result = await _repository.subCategory(_authToken, Id, cId);
      SubCategoryModel subCategory = subCategoryModelFromJson(result.data);
      subcategoryListSink.add(subCategory.subcategory);
    } on DioError catch (error) {
      subcategoryListSink.addError(error);
    }
  }

  getRemark(String Id, String subCatId) async {
    isLoadingSink.add(true);
    remarkListSink.add(List<Product>());
    try {
      final result = await _repository.remarks(_authToken, Id, subCatId);
      RemarkModel remarkmodel = remarkModelFromJson(result.data);
      remarkListSink.add(remarkmodel.product);
    } on DioError catch (error) {
      remarkListSink.addError(error);
    }
  }

  productGraph(String Id, String subCatId) async {
    isLoadingSink.add(true);
    barChartSink.add(List<Result>());
    try {
      final result = await _repository.productGraph(_authToken, Id, subCatId);
      RcaBar rcabar = rcaBarFromJson(result.data);
      barChartSink.add(rcabar.result);
    } on DioError catch (error) {
      barChartSink.addError(error);
    }
  }

  dispose() {
    super.dispose();
    _loadingController.close();
    _storeListController.close();
    _regionListController.close();
    _regionController.close();
    _storeController.close();
    _deptController.close();
    _deptListController.close();
    _sectionListController.close();
    _sectionController.close();
    _categoryController.close();
    _categoryListController.close();
    _remarkListController.close();
    _remarkController.close();
  }
}
