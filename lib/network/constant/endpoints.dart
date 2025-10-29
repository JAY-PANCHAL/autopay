
import '../../common/utils/storage_service.dart';

class Endpoints {
  Endpoints._();

  //static const String baseUrl = "http://agdisk.com/AasanApi/api/"; //Live

  static const String baseUrl =
      "https://www.mindtechsolutions.com/tester/M2/M2Utilities/api/"; //new

  // receiveTimeout
  static const int receiveTimeout = 250000;
// 9985552312
  //2312

  // connectTimeout
  static const int connectionTimeout = 250000;
  final StorageService storageService = StorageService();

  static const String login = 'smart_track_authenticate/login';
  static const String getEmpData =
      'smart_track_authenticate/get_employee_details';
  static const String getQCData = 'transaction/get_qc_param_list';
  static const String subProcessData = 'transaction/get_sub_proccesses';
  static const String getReasonsMaster = 'transaction/get_reasons';
  static const String getBagInfo = 'transaction/get_worker_bag_info';
  static const String getBagList = 'transaction/get_worker_bag_list';
  static const String workerBagEntry = 'transaction/insert_bag_worker_entry';
  static const String workerQcEntry = 'transaction/update_qc_details';
  static const String verifyOtp = "Authentication/CheckValidateOTP";
  static const String getTodayStatus = 'transaction/get_todays_status';

  static const String locationMaster = "Authentication/LocationMaster";

  static const String getMemberCount = "Member/GetMemberCount?IsNew=1";

  static const String getMemberData = "Member/GetMemberData";

  static const String confirmMemberData = "Member/ConfirmMemberData";
  static const String maxofMembers = "Member/MaxofMemberCode";

  static const String getLastLocalsalesID = "LocalSales/GetLastLocalSalesId";
  static const String getLastPayDeductionID =
      "PaymentDeduction/GetLastPayDeductionId";

  static const String getBankMaster = "BankMaster/GetBankMaster";

  static const String getDataRelatedSetting =
      'Setting/GetDataRelatedSetting?IsDefault=1';
  static const String getSessionRelatedSetting =
      'Setting/GetSessionRelatedSetting?IsDefault=1';

  static const String getRateRelatedSetting =
      'Setting/GetRateRelatedSetting?IsDefault=1';
  static const String getFATBasedRateChartCount =
      'RateChart/getFATBasedRateChartCount?IsNew=1';

  static const String getFATBasedRateChart = 'RateChart/getFATBasedRateChart';

  static const String confirmFATBasedRateChart =
      'RateChart/ConfirmFATBasedRateChart';

  static const String getAsaanAppMenu = 'Menu/GetAssanAppMenu';

  static const String getAsaanAppUserRole = 'Menu/GetAppUserRole';

  static const String locationInsert = "Authentication/LocationInsert";

  static const String confirmNotification =
      "Setting/ConfirmNotification?ConfigCode=";

  static const String getLastCollectionId = "Collection/GetLastCollectionId";

  static const String postMilkCollection = "Collection/postMilkCollection";
  static const String getMilkCollection = "Collection/GetCollectionData";

  static const String postFatBasedManualRate =
      "RateChart/PostFATBasedManualRate";

  static const String getCollectionUploadStatus =
      "Collection/GetCollectionUploadStatus";

  static const String deviceProfile = '''
  CREATE TABLE DeviceProfile (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    SocietyCode INTEGER,
    SocietyName TEXT,
    SocietyAddress TEXT,
    SocietyPAN TEXT,
    SocietyGST TEXT,
    SocietyRegNo TEXT,
    MobileNumber TEXT,
    KeyToken TEXT,
    KeyGeneratedOn TEXT,
    KeyExpiryOn TEXT,
    KeyExpired INTEGER,
    LastOTP TEXT,
    LastSystemDate TEXT,
    LastLoginDateTime TEXT,
    APPLanguage INTEGER,
    APPDateFormat INTEGER,
    Keyboard INTEGER,
    FontSize INTEGER,
    FontName TEXT,
    MultipleEntries INTEGER,
    IsSync INTEGER,
    DeviceLastConnected TEXT
  )
''';

  static const String membersActivity = '''
    CREATE TABLE MembersActivity (
      Code INTEGER PRIMARY KEY AUTOINCREMENT,
      MemCode TEXT,
      LastCollectionDT TEXT,
      LastCollLiters TEXT,
      LastCollAmount TEXT,
      TotCollection TEXT,
      TotCollectionLtr TEXT,
      IsSync INTEGER,
      TotCollectionAmount TEXT
    )
  ''';

  static const String milkCollection = '''
  CREATE TABLE MilkCollection (
    Code INTEGER PRIMARY KEY AUTOINCREMENT, 
    AutoID INTEGER, 
    CollDate TEXT, 
    CollTime TEXT, 
    CollSession TEXT, 
    MemCode TEXT, 
    MemName TEXT, 
    Cattle TEXT, 
    Liters TEXT, 
    LitersEntryType INTEGER, 
    FAT TEXT, 
    SNF TEXT, 
    CLR TEXT, 
    FAT_SNF_EntryType INTEGER, 
    Rate TEXT, 
    KgFatRate TEXT, 
    Amount TEXT, 
    Payment_Type INTEGER, 
    Amount_Type INTEGER, 
    ReceiptPrinted INTEGER, 
    SentStatus INTEGER, 
    SentOn TEXT, 
    UploadStatus INTEGER, 
    IsSync INTEGER, 
    SampleNo TEXT, 
    TransactionType TEXT,
    VoucherNo TEXT, 
    IsUpdate INTEGER, 
    KgFat TEXT, 
    KgSnf TEXT, 
    OldWeight TEXT, 
    OldFat TEXT, 
    OldSNF TEXT, 
    OldAmount TEXT, 
    Locked INTEGER, 
    UploadOn TEXT
  )
''';

// Comments for milk collection
// LitersEntryType: 0=AutoReadMachine, 1=Manual(AutoReadFailed), 2=ManualByForceSetup(AutoReadWasPossible)
// FAT_SNF_EntryType: 0=AutoReadMachine, 1=Manual(AutoReadFailed), 2=ManualByForceSetup(AutoReadWasPossible)
// Payment_Type: 0=Fat, 1=Fat+SNF, 2=Fat+CLR
// Amount_Type: 0=RateChartBased, 1=FormulaBased
// SampleNo: RunningSrNo Based On Session
// VoucherNo: Session + Cattle  // MB

  static const String bankMaster = '''
  CREATE TABLE BankMaster (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    BankCode INTEGER,
    BankName TEXT,
    BankShortName TEXT,
    IFSCCode TEXT,
    Location TEXT,
    BankAutoId TEXT,
    BankGujName TEXT,
    BankAccountNo TEXT,
    OpenBalance TEXT,
    IsLoanBank TEXT,
    ReportBankOpenBalance TEXT,
    Remarks TEXT,
    LastUpdate TEXT,
    NoDisplay TEXT,
    BankLocalName TEXT,
    IsClose TEXT
  )
''';
// Comments
// BankShortName: 0=COW, 1=BUFFALO

  static const String settingsDevices = '''
  CREATE TABLE Settings_Devices (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    DeviceType INTEGER,
    Brand INTEGER,
    BrandName TEXT,
    BAUDRate TEXT,
    Parity TEXT,
    DataBits TEXT,
    StringSliceFrom TEXT,
    IsSync INTEGER,
    StringSliceTo TEXT
  )
''';

// Comments
// DeviceType: 0=MilkAnalyzer, 1=WeighingScale, 2=RemoteDisplay, 3=ThermalPrinter
// Brand: 0=Internal (Akashganga), 2=External

