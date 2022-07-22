import '../common/map_util.dart';

class KmsKey {
  int? id;
  String? originalText;
  String? cipher;
  String? tag;
  bool? exposeYn;
  String? createdAt;
  String? updatedAt;

  KmsKey({
    this.id,
    this.originalText,
    this.cipher,
    this.tag,
    this.exposeYn,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "originalText": originalText,
    "cipher": cipher,
    "tag": tag,
    "exposeYn": exposeYn,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };

  KmsKey.fromJson(Map<String, dynamic> map) {
    print('KmsKey.fromJson > map.toString() :: ' + map.toString());
    id = getItemFromMapForInt(map, "id");
    originalText = getItemFromMapForStr(map, "originalText");
    cipher = getItemFromMapForStr(map, "cipher");
    tag = getItemFromMapForStr(map, "tag");
    exposeYn = getItemFromMapForBool(map, "exposeYn");
    createdAt = getItemFromMapForStr(map, "createdAt");
    updatedAt = getItemFromMapForStr(map, "updatedAt");
  }

  @override
  String toString() => '${toMap()}';
}
