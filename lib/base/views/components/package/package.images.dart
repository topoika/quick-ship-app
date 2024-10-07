// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../components.dart";

class SliderWithIndicators extends StatefulWidget {
  final List<PackageImage>? images;
  const SliderWithIndicators({
    super.key,
    this.images,
  });

  @override
  _SliderWithIndicatorsState createState() => _SliderWithIndicatorsState();
}

class _SliderWithIndicatorsState extends State<SliderWithIndicators> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.width * 0.85,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            itemCount: widget.images!.length,
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.images![index].url ?? "https://via.placeholder.com/150",
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Visibility(
          visible: widget.images!.length > 1,
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.images!.length; i++) {
      indicators.add(_buildIndicator(i == _currentPage));
    }
    return indicators;
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
          color: isActive ? context.primaryColor : Colors.grey,
          shape: BoxShape.circle),
    );
  }
}

class PackageDetailsWidgetBody extends StatelessWidget {
  final Package package;
  const PackageDetailsWidgetBody({
    super.key,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextVariation(
              text: package.name!,
              size: 17,
              weight: FontWeight.w600,
              color: context.primaryColor,
            ),
            TextVariation(
              text: "Item# ${package.id}",
              size: 12,
              weight: FontWeight.w500,
              opacity: .7,
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomContainer(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    TextVariation(
                      text: "${package.weight?.toStringAsFixed(1) ?? "0"} Kg",
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                    const TextVariation(
                      text: "Weight",
                      size: 10,
                      weight: FontWeight.w500,
                      opacity: .7,
                    ),
                  ],
                ),
              ),
              Container(
                height: 35,
                width: 2,
                decoration: BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    TextVariation(
                      text:
                          "${package.dimLength?.ceil() ?? "0"}' ${package.dimWidth?.ceil() ?? "0"}' ${package.dimHeight?.ceil() ?? "0"}'",
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                    const TextVariation(
                      text: "Dimensions",
                      size: 10,
                      weight: FontWeight.w500,
                      opacity: .7,
                    ),
                  ],
                ),
              ),
              Container(
                height: 35,
                width: 2,
                decoration: BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    TextVariation(
                      text: formatCurrency(value: package.value),
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                    const TextVariation(
                      text: "Value",
                      size: 10,
                      weight: FontWeight.w500,
                      opacity: .7,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            TextVariation(
              text: "Note to Postman",
              size: 14,
              weight: FontWeight.w500,
              color: context.primaryColor,
            ),
            CustomContainer(
              child: Column(
                children: <Widget>[
                  detailsItem(txt: package.postManNote!, value: ""),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextVariation(
          text: "Description",
          size: 14,
          weight: FontWeight.w500,
          color: context.primaryColor,
        ),
        TextVariation(
          text: package.description!,
          size: 11,
          weight: FontWeight.w400,
          opacity: .7,
        ),
        const SizedBox(height: 10),
        TextVariation(
          text: "Take off Address",
          size: 14,
          weight: FontWeight.w500,
          color: context.primaryColor,
        ),
        CustomContainer(
          child: Column(
            children: <Widget>[
              detailsItem(
                txt: "Address",
                value: package.sourceAddress?.nameAddress,
              ),
              detailsItem(
                txt: "City",
                value: package.sourceAddress?.city,
              ),
              detailsItem(
                txt: "Meeting Point",
                value: package.sourceAddress?.meetingPoint,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        TextVariation(
          text: "Delivery Address",
          size: 14,
          weight: FontWeight.w500,
          color: context.primaryColor,
        ),
        CustomContainer(
          child: Column(
            children: <Widget>[
              detailsItem(
                txt: "Address",
                value: package.destinationAddress?.nameAddress,
              ),
              detailsItem(
                txt: "City",
                value: package.destinationAddress?.city,
              ),
              detailsItem(
                txt: "Meeting Point",
                value: package.destinationAddress?.meetingPoint,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        CustomContainer(
          child: Column(
            children: <Widget>[
              detailsItem(
                txt: "Date",
                value: package.dateOfShipment,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],
      ),
      child: child,
    );
  }
}

class ContactShipper extends StatelessWidget {
  final Package package;
  const ContactShipper({
    super.key,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          margin: const EdgeInsets.only(top: 10, bottom: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.06),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextVariation(
                  text: "Shipper",
                  size: 14,
                  weight: FontWeight.w600,
                  color: context.primaryColor),
              TextVariation(
                text: package.shipper?.name ?? "Shipper",
                size: 16,
                weight: FontWeight.w600,
                color: context.primaryColor,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            onTap: () {
              // TODO: Navigate to chat screen
              // Navigator.pushNamed(context, AppStrings.chat);
            },
            child: Row(
              children: <Widget>[
                Image.asset(
                  AppStrings.chatActive,
                  height: 22,
                  color: Colors.black,
                ),
                const SizedBox(width: 10),
                TextVariation(
                  text: "Contact Shipper",
                  size: 14,
                  weight: FontWeight.w500,
                  color: context.primaryColor,
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: context.primaryColor,
                  size: 20,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