  static const String settingsSession = '''
  CREATE TABLE Settings_Session (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    MSessStartTime TEXT,
    MSessEndTime TEXT,
    ESessStartTime TEXT,
    ESessEndTime TEXT,
    IsSync INTEGER,
    SessGraceTime TEXT
  )
''';

// Comments
// SessGraceTime: Time in minutes

  static const String settingsData = '''
  CREATE TABLE Settings_Data (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    AllowZeroFAT INTEGER,
    AllowZeroSNF INTEGER,
    FATDecPoints TEXT,
    SNFDecPoints TEXT,
    RejectionCowMinFAT TEXT,
    RejectionBuffMinFAT TEXT,
    RejectionCowMaxFAT TEXT,
    RejectionBuffMaxFAT TEXT,
    RejectionCowMinSNF TEXT,
    RejectionBuffMinSNF TEXT,
    RejectionCowMaxSNF TEXT,
    RejectionBuffMaxSNF TEXT,
    SendAlertSMS INTEGER,
    SendAlertMail INTEGER,
    AllowLiterManual INTEGER,
    IsSync INTEGER,
    AllowSNFFATManual INTEGER
  )
''';

// Comments
// AllowZeroFAT: Whether FAT can be zero
// AllowZeroSNF: Whether SNF can be zero

  static const String settingsRate = '''
  CREATE TABLE Settings_Rate (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    RateDecimalPoints TEXT,
    PaymentType INTEGER,
    PaymentOn INTEGER,
    BuffCommissionRate TEXT,
    CowCommissionRate TEXT,
    CowGrade1Factor TEXT,
    CowGrade2Factor TEXT,
    CowGrade3Factor TEXT,
    PrintSNF_FATRate INTEGER,
    PrintKG_FATRate INTEGER,
    FATDensity TEXT,
    Incentive TEXT,
    IsSync INTEGER,
    IncentiveMinFAT TEXT
  )
''';

// Comments
// PaymentType: 0=FAT, 1=FAT+SNF, 2=FAT+CLR
// PaymentOn: 0=BasedOnRateChart, 1=BasedOnFormula

  static const String membersProfile = '''
  CREATE TABLE MembersProfile (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    MemCode TEXT,
    Fname TEXT,
    Mname TEXT,
    Lname TEXT,
    MemberName TEXT,
    DOB TEXT,
    MobileNumber TEXT,
    MobileOTP TEXT,
    MobileVerified INTEGER,
    Add1 TEXT,
    Add2 TEXT,
    Add3 TEXT,
    City TEXT,
    State TEXT,
    Country TEXT,
    PIN INTEGER,
    NoOfCows INTEGER,
    NoOfBuffalos INTEGER,
    NoOfOtherCattles INTEGER,
    Gender INTEGER,
    NomineeName TEXT,
    NomineeRelation TEXT,
    AdharNo TEXT,
    PAN TEXT,
    BankName TEXT,
    IFSCNumber TEXT,
    BankAccountNo TEXT,
    BPLNumber TEXT,
    IsMember INTEGER,
    IsCommitteeMember INTEGER,
    IsSync INTEGER,
    Photo TEXT,
    CattleTypeName TEXT,
    BankCode TEXT
  )
''';

// Comments
// MobileVerified: 1=Verified, 0=Not Verified
// Gender: 0=Male, 1=Female, 2=Other
// IsMember: 1=Yes, 0=No
// IsCommitteeMember: 1=Yes, 0=No

  static const String fatSnfBasedRateChart = '''
  CREATE TABLE FATSNFBasedRateChart (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    ID INTEGER,
    LocationCode INTEGER,
    EffectiveDate TEXT,
    CattleType INTEGER,
    FAT REAL,
    SNF REAL,
    Rate REAL,
    Locked INTEGER
  )
''';

// Comments
// CattleType: 0=COW, 1=BUFFALO

  static const String fatBasedRateChart = '''
  CREATE TABLE FATBasedRateChart (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    ID INTEGER,
    LocationCode INTEGER,
    EffectiveDate TEXT,
    CattleType INTEGER,
    Grade INTEGER,
    FromFat REAL,
    ToFat REAL,
    Rate REAL,
    Locked INTEGER
  )
''';

// Comments
// CattleType: 0=COW, 1=BUFFALO

  static const String fatBasedRateChartManual = '''
  CREATE TABLE FATBasedRateChartManual (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    ID INTEGER,
    LocationCode INTEGER,
    EffectiveDate TEXT,
    CattleType INTEGER,
    Grade INTEGER,
    FromFat REAL,
    ToFat REAL,
    Rate REAL,
    Locked INTEGER
  )
''';

// Comments
// CattleType: 0=COW, 1=BUFFALO

  static const String fatBasedRateChartManualExcel = '''
  CREATE TABLE FATBasedRateChartManualExcel (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    ID INTEGER,
    EffectiveDate TEXT,
    CattleType TEXT,
    SNF REAL,
    FAT_0_5 REAL, FAT_0_6 REAL, FAT_0_7 REAL, FAT_0_8 REAL, FAT_0_9 REAL,
    FAT_1_0 REAL, FAT_1_1 REAL, FAT_1_2 REAL, FAT_1_3 REAL, FAT_1_4 REAL, FAT_1_5 REAL, FAT_1_6 REAL, FAT_1_7 REAL, FAT_1_8 REAL, FAT_1_9 REAL,
    FAT_2_0 REAL, FAT_2_1 REAL, FAT_2_2 REAL, FAT_2_3 REAL, FAT_2_4 REAL, FAT_2_5 REAL, FAT_2_6 REAL, FAT_2_7 REAL, FAT_2_8 REAL, FAT_2_9 REAL,
    FAT_3_0 REAL, FAT_3_1 REAL, FAT_3_2 REAL, FAT_3_3 REAL, FAT_3_4 REAL, FAT_3_5 REAL, FAT_3_6 REAL, FAT_3_7 REAL, FAT_3_8 REAL, FAT_3_9 REAL,
    FAT_4_0 REAL, FAT_4_1 REAL, FAT_4_2 REAL, FAT_4_3 REAL, FAT_4_4 REAL, FAT_4_5 REAL, FAT_4_6 REAL, FAT_4_7 REAL, FAT_4_8 REAL, FAT_4_9 REAL,
    FAT_5_0 REAL, FAT_5_1 REAL, FAT_5_2 REAL, FAT_5_3 REAL, FAT_5_4 REAL, FAT_5_5 REAL, FAT_5_6 REAL, FAT_5_7 REAL, FAT_5_8 REAL, FAT_5_9 REAL,
    FAT_6_0 REAL, FAT_6_1 REAL, FAT_6_2 REAL, FAT_6_3 REAL, FAT_6_4 REAL, FAT_6_5 REAL, FAT_6_6 REAL, FAT_6_7 REAL, FAT_6_8 REAL, FAT_6_9 REAL,
    FAT_7_0 REAL, FAT_7_1 REAL, FAT_7_2 REAL, FAT_7_3 REAL, FAT_7_4 REAL, FAT_7_5 REAL, FAT_7_6 REAL, FAT_7_7 REAL, FAT_7_8 REAL, FAT_7_9 REAL,
    FAT_8_0 REAL, FAT_8_1 REAL, FAT_8_2 REAL, FAT_8_3 REAL, FAT_8_4 REAL, FAT_8_5 REAL, FAT_8_6 REAL, FAT_8_7 REAL, FAT_8_8 REAL, FAT_8_9 REAL,
    FAT_9_0 REAL, FAT_9_1 REAL, FAT_9_2 REAL, FAT_9_3 REAL, FAT_9_4 REAL, FAT_9_5 REAL, FAT_9_6 REAL, FAT_9_7 REAL, FAT_9_8 REAL, FAT_9_9 REAL,
    FAT_10_0 REAL, FAT_10_1 REAL, FAT_10_2 REAL, FAT_10_3 REAL, FAT_10_4 REAL, FAT_10_5 REAL, FAT_10_6 REAL, FAT_10_7 REAL, FAT_10_8 REAL, FAT_10_9 REAL,
    FAT_11_0 REAL, FAT_11_1 REAL, FAT_11_2 REAL, FAT_11_3 REAL, FAT_11_4 REAL, FAT_11_5 REAL, FAT_11_6 REAL, FAT_11_7 REAL, FAT_11_8 REAL, FAT_11_9 REAL,
    FAT_12_0 REAL, FAT_12_1 REAL, FAT_12_2 REAL, FAT_12_3 REAL, FAT_12_4 REAL, FAT_12_5 REAL
  )
''';

// Comments
// CattleType: 0=COW, 1=BUFFALO
// FAT columns represent different fat percentage rates

