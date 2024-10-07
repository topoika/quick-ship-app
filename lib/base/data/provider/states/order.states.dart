part of "../export.provider.dart";

class OrderStates extends Equatable {
  const OrderStates();
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderStates {}

class OrderLoading extends OrderStates {}

class StatusUpdating extends OrderStates {
  final int id;

  const StatusUpdating({required this.id});

  @override
  List<Object> get props => [id];
}

class StatusUpdated extends OrderStates {}

class OrdersLoaded extends OrderStates {
  final List<Order> orders;
  const OrdersLoaded({required this.orders});
  @override
  List<Object> get props => [orders];
}

class OrderError extends OrderStates {
  final String message;
  const OrderError({required this.message});
  @override
  List<Object> get props => [message];
}

class OrderCreated extends OrderStates {
  final Order order;
  const OrderCreated({required this.order});
  @override
  List<Object> get props => [order];
}

class OrderUpdated extends OrderStates {
  final Order order;
  const OrderUpdated({required this.order});
  @override
  List<Object> get props => [order];
}

class ReviewAdded extends OrderStates {}
