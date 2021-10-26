
class ClassAlat {
  String type;
  String motion;
  String image;
  String id;
  int sukses;



  Map toJson() => {
    'type': type,
    'motion': motion,
    'image': image,
    'id': id,
    'sukses': sukses

  };

  ClassAlat(
      this.type,
      this.motion,
      this.image,
      this.id,
      this.sukses
      );
}