  static const String fatBaseRateChartForOnlyFat = '''
  CREATE TABLE FATBaseRateChartForOnlyFat (
    Code INTEGER PRIMARY KEY,
    EffectiveDate TEXT,
    CattleType TEXT,
    FatValue REAL,
    Rate REAL
  )
''';

// Comments
// CattleType: 0=COW, 1=BUFFALO
// FatValue: The percentage of fat in milk

/*
Jay Panchal : Rate Master Related Tables Creation Ends Here
    */

  static const String errorsRecord = '''
  CREATE TABLE ErrorsRecord (
    Code INTEGER PRIMARY KEY,
    TableActivity TEXT,
    TableTime TEXT,
    TableException TEXT,
    MethodName TEXT,
    Description TEXT,
    TypeException TEXT
  )
''';

// Comments
// Code: Unique identifier for error records
// TableActivity: The table where the error occurred
// TableException: The exception message
// MethodName: The function/method that caused the error
// Description: Detailed error description
// TypeException: Type of the exception

  static const String tabConfiguration = '''
  CREATE TABLE TabConfiguration (
    Code INTEGER PRIMARY KEY,
    SocietyName TEXT,
    SocietyCode TEXT,
    Taluka TEXT,
    State TEXT,
    Project TEXT,
    SecretaryName TEXT,
    SecretaryMobile TEXT,
    GSTNO TEXT,
    IsSync INTEGER
  )
''';

// Comments
// SocietyName: Name of the society
// SocietyCode: Unique society identifier
// SecretaryMobile: Contact number of the secretary
// GSTNO: GST number of the society
// IsSync: Flag to indicate if data is synced

  static const String feedback = '''
  CREATE TABLE Feedback (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    FeedbackDateTime TEXT,
    FBFor INTEGER,  -- 0=ForFederation, 1=ForAkashganga
    FBType INTEGER,  -- 0=Query, 1=Information, 2=Complain
    FBSeverity INTEGER,  -- 0=Low, 1=Medium, 2=High
    FBDetails TEXT,
    FBReply TEXT,
    IsSync INTEGER,
    FBReplyDateTime TEXT
  )
''';

// Comments
// FeedbackDateTime: Date and time of feedback submission
// FBFor: Feedback directed to either Federation or Akashganga
// FBType: Type of feedback - Query, Information, or Complaint
// FBSeverity: Feedback severity level - Low, Medium, or High
// FBDetails: User-submitted feedback details
// FBReply: Admin's response to feedback
// IsSync: Status flag for synchronization
// FBReplyDateTime: Date and time when the feedback was replied to

/*
     * oDairyRegister table to store local sale entry, deduction entry, dispatch
     *
     * */

