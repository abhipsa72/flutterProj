import 'dart:convert';

List<TargetModel> targetModelFromJson(List str) =>
    List<TargetModel>.from(str.map((x) => TargetModel.fromMap(x)));

String targetModelToJson(List<TargetModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class TargetModel {
  TargetModel({
    this.id,
    this.custCode,
    this.custName,
    this.custMob,
    this.custArea,
    this.custCategory,
    this.location,
    this.lastPurchLocation,
    this.lastPurchDate,
    this.status,
    this.idleDays,
    this.frequency90,
    this.frequency180,
    this.frequency360,
    this.recency,
    this.timegapRatio,
    this.sales_90,
    this.sales_180,
    this.sales_360,
    this.transactions90,
    this.transactions180,
    this.transactions360,
    this.basket90,
    this.basket180,
    this.basket360,
    this.priority90,
    this.priority180,
    this.priority360,
    this.marginPerc,
    this.favWeek,
    this.oddEven,
    this.favDay,
    this.favTime,
    this.the30Subgroup1,
    this.the30Subgroup2,
    this.the30Subgroup3,
    this.the90Subgroup1,
    this.the180Subgroup1,
    this.the360Subgroup1,
    this.message,
    this.channel,
    this.testControlFlag,
    this.campaign,
    this.timePeriod,
    this.preSales,
    this.preTrxn,
    this.preBasket,
  });

  final String id;
  final String custCode;
  final String custName;
  final String custMob;
  final String custArea;
  final String custCategory;
  final String location;
  final String lastPurchLocation;
  final DateTime lastPurchDate;
  final String status;
  final int idleDays;
  final double frequency90;
  final double frequency180;
  final double frequency360;
  final int recency;
  final double timegapRatio;
  final double sales_90;
  final double sales_180;
  final double sales_360;
  final int transactions90;
  final int transactions180;
  final int transactions360;
  final double basket90;
  final double basket180;
  final double basket360;
  final int priority90;
  final int priority180;
  final int priority360;
  final double marginPerc;
  final String favWeek;
  final String oddEven;
  final String favDay;
  final String favTime;
  final String the30Subgroup1;
  final String the30Subgroup2;
  final String the30Subgroup3;
  final String the90Subgroup1;
  final String the180Subgroup1;
  final String the360Subgroup1;
  final String message;
  final String channel;
  final String testControlFlag;
  final String campaign;
  final DateTime timePeriod;
  final double preSales;
  final double preTrxn;
  final double preBasket;

  factory TargetModel.fromMap(Map<String, dynamic> json) => TargetModel(
        id: json["_id"] == null ? null : json["_id"],
        custCode: json["cust_Code"] == null ? null : json["cust_Code"],
        custName: json["cust_Name"] == null ? null : json["cust_Name"],
        custMob: json["cust_Mob"] == null ? null : json["cust_Mob"],
        custArea: json["cust_Area"] == null ? null : json["cust_Area"],
        custCategory:
            json["cust_Category"] == null ? null : json["cust_Category"],
        location: json["location"] == null ? null : json["location"],
        lastPurchLocation: json["last_Purch_Location"] == null
            ? null
            : json["last_Purch_Location"],
        lastPurchDate: json["last_Purch_Date"] == null
            ? null
            : DateTime.parse(json["last_Purch_Date"]),
        status: json["status"] == null ? null : json["status"],
        idleDays: json["idle_Days"] == null ? null : json["idle_Days"],
        frequency90: json["frequency_90"] == null
            ? null
            : json["frequency_90"].toDouble(),
        frequency180: json["frequency_180"] == null
            ? null
            : json["frequency_180"].toDouble(),
        frequency360: json["frequency_360"] == null
            ? null
            : json["frequency_360"].toDouble(),
        recency: json["recency"] == null ? null : json["recency"],
        timegapRatio: json["timegap_Ratio"] == null
            ? null
            : json["timegap_Ratio"].toDouble(),
        sales_90: json["sales_90"] == null ? null : json["sales_90"],
        sales_180: json["sales_180"] == null ? null : json["sales_180"],
        sales_360: json["sales_360"] == null ? null : json["sales_360"],
        transactions90:
            json["transactions_90"] == null ? null : json["transactions_90"],
        transactions180:
            json["transactions_180"] == null ? null : json["transactions_180"],
        transactions360:
            json["transactions_360"] == null ? null : json["transactions_360"],
        basket90: json["basket_90"] == null ? null : json["basket_90"],
        basket180: json["basket_180"] == null ? null : json["basket_180"],
        basket360: json["basket_360"] == null ? null : json["basket_360"],
        priority90: json["priority_90"] == null ? null : json["priority_90"],
        priority180: json["priority_180"] == null ? null : json["priority_180"],
        priority360: json["priority_360"] == null ? null : json["priority_360"],
        marginPerc: json["margin_Perc"] == null ? null : json["margin_Perc"],
        favWeek: json["fav_Week"] == null ? null : json["fav_Week"],
        oddEven: json["odd_Even"] == null ? null : json["odd_Even"],
        favDay: json["fav_Day"] == null ? null : json["fav_Day"],
        favTime: json["fav_Time"] == null ? null : json["fav_Time"],
        the30Subgroup1:
            json["_30_subgroup1"] == null ? null : json["_30_subgroup1"],
        the30Subgroup2:
            json["_30_subgroup2"] == null ? null : json["_30_subgroup2"],
        the30Subgroup3:
            json["_30_subgroup3"] == null ? null : json["_30_subgroup3"],
        the90Subgroup1:
            json["_90_subgroup1"] == null ? null : json["_90_subgroup1"],
        the180Subgroup1:
            json["_180_subgroup1"] == null ? null : json["_180_subgroup1"],
        the360Subgroup1:
            json["_360_subgroup1"] == null ? null : json["_360_subgroup1"],
        message: json["message"] == null ? null : json["message"],
        channel: json["channel"] == null ? null : json["channel"],
        testControlFlag: json["test_Control_Flag"] == null
            ? null
            : json["test_Control_Flag"],
        campaign: json["campaign"] == null ? null : json["campaign"],
        timePeriod: json["time_Period"] == null
            ? null
            : DateTime.parse(json["time_Period"]),
        preSales: json["pre_Sales"] == null ? null : json["pre_Sales"],
        preTrxn: json["pre_Trxn"] == null ? null : json["pre_Trxn"],
        preBasket: json["pre_Basket"] == null ? null : json["pre_Basket"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "cust_Code": custCode == null ? null : custCode,
        "cust_Name": custName == null ? null : custName,
        "cust_Mob": custMob == null ? null : custMob,
        "cust_Area": custArea == null ? null : custArea,
        "cust_Category": custCategory == null ? null : custCategory,
        "location": location == null ? null : location,
        "last_Purch_Location":
            lastPurchLocation == null ? null : lastPurchLocation,
        "last_Purch_Date": lastPurchDate == null
            ? null
            : "${lastPurchDate.year.toString().padLeft(4, '0')}-${lastPurchDate.month.toString().padLeft(2, '0')}-${lastPurchDate.day.toString().padLeft(2, '0')}",
        "status": status == null ? null : status,
        "idle_Days": idleDays == null ? null : idleDays,
        "frequency_90": frequency90 == null ? null : frequency90,
        "frequency_180": frequency180 == null ? null : frequency180,
        "frequency_360": frequency360 == null ? null : frequency360,
        "recency": recency == null ? null : recency,
        "timegap_Ratio": timegapRatio == null ? null : timegapRatio,
        "sales_90": sales_90 == null ? null : sales_90,
        "sales_180": sales_180 == null ? null : sales_180,
        "sales_360": sales_360 == null ? null : sales_360,
        "transactions_90": transactions90 == null ? null : transactions90,
        "transactions_180": transactions180 == null ? null : transactions180,
        "transactions_360": transactions360 == null ? null : transactions360,
        "basket_90": basket90 == null ? null : basket90,
        "basket_180": basket180 == null ? null : basket180,
        "basket_360": basket360 == null ? null : basket360,
        "priority_90": priority90 == null ? null : priority90,
        "priority_180": priority180 == null ? null : priority180,
        "priority_360": priority360 == null ? null : priority360,
        "margin_Perc": marginPerc == null ? null : marginPerc,
        "fav_Week": favWeek == null ? null : favWeek,
        "odd_Even": oddEven == null ? null : oddEven,
        "fav_Day": favDay == null ? null : favDay,
        "fav_Time": favTime == null ? null : favTime,
        "_30_subgroup1": the30Subgroup1 == null ? null : the30Subgroup1,
        "_30_subgroup2": the30Subgroup2 == null ? null : the30Subgroup2,
        "_30_subgroup3": the30Subgroup3 == null ? null : the30Subgroup3,
        "_90_subgroup1": the90Subgroup1 == null ? null : the90Subgroup1,
        "_180_subgroup1": the180Subgroup1 == null ? null : the180Subgroup1,
        "_360_subgroup1": the360Subgroup1 == null ? null : the360Subgroup1,
        "message": message == null ? null : message,
        "channel": channel == null ? null : channel,
        "test_Control_Flag": testControlFlag == null ? null : testControlFlag,
        "campaign": campaign == null ? null : campaign,
        "time_Period": timePeriod == null
            ? null
            : "${timePeriod.year.toString().padLeft(4, '0')}-${timePeriod.month.toString().padLeft(2, '0')}-${timePeriod.day.toString().padLeft(2, '0')}",
        "pre_Sales": preSales == null ? null : preSales,
        "pre_Trxn": preTrxn == null ? null : preTrxn,
        "pre_Basket": preBasket == null ? null : preBasket,
      };
}
