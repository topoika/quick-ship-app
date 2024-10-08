// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../components.dart";

class ShipmentItemWidget extends StatelessWidget {
  final Order order;
  const ShipmentItemWidget({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextVariation(
                text: "Order #${order.id}",
                size: 12,
                weight: FontWeight.w500,
              ),
              statusTag(status: order.status ?? "pending"),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const TextVariation(
                text: "Date: 25/06/2021",
                size: 12,
                weight: FontWeight.w400,
              ),
              TextVariation(
                text: formatCurrency(value: order.payment?.amount ?? 0.0),
                size: 13,
                weight: FontWeight.w600,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.primaryColor.withOpacity(.12),
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  color: Colors.redAccent,
                  size: 10,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: TextVariation(
                  text: getAddressName(order.trip!.departure!),
                  size: 12,
                  weight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            alignment: Alignment.centerLeft,
            height: 15,
            child: VerticalDivider(
              color: Colors.black.withOpacity(.9),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.primaryColor.withOpacity(.12),
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  color: Colors.redAccent,
                  size: 10,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: TextVariation(
                  text: getAddressName(order.trip!.destination!),
                  size: 12,
                  weight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[400],
            thickness: .8,
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[400],
                        image: order.trip!.postman!.image != null
                            ? DecorationImage(
                                image:
                                    NetworkImage(order.trip!.postman!.image!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      margin: const EdgeInsets.only(right: 8),
                      child: order.trip!.postman!.image == null
                          ? const Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 15,
                            )
                          : const SizedBox(),
                    ),
                    TextVariation(
                      text: order.trip!.postman!.name ?? "Postman",
                      size: 13,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: order.review != null,
                child: ratingWidget(
                  context: context,
                  rating: order.review?.rating ?? 0,
                ),
              ),
            ],
          ),
          Visibility(
            visible: order.review != null && (order.review?.tipAmount ?? 0) > 0,
            child: Column(
              children: [
                Divider(
                  color: Colors.grey[400],
                  thickness: .8,
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const TextVariation(
                        text: "Tip",
                        size: 12,
                        weight: FontWeight.w500,
                      ),
                      TextVariation(
                        text: formatCurrency(
                            value: order.review?.tipAmount ?? 0.0),
                        size: 13,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: order.review == null && order.status == "completed",
            child: Column(
              children: [
                Divider(
                  color: Colors.grey[400],
                  thickness: .8,
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: PrimaryButton(
                    text: "Rate Shippment",
                    onPressed: () {
                      context.read<DetailsItemCubit>().setOrderId(order.id!);
                      Navigator.of(context)
                          .pushNamed(AppRoutes.rateShipmentPage);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderItemWidget extends StatelessWidget {
  final Order order;
  const OrderItemWidget({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextVariation(
                text: "Order #${order.id}",
                size: 12,
                weight: FontWeight.w500,
              ),
              statusTag(status: order.status ?? "pending"),
            ],
          ),
          const SizedBox(height: 4),
          detailsItem(
            txt: "Date",
            value: formatToTimeAndDate(date: DateTime.parse(order.createdAt!)),
          ),
          detailsItem(
            txt: "Delivery In",
            value: getAddressName(order.package!.destinationAddress!),
          ),
          detailsItem(
            txt: "Postage Fee",
            value: formatCurrency(value: order.payment?.amount ?? 0.0),
          ),
          Divider(
            color: Colors.grey[400],
            thickness: .8,
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[400],
                        image: order.package!.shipper!.image != null
                            ? DecorationImage(
                                image: NetworkImage(
                                    order.package!.shipper!.image!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      margin: const EdgeInsets.only(right: 8),
                      child: order.package!.shipper!.image == null
                          ? const Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 15,
                            )
                          : const SizedBox(),
                    ),
                    TextVariation(
                      text: order.package!.shipper!.name ?? "Postman",
                      size: 13,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
          BlocListener<OrderBloc, OrderStates>(
            listener: (context, state) {
              if (state is OrderError) {
                showCustomToast(message: state.message, type: "err");
              } else if (state is StatusUpdated) {
                showCustomToast(message: "Order Updated", type: "suc");
                context.read<MyOrderBloc>().add(FetchOrders());
              }
            },
            child: BlocBuilder<OrderBloc, OrderStates>(
              builder: (context, state) {
                // Define button text and next status
                final statusMapping = {
                  "started": {
                    "text": "Mark Delivered",
                    "nextStatus": "completed"
                  },
                  "pending": {
                    "text": "Mark Collected",
                    "nextStatus": "collected"
                  },
                  "collected": {
                    "text": "Mark Started",
                    "nextStatus": "started"
                  },
                  "postponed": {
                    "text": "Mark Postponed",
                    "nextStatus": "postponed"
                  },
                };

                // Check if current status exists in the mapping
                final statusData = statusMapping[order.status];
                final isVisible = statusData != null;
                final buttonText = statusData?['text'] ?? '';
                final nextStatus = statusData?['nextStatus'] ?? '';

                return Visibility(
                  visible: isVisible,
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.grey[400],
                        thickness: .8,
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: PrimaryButton(
                            loading:
                                state is StatusUpdating && state.id == order.id,
                            text: buttonText,
                            onPressed: () {
                              context.read<OrderBloc>().add(UpdateOrder(
                                  id: order.id!, status: nextStatus));
                            }),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget ratingWidget(
    {required BuildContext context, required int rating, double? size}) {
  return Row(
    children: List.generate(
      5,
      (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: context.primaryColor,
          size: size ?? 15,
        );
      },
    ),
  );
}