  static const String oDairyRegister = '''
  CREATE TABLE ODairyRegister (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    AutoId INTEGER,
    LocationCode INTEGER,
    CompanyCode INTEGER,
    EntryDate TEXT,
    Session TEXT,
    Category TEXT,
    LastCanNo INTEGER,
    LastCanLiter REAL,
    LocalEntryUserId INTEGER,
    LocalEntryTime TEXT,
    LocalWeight REAL,
    LocalRate REAL,
    LocalAmount REAL,
    IsLocalSaleByCoupon INTEGER,
    SaleGood1Weight REAL,
    SaleGood1Fat REAL,
    SaleGood1SNF REAL,
    SaleGood1KgFat REAL,
    SaleGood1Rate REAL,
    SaleGood1Amount REAL,
    SaleGood2Weight REAL,
    SaleGood2Fat REAL,
    SaleGood2SNF REAL,
    SaleGood2KgFat REAL,
    SaleGood2Rate REAL,
    SaleGood2Amount REAL,
    SaleSourWeight REAL,
    SaleSourFat REAL,
    SaleSourSNF REAL,
    SaleSourKgFat REAL,
    SaleSourRate REAL,
    SaleSourAmount REAL,
    SaleCurdWeight REAL,
    SaleCurdFat REAL,
    SaleCurdSNF REAL,
    SaleCurdKgFat REAL,
    SaleCurdRate REAL,
    SaleCurdAmount REAL,
    SaleEntryTime TEXT,
    SaleEntryUserId INTEGER,
    DairyAmount REAL,
    DairyKgFatRate REAL,
    DairyRate REAL,
    ExpectedDairyWeight REAL,
    ExpectedDairyAmount REAL,
    ExpectedDairyKgFatRate REAL,
    ExpectedDairyRate REAL,
    ExpectedProfitAmount REAL,
    PurchaseGoodRate1 REAL,
    PurchaseGoodRate2 REAL,
    PurchaseGoodRate3 REAL,
    PurchaseCommission REAL,
    AutoWeightPercent REAL,
    AutoFatPercent REAL,
    ManualWeightPercent REAL,
    ManualFatPercent REAL,
    TotalSample INTEGER,
    TotalCan INTEGER,
    IsTruckSlipEntry INTEGER,
    MixedAutoId INTEGER,
    BillFromDate TEXT,
    BillToDate TEXT,
    EntryUserId INTEGER,
    DispatchVoucherNo INTEGER,
    DispatchNoteCan REAL,
    DispatchNoteWeight REAL,
    DispatchNoteFat REAL,
    DispatchNoteSNF REAL,
    DispatchNoteEntryUserId INTEGER,
    DispatchNoteEntryTime TEXT,
    IsManualDispatchNote INTEGER,
    IsMixAmount INTEGER,
    Notes TEXT,
    Remark TEXT,
    LastUpdate TEXT,
    NoDisplay INTEGER,
    SaleGood1Can INTEGER,
    SaleGood2Can INTEGER,
    SaleSourCan INTEGER,
    SaleCurdCan INTEGER,
    SyncDateTime TEXT,
    MilkSlipMessage TEXT,
    IsDelete INTEGER,
    IsEdit INTEGER,
    MilkDispatchAutoId INTEGER,
    PurchaseMilkMembers INTEGER,
    PurchaseMilkWeight REAL,
    PurchaseMilkFat REAL,
    PurchaseMilkSNF REAL,
    PurchaseMilkAmount REAL,
    isSync INTEGER
  )
''';
//**********************************************For Local Sales Entry Screen below are Some Queries***********************************************************//

//Entering dummy data to populate table
  static const String entryInODairy = '''
INSERT INTO ODairyRegister (
    AutoId, LocationCode, CompanyCode, EntryDate, Session, Category,
    LastCanNo, LastCanLiter, LocalEntryUserId, LocalEntryTime, LocalWeight, LocalRate, LocalAmount,
    IsLocalSaleByCoupon, SaleGood1Weight, SaleGood1Fat, SaleGood1SNF, SaleGood1KgFat, SaleGood1Rate, SaleGood1Amount,
    SaleGood2Weight, SaleGood2Fat, SaleGood2SNF, SaleGood2KgFat, SaleGood2Rate, SaleGood2Amount,
    SaleSourWeight, SaleSourFat, SaleSourSNF, SaleSourKgFat, SaleSourRate, SaleSourAmount,
    SaleCurdWeight, SaleCurdFat, SaleCurdSNF, SaleCurdKgFat, SaleCurdRate, SaleCurdAmount,
    SaleEntryTime, SaleEntryUserId, DairyAmount, DairyKgFatRate, DairyRate, ExpectedDairyWeight,
    ExpectedDairyAmount, ExpectedDairyKgFatRate, ExpectedDairyRate, ExpectedProfitAmount,
    PurchaseGoodRate1, PurchaseGoodRate2, PurchaseGoodRate3, PurchaseCommission,
    AutoWeightPercent, AutoFatPercent, ManualWeightPercent, ManualFatPercent,
    TotalSample, TotalCan, IsTruckSlipEntry, MixedAutoId, BillFromDate, BillToDate,
    EntryUserId, DispatchVoucherNo, DispatchNoteCan, DispatchNoteWeight, DispatchNoteFat, DispatchNoteSNF,
    DispatchNoteEntryUserId, DispatchNoteEntryTime, IsManualDispatchNote, IsMixAmount, Notes, Remark, LastUpdate,
    NoDisplay, SaleGood1Can, SaleGood2Can, SaleSourCan, SaleCurdCan, SyncDateTime, MilkSlipMessage,
    IsDelete, IsEdit, MilkDispatchAutoId, PurchaseMilkMembers, PurchaseMilkWeight, PurchaseMilkFat,
    PurchaseMilkSNF, PurchaseMilkAmount, isSync
) VALUES (
    1, 101, 1001,'2025-03-27','M','B',
    5, 50.0, 1, '2025-03-17 08:00:00', 100.0, 50.0, 5000.0,
    0, NULL, NULL, 8.5, NULL, 45.0, 900.0,
    15.0, 4.2, 8.2, 0.8, 42.0, 630.0,
    10.0, 3.8, 7.8, 0.7, 38.0, 380.0,
    8.0, 3.5, 7.5, 0.6, 35.0, 280.0,
    '2025-03-17 09:00:00', 2, 2000.0, 42.5, 40.0, 95.0,
    3800.0, 40.0, 38.0, 200.0,
    35.0, 33.0, 30.0, 5.0,
    98.0, 3.2, 97.0, 3.5,
    10, 5, 0, 2, '2025-03-17', '2025-03-18',
    3, NULL, 2, 20, 4.0, 8.0,
    4, '2025-03-17 10:00:00', 0, 1, 'No issues', 'Good quality', '2025-03-17 11:00:00',
    0, 3, 2, 1, 1, '2025-03-17 12:00:00', 'Milk ready',
    0, 0, 10, 5, 200.0, 4.0,
    8.0, 760.0, 1
);
  ''';

//Deleting all dummy data to clean table
  static const String deleteAllInODairy = '''
    DELETE FROM ODairyRegister;
  ''';

//Deleting all dummy data to clean table
  static const String updateCodeInODairy =
      "UPDATE sqlite_sequence SET seq = 0 WHERE name = 'ODairyRegister'";

//1) Checking if data exists for the given selection
  static Future<String> selectQueryODairy(
      {required String selectedDate,
      required String selectedSession,
      required String selectedCattleType}) {
    String query =
        "Select Code,PurchaseMilkWeight From ODairyRegister WHERE EntryDate='$selectedDate' AND Session='$selectedSession' AND Category='$selectedCattleType' AND DispatchVoucherNo ISNULL AND DispatchNoteWeight ISNULL";
    return Future.value(query);
  }

  //2) Fetching the sale volume Retrieves the LocalWeight (sold milk volume) for the specific record identified by Code = oDairyCode.first.
  static Future<String> selectQueryLocalWeightODairy({
    required String code,
  }) {
    String query = "Select LocalWeight FROM ODairyRegister WHERE Code='$code'";
    return Future.value(query);
  }

  //3) Updating an existing entry if a sale is recorded
  static Future<String> updateODairyRegister({
    required String code,
    required String selectedDate,
    required String selectedTime,
    required int userCode,
    required double selectedVolume,
    required double selectedRate,
    required double selectedAmount,
    required double oldWeight,
  }) {
    String query =
        "UPDATE ODairyRegister SET LocalEntryUserId = $userCode, LocalEntryTime = '$selectedDate $selectedTime', LocalWeight = IFNULL(LocalWeight, 0) + ($selectedVolume - $oldWeight), LocalRate = '$selectedRate', LocalAmount = IFNULL(LocalAmount, 0) + $selectedAmount, isSync = '0' WHERE Code = '$code'";
    return Future.value(query);
  }

  //4) Updating an existing entry if a sale is not recorded
  static Future<String> updateODairyRegisterNot({
    required String code,
    required String selectedDate,
    required String selectedTime,
    required int userCode,
    required double selectedVolume,
    required double selectedRate,
    required double selectedAmount,
    required double oldWeight,
  }) {
    String query =
        "UPDATE ODairyRegister SET LocalEntryUserId = $userCode, LocalEntryTime = '$selectedDate $selectedTime', LocalWeight = IFNULL(LocalWeight, 0) + $selectedVolume, LocalRate = '$selectedRate', LocalAmount = IFNULL(LocalAmount, 0) + $selectedAmount, isSync = '0' WHERE Code = '$code'";
    return Future.value(query);
  }

  //5 Get Local Sale
  static Future<String> getLocalSalesByDate({
    required String selectedDateVal,
  }) {
    String query = """
    SELECT Code, LocationCode, EntryDate, Session, Category, LocalEntryTime, 
           LocalWeight, LocalRate, LocalAmount
    FROM ODairyRegister
    WHERE EntryDate = '$selectedDateVal' AND LocalWeight IS NOT NULL
  """;

    return Future.value(query);
  }

  //**********************************************For Dispatch Slip Entry Screen below are Some Queries***********************************************************//
  //1 Query to get Code and PurchaseMilkWeight from ODairyRegister
  static Future<String> selectDispatchSlipScreenODairy({
    required String selectedDate,
    required String selectedSession,
    required String selectedCattle,
  }) {
    String query =
        "SELECT Code, PurchaseMilkWeight FROM ODairyRegister WHERE EntryDate='$selectedDate' "
        "AND Session='$selectedSession' AND Category='$selectedCattle' "
        "AND DispatchVoucherNo IS NULL AND DispatchNoteWeight IS NULL";
    return Future.value(query);
  }

  //2 Query to get Local Weight from ODairyRegister
  static Future<String> selectLocalWeightDispatchSlipScreenODairy({
    required String code,
  }) {
    String query = "SELECT LocalWeight FROM ODairyRegister WHERE Code='$code'";
    return Future.value(query);
  }

