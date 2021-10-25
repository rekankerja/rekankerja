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
  String _alatConnect;
  String _alatAddress;
  String _alatNama;
  String _isMotion;
  String _isImage;
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
      this._alatConnect,
      this._alatAddress,
      this._alatNama,
      this._isMotion,
      this._isImage,
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
    this._alatConnect = obj["alatConnect"];
    this._alatAddress = obj["alatAddress"];
    this._alatNama = obj["alatNama"];
    this._isMotion = obj["isMotion"];
    this._isImage = obj["isImage"];
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
  String get alatConnect => _alatConnect;
  String get alatAddress => _alatAddress;
  String get alatNama => _alatNama;
  String get isMotion => _isMotion;
  String get isImage => _isImage;
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
    map['alatConnect'] = _alatConnect;
    map['alatAddress'] = _alatAddress;
    map['alatNama'] = _alatNama;
    map['isMotion'] = _isMotion;
    map['isImage'] = _isImage;
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
  String _dateTimeReceive;
  String _isUseBuzzer;
  String _uidTarget;
  String _displayNameTarget;
  String _urlPhotoTarget;
  String _pesan;
  String _isBuzzerReceive;
  String _isRead;

  LogSendPesanHelper(this._uid, this._dateTimeSend, this._dateTimeReceive,
      this._isUseBuzzer, this._uidTarget, this._displayNameTarget, this._urlPhotoTarget, this._pesan, this._isBuzzerReceive, this._isRead);

  LogSendPesanHelper.map(dynamic obj) {
    this._uid = obj["uid"];
    this._dateTimeSend = obj["dateTimeSend"];
    this._dateTimeReceive = obj["dateTimeReceive"];
    this._isUseBuzzer = obj["isUseBuzzer"];
    this._uidTarget = obj["uidTarget"];
    this._displayNameTarget = obj["displayNameTarget"];
    this._urlPhotoTarget = obj["urlPhotoTarget"];
    this._pesan = obj["pesan"];
    this._isBuzzerReceive = obj["isBuzzerReceive"];
    this._isRead = obj["isRead"];
  }

  String get uid => _uid;
  String get dateTimeSend => _dateTimeSend;
  String get dateTimeReceive => _dateTimeReceive;
  String get isUseBuzzer => _isUseBuzzer;
  String get uidTarget => _uidTarget;
  String get displayNameTarget => _displayNameTarget;
  String get urlPhotoTarget => _urlPhotoTarget;
  String get pesan => _pesan;
  String get isBuzzerReceive => _isBuzzerReceive;
  String get isRead => _isRead;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['uid'] = _uid;
    map['dateTimeSend'] = _dateTimeSend;
    map['dateTimeReceive'] = _dateTimeReceive;
    map['isUseBuzzer'] = _isUseBuzzer;
    map['uidTarget'] = _uidTarget;
    map['displayNameTarget'] = _displayNameTarget;
    map['urlPhotoTarget'] = _urlPhotoTarget;
    map['pesan'] = _pesan;
    map['isBuzzerReceive'] = _isBuzzerReceive;
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
  String _urlPhotoSender;
  int _idMessageSender;
  String _isBuzzerReceive;
  String _isRead;

  LogReceivePesan(
      this._uid,
      this._dateTimeReceive,
      this._uidSender,
      this._displayNameSender,
      this._pesan,
      this._urlPhotoSender,
      this._idMessageSender,
      this._isBuzzerReceive,
      this._isRead);

  LogReceivePesan.map(dynamic obj) {
    this._uid = obj["uid"];
    this._dateTimeReceive = obj["dateTimeReceive"];
    this._uidSender = obj["uidSender"];
    this._displayNameSender = obj["displayNameSender"];
    this._pesan = obj["pesan"];
    this._urlPhotoSender = obj["urlPhotoSender"];
    this._idMessageSender = obj["idMessageSender"];
    this._isBuzzerReceive = obj["isBuzzerReceive"];
    this._isRead = obj["isRead"];
  }

  String get uid => _uid;
  String get dateTimeReceive => _dateTimeReceive;
  String get uidSender => _uidSender;
  String get displayNameSender => _displayNameSender;
  String get pesan => _pesan;
  String get urlPhotoSender => _urlPhotoSender;
  int get idMessageSender => _idMessageSender;
  String get isBuzzerReceive => _isBuzzerReceive;
  String get isRead => _isRead;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['uid'] = _uid;
    map['dateTimeReceive'] = _dateTimeReceive;
    map['uidSender'] = _uidSender;
    map['displayNameSender'] = _displayNameSender;
    map['pesan'] = _pesan;
    map['urlPhotoSender'] = _urlPhotoSender;
    map['idMessageSender'] = _idMessageSender;
    map['isBuzzerReceive'] = _isBuzzerReceive;
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

class RekanKerjaHelper {
  int id;
  String _uid;
  String _email;
  String _displayName;
  String _urlPhoto;
  String _jabatan;
  String _isNotifOn;
  String _workStatus;
  String _keteranganWorkStatus;
  String _latitude;
  String _longitude;
  String _alatConnect;
  String _isMotion;
  String _isImage;
  String _lastLogin;
  String _lastUpdate;

  RekanKerjaHelper(
    this._uid,
    this._email,
    this._displayName,
    this._urlPhoto,
    this._jabatan,
    this._isNotifOn,
    this._workStatus,
    this._keteranganWorkStatus,
    this._latitude,
    this._longitude,
    this._alatConnect,
    this._isMotion,
    this._isImage,
    this._lastLogin,
    this._lastUpdate,
  );

  RekanKerjaHelper.map(dynamic obj) {
    this._uid = obj["uid"];
    this._email = obj["email"];
    this._displayName = obj["displayName"];
    this._urlPhoto = obj["urlPhoto"];
    this._jabatan = obj["jabatan"];
    this._isNotifOn = obj["isNotifOn"];
    this._workStatus = obj["workStatus"];
    this._keteranganWorkStatus = obj["keteranganWorkStatus"];
    this._latitude = obj["latitude"];
    this._longitude = obj["longitude"];
    this._alatConnect = obj["alatConnect"];
    this._isMotion = obj["isMotion"];
    this._isImage = obj["isImage"];
    this._lastLogin = obj["lastLogin"];
    this._lastUpdate = obj["lastUpdate"];
  }

  String get uid => _uid;
  String get email => _email;
  String get displayName => _displayName;
  String get urlPhoto => _urlPhoto;
  String get jabatan => _jabatan;
  String get isNotifOn => _isNotifOn;
  String get workStatus => _workStatus;
  String get keteranganWorkStatus => _keteranganWorkStatus;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String get alatConnect => _alatConnect;
  String get isMotion => _isMotion;
  String get isImage => _isImage;
  String get lastLogin => _lastLogin;
  String get lastUpdate => _lastUpdate;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['uid'] = _uid;
    map['email'] = _email;
    map['displayName'] = _displayName;
    map['urlPhoto'] = _urlPhoto;
    map['jabatan'] = _jabatan;
    map['isNotifOn'] = _isNotifOn;
    map['workStatus'] = _workStatus;
    map['keteranganWorkStatus'] = _keteranganWorkStatus;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['alatConnect'] = _alatConnect;
    map['isMotion'] = _isMotion;
    map['isImage'] = _isImage;
    map['lastLogin'] = _lastLogin;
    map['lastUpdate'] = _lastUpdate;

    return map;
  }

  void setrekankerjaId(int id) {
    this.id = id;
  }
}
