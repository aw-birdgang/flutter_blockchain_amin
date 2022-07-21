import '../common/map_util.dart';

class Token {
  int? id;
  String? symbol;
  String? name;
  String? totalSupply;
  int? decimals;
  String? type;
  bool? exposeYn;
  String? createdAt;
  String? updatedAt;

  Token({
    this.id,
    this.name,
    this.totalSupply,
    this.decimals,
    this.type,
    this.exposeYn,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "symbol": symbol,
    "name": name,
    "totalSupply": totalSupply,
    "decimals": decimals,
    "type": type,
    "exposeYn": exposeYn,
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
    decimals = getItemFromMapForInt(map, "decimals");
    type = getItemFromMapForStr(map, "type");
    exposeYn = getItemFromMapForBool(map, "exposeYn");
    createdAt = getItemFromMapForStr(map, "createdAt");
    updatedAt = getItemFromMapForStr(map, "updatedAt");
  }

  @override
  String toString() => '${toMap()}';
}
