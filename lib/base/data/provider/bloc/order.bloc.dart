part of "../export.provider.dart";

// order bloc
class OrderBloc extends Bloc<OrderEvents, OrderStates> {
  OrdersRepo repo = OrdersRepo();
  OrderBloc() : super(OrderInitial()) {
    on<CreateOrder>(createOrder);
    on<FetchShipments>(fetchShipments);
    on<UpdateOrder>(updateOrderStatus);
    on<AddReview>(addOrderReview);
  }
  void createOrder(event, emit) async {
    emit(OrderLoading());
    try {
      final Order order = await repo.createOrder(
          requestId: event.requestId, phone: event.phone);
      emit(OrderCreated(order: order));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  // fet user shipments
  void fetchShipments(event, emit) async {
    emit(OrderLoading());
    try {
      final List<Order> orders = await repo.fetchShipments();
      emit(OrdersLoaded(orders: orders));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  // update order status
  void updateOrderStatus(event, emit) async {
    emit(StatusUpdating(id: event.id));
    try {
      await repo.changeOrderStatus(id: event.id, status: event.status);
      emit(StatusUpdated());
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  // add order review
  void addOrderReview(event, emit) async {
    emit(OrderLoading());
    try {
      await repo.addOrderReview(
          orderId: event.orderId,
          rating: event.rating,
          tipAmount: event.tipAmount);
      emit(ReviewAdded());
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }
}

// MyOrder bloc
class MyOrderBloc extends Bloc<OrderEvents, OrderStates> {
  OrdersRepo repo = OrdersRepo();
  MyOrderBloc() : super(OrderInitial()) {
    on<FetchOrders>(fetUserOrders);
  }

  void fetUserOrders(event, emit) async {
    emit(OrderLoading());
    try {
      final List<Order> orders = await repo.fetchOrders();
      emit(OrdersLoaded(orders: orders));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }
}

// Shipments bloc
class ShipmentsBloc extends Bloc<OrderEvents, OrderStates> {
  OrdersRepo repo = OrdersRepo();
  ShipmentsBloc() : super(OrderInitial()) {
    on<FetchShipments>(fetchShipments);
  }
  void fetchShipments(event, emit) async {
    emit(OrderLoading());
    try {
      final List<Order> orders = await repo.fetchShipments();
      emit(OrdersLoaded(orders: orders));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }
}
