// Class UserLogin
class ClassSettingAdmin {
  String setting;
  String attribut1;
  String attribut2;
  String attribut3;
  String attribut4;


  Map toJson() => {
    'setting': setting,
    'attribut1': attribut1,
    'attribut2': attribut2,
    'attribut3': attribut3,
    'attribut4': attribut4,
  };

  ClassSettingAdmin.fromJson(Map<String, dynamic> json) {
    setting = json['setting'];
    attribut1 = json['attribut1'];
    attribut2 = json['attribut2'];
    attribut3 = json['attribut3'];
    attribut4 = json['attribut4'];
  }

  ClassSettingAdmin(
      this.setting,
      this.attribut1,
      this.attribut2,
      this.attribut3,
      this.attribut4,
      );

}
