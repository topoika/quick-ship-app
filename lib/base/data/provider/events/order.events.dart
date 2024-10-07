part of "../export.provider.dart";

class OrderEvents extends Equatable {
  const OrderEvents();
  @override
  List<Object> get props => [];
}

class CreateOrder extends OrderEvents {
  final int? requestId;
  final String? phone;

  const CreateOrder({required this.requestId, required this.phone});

  @override
  List<Object> get props => [requestId!, phone!];
}

class UpdateOrder extends OrderEvents {
  final String status;
  final int id;

  const UpdateOrder({required this.status, required this.id});

  @override
  List<Object> get props => [status, id];
}

class FetchOrders extends OrderEvents {}

class FetchShipments extends OrderEvents {}

class AddReview extends OrderEvents {
  final int orderId;
  final int rating;
  final double? tipAmount;

  const AddReview(
      {required this.orderId, required this.rating, this.tipAmount});
}
