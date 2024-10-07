part of "../export.provider.dart";

class OrdersRepo extends NetworkRequest {
  // create order
  Future<Order> createOrder(
      {required int? requestId, required String phone}) async {
    try {
      final response = await post("order/create",
          {'requestId': requestId, 'phone': getPhoneNumber(phone)});
      log("Response: $response");
      if (response['success'] == true) {
        return Order.fromMap(response['data']);
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      log("Error: $e");
      rethrow;
    }
  }

  // fetch user shipments
  Future<List<Order>> fetchShipments() async {
    try {
      final response = await get("order/my-shipments");
      if (response['success'] == true) {
        return List<Order>.from(
            response['data'].map((order) => Order.fromMap(order)));
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // fetch user orders
  Future<List<Order>> fetchOrders() async {
    try {
      final response = await get("order/my-orders");
      if (response['success'] == true) {
        return List<Order>.from(
            response['data'].map((order) => Order.fromMap(order)));
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // change order status
  Future changeOrderStatus({required int? id, required String status}) async {
    try {
      final response =
          await put("order/update-status", {'id': id, 'status': status});
      if (response['success'] == true) {
        return;
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  // add review
  Future addOrderReview(
      {required int? orderId, required int rating, double? tipAmount}) async {
    try {
      final response = await post("order/add-review", {
        'orderId': orderId,
        'rating': rating,
        'tipAmount': tipAmount,
      });
      print("Response: $response");
      if (response['success'] == true) {
        return;
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}

String getPhoneNumber(String phone) {
  if (phone.startsWith('0')) {
    return phone.replaceFirst('0', '254');
  } else {
    return '254$phone';
  }
}
