class StatusImageModel {
  final String? url;
  final String? type;
  final List<String>? viewers;

  StatusImageModel({this.url, this.viewers, this.type});

  factory StatusImageModel.fromJson(Map<String, dynamic> json) {
    return StatusImageModel(
        url: json['url'],
        type: json['type'],
        viewers: List.from(json['viewers']));
  }

  static Map<String, dynamic> toJsonStatic(
          StatusImageModel statusImageEntity) =>
      {
        "url": statusImageEntity.url,
        "viewers": statusImageEntity.viewers,
        "type": statusImageEntity.type,
      };
  Map<String, dynamic> toJson() => {
        "url": url,
        "viewers": viewers,
        "type": type,
      };
}