  //3 Query to update ODairyRegister
  static Future<String> updateODairyRegisterDispatchSlipScreenODairy(
      {required String dispatchNoteEntryTime,
      required String selectedDate,
      required String voucherSession,
      required String voucherCattle,
      required String code,
      required String kgVolume,
      required String cans}) {
    String query = "UPDATE ODairyRegister SET DispatchNoteEntryUserId='1', "
        "DispatchNoteEntryTime='$dispatchNoteEntryTime', "
        "DispatchNoteFat=PurchaseMilkFat, "
        "DispatchVoucherNo='${selectedDate.replaceAll("-", "")}$voucherSession$voucherCattle', "
        "DispatchNoteSNF=PurchaseMilkSNF, "
        "DispatchNoteCan='${cans.trim()}', "
        "DispatchNoteWeight='${kgVolume.trim()}', isSync='0' "
        "WHERE Code='${code}'";
    return Future.value(query);
  }

  //4 Get Dispatch Sale
  static Future<String> getDispatchSlipByDate({
    required String selectedDateVal,
  }) {
    String query = """
  SELECT Code, LocationCode, EntryDate, Session, Category, DispatchVoucherNo, DispatchNoteEntryTime, 
         DispatchNoteCan, DispatchNoteWeight, DispatchNoteFat, DispatchNoteSNF, DispatchNoteEntryUserId
  FROM ODairyRegister
  WHERE EntryDate = '$selectedDateVal' AND DispatchNoteWeight IS NOT NULL
  """;

    return Future.value(query);
  }

  //**********************************************For Union Truck Slip Entry Screen below are Some Queries***********************************************************//
  //1 Query to get ODairyCodeBuff from ODairyRegister
  static Future<String> selectQueryOdairyCodeBuff({
    required String selectedDate,
    required String selectedSession,
  }) {
    String query = """
    SELECT Code, PurchaseMilkWeight FROM ODairyRegister
    WHERE EntryDate ='$selectedDate'
    AND Session ='$selectedSession'
    AND Category ='B'
    AND SaleGood1Weight IS NULL
    AND SaleGood1KgFat IS NULL
""";
    return Future.value(query);
  }

  //2 Query to get ODairyCodeCow from ODairyRegister
  static Future<String> selectQueryOdairyCodeCow({
    required String selectedDate,
    required String selectedSession,
  }) {
    String query = """
    SELECT Code, PurchaseMilkWeight FROM ODairyRegister
    WHERE EntryDate ='$selectedDate'
    AND Session ='$selectedSession'
    AND Category ='C'
    AND SaleGood1Weight IS NULL
    AND SaleGood1KgFat IS NULL
""";
    return Future.value(query);
  }

  //3 Query to get saleDispatchBuff from ODairyRegister
  static Future<String> selectQuerySaleDispatchBuff({
    required String code,
  }) {
    String query = "SELECT DispatchNoteWeight FROM ODairyRegister "
        "WHERE Code = '$code' AND DispatchNoteWeight IS NOT NULL";
    return Future.value(query);
  }

  //4 Query to get saleDispatchCow from ODairyRegister
  static Future<String> selectQuerySaleDispatchCow({
    required String code,
  }) {
    String query = "SELECT DispatchNoteWeight FROM ODairyRegister "
        "WHERE Code = '$code' AND DispatchNoteWeight IS NOT NULL";
    return Future.value(query);
  }

  //5 Query to update bufffalo data for ODairyRegister
  static Future<String> updateQueryBuffODairyRegister({
    required String code,
    required String selectedVolBuff,
    required String selectedFatBuff,
    required String selectedSnfBuff,
    required String selectedAmountBuff,
  }) {
    String saleGood1KgFat =
        (double.parse(selectedVolBuff) * double.parse(selectedFatBuff) / 100)
            .toStringAsFixed(2);
    String query = """
UPDATE ODairyRegister SET 
  SaleGood1Weight = '${selectedVolBuff ?? "0"}',
  SaleGood1Fat = '${selectedFatBuff ?? "0"}',
  SaleGood1SNF = '${selectedSnfBuff ?? "0"}',
  SaleGood1KgFat = '${saleGood1KgFat ?? "0"}',
  SaleGood1Amount = '${selectedAmountBuff ?? "0"}',
  isSync = '0'
WHERE Code = '${code ?? "0"}'
""";
    return Future.value(query);
  }

  //6 Query to update cow data for ODairyRegister
  static Future<String> updateQueryCowODairyRegister({
    required String code,
    required String selectedVolCow,
    required String selectedFatCow,
    required String selectedSnfCow,
    required String selectedAmountCow,
  }) {
    String saleGood1KgFat =
        (double.parse(selectedVolCow) * double.parse(selectedFatCow) / 100)
            .toStringAsFixed(2);
    String query = "UPDATE ODairyRegister SET " +
        "SaleGood1Weight = ${selectedVolCow ?? 0}, " +
        "SaleGood1Fat = ${selectedFatCow ?? 0}, " +
        "SaleGood1SNF = ${selectedSnfCow ?? 0}, " +
        "SaleGood1KgFat = ${saleGood1KgFat ?? 0}, " +
        "SaleGood1Amount = ${selectedAmountCow ?? 0}, " +
        "isSync = 0 " +
        "WHERE Code = ${code ?? 0}";
    return Future.value(query);
  }

  //5 Get Local Sale
  static Future<String> getUnionTruckBuffCowQuery({
    required String selectedDateVal,
  }) {
    String query = """
    SELECT Code, LocationCode, EntryDate, Session, Category,
           SaleGood1Weight, SaleGood1Fat, SaleGood1SNF,
           SaleGood1KgFat, SaleGood1Rate, SaleGood1Amount
    FROM ODairyRegister
    WHERE EntryDate = '$selectedDateVal' AND SaleGood1Weight IS NOT NULL
  """;

    return Future.value(query);
  }

  //**********************************************For Deduction Entry Screen below are Some Queries***********************************************************//
  //1 Query to check if deduction amount is greater than total or sum amount

  static Future<String> selectGetTotalAmount({
    required String memCode,
    required String selectedDate,
  }) {
    String query = """
    SELECT SUM(Amount) AS Amount 
    FROM MilkCollection 
    WHERE MemCode = '$memCode' 
      AND CollDate = '$selectedDate' 
      AND Locked <> '1'
  """;

    return Future.value(query);
  }

  //2 Query to max auto code local
  static Future<String> selectGetMaxAutoCode() {
    String query = "Select Max(AutoId) From DeductionEntry";
    return Future.value(query);
  }

  //3 Query to insert data in DeductionEntry
  static Future<String> insertDeductionEntry({
    required String autoId,
    required String selectedMemCode,
    required String selectedDate,
    required String selectedDeductionType,
    required String selectedQty,
    required String selectedRate,
    required String selectedAmount,
    required String selectedLocationCode,
  }) async {
    String query =
        "${"Insert INTO DeductionEntry(AutoId,LocationCode,MemberCode,VoucherDate,VoucherNo,DeductionType,Qty,Rate,Amount,isSync)Values('$autoId','$selectedLocationCode','$selectedMemCode','$selectedDate','" + selectedDate.replaceAll("-", "")}','$selectedDeductionType','$selectedQty','$selectedRate','$selectedAmount','0')";
    return Future.value(query);
  }

