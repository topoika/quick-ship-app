part of "../../pages.dart";

class RateShipmentPage extends StatelessWidget {
  const RateShipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsItemCubit = context.watch<DetailsItemCubit>();
    int rating = detailsItemCubit.state.rating ?? 5;
    double tip = detailsItemCubit.state.tip ?? 0.0;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 72,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin:
                EdgeInsets.symmetric(horizontal: context.horPad, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey[300]!,
              ),
            ),
            height: 10,
            width: 10,
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
        ),
        title: const TextVariation(
          text: "Rate Shipment",
          size: 15,
          weight: FontWeight.w600,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.horPad),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 75),
                  const TextVariation(
                    text: "Rate your experience",
                    size: 20,
                    weight: FontWeight.w600,
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  const TextVariation(
                    text:
                        "Let us know how good was your experience with the Shawn Mentes.",
                    size: 12,
                    color: Colors.grey,
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [1, 2, 3, 4, 5].map((e) {
                      bool checked = (rating >= e);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            detailsItemCubit.setRating(e);
                          },
                          child: Icon(
                            Icons.star,
                            color: checked
                                ? context.primaryColor
                                : Colors.grey.withOpacity(.5),
                            size: 44,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 55),
                  Divider(
                      color: Colors.grey.withOpacity(.5),
                      thickness: .8,
                      height: 10),
                  const SizedBox(height: 55),
                  const TextVariation(
                    text: "Tip the Postman",
                    size: 20,
                    weight: FontWeight.w600,
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  const TextVariation(
                    text: "You can add a tip to the postman",
                    size: 12,
                    color: Colors.grey,
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [0, 50, 100, 200].map((e) {
                      bool checked = (tip == e);
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () => detailsItemCubit.setTip(e.toDouble()),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: checked
                                    ? context.primaryColor
                                    : Colors.grey.withOpacity(.5)),
                            child: TextVariation(
                              text:
                                  e == 0 ? "No Tip" : formatCurrency(value: e),
                              size: 10,
                              color: checked ? Colors.white : Colors.black,
                              weight: FontWeight.w600,
                              align: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 20,
                bottom: context.height * 0.05,
                left: context.horPad,
                right: context.horPad),
            child: PrimaryButton(
              text: tip > 0 ? "Pay Now" : "Done",
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
