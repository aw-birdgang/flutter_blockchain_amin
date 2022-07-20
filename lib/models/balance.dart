import '../common/map_util.dart';

class Balance {
  String? balance = "0";

  Balance({
    this.balance,
  });

  Map<String, dynamic> toMap() => {
    "balance": balance,
  };

  Balance.fromJson(Map<String, dynamic> map) {
    print('Balance.fromJson > map.toString() :: ' + map.toString());
    balance = getItemFromMapForStr(map, "balance");
  }

  @override
  String toString() => '${toMap()}';
}
