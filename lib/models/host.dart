import '../common/map_util.dart';

class Host {
  int? id;
  String? name;
  String? accessToken;
  String? type;
  bool? exposeYn;
  String? createdAt;
  String? updatedAt;

  Host({
    this.id,
    this.name,
    this.accessToken,
    this.type,
    this.exposeYn,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "accessToken": accessToken,
    "type": type,
    "exposeYn": exposeYn,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };

  Host.fromJson(Map<String, dynamic> map) {
    print('Host.fromJson > map.toString() :: ' + map.toString());
    id = getItemFromMapForInt(map, "id");
    name = getItemFromMapForStr(map, "name");
    accessToken = getItemFromMapForStr(map, "accessToken");
    type = getItemFromMapForStr(map, "type");
    exposeYn = getItemFromMapForBool(map, "exposeYn");
    createdAt = getItemFromMapForStr(map, "createdAt");
    updatedAt = getItemFromMapForStr(map, "updatedAt");
  }

  @override
  String toString() => '${toMap()}';
}
