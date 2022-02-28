import 'package:dio/dio.dart';
import 'package:zel_app/managers/StockOutManager.dart';
import 'package:zel_app/managers/finance_manager.dart';
import 'package:zel_app/managers/it_manager.dart';
import 'package:zel_app/managers/login_manager.dart';
import 'package:zel_app/managers/managing_director_manager.dart';
import 'package:zel_app/managers/product_manager.dart';
import 'package:zel_app/managers/products_manager.dart';
import 'package:zel_app/managers/purchaser_manager.dart';
import 'package:zel_app/managers/rca_manager.dart';
import 'package:zel_app/managers/store_manager.dart';
import 'package:zel_app/managers/target_list_manager.dart';
import 'package:zel_app/managers/warehouse_manager.dart';
import 'package:zel_app/managing_director/managing_director_provider.dart';
import 'package:zel_app/model/login_response.dart';

class DataManagerRepository {
  //final LoginRepository _loginRepository = locator<LoginRepository>();

  final LoginManager _loginManager = LoginManager();
  final _storeManager = StoreManager();
  final _productManager = ProductManager();
  final _targetManager = MarketEngineManager();
  final _warehouseManager = WarehouseManager();
  final _purchaserManager = PurchaserManager();
  final _financeManager = FinanceManager();
  final _productsManager = ProductsManager();
  final _managingDirectorManager = ManagingDirectorManaging();
  final _itManager = ItManager();
  final _rcaManager = RcaManager();
  final _stockOutManager = StockOutManager();
  Future<Response> login(String email, String password) =>
      _loginManager.login(email, password);

  Future<Response> languages() => _loginManager.languages();

  Future<Response> selectedLanguage(String lang) =>
      _loginManager.selectedLanguage(lang);

  Future<Response> registerAccount(
    String fullName,
    String email,
    String phoneNumber,
    String password,
  ) =>
      _loginManager.registerAccount(
        fullName,
        email,
        phoneNumber,
        password,
      );

  Future<Response> forgotPassword(String emailOrNumber) =>
      _loginManager.forgotPassword(emailOrNumber);

  Future<Response> changePassword(
    String emailOrNumber,
    String password,
  ) =>
      _loginManager.changePassword(
        emailOrNumber,
        password,
      );

  Future<Response> verifyOtp(String emailOrNumber, String otp) =>
      _loginManager.verifyOtp(
        emailOrNumber,
        otp,
      );

  Future<Response> homeDetails() => _storeManager.homeDetails();

  Future<Response> details(
    String authToken,
    String companyId,
    String fromDate,
    String endDate,
  ) =>
      _storeManager.details(
        authToken,
        companyId,
        fromDate,
        endDate,
      );

  Future<Response> barChartDetails(
    String authToken,
    String companyId,
    String fromDate,
    String endDate,
  ) =>
      _storeManager.barChart(
        authToken,
        companyId,
        fromDate,
        endDate,
      );

  Future<Response> pieChartsDetails(
    String authToken,
    String companyId,
    String fromDate,
    String endDate,
  ) =>
      _storeManager.pieChart(
        authToken,
        companyId,
        fromDate,
        endDate,
      );

  Future<Response> lineChartDetails(
    String authToken,
    String companyId,
    String fromDate,
    String endDate,
  ) =>
      _storeManager.lineChart(
        authToken,
        companyId,
        fromDate,
        endDate,
      );

  Future<Response> lineChartFilter(
          {String authToken,
          String fromDate,
          String endDate,
          String companyId,
          String value}) =>
      _storeManager.lineFiler(authToken, fromDate, endDate, companyId, value);

//  Future<Response> donughtChartFilter(
//      {String authToken,
//        String fromDate,
//        String endDate,
//        String companyId,
//        String value}) =>
//      _storeManager.donughtFiler(authToken, fromDate, endDate, companyId, value);

