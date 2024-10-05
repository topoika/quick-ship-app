part of "../pages.dart";

class ShipmentsPage extends StatelessWidget {
  const ShipmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextVariation(
          text: "Shipments",
          size: 15,
          weight: FontWeight.w600,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.horPad),
            child: const NotificationButton(),
          ),
        ],
      ),
      body:

          // ListView.builder(
          //   itemCount: 10,
          //   shrinkWrap: true,
          //   padding: EdgeInsets.symmetric(horizontal: context.horPad),
          //   itemBuilder: (context, index) {
          //     return ShipmentItemWidget(shipment: Shipment());
          //   },
          // ),

          Center(
        child: ErrorNoDataWidget(
          type: "no-data",
          message: "No shipments yet",
          onRetry: () {},
        ),
      ),
    );
  }
}
