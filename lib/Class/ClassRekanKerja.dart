// Class UserLogin
class ClassRekanKerja {
  String uid;
  String displayName;
  String email;
  String photoURL;
  String createDate;
  String lastSignInTime;
  String jabatan;
  String referall;
  String selfReferall;
  String isNotifOn = "FALSE";
  String workStatus;
  String keteranganWorkStatus;
  String alatConnect;
  String isMotion;
  String isImage;
  String latitude;
  String longitude;
  String lastUpdate;

  Map toJson() => {
    'uid': uid,
    'displayName': displayName,
    'email': email,
    'photoURL': photoURL,
    'createDate': createDate,
    'lastSignInTime': lastSignInTime,
    'jabatan': jabatan,
    'referall': referall,
    'selfReferall': selfReferall,
    'isNotifOn': isNotifOn,
    'workStatus': workStatus,
    'keteranganWorkStatus': keteranganWorkStatus,
    'alatConnect': alatConnect,
    'isMotion': isMotion,
    'isImage': isImage,
    'latitude': latitude,
    'longitude': longitude,
    'lastUpdate': lastUpdate
  };

  ClassRekanKerja(
      this.uid,
      this.displayName,
      this.email,
      this.photoURL,
      this.createDate,
      this.lastSignInTime,
      this.jabatan,
      this.referall,
      this.selfReferall,
      this.isNotifOn,
      this.workStatus,
      this.keteranganWorkStatus,
      this.alatConnect,
      this.isMotion,
      this.isImage,
      this.latitude,
      this.longitude,
      this.lastUpdate
      );
}