  Future<Response> bubbleChartDetails(
    String authToken,
    String companyId,
    String fromDate,
    String endDate,
  ) =>
      _storeManager.bubbleChart(
        authToken,
        companyId,
        fromDate,
        endDate,
      );

//  Future<Response> actionsTable(
//    String authToken,
//    Roles roles,
//    String fromDate,
//    String endDate,
//  ) =>
//      _storeManager.actionTable(
//        authToken,
//        roles,
//        fromDate,
//        endDate,
//      );

  Future<Response> targetListApi(String token) =>
      _targetManager.targetListApi(token);

  Future<Response> getLocation(String authToken) =>
      _targetManager.getLocation(authToken);

  Future<Response> getChannel(String authToken) =>
      _targetManager.getChannel(authToken);

  Future<Response> getCampaign(String authToken) =>
      _targetManager.getCampaign(authToken);

  Future<Response> timePeriod(String authToken) =>
      _targetManager.timePeriod(authToken);

  Future<Response> filterTargetList(String token, String location,
          String channel, String time, String campaign) =>
      _targetManager.filterTargetList(token, location, channel, time, campaign);

  Future<Response> createAction(
          String token, String time, String campaignName, String targetIds) =>
      _targetManager.createAction(token, time, campaignName, targetIds);

  Future<Response> existingCampaign(String authToken) =>
      _targetManager.existingCampaign(authToken);

  Future<Response> deleteCampaign(String authToken, String ids) =>
      _targetManager.deleteCampaign(authToken, ids);

  Future<Response> editAction(String authToken, String name, String ids) =>
      _targetManager.editAction(authToken, name, ids);

  Future<Response> recomSummary(String authToken, String timePeriod) =>
      _targetManager.recomSummary(authToken, timePeriod);

  Future<Response> customerStatus(String authToken) =>
      _targetManager.customerStatus(authToken);

  Future<Response> agentFeedbak(String authToken, String actionListId,
          String targetListId, String feedback, String value) =>
      _targetManager.agentFeedback(
          authToken, actionListId, targetListId, feedback, value);

  Future<Response> allAlarms(String token) => _productManager.allAlarms(token);

  Future<Response> allProducts(
    String authToken,
    String companyId,
    String fromDate,
    String endDate,
  ) =>
      _productManager.productList(
        authToken,
        companyId,
        fromDate,
        endDate,
      );

  Future<Response> flowProgres(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
    String value,
    String companyId,
  ) =>
      _productManager.flowProgres(
          authToken, roles, fromDate, endDate, value, companyId);
  Future<Response> updateRemarks(
    String authToken,
    String productId,
    String companyId,
    String alarmName,
  ) =>
      _productManager.updateRemarks(authToken, productId, companyId, alarmName);

  Future<Response> updateAction(
    String authToken,
    String productId,
    String companyId,
    String actionName,
  ) =>
      _productManager.updateAction(authToken, productId, companyId, actionName);

  Future<Response> saveAction(
    String remark,
    String authToken,
    String productId,
  ) =>
      _productManager.setRemarks(remark, productId, authToken);

  Future<Response> getActionsFromAlarm(
    String authToken,
    String alarmName,
  ) =>
      _productManager.getActionsFromAlarm(
        authToken,
        alarmName,
      );

  Future<Response> getSubActionsFromAction(
          String authToken, String actionName) =>
      _productManager.getSubActionsFromAction(authToken, actionName);

  Future<Response> saveDetails(
    String authToken,
    String productId,
    String subActionName,
    String remarkable,
    String barCode,
    String companyId,
  ) =>
      _productManager.saveDetails(
          authToken, productId, subActionName, remarkable, barCode, companyId);

  Future<Response> filterAlaramStore(
    String authToken,
    String value,
    String fromDate,
    String companyId,
    String endDate,
  ) =>
      _productManager.filterAlaramStore(
          authToken, value, fromDate, companyId, endDate);

  Future<Response> updateRole(
          String authToken, String productId, Roles roles) =>
      _productManager.updateRole(authToken, productId, roles);

  Future<Response> search(
    String companyId,
    String fromDate,
    String endDate,
    String prodId,
    String authToken,
  ) =>
      _productManager.search(
        companyId,
        fromDate,
        endDate,
        prodId,
        authToken,
      );

