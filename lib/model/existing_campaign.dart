import 'dart:convert';

List<ExistingCampaignModel> existingCampaignModelFromJson(List str) =>
    List<ExistingCampaignModel>.from(
        str.map((x) => ExistingCampaignModel.fromMap(x)));

String existingCampaignModelToJson(List<ExistingCampaignModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ExistingCampaignModel {
  ExistingCampaignModel({
    this.id,
    this.name,
    this.associatedTargetList,
    this.timePeriod,
    this.campaigns,
    this.channels,
    this.createdDate,
  });

  final String id;
  final String name;
  final List<AssociatedTargetList> associatedTargetList;
  final String timePeriod;
  final String campaigns;
  final Channel channels;
  final String createdDate;

  factory ExistingCampaignModel.fromMap(Map<String, dynamic> json) =>
      ExistingCampaignModel(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        associatedTargetList: json["associatedTargetList"] == null
            ? null
            : List<AssociatedTargetList>.from(json["associatedTargetList"]
                .map((x) => AssociatedTargetList.fromMap(x))),
        timePeriod: json["timePeriod"] == null ? null : json["timePeriod"],
        campaigns: json["campaigns"] == null ? null : json["campaigns"],
        channels: json["channels"] == null
            ? null
            : channelValues.map[json["channels"]],
        createdDate: json["createdDate"] == null ? null : json["createdDate"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "associatedTargetList": associatedTargetList == null
            ? null
            : List<dynamic>.from(associatedTargetList.map((x) => x.toMap())),
        "timePeriod": timePeriod == null ? null : timePeriod,
        "campaigns": campaigns == null ? null : campaigns,
        "channels": channels == null ? null : channelValues.reverse[channels],
        "createdDate": createdDate == null ? null : createdDate,
      };
}

class AssociatedTargetList {
  AssociatedTargetList({
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
    this.sales90,
    this.sales180,
    this.sales360,
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
    this.checked,
    this.added,
    this.called,
  });

  final String id;
  final String custCode;
  final String custName;
  final String custMob;
  final CustArea custArea;
  final CustCategory custCategory;
  final Location location;
  final Location lastPurchLocation;
  final DateTime lastPurchDate;
  final Status status;
  final int idleDays;
  final double frequency90;
  final double frequency180;
  final double frequency360;
  final int recency;
  final double timegapRatio;
  final dynamic sales90;
  final dynamic sales180;
  final dynamic sales360;
  final int transactions90;
  final int transactions180;
  final int transactions360;
  final dynamic basket90;
  final dynamic basket180;
  final dynamic basket360;
  final int priority90;
  final int priority180;
  final int priority360;
  final dynamic marginPerc;
  final FavWeek favWeek;
  final OddEven oddEven;
  final FavDay favDay;
  final FavTime favTime;
  final String the30Subgroup1;
  final String the30Subgroup2;
  final String the30Subgroup3;
  final String the90Subgroup1;
  final String the180Subgroup1;
  final String the360Subgroup1;
  final String message;
  final Channel channel;
  final TestControlFlag testControlFlag;
  final Campaign campaign;
  final DateTime timePeriod;
  final dynamic preSales;
  final dynamic preTrxn;
  final dynamic preBasket;
  final bool checked;
  final int added;
  final bool called;

  factory AssociatedTargetList.fromMap(Map<String, dynamic> json) =>
      AssociatedTargetList(
        id: json["_id"] == null ? null : json["_id"],
        custCode: json["cust_Code"] == null ? null : json["cust_Code"],
        custName: json["cust_Name"] == null ? null : json["cust_Name"],
        custMob: json["cust_Mob"] == null ? null : json["cust_Mob"],
        custArea: json["cust_Area"] == null
            ? null
            : custAreaValues.map[json["cust_Area"]],
        custCategory: json["cust_Category"] == null
            ? null
            : custCategoryValues.map[json["cust_Category"]],
        location: json["location"] == null
            ? null
            : locationValues.map[json["location"]],
        lastPurchLocation: json["last_Purch_Location"] == null
            ? null
            : locationValues.map[json["last_Purch_Location"]],
        lastPurchDate: json["last_Purch_Date"] == null
            ? null
            : DateTime.parse(json["last_Purch_Date"]),
        status:
            json["status"] == null ? null : statusValues.map[json["status"]],
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
        sales90: json["sales_90"] == null ? null : json["sales_90"],
        sales180: json["sales_180"] == null ? null : json["sales_180"],
        sales360: json["sales_360"] == null ? null : json["sales_360"],
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
        favWeek: json["fav_Week"] == null
            ? null
            : favWeekValues.map[json["fav_Week"]],
        oddEven: json["odd_Even"] == null
            ? null
            : oddEvenValues.map[json["odd_Even"]],
        favDay:
            json["fav_Day"] == null ? null : favDayValues.map[json["fav_Day"]],
        favTime: json["fav_Time"] == null
            ? null
            : favTimeValues.map[json["fav_Time"]],
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
        channel:
            json["channel"] == null ? null : channelValues.map[json["channel"]],
        testControlFlag: json["test_Control_Flag"] == null
            ? null
            : testControlFlagValues.map[json["test_Control_Flag"]],
        campaign: json["campaign"] == null
            ? null
            : campaignValues.map[json["campaign"]],
        timePeriod: json["time_Period"] == null
            ? null
            : DateTime.parse(json["time_Period"]),
        preSales: json["pre_Sales"] == null ? null : json["pre_Sales"],
        preTrxn: json["pre_Trxn"] == null ? null : json["pre_Trxn"],
        preBasket: json["pre_Basket"] == null ? null : json["pre_Basket"],
        checked: json["checked"] == null ? null : json["checked"],
        added: json["added"] == null ? null : json["added"],
        called: json["called"] == null ? null : json["called"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "cust_Code": custCode == null ? null : custCode,
        "cust_Name": custName == null ? null : custName,
        "cust_Mob": custMob == null ? null : custMob,
        "cust_Area": custArea == null ? null : custAreaValues.reverse[custArea],
        "cust_Category": custCategory == null
            ? null
            : custCategoryValues.reverse[custCategory],
        "location": location == null ? null : locationValues.reverse[location],
        "last_Purch_Location": lastPurchLocation == null
            ? null
            : locationValues.reverse[lastPurchLocation],
        "last_Purch_Date": lastPurchDate == null
            ? null
            : "${lastPurchDate.year.toString().padLeft(4, '0')}-${lastPurchDate.month.toString().padLeft(2, '0')}-${lastPurchDate.day.toString().padLeft(2, '0')}",
        "status": status == null ? null : statusValues.reverse[status],
        "idle_Days": idleDays == null ? null : idleDays,
        "frequency_90": frequency90 == null ? null : frequency90,
        "frequency_180": frequency180 == null ? null : frequency180,
        "frequency_360": frequency360 == null ? null : frequency360,
        "recency": recency == null ? null : recency,
        "timegap_Ratio": timegapRatio == null ? null : timegapRatio,
        "sales_90": sales90 == null ? null : sales90,
        "sales_180": sales180 == null ? null : sales180,
        "sales_360": sales360 == null ? null : sales360,
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
        "fav_Week": favWeek == null ? null : favWeekValues.reverse[favWeek],
        "odd_Even": oddEven == null ? null : oddEvenValues.reverse[oddEven],
        "fav_Day": favDay == null ? null : favDayValues.reverse[favDay],
        "fav_Time": favTime == null ? null : favTimeValues.reverse[favTime],
        "_30_subgroup1": the30Subgroup1 == null ? null : the30Subgroup1,
        "_30_subgroup2": the30Subgroup2 == null ? null : the30Subgroup2,
        "_30_subgroup3": the30Subgroup3 == null ? null : the30Subgroup3,
        "_90_subgroup1": the90Subgroup1 == null ? null : the90Subgroup1,
        "_180_subgroup1": the180Subgroup1 == null ? null : the180Subgroup1,
        "_360_subgroup1": the360Subgroup1 == null ? null : the360Subgroup1,
        "message": message == null ? null : message,
        "channel": channel == null ? null : channelValues.reverse[channel],
        "test_Control_Flag": testControlFlag == null
            ? null
            : testControlFlagValues.reverse[testControlFlag],
        "campaign": campaign == null ? null : campaignValues.reverse[campaign],
        "time_Period": timePeriod == null
            ? null
            : "${timePeriod.year.toString().padLeft(4, '0')}-${timePeriod.month.toString().padLeft(2, '0')}-${timePeriod.day.toString().padLeft(2, '0')}",
        "pre_Sales": preSales == null ? null : preSales,
        "pre_Trxn": preTrxn == null ? null : preTrxn,
        "pre_Basket": preBasket == null ? null : preBasket,
        "checked": checked == null ? null : checked,
        "added": added == null ? null : added,
        "called": called == null ? null : called,
      };
}

enum Campaign { REDEMPTION, PREVENTION }

final campaignValues = EnumValues(
    {"Prevention": Campaign.PREVENTION, "Redemption": Campaign.REDEMPTION});

enum Channel { CALL, SMS, CALL_SMS }

final channelValues = EnumValues(
    {"Call": Channel.CALL, "Call, SMS": Channel.CALL_SMS, "SMS": Channel.SMS});

enum CustArea { UAE }

final custAreaValues = EnumValues({"UAE": CustArea.UAE});

enum CustCategory { L001 }

final custCategoryValues = EnumValues({"L001": CustCategory.L001});

enum FavDay { THU, FRI, SAT }

final favDayValues =
    EnumValues({"Fri": FavDay.FRI, "Sat": FavDay.SAT, "Thu": FavDay.THU});

enum FavTime { EVENING, MORNING, NIGHT, NOON }

final favTimeValues = EnumValues({
  "Evening": FavTime.EVENING,
  "Morning": FavTime.MORNING,
  "Night": FavTime.NIGHT,
  "Noon": FavTime.NOON
});

enum FavWeek { WEEK2, WEEK1, WEEK4 }

final favWeekValues = EnumValues(
    {"week1": FavWeek.WEEK1, "week2": FavWeek.WEEK2, "week4": FavWeek.WEEK4});

enum Location { GRAND_HYPERMARKET, GRAND_CITY_MALL, GRAND_HYPER }

final locationValues = EnumValues({
  "GRAND CITY MALL": Location.GRAND_CITY_MALL,
  "GRAND HYPER": Location.GRAND_HYPER,
  "GRAND HYPERMARKET": Location.GRAND_HYPERMARKET
});

enum OddEven { EVEN, ODD }

final oddEvenValues = EnumValues({"Even": OddEven.EVEN, "Odd": OddEven.ODD});

enum Status { STRUCTURAL, ACTIVE, INACTIVE }

final statusValues = EnumValues({
  "Active": Status.ACTIVE,
  "Inactive": Status.INACTIVE,
  "Structural": Status.STRUCTURAL
});

enum TestControlFlag { T, C }

final testControlFlagValues =
    EnumValues({"C": TestControlFlag.C, "T": TestControlFlag.T});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