  static Future<String> selectDeductionEntriesByDate({
    required String selectedDateVal,
  }) {
    String query = """
    SELECT * 
    FROM DeductionEntry 
    WHERE VoucherDate = '$selectedDateVal'
  """;

    return Future.value(query);
  }

//Dummy Milk Collection Insert Query
  static Future<String> insertDummyMilkCollection() async {
    String query = '''
  INSERT INTO MilkCollection (
    AutoID, CollDate, CollTime, CollSession, MemCode, MemName, Cattle, Liters, 
    LitersEntryType, FAT, SNF, CLR, FAT_SNF_EntryType, Rate, KgFatRate, Amount, 
    Payment_Type, Amount_Type, ReceiptPrinted, SentStatus, SentOn, UploadStatus, 
    IsSync, SampleNo, VoucherNo, IsUpdate, KgFat, KgSnf, OldWeight, OldFat, 
    OldSNF, OldAmount, Locked, UploadOn
  ) VALUES (
    1, '2025-03-26', '10:30 AM', 'Morning', '0012', 'John Doe', 'Cow', '5.5', 
    1, '3.8', '8.5', '28', 1, '45', '50', '247.5', 
    1, 1, 0, 0, NULL, 0, 
    0, 'S001', 'V12345', 0, '1.2', '2.5', '5.3', '3.9', 
    '8.1', '220', 0, NULL
  )
''';
    return Future.value(query);
  }

  //**********************************************For Member Slip Screen below are Some Queries***********************************************************//
  //1 Query to get ODairyCodeBuff from ODairyRegister
  static Future<String> selectMilkCollectionMemberSlip({
    required String selectedDate,
    required String selectedSession,
    required String allMemberCode,
  }) {
    /* String query = """
    SELECT Code, AutoID, MemCode, CollDate, CollTime, COUNT(CollSession) AS CollSession,
    printf('%.2f', SUM(KgFat) / SUM(Liters)) AS FAT, SUM(Amount) AS Amount, SUM(Liters) AS Liters,
    group_concat(Cattle) AS Cattle, LitersEntryType, printf('%.2f', SUM(KgSnf) / SUM(Liters)) AS SNF, 
    AVG(CLR) AS CLR, FAT_SNF_EntryType, AVG(Rate) AS Rate, Amount_Type, ReceiptPrinted, SentStatus,
    SentOn, UploadStatus, UploadOn, IsSync, SampleNo, VoucherNo, IsUpdate, MemName, KgFatRate, 
    Payment_Type, Locked, KgFat, KgSnf, OldWeight, OldFat, OldSNF, OldAmount 
    FROM MilkCollection 
    WHERE CollDate = '$selectedDate' 
    AND CollSession = '$selectedSession' 
    AND MemCode IN ($allMemberCode) 
    AND Locked <> '1' 
    GROUP BY MemCode
""";*/
    String query = """
    SELECT Code, AutoID, MemCode, CollDate, CollTime, CollSession,
    printf('%.2f', KgFat / Liters) AS FAT,
    Amount, Liters, Cattle, LitersEntryType,
    printf('%.2f', KgSnf / Liters) AS SNF, 
    CLR, FAT_SNF_EntryType, Rate, Amount_Type, ReceiptPrinted, 
    SentStatus, SentOn, UploadStatus, UploadOn, IsSync, SampleNo, 
    VoucherNo, IsUpdate, MemName, KgFatRate, Payment_Type, Locked, 
    KgFat, KgSnf, OldWeight, OldFat, OldSNF, OldAmount 
    FROM MilkCollection 
    WHERE CollDate = '$selectedDate' 
    AND CollSession = '$selectedSession' 
    AND MemCode IN ($allMemberCode) 
    AND Locked <> '1'
""";
    return Future.value(query);
  }

  //**********************************************For Session Report below are Some Queries***********************************************************//
  //1 Select query to get ODairyCodeBuff from ODairyRegister
  static Future<String> sessionReportODairyCodeBuff({
    required String selectedDate,
    required String selectedSession,
  }) {
    String query =
        """SELECT IFNULL(SaleGood1Fat, '0'),IFNULL(SaleGood1SNF, '0') FROM ODairyRegister WHERE EntryDate = '$selectedDate' AND Session = '$selectedSession' AND Category = 'B';""";
    return Future.value(query);
  }

  //2 Select query to get ODairyCodeCow from ODairyRegister
  static Future<String> sessionReportODairyCodeCow({
    required String selectedDate,
    required String selectedSession,
  }) {
    String query =
        """SELECT IFNULL(SaleGood1Fat, '0'),IFNULL(SaleGood1SNF, '0') FROM ODairyRegister WHERE EntryDate = '$selectedDate' AND Session = '$selectedSession' AND Category = 'C';""";
    return Future.value(query);
  }

  //3 Update query to update Milk Collection table with buff
  static Future<String> sessionReportODairyCodeBuffUpdate({
    required String buffFat,
    required String buffSnf,
    required String selectedDate,
    required String selectedSession,
  }) {
    String query =
        "Update MilkCollection set FAT ='$buffFat' , SNF = '$buffSnf', IsSync='0' WHERE CollDate='$selectedDate' AND CollSession='$selectedSession' AND Cattle='B' AND CAST(FAT AS REAL)<='0'  AND CAST(SNF AS REAL)<='0'";
    return Future.value(query);
  }

  //4 Update query to update Milk Collection table with cow
  static Future<String> sessionReportODairyCodeCowUpdate({
    required String cowFat,
    required String cowSnf,
    required String selectedDate,
    required String selectedSession,
  }) {
    String query =
        "Update MilkCollection set FAT ='$cowFat' , SNF = '$cowSnf', IsSync='0' WHERE CollDate='$selectedDate' AND CollSession='$selectedSession' AND Cattle='C' AND CAST(FAT AS REAL)<='0'  AND CAST(SNF AS REAL)<='0'";
    return Future.value(query);
  }

  //5 Below query is used to select values from milk collection table for cow when milkColEntryType is 1
  static Future<String> sessionReportSelectMilkCollectionCowIs1({
    required String selectedDate,
    required String selectedSession,
    required String selectedOrderBy,
  }) {
    String query = """
    SELECT Code, AutoID, MemCode, CollDate, CollTime, 
           printf('%.2f', AVG(FAT)) AS FAT, 
           printf('%.2f', SUM(Amount)) AS Amount, 
           printf('%.2f', SUM(Liters)) AS Liters,
           Cattle, LitersEntryType, 
           printf('%.2f', AVG(SNF)) AS SNF, 
           AVG(CLR) AS CLR, 
           FAT_SNF_EntryType, 
           AVG(Rate) AS Rate, 
           Amount_Type, ReceiptPrinted, SentStatus, SentOn, 
           UploadStatus, UploadOn, IsSync, SampleNo, VoucherNo, 
           IsUpdate, MemName, KgFatRate, Payment_Type, Locked, 
           KgFat, KgSnf, OldWeight, OldFat, OldSNF, OldAmount 
    FROM MilkCollection 
    WHERE CollDate = '$selectedDate' 
    AND CollSession = '$selectedSession' 
    AND Cattle = 'C' 
    AND Locked <> '1' 
    GROUP BY MemCode, Cattle 
    ORDER BY $selectedOrderBy;
""";
    return Future.value(query);
  }

