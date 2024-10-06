part of "../components.dart";

class ShipmentItemWidget extends StatelessWidget {
  final Shipment shipment;
  const ShipmentItemWidget({
    super.key,
    required this.shipment,
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
              const TextVariation(
                text: "Order #2345434",
                size: 12,
                weight: FontWeight.w500,
              ),
              statusTag(status: "completed"),
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
                text: formatCurrency(value: 450),
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
              const Flexible(
                child: TextVariation(
                  text: "From: Lagos, Nigeria",
                  size: 12,
                  weight: FontWeight.w400,
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
              const Flexible(
                child: TextVariation(
                  text: "To: Lagos, Nigeria",
                  size: 12,
                  weight: FontWeight.w400,
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
                      ),
                      margin: const EdgeInsets.only(right: 8),
                      child: const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                    const TextVariation(
                      text: "Shane Watson",
                      size: 13,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              ratingWidget(
                context: context,
                rating: 4,
              ),
            ],
          ),
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
                  weight: FontWeight.w400,
                ),
                TextVariation(
                  text: formatCurrency(value: 50),
                  size: 13,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 5),
          //   child: PrimaryButton(
          //     text: "Rate Shippment",
          //     onPressed: () {
          //       context.read<DetailsItemCubit>().updateState(
          //           DetailsItemState(id: shipment.id, rating: 0, tip: 0.0));
          //       Navigator.of(context).pushNamed(AppRoutes.rateShipmentPage);
          //     },
          //   ),
          // ),
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
