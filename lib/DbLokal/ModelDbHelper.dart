class UserHelper {
  int id;
  String _uid;
  String _email;
  String _displayName;
  String _urlPhoto;
  String _lastLogin;
  String _jabatan;
  String _referall;
  String _selfReferall;
  String _isNotifOn;
  String _workStatus;
  String _keteranganWorkStatus;
  String _latitude;
  String _longitude;
  String _appVersion;
  String _buildCode;

  UserHelper(
      this._uid,
      this._email,
      this._displayName,
      this._urlPhoto,
      this._lastLogin,
      this._jabatan,
      this._referall,
      this._selfReferall,
      this._isNotifOn,
      this._workStatus,
      this._keteranganWorkStatus,
      this._latitude,
      this._longitude,
      this._appVersion,
      this._buildCode);

  UserHelper.map(dynamic obj) {
    this._uid = obj["uid"];
    this._email = obj["email"];
    this._displayName = obj["displayName"];
    this._urlPhoto = obj["urlPhoto"];
    this._lastLogin = obj["lastLogin"];
    this._jabatan = obj["jabatan"];
    this._referall = obj["referall"];
    this._selfReferall = obj["selfReferall"];
    this._isNotifOn = obj["isNotifOn"];
    this._workStatus = obj["workStatus"];
    this._keteranganWorkStatus = obj["keteranganWorkStatus"];
    this._latitude = obj["latitude"];
    this._longitude = obj["longitude"];
    this._appVersion = obj["appVersion"];
    this._buildCode = obj["buildCode"];
  }

  String get uid => _uid;
  String get email => _email;
  String get displayName => _displayName;
  String get urlPhoto => _urlPhoto;
  String get lastLogin => _lastLogin;
  String get jabatan => _jabatan;
  String get referall => _referall;
  String get selfReferall => _selfReferall;
  String get isNotifOn => _isNotifOn;
  String get workStatus => _workStatus;
  String get keteranganWorkStatus => _keteranganWorkStatus;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String get appVersion => _appVersion;
  String get buildCode => _buildCode;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['uid'] = _uid;
    map['email'] = _email;
    map['displayName'] = _displayName;
    map['urlPhoto'] = _urlPhoto;
    map['lastLogin'] = _lastLogin;
    map['jabatan'] = _jabatan;
    map['referall'] = _referall;
    map['selfReferall'] = _selfReferall;
    map['isNotifOn'] = _isNotifOn;
    map['workStatus'] = _workStatus;
    map['keteranganWorkStatus'] = _keteranganWorkStatus;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['appVersion'] = _appVersion;
    map['buildCode'] = _buildCode;

    return map;
  }

  void setUserId(int id) {
    this.id = id;
  }
}

class LogDisconnectHelper {
  int id;
  String _uid;
  String _dateTimeDisconnect;
  String _keterangan;

  LogDisconnectHelper(this._uid, this._dateTimeDisconnect, this._keterangan);

  LogDisconnectHelper.map(dynamic obj) {
    this._uid = obj["uid"];
    this._dateTimeDisconnect = obj["dateTimeDisconnect"];
    this._keterangan = obj["keterangan"];
  }

  String get uid => _uid;
  String get dateTimeDisconnect => _dateTimeDisconnect;
  String get keterangan => _keterangan;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['uid'] = _uid;
    map['dateTimeDisconnect'] = _dateTimeDisconnect;
    map['keterangan'] = _keterangan;
    ;

    return map;
  }

  void setLogDisconnectId(int id) {
    this.id = id;
  }
}

class LogSendPesanHelper {
  int id;
  String _uid;
  String _dateTimeSend;
  String _uidTarget;
  String _pesan;
  String _isRead;

  LogSendPesanHelper(this._uid, this._dateTimeSend, this._uidTarget,
      this._pesan, this._isRead);

  LogSendPesanHelper.map(dynamic obj) {
    this._uid = obj["uid"];
    this._dateTimeSend = obj["dateTimeSend"];
    this._uidTarget = obj["uidTarget"];
    this._pesan = obj["pesan"];
    this._isRead = obj["isRead"];
  }

  String get uid => _uid;
  String get dateTimeSend => _dateTimeSend;
  String get uidTarget => _uidTarget;
  String get pesan => _pesan;
  String get isRead => _isRead;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['uid'] = _uid;
    map['dateTimeSend'] = _dateTimeSend;
    map['uidTarget'] = _uidTarget;
    map['pesan'] = _pesan;
    map['isRead'] = _isRead;

    return map;
  }

  void setLogSendPesanId(int id) {
    this.id = id;
  }
}

