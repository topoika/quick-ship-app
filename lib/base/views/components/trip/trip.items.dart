part of "../components.dart";

class TripItem extends StatelessWidget {
  final Trip trip;
  const TripItem({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<DetailsItemCubit>().setTripId(trip.id!);
        context
            .read<TripDetailsBloc>()
            .add(FetchTripDetailsEvent(id: trip.id!));
        Navigator.pushNamed(context, AppRoutes.tripDetails);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.primaryColor.withOpacity(.1),
                  ),
                  child: QImage(
                    imageUrl: trip.travelMethod!.icon!,
                    height: 12,
                    color: context.primaryColor,
                  ),
                ),
                statusTag(status: trip.status ?? "active"),
              ],
            ),
            const SizedBox(height: 8),
            topPart(),
            const SizedBox(height: 8),
            bottomPart(trip),
          ],
        ),
      ),
    );
  }
}

Widget statusTag({required String status}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
    decoration: BoxDecoration(
      color: statusColor(status),
      borderRadius: BorderRadius.circular(50),
    ),
    child: TextVariation(
      text: capitalize(status) ?? "",
      color: Colors.white,
      size: 9,
    ),
  );
}

Widget bottomPart(Trip trip) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextVariation(
              text: getAddressName(trip.departure!),
              size: 11,
              weight: FontWeight.w600,
            ),
            const SizedBox(height: 5),
            TextVariation(
              text: tripDateFormat(date: trip.departure!.dateAndTime!),
              size: 11,
              weight: FontWeight.w500,
              color: Colors.black45,
            ),
          ],
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextVariation(
                text: getAddressName(trip.destination!),
                size: 11,
                align: TextAlign.right,
                weight: FontWeight.w600),
            const SizedBox(height: 5),
            TextVariation(
              text: tripDateFormat(date: trip.destination!.dateAndTime!),
              size: 11,
              align: TextAlign.right,
              weight: FontWeight.w500,
              color: Colors.black45,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget topPart() {
  return const Row(
    children: <Widget>[
      TextVariation(
        text: 'Departure',
        size: 11,
        weight: FontWeight.w500,
        color: Colors.grey,
      ),
      Expanded(
        child: Row(
          children: <Widget>[
            SizedBox(width: 10),
            Expanded(
              child: Divider(color: Color(0xffF95959), thickness: 1),
            ),
            SizedBox(width: 3),
            Icon(
              Icons.location_on_rounded,
              size: 14,
              color: Color(0xffF95959),
            ),
            SizedBox(width: 3),
            Expanded(
              child: Divider(color: Color(0xffF95959), thickness: 1),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
      TextVariation(
        text: 'Destination',
        size: 11,
        weight: FontWeight.w500,
        color: Colors.grey,
      ),
    ],
  );
}

Widget detailsItem({required String txt, String? value}) {
  return Visibility(
    visible: value != null,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextVariation(
            text: txt,
            size: 12,
            weight: FontWeight.w500,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 15),
          Flexible(
            child: TextVariation(
              text: value ?? "",
              size: 11,
              weight: FontWeight.w600,
              align: TextAlign.right,
            ),
          ),
        ],
      ),
    ),
  );
}

Color statusColor(String status) {
  switch (status) {
    case 'pending':
      return Colors.blue;
    case "completed":
      return Colors.green;
    case "cancelled":
      return Colors.red;
    default:
      return Colors.orange;
  }
}
