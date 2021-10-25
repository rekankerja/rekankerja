import 'package:path_provider/path_provider.dart';
import 'package:rekankerja/Class/ClassUserLogin.dart';
import 'package:rekankerja/Global/GlobalVariable.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'dart:async';
import 'package:path/path.dart';
import 'ModelDbHelper.dart';

class DBHelper {
  static final DBHelper _instance = new DBHelper.internal();
  DBHelper.internal();

  factory DBHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await setDB();
    return _db;
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "rekanKerjaLogDB");
    var dB = await openDatabase(
      path, version: 1, onCreate: _onCreate,

      // onUpgrade: (db, oldVersion, newVersion) async {
      //   var batch = db.batch();
      //   if (oldVersion == 2) {
      //     // We update existing table and create the new tables
      //     // _updateTableCompanyV1toV2(batch);
      //     _createTableFilterFavoritV2(batch);
      //     _createTableTourV3(batch);
      //   }
      //   if (oldVersion == 3) {
      //     // We update existing table and create the new tables
      //     // _updateTableCompanyV1toV2(batch);
      //     _createTableTourV3(batch);
      //   }
      //   await batch.commit();
      // },
    );
    return dB;
  }

  void _onCreate(Database db, int version) async {
    /// bikin database untuk user db
    await db.execute(
        "CREATE TABLE user(id INTEGER PRIMARY KEY, uid TEXT, email TEXT, displayName TEXT, urlPhoto TEXT, lastLogin Text, jabatan TEXT, referall TEXT, selfReferall TEXT, isNotifOn TEXT, workStatus TEXT, keteranganWorkStatus TEXT, latitude TEXT, longitude TEXT, alatConnect TEXT, alatAddress TEXT, alatNama TEXT, isMotion TEXT, isImage TEXT, appVersion TEXT, buildCode TEXT)");

    /// bikin database untuk logDisconnect db
    await db.execute(
        "CREATE TABLE logdisconnect(id INTEGER PRIMARY KEY, uid TEXT, dateTimeDisconnect TEXT, keterangan TEXT)");

    /// bikin database untuk logSendPesan db -- INI UNTUK MENGIRIM PESAN
    await db.execute(
        "CREATE TABLE logsendpesan(id INTEGER PRIMARY KEY, uid TEXT, dateTimeSend TEXT, dateTimeReceive TEXT, isUseBuzzer TEXT, uidTarget TEXT, displayNameTarget TEXT, urlPhotoTarget TEXT, pesan TEXT, isBuzzerReceive TEXT, isRead TEXT)");

    /// bikin database untuk logReceivepesan db -- INI SAAT MENERIMA PESAN
    await db.execute(
        "CREATE TABLE logreceivepesan(id INTEGER PRIMARY KEY, uid TEXT, dateTimeReceive TEXT, uidSender TEXT, displayNameSender TEXT, pesan TEXT, urlPhotoSender TEXT, idMessageSender INTEGER, isBuzzerReceive TEXT, isRead TEXT)");

    /// bikin database untuk pesan db -- INI UNTUK SETTING ADMIN
    await db.execute(
        "CREATE TABLE settingadmin(id INTEGER PRIMARY KEY, setting TEXT, attribut1 TEXT, attribut2 TEXT, attribut3 TEXT, attribut4 TEXT)");

    /// bikin database untuk list rekan kerja
    await db.execute(
        "CREATE TABLE rekankerja(id INTEGER PRIMARY KEY, uid TEXT, email TEXT, displayName TEXT, urlPhoto TEXT, jabatan TEXT, isNotifOn TEXT, workStatus TEXT, keteranganWorkStatus TEXT, latitude TEXT, longitude TEXT, alatConnect TEXT, isMotion TEXT, isImage TEXT, lastLogin Text, lastUpdate Text)");
  }

  // /// Create Employee table V2
  // void _createTableFilterFavoritV2(Batch batch) {
  //   batch.execute('''CREATE TABLE filterfavorit(id INTEGER PRIMARY KEY, namafilter TEXT, indexfilter INTEGER, kueri TEXT)''');
  // }
  //
  // /// Create Employee table V2
  // void _createTableTourV3(Batch batch) {
  //   batch.execute('''CREATE TABLE tour(id INTEGER PRIMARY KEY, namatour TEXT, isshow INTEGER)''');
  // }

  Future<int> saveUser(UserHelper userhelper) async {
    var dbClient = await db;
    int res = await dbClient.insert("user", userhelper.toMap());

    return res;
  }

  deleteUser() async {
    final dbClient = await db;
    var res = dbClient.rawDelete("Delete from user");
    return res;
  }

  Future<bool> updateUser(UserHelper userhelper) async {
    var dbclient = await db;
    int res = await dbclient.update("user", userhelper.toMap(),
        where: "id=?", whereArgs: <int>[userhelper.id]);
    return res > 0 ? true : false;
  }

  Future<List<UserHelper>> getUser() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("Select * from user");
    List<UserHelper> datauser = new List();
    for (int i = 0; i < list.length; i++) {
      var data = new UserHelper(
          list[i]['uid'],
          list[i]['email'],
          list[i]['displayName'],
          list[i]['urlPhoto'],
          list[i]['lastLogin'],
          list[i]['jabatan'],
          list[i]['referall'],
          list[i]['selfReferall'],
          list[i]['isNotifOn'],
          list[i]['workStatus'],
          list[i]['keteranganWorkStatus'],
          list[i]['latitude'],
          list[i]['longitude'],
          list[i]['alatConnect'],
          list[i]['alatAddress'],
          list[i]['alatNama'],
          list[i]['isMotion'],
          list[i]['isImage'],
          list[i]['appVersion'],
          list[i]['buildCode']);
      data.setUserId(list[i]['id']);
      datauser.add(data);
    }
    return datauser;
  }

  /// BATAS FUNGSI DB USER /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  /// MASUK KE DB saveLogDisconnect ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<int> saveLogDisconnect(LogDisconnectHelper logDisconnectHelper) async {
    var dbClient = await db;
    int res =
        await dbClient.insert("logdisconnect", logDisconnectHelper.toMap());

    return res;
  }

  deleteLogDisconnect(idlogdisconnect) async {
    final dbClient = await db;
    int res = await dbClient.delete("logdisconnect",
        where: "id=?", whereArgs: <int>[idlogdisconnect]);
    return res;
  }

  Future<bool> updateLogDisconnect(
      LogDisconnectHelper logDisconnectHelper) async {
    var dbclient = await db;
    int res = await dbclient.update(
        "logdisconnect", logDisconnectHelper.toMap(),
        where: "id=?", whereArgs: <int>[logDisconnectHelper.id]);
    return res > 0 ? true : false;
  }

  Future<List<LogDisconnectHelper>> getLogDisconnect() async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery("Select * from logdisconnect where uid = ${userLogin2.uid}");
    List<LogDisconnectHelper> datalogdisconnect = new List();
    for (int i = 0; i < list.length; i++) {
      var data = new LogDisconnectHelper(
          list[i]['uid'], list[i]['dateTimeDisconnect'], list[i]['keterangan']);
      data.setLogDisconnectId(list[i]['id']);
      datalogdisconnect.add(data);
    }
    return datalogdisconnect;
  }

  /// BATAS FUNGSI DB savelogDisconnect /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  /// MASUK KE DB TASK saveLogBuzzer ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<int> saveLogSendPesan(LogSendPesanHelper logSendPesanHelper) async {
    var dbClient = await db;
    int res = await dbClient.insert("logsendpesan", logSendPesanHelper.toMap());

    return res;
  }

  deleteLogSendPesan(idLogSendPesan) async {
    final dbClient = await db;
    int res = await dbClient.delete("logsendpesan",
        where: "id=?", whereArgs: <int>[idLogSendPesan]);
    return res;
  }

  Future<bool> updateLogSendPesan(LogSendPesanHelper logSendPesanHelper) async {
    var dbclient = await db;
    int res = await dbclient.update("logsendpesan", logSendPesanHelper.toMap(),
        where: "id=?", whereArgs: <int>[logSendPesanHelper.id]);
    return res > 0 ? true : false;
  }

  Future<List<LogSendPesanHelper>> getLogSendPesan() async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery("Select * from logsendpesan where uid = '${userLogin2.uid}'");
    List<LogSendPesanHelper> datalogsendpesan = new List();
    for (int i = 0; i < list.length; i++) {
      var data = new LogSendPesanHelper(
          list[i]['uid'],
          list[i]['dateTimeSend'],
          list[i]['dateTimeReceive'],
          list[i]['isUseBuzzer'],
          list[i]['uidTarget'],
          list[i]['displayNameTarget'],
          list[i]['urlPhotoTarget'],
          list[i]['pesan'],
          list[i]["isBuzzerReceive"],
          list[i]['isRead']);
      data.setLogSendPesanId(list[i]['id']);
      datalogsendpesan.add(data);
    }
    return datalogsendpesan;
  }

  /// BATAS FUNGSI DB saveLogBuzzer /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  /// MASUK KE DB TASK savePesan ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<int> saveReceivePesan(LogReceivePesan logReceivePesan) async {
    var dbClient = await db;
    int res = await dbClient.insert("logreceivepesan", logReceivePesan.toMap());

    return res;
  }

  deleteReceivePesan(idLogReceivePesan) async {
    final dbClient = await db;
    int res = await dbClient.delete("logreceivepesan",
        where: "id=?", whereArgs: <int>[idLogReceivePesan]);
    return res;
  }

  Future<bool> updateReceivePesan(LogReceivePesan logReceivePesan) async {
    var dbclient = await db;
    int res = await dbclient.update("logreceivepesan", logReceivePesan.toMap(),
        where: "id=?", whereArgs: <int>[logReceivePesan.id]);
    return res > 0 ? true : false;
  }

  Future<List<LogReceivePesan>> getReceivePesan() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        "Select * from logreceivepesan where uid = '${userLogin2.uid}'");
    List<LogReceivePesan> datalogreceivepesan = new List();
    for (int i = 0; i < list.length; i++) {
      var data = new LogReceivePesan(
          list[i]['uid'],
          list[i]['dateTimeReceive'],
          list[i]['uidSender'],
          list[i]['displayNameSender'],
          list[i]['pesan'],
          list[i]['urlPhotoSender'],
          list[i]['idMessageSender'],
          list[i]['isBuzzerReceive'],
          list[i]['isRead']);
      data.setLogReceivePesanId(list[i]['id']);
      datalogreceivepesan.add(data);
    }
    return datalogreceivepesan;
  }

  /// BATAS FUNGSI DB savePesan /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  /// MASUK KE DB TASK settingadmin ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<int> saveSettingAdmin(SettingAdmin settingAdmin) async {
    var dbClient = await db;
    int res = await dbClient.insert("settingadmin", settingAdmin.toMap());

    return res;
  }

  deleteSettingAdmin(idSettingAdmin) async {
    final dbClient = await db;
    int res = await dbClient.delete("settingadmin",
        where: "id=?", whereArgs: <int>[idSettingAdmin]);
    return res;
  }

  Future<bool> updateSettingAdmin(SettingAdmin settingAdmin) async {
    var dbclient = await db;
    int res = await dbclient.update("settingadmin", settingAdmin.toMap(),
        where: "id=?", whereArgs: <int>[settingAdmin.id]);
    return res > 0 ? true : false;
  }

  Future<List<SettingAdmin>> getSettingAdmin() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("Select * from settingadmin");
    List<SettingAdmin> dataSettingAdmin = new List();
    for (int i = 0; i < list.length; i++) {
      var data = new SettingAdmin(list[i]['setting'], list[i]['attribut1'],
          list[i]['attribut2'], list[i]['attribut3'], list[i]['attribut4']);
      data.setSettingId(list[i]['id']);
      dataSettingAdmin.add(data);
    }
    return dataSettingAdmin;
  }

  Future<List<SettingAdmin>> getSettingAdminHariKerja() async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery("Select * from settingadmin where setting = 'HARI KERJA'");
    List<SettingAdmin> dataSettingAdmin = new List();
    for (int i = 0; i < list.length; i++) {
      var data = new SettingAdmin(list[i]['setting'], list[i]['attribut1'],
          list[i]['attribut2'], list[i]['attribut3'], list[i]['attribut4']);
      data.setSettingId(list[i]['id']);
      dataSettingAdmin.add(data);
    }
    return dataSettingAdmin;
  }

  Future<List<SettingAdmin>> getSettingAdminRefreshRate() async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery("Select * from settingadmin where setting = 'REFRESH RATE'");
    List<SettingAdmin> dataSettingAdmin = new List();
    for (int i = 0; i < list.length; i++) {
      var data = new SettingAdmin(list[i]['setting'], list[i]['attribut1'],
          list[i]['attribut2'], list[i]['attribut3'], list[i]['attribut4']);
      data.setSettingId(list[i]['id']);
      dataSettingAdmin.add(data);
    }
    return dataSettingAdmin;
  }

  /// BATAS FUNGSI DB settingadmin /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  /// MASUK KE DB REKAN KERJA ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<int> saveRekanKerja(RekanKerjaHelper rekanKerja) async {
    var dbClient = await db;
    int res = await dbClient.insert("rekankerja", rekanKerja.toMap());

    return res;
  }

  deleterekanKerja(idRekanKerja) async {
    final dbClient = await db;
    int res = await dbClient
        .delete("rekankerja", where: "id=?", whereArgs: <int>[idRekanKerja]);
    return res;
  }

  Future<bool> updateRekanKerja(RekanKerjaHelper rekanKerja) async {
    var dbclient = await db;
    int res = await dbclient.update("rekankerja", rekanKerja.toMap(),
        where: "uid=?", whereArgs: <String>[rekanKerja.uid]);
    return res > 0 ? true : false;
  }

  Future<List<RekanKerjaHelper>> getRekanKerja() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("Select * from rekankerja");
    List<RekanKerjaHelper> dataRekanKerja = new List();
    for (int i = 0; i < list.length; i++) {
      var data = new RekanKerjaHelper(
          list[i]['uid'],
          list[i]['email'],
          list[i]['displayName'],
          list[i]['urlPhoto'],
          list[i]['jabatan'],
          list[i]['isNotifOn'],
          list[i]['workStatus'],
          list[i]['keteranganWorkStatus'],
          list[i]['latitude'],
          list[i]['longitude'],
          list[i]['alatConnect'],
          list[i]['isMotion'],
          list[i]['isImage'],
          list[i]['lastLogin'],
          list[i]['lastUpdate']);
      data.setrekankerjaId(list[i]['id']);
      dataRekanKerja.add(data);
    }
    return dataRekanKerja;
  }

  //
  //
  // /// BATAS FUNGSI DB TASK FAVORIT /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // ///
  // ///
  // ///
  // ///
  // /// MASUK KE DB FILTER FAVORIT ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  // Future<int> saveFilterFavorit(FilterFavoritHelper filterFavoritHelper) async{
  //   var dbClient = await db;
  //   int res = await dbClient.insert("filterfavorit", filterFavoritHelper.toMap());
  //   return res;
  // }
  //
  // deleteFilterFavorit(idfilterfavorit) async{
  //   final dbClient = await db;
  //   int res = await dbClient.delete("filterfavorit", where: "id=?", whereArgs: <int>[idfilterfavorit]);
  //   return res;
  // }
  //
  //
  // Future<bool> updateFilterFavorit(FilterFavoritHelper filterFavoritHelper) async{
  //   var dbclient = await db;
  //   int res = await dbclient.update("filterfavorit", filterFavoritHelper.toMap(), where:"id=?",
  //       whereArgs: <int>[filterFavoritHelper.id]);
  //   return res > 0 ?true:false;
  // }
  //
  // Future<List<FilterFavoritHelper>> getFilterFavorit() async{
  //   var dbClient = await db;
  //   List<Map> list = await dbClient.rawQuery("Select * from filterfavorit" );
  //   List<FilterFavoritHelper> datafilterfavorit = new List();
  //   for(int i = 0; i<list.length;i++){
  //     var data = new FilterFavoritHelper(list[i]['namafilter'], list[i]['indexfilter'], list[i]['kueri']);
  //     data.setFilterFavorit(list[i]['id']);
  //     datafilterfavorit.add(data);
  //   }
  //   return datafilterfavorit;
  // }
  //
  // /// BATAS FUNGSI DB TASK FAVORIT /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // ///
  // ///
  // ///
  // ///
  // /// MASUK KE DB FILTER FAVORIT ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //
  // Future<int> saveTour(TourHelper tourHelper) async{
  //   var dbClient = await db;
  //   int res = await dbClient.insert("tour", tourHelper.toMap());
  //   return res;
  // }
  //
  // deleteTour(idtour) async{
  //   final dbClient = await db;
  //   int res = await dbClient.delete("tour", where: "id=?", whereArgs: <int>[idtour]);
  //   return res;
  // }
  //
  //
  // Future<bool> updateTour(TourHelper tourHelper) async{
  //   var dbclient = await db;
  //   int res = await dbclient.update("tour", tourHelper.toMap(), where:"id=?",
  //       whereArgs: <int>[tourHelper.id]);
  //   return res > 0 ?true:false;
  // }
  //
  // Future<List<TourHelper>> getTour() async{
  //   var dbClient = await db;
  //   List<Map> list = await dbClient.rawQuery("Select * from tour" );
  //   List<TourHelper> datatour = new List();
  //   for(int i = 0; i<list.length;i++){
  //     var data = new TourHelper(list[i]['namatour'], list[i]['isshow']);
  //     data.setTour(list[i]['id']);
  //     datatour.add(data);
  //   }
  //   return datatour;
  // }

}