class LogReceivePesan {
  int id;
  String _uid;
  String _dateTimeReceive;
  String _uidSender;
  String _displayNameSender;
  String _pesan;
  String _urlPhoto;
  String _isRead;

  LogReceivePesan(this._uid, this._dateTimeReceive, this._uidSender,
      this._displayNameSender, this._pesan, this._urlPhoto, this._isRead);

  LogReceivePesan.map(dynamic obj) {
    this._uid = obj["uid"];
    this._dateTimeReceive = obj["dateTimeReceive"];
    this._uidSender = obj["uidSender"];
    this._displayNameSender = obj["displayNameSender"];
    this._pesan = obj["pesan"];
    this._urlPhoto = obj["urlPhoto"];
    this._isRead = obj["isRead"];
  }

  String get uid => _uid;
  String get dateTimeReceive => _dateTimeReceive;
  String get uidSender => _uidSender;
  String get displayNameSender => _displayNameSender;
  String get pesan => _pesan;
  String get urlPhoto => _urlPhoto;
  String get isRead => _isRead;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['uid'] = _uid;
    map['dateTimeReceive'] = _dateTimeReceive;
    map['uidSender'] = _uidSender;
    map['displayNameSender'] = _displayNameSender;
    map['pesan'] = _pesan;
    map['urlPhoto'] = _urlPhoto;
    map['isRead'] = _isRead;

    return map;
  }

  void setLogReceivePesanId(int id) {
    this.id = id;
  }
}

class SettingAdmin {
  int id;
  String _setting;
  String _attribut1;
  String _attribut2;
  String _attribut3;
  String _attribut4;

  SettingAdmin(this._setting, this._attribut1, this._attribut2, this._attribut3,
      this._attribut4);

  SettingAdmin.map(dynamic obj) {
    this._setting = obj["setting"];
    this._attribut1 = obj["attribut1"];
    this._attribut2 = obj["attribut2"];
    this._attribut3 = obj["attribut3"];
    this._attribut4 = obj["attribut4"];
  }

  String get setting => _setting;
  String get attribut1 => _attribut1;
  String get attribut2 => _attribut2;
  String get attribut3 => _attribut3;
  String get attribut4 => _attribut4;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['setting'] = _setting;
    map['attribut1'] = _attribut1;
    map['attribut2'] = _attribut2;
    map['attribut3'] = _attribut3;
    map['attribut4'] = _attribut4;

    return map;
  }

  void setSettingId(int id) {
    this.id = id;
  }
}

class RekanKerja {
  int id;
  String _uid;
  String _email;
  String _displayName;
  String _urlPhoto;
  String _isNotifOn;
  String _workStatus;
  String _keteranganWorkStatus;
  String _latitude;
  String _longitude;
  String _alatConnect;
  String _lastLogin;
  String _lastUpdate;

  RekanKerja(
      this._uid,
      this._email,
      this._displayName,
      this._urlPhoto,
      this._isNotifOn,
      this._workStatus,
      this._keteranganWorkStatus,
      this._latitude,
      this._longitude,
      this._alatConnect,
      this._lastLogin,
      this._lastUpdate,
      );

  RekanKerja.map(dynamic obj) {
    this._uid = obj["uid"];
    this._email = obj["email"];
    this._displayName = obj["displayName"];
    this._urlPhoto = obj["urlPhoto"];
    this._isNotifOn = obj["isNotifOn"];
    this._workStatus = obj["workStatus"];
    this._keteranganWorkStatus = obj["keteranganWorkStatus"];
    this._latitude = obj["latitude"];
    this._longitude = obj["longitude"];
    this._alatConnect = obj["alatConnect"];
    this._lastLogin = obj["lastLogin"];
    this._lastUpdate = obj["lastUpdate"];
  }

  String get uid => _uid;
  String get email => _email;
  String get displayName => _displayName;
  String get urlPhoto => _urlPhoto;
  String get isNotifOn => _isNotifOn;
  String get workStatus => _workStatus;
  String get keteranganWorkStatus => _keteranganWorkStatus;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String get alatConnect => _alatConnect;
  String get lastLogin => _lastLogin;
  String get lastUpdate => _lastUpdate;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['uid'] = _uid;
    map['email'] = _email;
    map['displayName'] = _displayName;
    map['urlPhoto'] = _urlPhoto;
    map['isNotifOn'] = _isNotifOn;
    map['workStatus'] = _workStatus;
    map['keteranganWorkStatus'] = _keteranganWorkStatus;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['alatConnect'] = _alatConnect;
    map['lastLogin'] = _lastLogin;
    map['lastUpdate'] = _lastUpdate;

    return map;
  }

  void setrekankerjaId(int id) {
    this.id = id;
  }
}