  Future<Response> warehouseDetails(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) =>
      _warehouseManager.warehouseDetails(authToken, roles, fromDate, endDate);
  Future<Response> filterAlaram(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
    String value,
  ) =>
      _warehouseManager.filterAlaram(
          authToken, roles, fromDate, endDate, value);
  Future<Response> wareHouseProductList(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) =>
      _warehouseManager.wareHouseProductList(
        authToken,
        roles,
        fromDate,
        endDate,
      );

  Future<Response> wareHouseActions(String authToken) =>
      _warehouseManager.wareHouseActions(authToken);

  Future<Response> wareHouseSubActions(String authToken) =>
      _warehouseManager.wareHouseActions(authToken);

  Future<Response> setSupplierToProduct(
    String authToken,
    String productId,
    String supplierName,
  ) =>
      _warehouseManager.setSupplierToProduct(
        authToken,
        productId,
        supplierName,
      );

  Future<Response> getActionByPermission(
    String authToken,
    String id,
  ) =>
      _warehouseManager.getActionByPermission(
        authToken,
        id,
      );

  Future<Response> getPermissionsByRole(
    String authToken,
    Roles roles,
    String thId,
  ) =>
      _warehouseManager.getPermissionsByRole(authToken, roles, thId);

  Future<Response> getStores(String authToken) =>
      _warehouseManager.getStores(authToken);

  Future<Response> getDepartments(String authToken) =>
      _warehouseManager.getDepartments(authToken);

  Future<Response> getFilterProducts(
    String authToken,
    Roles roles,
    String department,
    String store,
    String fromDate,
    String endDate,
  ) =>
      _warehouseManager.getFilterProducts(
        authToken,
        roles,
        department,
        store,
        fromDate,
        endDate,
      );

  Future<Response> getFilterByScode(
    String authToken,
    String fromDate,
    String endDate,
    String store,
    Roles roles,
  ) =>
      _warehouseManager.getFilterByScode(
          authToken, fromDate, endDate, store, roles);

  Future<Response> getFilterByDept(String authToken, String fromDate,
          String endDate, String department, Roles role) =>
      _warehouseManager.getFilterByDepartment(
          authToken, fromDate, endDate, department, role);
  Future<Response> purchaserDetails(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) =>
      _purchaserManager.purchaserDetails(
        authToken,
        roles,
        fromDate,
        endDate,
      );
  Future<Response> getFilterByStorecode(
    String authToken,
    String fromDate,
    String endDate,
    String store,
  ) =>
      _purchaserManager.getFilterByScode(
        authToken,
        fromDate,
        endDate,
        store,
      );
  Future<Response> getFilterByDepartment(
    String authToken,
    String fromDate,
    String endDate,
    String department,
  ) =>
      _purchaserManager.getFilterByDepartment(
        authToken,
        fromDate,
        endDate,
        department,
      );
  Future<Response> purchaserProductList(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) =>
      _purchaserManager.purchaserProductList(
        authToken,
        roles,
        fromDate,
        endDate,
      );

  Future<Response> purchaserActionTable(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) =>
      _purchaserManager.purchaserActionTable(
        authToken,
        roles,
        fromDate,
        endDate,
      );

  Future<Response> getPermissionOnRole(
          String authToken, Roles roles, String tId) =>
      _purchaserManager.getPermissionsByRole(authToken, roles, tId);

  Future<Response> getSubActionByPermission(
    String authToken,
    String id,
  ) =>
      _purchaserManager.getActionByPermission(
        authToken,
        id,
      );
  Future<Response> getAsignByPermission(
    String authToken,
    String id,
  ) =>
      _purchaserManager.asign(
        authToken,
        id,
      );
  Future<Response> setSupplier(
    String authToken,
    String productId,
    String supplierName,
  ) =>
      _purchaserManager.setSupplier(
        authToken,
        productId,
        supplierName,
      );

