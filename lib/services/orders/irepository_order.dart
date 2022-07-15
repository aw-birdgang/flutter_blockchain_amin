import '../../models/ordermodel.dart';

abstract class IrepositoryOrder {
  Future<List<Order>> getorders();
  Future<void> updateOrderStatus(String orderId, String statusvalue);
}
