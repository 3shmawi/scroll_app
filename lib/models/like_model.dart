class LikeModel {
  String? name;
  String? uId;
  String? image;

  LikeModel({
    required this.name,
    required this.uId,
    required this.image,
  });

  LikeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
    };
  }
}