  Future<Response> getFilterProduct(
    Roles roles,
    String authToken,
    int companyId,
    String division,
    String fromDate,
    String endDate,
  ) =>
      _purchaserManager.getFilterProducts(
        roles,
        authToken,
        companyId,
        division,
        fromDate,
        endDate,
      );

  Future<Response> setWorkFlowToProduct(
    String wId,
    String authToken,
    String id,
    String targetDays,
  ) =>
      _warehouseManager.setWorkFlowToProduct(
        wId,
        authToken,
        id,
        targetDays,
      );

  Future<Response> actionTable(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) =>
      _warehouseManager.actionTable(
        authToken,
        roles,
        fromDate,
        endDate,
      );

  Future<Response> financeDetails(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) =>
      _financeManager.financeDetails(authToken, roles, fromDate, endDate);

  Future<Response> financeProductList(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) =>
      _financeManager.financeProductList(
        authToken,
        roles,
        fromDate,
        endDate,
      );

  Future<Response> financeActionTable(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) =>
      _financeManager.finanaceActionTable(
        authToken,
        roles,
        fromDate,
        endDate,
      );

  Future<Response> financeActions(
    String authToken,
    Roles roles,
    String threadId,
  ) =>
      _financeManager.financeActions(authToken, roles, threadId);

  Future<Response> financeSubActions(
    String authToken,
    String actionId,
  ) =>
      _financeManager.getActionByPermission(
        authToken,
        actionId,
      );

  Future<Response> setSuppliers(
    String authToken,
  ) =>
      _financeManager.getSupplier(
        authToken,
      );

  Future<Response> getFilter(
    Roles roles,
    String authToken,
    String supplierName,
  ) =>
      _financeManager.getFilterOfProduct(
        roles,
        authToken,
        supplierName,
      );

  Future<Response> setWorkFlow(
    String authToken,
    String productId,
    String actionId,
    String targetDays,
  ) =>
      _financeManager.setWorkFlowToProduct(
        authToken,
        productId,
        actionId,
        targetDays,
      );

  Future<Response> mdProductList(
          String region, String fromDate, String endDate, String authToken) =>
      _productsManager.mdProductList(
        authToken,
        fromDate,
        endDate,
        region,
      );

  Future<Response> mdWIPList(
          String region, String fromDate, String endDate, String authToken) =>
      _productsManager.mdWIPList(
        authToken,
        fromDate,
        endDate,
        region,
      );

  Future<Response> getAllStores(String authToken, String region) =>
      _productsManager.getStores(authToken, region);

  Future<Response> getRoles(String authToken) =>
      _productsManager.getRoles(authToken);

  Future<Response> getRegions(String authToken) =>
      _productsManager.getRegion(authToken);

  Future<Response> getAllRole(String authToken) =>
      _managingDirectorManager.getAllRole(authToken);

  Future<Response> getAllRegion(String authToken) =>
      _managingDirectorManager.getAllRegion(authToken);

  Future<Response> getWorkInProgressAlarms(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
    String storeCode,
  ) =>
      _managingDirectorManager.getWorkInProgressAlarms(
        authToken,
        region,
        fromDate,
        endDate,
        apiState,
        storeCode,
      );

  Future<Response> getWorkInProgressAlarmsByRole(
    String authToken,
    String role,
    String fromDate,
    String endDate,
  ) =>
      _managingDirectorManager.getWorkInProgressAlarmsByRole(
        authToken,
        role,
        fromDate,
        endDate,
      );

  Future<Response> getSalesAlarms(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
  ) =>
      _managingDirectorManager.getSalesAlarms(
          authToken, region, fromDate, endDate, apiState);

  Future<Response> getSalesAlarmsRefresh(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
    String storeCode,
  ) =>
      _managingDirectorManager.getSalesAlarmRefresh(
          authToken, region, fromDate, endDate, apiState, storeCode);

  Future<Response> lineChartForManagingDirector(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
    String storeName,
  ) =>
      _managingDirectorManager.lineChartForManagingDirector(
        authToken,
        region,
        fromDate,
        endDate,
        apiState,
        storeName,
      );

