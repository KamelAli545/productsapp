class Dimensions {
  Dimensions({
      this.width, 
      this.height, 
      this.depth,});

  Dimensions.fromJson(dynamic json) {
    width = (json['width'] as num?)?.toDouble();
    height = (json['height'] as num?)?.toDouble();
    depth = (json['depth'] as num?)?.toDouble();
  }
  double? width;
  double? height;
  double? depth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['width'] = width;
    map['height'] = height;
    map['depth'] = depth;
    return map;
  }

}