  //6 Below query is used to select values from milk collection table for cow when milkColEntryType is not 1
  static Future<String> sessionReportSelectMilkCollectionCowNot1({
    required String selectedDate,
    required String selectedSession,
    required String selectedOrderBy,
  }) {
    String query = """
    SELECT Code, AutoID, MemCode, CollDate, CollTime, CollSession,
           printf('%.2f', (SUM(KgFat) / SUM(Liters))) AS FAT, 
           printf('%.2f', SUM(Amount)) AS Amount, 
           printf('%.2f', SUM(Liters)) AS Liters,
           Cattle, LitersEntryType, 
           printf('%.2f', (SUM(KgSnf) / SUM(Liters))) AS SNF, 
           AVG(CLR) AS CLR, 
           FAT_SNF_EntryType, 
           AVG(Rate) AS Rate, 
           Amount_Type, ReceiptPrinted, SentStatus, SentOn, 
           UploadStatus, UploadOn, IsSync, SampleNo, VoucherNo, 
           IsUpdate, MemName, KgFatRate, Payment_Type, Locked, 
           KgFat, KgSnf, OldWeight, OldFat, OldSNF, OldAmount 
    FROM MilkCollection 
    WHERE CollDate = '$selectedDate' 
    AND CollSession = '$selectedSession' 
    AND Cattle = 'C' 
    AND Locked <> '1' 
    GROUP BY MemCode, Cattle 
    ORDER BY $selectedOrderBy;
""";
    return Future.value(query);
  }

  //7 Below query is used to select values from milk collection table for buff when milkColEntryType is  1
  static Future<String> sessionReportSelectMilkCollectionBuffIs1({
    required String selectedDate,
    required String selectedSession,
    required String selectedOrderBy,
  }) {
    String query = """
    SELECT Code, AutoID, MemCode, MemName, CollDate, CollTime, CollSession,
           printf('%.2f', AVG(FAT)) AS FAT, 
           printf('%.2f', SUM(Amount)) AS Amount, 
           printf('%.2f', SUM(Liters)) AS Liters,
           Cattle, LitersEntryType, 
           printf('%.2f', AVG(SNF)) AS SNF, 
           AVG(CLR) AS CLR, 
           FAT_SNF_EntryType, 
           AVG(Rate) AS Rate, 
           Amount_Type, ReceiptPrinted, SentStatus, SentOn, 
           UploadStatus, UploadOn, IsSync, SampleNo, VoucherNo, 
           IsUpdate, MemName, KgFatRate, Payment_Type, Locked, 
           KgFat, KgSnf, OldWeight, OldFat, OldSNF, OldAmount 
    FROM MilkCollection 
    WHERE CollDate = '$selectedDate' 
    AND CollSession = '$selectedSession' 
    AND Cattle = 'B' 
    AND Locked <> '1' 
    GROUP BY MemCode, Cattle 
    ORDER BY $selectedOrderBy;
""";
    return Future.value(query);
  }

  //8 Below query is used to select values from milk collection table for buff when milkColEntryType is not 1
  static Future<String> sessionReportSelectMilkCollectionBuffNot1({
    required String selectedDate,
    required String selectedSession,
    required String selectedOrderBy,
  }) {
    String query = """
    SELECT Code, AutoID, MemCode, MemName, CollDate, CollTime, CollSession,
           printf('%.2f', (SUM(KgFat) / SUM(Liters))) AS FAT, 
           printf('%.2f', SUM(Amount)) AS Amount, 
           printf('%.2f', SUM(Liters)) AS Liters,
           Cattle, LitersEntryType, 
           printf('%.2f', (SUM(KgSnf) / SUM(Liters))) AS SNF, 
           AVG(CLR) AS CLR, 
           FAT_SNF_EntryType, 
           AVG(Rate) AS Rate, 
           Amount_Type, ReceiptPrinted, SentStatus, SentOn, 
           UploadStatus, UploadOn, IsSync, SampleNo, VoucherNo, 
           IsUpdate, MemName, KgFatRate, Payment_Type, Locked, 
           KgFat, KgSnf, OldWeight, OldFat, OldSNF, OldAmount 
    FROM MilkCollection 
    WHERE CollDate = '$selectedDate' 
    AND CollSession = '$selectedSession' 
    AND Cattle = 'B' 
    AND Locked <> '1' 
    GROUP BY MemCode, Cattle 
    ORDER BY $selectedOrderBy;
""";
    return Future.value(query);
  }

  //**********************************************For Kapat Report below are Some Queries***********************************************************//
  //1 Select query to get deduction entry table values
  static Future<String> kapatReportSelectDeduction({
    required String selectedStartDate,
    required String selectedEndDate,
  }) {
    String query = """
    SELECT *
    FROM DeductionEntry 
    WHERE VoucherDate BETWEEN '$selectedStartDate' 
    AND '$selectedEndDate' 
""";
    return Future.value(query);
  }

  //**********************************************For Local Milk Sales Register Report below are Some Queries***********************************************************//
  //1 Select query to get ODairyRegister entry table values
  static Future<String> milkSalesReportSelect({
    required String selectedStartDate,
    required String selectedEndDate,
  }) {
    String query = """
    SELECT *
    FROM ODairyRegister 
    WHERE LocalEntryTime BETWEEN '$selectedStartDate 00:00:00'
    AND '$selectedEndDate 23:59:59' 
    GROUP BY Session, Category
""";
    return Future.value(query);
  }

  //2 Dummy Insert query for ODAiryRegister to check data
  static const String entryInODairyLocalSalesReport = '''
INSERT INTO ODairyRegister (
    AutoId, LocationCode, CompanyCode, EntryDate, Session, Category,
    LastCanNo, LastCanLiter, LocalEntryUserId, LocalEntryTime, LocalWeight, LocalRate, LocalAmount,
    IsLocalSaleByCoupon, SaleGood1Weight, SaleGood1Fat, SaleGood1SNF, SaleGood1KgFat, SaleGood1Rate, SaleGood1Amount,
    SaleGood2Weight, SaleGood2Fat, SaleGood2SNF, SaleGood2KgFat, SaleGood2Rate, SaleGood2Amount,
    SaleSourWeight, SaleSourFat, SaleSourSNF, SaleSourKgFat, SaleSourRate, SaleSourAmount,
    SaleCurdWeight, SaleCurdFat, SaleCurdSNF, SaleCurdKgFat, SaleCurdRate, SaleCurdAmount,
    SaleEntryTime, SaleEntryUserId, DairyAmount, DairyKgFatRate, DairyRate, ExpectedDairyWeight,
    ExpectedDairyAmount, ExpectedDairyKgFatRate, ExpectedDairyRate, ExpectedProfitAmount,
    PurchaseGoodRate1, PurchaseGoodRate2, PurchaseGoodRate3, PurchaseCommission,
    AutoWeightPercent, AutoFatPercent, ManualWeightPercent, ManualFatPercent,
    TotalSample, TotalCan, IsTruckSlipEntry, MixedAutoId, BillFromDate, BillToDate,
    EntryUserId, DispatchVoucherNo, DispatchNoteCan, DispatchNoteWeight, DispatchNoteFat, DispatchNoteSNF,
    DispatchNoteEntryUserId, DispatchNoteEntryTime, IsManualDispatchNote, IsMixAmount, Notes, Remark, LastUpdate,
    NoDisplay, SaleGood1Can, SaleGood2Can, SaleSourCan, SaleCurdCan, SyncDateTime, MilkSlipMessage,
    IsDelete, IsEdit, MilkDispatchAutoId, PurchaseMilkMembers, PurchaseMilkWeight, PurchaseMilkFat,
    PurchaseMilkSNF, PurchaseMilkAmount, isSync
) VALUES (
    1, 101, 1001,'2025-03-27','M','B',
    5, 50.0, 1, '2025-03-31 08:00:00', 100.0, 50.0, 5000.0,
    0, NULL, NULL, 8.5, NULL, 45.0, 900.0,
    15.0, 4.2, 8.2, 0.8, 42.0, 630.0,
    10.0, 3.8, 7.8, 0.7, 38.0, 380.0,
    8.0, 3.5, 7.5, 0.6, 35.0, 280.0,
    '2025-03-17 09:00:00', 2, 2000.0, 42.5, 40.0, 95.0,
    3800.0, 40.0, 38.0, 200.0,
    35.0, 33.0, 30.0, 5.0,
    98.0, 3.2, 97.0, 3.5,
    10, 5, 0, 2, '2025-03-17', '2025-03-18',
    3, NULL, 2, 20, 4.0, 8.0,
    4, '2025-03-17 10:00:00', 0, 1, 'No issues', 'Good quality', '2025-03-17 11:00:00',
    0, 3, 2, 1, 1, '2025-03-17 12:00:00', 'Milk ready',
    0, 0, 10, 5, 200.0, 4.0,
    8.0, 760.0, 1
);
  ''';

//**********************************************For Dairy Register Report below are Some Queries***********************************************************//
  //1 Select query to get ODairyRegister entry table values
  static Future<String> dairyRegisterReportSelect({
    required String selectedStartDate,
    required String selectedEndDate,
  }) {
    String query = """
    SELECT *
    FROM ODairyRegister 
    WHERE EntryDate BETWEEN '$selectedStartDate'
    AND '$selectedEndDate' 
    ORDER BY Category
""";
    return Future.value(query);
  }

