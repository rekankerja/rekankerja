
class ClassAlat {
  String type;
  String motion;
  String image;



  Map toJson() => {
    'type': type,
    'motion': motion,
    'image': image,

  };

  ClassAlat(
      this.type,
      this.motion,
      this.image,
      );
}
