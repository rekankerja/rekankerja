// Class UserLogin
class ClassUserLogin {
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
  String latitude;
  String longitude;

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
        'latitude': latitude,
        'longitude': longitude,
      };

  ClassUserLogin(
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
      this.latitude,
      this.longitude
      );
}
