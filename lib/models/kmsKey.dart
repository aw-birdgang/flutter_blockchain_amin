import '../common/map_util.dart';

class KmsKey {
  int? id;
  String? cipher;
  String? tag;
  String? createdAt;
  String? updatedAt;

  KmsKey({
    this.id,
    this.cipher,
    this.tag,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "cipher": cipher,
    "tag": tag,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };

  KmsKey.fromJson(Map<String, dynamic> map) {
    print('KmsKey.fromJson > map.toString() :: ' + map.toString());
    id = getItemFromMapForInt(map, "id");
    cipher = getItemFromMapForStr(map, "cipher");
    tag = getItemFromMapForStr(map, "tag");
    createdAt = getItemFromMapForStr(map, "createdAt");
    updatedAt = getItemFromMapForStr(map, "updatedAt");
  }

  @override
  String toString() => '${toMap()}';
}