  //**********************************************For Payment Register Report below are Some Queries***********************************************************//
  //1 Select query to get ODairyRegister entry table values
  static Future<String> paymentRegisterReportSelect({
    required String selectedStartDate,
    required String selectedEndDate,
  }) {
    String query = """
    SELECT * FROM (
        SELECT 
            a.Code, a.AutoID, a.MemCode, a.CollDate, a.CollTime, COUNT(a.CollSession) AS CollSession,
            printf('%.2f', SUM(a.KgFat) / SUM(a.Liters)) AS FAT, 
            printf('%.2f', SUM(a.Amount)) AS Amount,
            printf('%.2f', SUM(a.Liters)) AS Liters, 
            a.Cattle, a.LitersEntryType,
            printf('%.2f', SUM(a.KgSnf) / SUM(a.Liters)) AS SNF, 
            AVG(a.CLR) AS CLR, 
            a.FAT_SNF_EntryType,
            printf('%.2f', AVG(a.Rate)) AS Rate, 
            a.Amount_Type, a.ReceiptPrinted, a.SentStatus, a.SentOn,
            a.UploadStatus, a.UploadOn, a.IsSync, a.SampleNo, a.VoucherNo, 
            a.IsUpdate, a.MemName, a.KgFatRate, a.Payment_Type, a.Locked,
            a.KgFat, a.KgSnf, a.OldWeight, a.OldFat, a.OldSNF, a.OldAmount,
            b.DeductionType, b.Amount AS DeductionAmount, 1 AS ViewType
        FROM MilkCollection a
        LEFT OUTER JOIN (
            SELECT 
                MemberCode, 
                GROUP_CONCAT(DeductionType) AS DeductionType, 
                SUM(Amount) AS Amount 
            FROM DeductionEntry
            WHERE VoucherDate BETWEEN '$selectedStartDate' AND '$selectedEndDate'
            GROUP BY MemberCode
        ) b ON b.MemberCode = a.MemCode
        WHERE a.CollDate BETWEEN '$selectedStartDate' AND '$selectedEndDate' 
            AND a.Locked <> '1'
        GROUP BY a.MemCode, a.Cattle
        
        UNION
        
        SELECT 
            a.Code, a.AutoID, a.MemCode, a.CollDate, a.CollTime, COUNT(a.CollSession) AS CollSession,
            printf('%.2f', SUM(a.KgFat) / SUM(a.Liters)) AS FAT, 
            printf('%.2f', SUM(a.Amount)) AS Amount,
            printf('%.2f', SUM(a.Liters)) AS Liters, 
            a.Cattle, a.LitersEntryType,
            printf('%.2f', SUM(a.KgSnf) / SUM(a.Liters)) AS SNF, 
            AVG(a.CLR) AS CLR, 
            a.FAT_SNF_EntryType,
            printf('%.2f', AVG(a.Rate)) AS Rate, 
            a.Amount_Type, a.ReceiptPrinted, a.SentStatus, a.SentOn,
            a.UploadStatus, a.UploadOn, a.IsSync, a.SampleNo, a.VoucherNo, 
            a.IsUpdate, a.MemName, a.KgFatRate, a.Payment_Type, a.Locked,
            a.KgFat, a.KgSnf, a.OldWeight, a.OldFat, a.OldSNF, a.OldAmount,
            b.DeductionType, b.Amount AS DeductionAmount, 2 AS ViewType
        FROM MilkCollection a
        LEFT OUTER JOIN (
            SELECT 
                MemberCode, 
                GROUP_CONCAT(DeductionType) AS DeductionType, 
                SUM(Amount) AS Amount 
            FROM DeductionEntry
            WHERE VoucherDate BETWEEN '$selectedStartDate' AND '$selectedEndDate'
            GROUP BY MemberCode
        ) b ON b.MemberCode = a.MemCode
        WHERE a.CollDate BETWEEN '$selectedStartDate' AND '$selectedEndDate' 
            AND a.Locked <> '1'
        GROUP BY a.MemCode
    ) K
    ORDER BY K.MemCode, K.ViewType
""";
    return Future.value(query);
  }

  static const String deductionEntry = '''
  CREATE TABLE DeductionEntry  (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    AutoId INTEGER,
    LocationCode INTEGER,
    MemberCode TEXT,
    VoucherDate TEXT,
    VoucherNo TEXT,
    DeductionType TEXT,
    Qty REAL,
    Rate REAL,
    Amount REAL,
    isSync INTEGER
  )
''';

  static const String shareRegister = '''
  CREATE TABLE IF NOT EXISTS ShareRegister (
    Code INTEGER PRIMARY KEY AUTOINCREMENT,
    MemCode TEXT,
    LocationCode INTEGER,
    Date TEXT,
    ShareQuality REAL,
    ShareAmount REAL,
    Total REAL,
    Share REAL,
    ShareChillerAmount REAL
  )
''';

  static const String aasanAppMenu = '''
  CREATE TABLE Aasan_AppMenu (
    Code INTEGER PRIMARY KEY,
    Name TEXT,
    ShortCode TEXT,
    MenuIcon TEXT,
    MenuOrder INTEGER,
    IsNavigationMainActivity INTEGER,
    OnClickEvent TEXT,
    Locked INTEGER,
    EntryDate TEXT
  )
''';

  static const String aasanUserRole = '''
  CREATE TABLE Aasan_UserRole (
    Code INTEGER PRIMARY KEY,
    Description TEXT,
    ShortCode TEXT,
    Locked INTEGER,
    CreatedOn TEXT,
    CreatedBy TEXT
  )
''';

  static const String aasanUserMenuRights = '''
  CREATE TABLE Aasan_UserMenuRights (
    Code INTEGER PRIMARY KEY,
    UserRole INTEGER,
    MenuCode INTEGER,
    Locked INTEGER,
    EntryDate TEXT
  )
''';

  static const String aasanRoleMappingToLogin = '''
  CREATE TABLE Aasan_RoleMappingToLogin (
    Code INTEGER PRIMARY KEY,
    UserRole INTEGER,
    LoginCode INTEGER,
    Locked INTEGER,
    EntryDate TEXT
  )
''';

  /// Jay Panchal - - for role based menu access
}