  Future<Response> flowProgressionManagingDirector(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
    String companyId,
  ) =>
      _managingDirectorManager.flowProgressionManagingDirector(
        authToken,
        region,
        fromDate,
        endDate,
        apiState,
        companyId,
      );

  Future<Response> barChartManagingDirector(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
    String companyId,
    String storeName,
  ) =>
      _managingDirectorManager.barChartManagingDirector(
          authToken, region, fromDate, endDate, apiState, companyId, storeName);

  Future<Response> salesImpactChart(
    String authToken,
    String region,
    String fromDate,
    String endDate,
    ApiState apiState,
    String storeCode,
  ) =>
      _managingDirectorManager.salesImpactChart(
        authToken,
        region,
        fromDate,
        endDate,
        apiState,
        storeCode,
      );

  Future<Response> getStoresByRegion(
    String authToken,
    String region,
  ) =>
      _managingDirectorManager.getStoresByRegion(
        authToken,
        region,
      );

  Future<Response> itDetails(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) =>
      _itManager.ItDetails(
        authToken,
        roles,
        fromDate,
        endDate,
      );

  Future<Response> itProductList(
    String authToken,
    Roles roles,
    String fromDate,
    String endDate,
  ) =>
      _itManager.itProductList(
        authToken,
        roles,
        fromDate,
        endDate,
      );

//Future<Response> itActionTable(
//    String authToken,
//    Roles roles,
//    String fromDate,
//    String endDate,
//    ) =>
//    _itManager.itActionTable(
//      authToken,
//      roles,
//      fromDate,
//      endDate,
//    );
//
//Future<Response> getPermissionOnRole(
//    String authToken,
//    Roles roles,
//    ) =>
//    _itManager.getPermissionsByRole(
//      authToken,
//      roles,
//    );
//
//Future<Response> getSubActionByPermission(
//    String authToken,
//    String id,
//    ) =>
//    _itManager.getActionByPermission(
//      authToken,
//      id,
//    );

  Future<Response> setSupplierToIt(
    String authToken,
    String productId,
    String supplierName,
  ) =>
      _itManager.setSupplierToProduct(
        authToken,
        productId,
        supplierName,
      );

  Future<Response> getItFilterProduct(
    Roles roles,
    String authToken,
    int companyId,
    String division,
    String fromDate,
    String endDate,
  ) =>
      _itManager.getFilterOfProducts(
        roles,
        authToken,
        companyId,
        division,
        fromDate,
        endDate,
      );

  Future<Response> getRcaRegion(String authToken) => _rcaManager.rcaOnRegion(
        authToken,
      );

  Future<Response> storeByRegion(
    String authToken,
    String id,
  ) =>
      _rcaManager.rcaOnStore(
        authToken,
        id,
      );

  Future<Response> departmentByStore(
    String authToken,
    String id,
  ) =>
      _rcaManager.rcaOnDepartment(
        authToken,
        id,
      );

  Future<Response> section(String authToken, String sId, String dId) =>
      _rcaManager.rcaOnSection(authToken, sId, dId);

  Future<Response> category(String authToken, String sId, String sectionId) =>
      _rcaManager.rcaOnCategory(authToken, sId, sectionId);

  Future<Response> subCategory(
          String authToken, String sId, String categoryId) =>
      _rcaManager.rcaOnSubCategory(authToken, sId, categoryId);

  Future<Response> remarks(
          String authToken, String sId, String subCategoryId) =>
      _rcaManager.rcaOnProduct(authToken, sId, subCategoryId);

  Future<Response> productGraph(
          String authToken, String sId, String subCategoryId) =>
      _rcaManager.rcaOnProductGraph(authToken, sId, subCategoryId);

  Future<Response> regions() => _stockOutManager.region();
  Future<Response> stores() => _stockOutManager.stores();

  Future<Response> productSummary(String region, String store, String date) =>
      _stockOutManager.productSummary(region, store, date);
}
