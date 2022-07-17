import '../common/map_util.dart';

class Token {
  int? id;
  String? symbol;
  String? name;
  String? totalSupply;
  double? decimals;
  String? type;
  String? createdAt;
  String? updatedAt;

  Token({
    this.id,
    this.name,
    this.totalSupply,
    this.decimals,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "totalSupply": totalSupply,
    "decimals": decimals,
    "type": type,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };

  // {createdAt: 2022-07-14T07:12:00.637Z, updatedAt: 2022-07-14T07:12:54.000Z, id: 1, symbol: GPW, name: GPW, totalSupply: 1000000000, decimals: 1000000, type: ERC-20}
  Token.fromJson(Map<String, dynamic> map) {
    print('Token.fromJson > map.toString() :: ' + map.toString());
    id = getItemFromMapForInt(map, "id");
    name = getItemFromMapForStr(map, "name");
    symbol = getItemFromMapForStr(map, "symbol");
    totalSupply = getItemFromMapForStr(map, "totalSupply");
    decimals = getItemFromMapForDouble(map, "decimals");
    type = getItemFromMapForStr(map, "type");
    createdAt = getItemFromMapForStr(map, "createdAt");
    updatedAt = getItemFromMapForStr(map, "updatedAt");
  }

  @override
  String toString() => '${toMap()}';
}
