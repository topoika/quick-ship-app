// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../components.dart";

class PackageListItem extends StatelessWidget {
  final Package package;
  const PackageListItem({
    super.key,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<DetailsItemCubit>().setPackageId(package.id!);
        context
            .read<PackageDetailsBloc>()
            .add(GetPackageDetails(id: package.id!));
        Navigator.pushNamed(context, AppRoutes.packageDetails);
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
                TextVariation(
                  text: package.name!,
                  size: 13,
                  weight: FontWeight.w600,
                ),
                statusTag(status: package.status ?? "active"),
              ],
            ),
            const SizedBox(height: 10),
            packageItemTop(),
            const SizedBox(height: 5),
            packageBottom(package: package),
          ],
        ),
      ),
    );
  }
}

Widget packageItemTop() {
  return const Row(
    children: <Widget>[
      TextVariation(
        text: 'Sender',
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
        text: 'Receiver',
        size: 11,
        weight: FontWeight.w500,
        color: Colors.grey,
      ),
    ],
  );
}

Widget packageBottom({required Package package}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextVariation(
              text:
                  "${package.shipper!.name ?? ""} ● ${package.shipper!.phone ?? ""}",
              size: 11,
              weight: FontWeight.w500,
              opacity: .6,
            ),
            const SizedBox(height: 5),
            TextVariation(
              text: getAddressName(package.sourceAddress!),
              size: 12,
              weight: FontWeight.w600,
            ),
          ],
        ),
      ),
      const SizedBox(width: 15),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextVariation(
              text:
                  "${package.recieverName ?? ""} ● ${package.recieverPhone ?? ""}",
              size: 11,
              weight: FontWeight.w500,
              align: TextAlign.right,
              opacity: .6,
            ),
            const SizedBox(height: 5),
            TextVariation(
              text: getAddressName(package.destinationAddress!),
              size: 12,
              align: TextAlign.right,
              weight: FontWeight.w600,
            ),
          ],
        ),
      ),
    ],
  );
}

class PackageRequestListItem extends StatelessWidget {
  final PackageRequest packageRequest;
  const PackageRequestListItem({
    super.key,
    required this.packageRequest,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<DetailsItemCubit>().setRequestId(packageRequest.id!);
        context
            .read<PackageRequestDetailsBloc>()
            .add(FetchPackageRequestDetailsEvent(id: packageRequest.id!));
        Navigator.pushNamed(context, AppRoutes.requestDetails);
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
                TextVariation(
                  text: "Item#${packageRequest.id}",
                  size: 13,
                  weight: FontWeight.w600,
                ),
                statusTag(status: packageRequest.status ?? "pending"),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const TextVariation(
                        text: "Pickup Date",
                        size: 11,
                        weight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      TextVariation(
                        text: tripDateFormat(
                            date: packageRequest.trip?.departure!.dateAndTime ??
                                ""),
                        size: 12,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const TextVariation(
                        text: "Delivery Date",
                        size: 11,
                        align: TextAlign.right,
                        weight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      TextVariation(
                        text: tripDateFormat(
                            date: packageRequest.trip?.departure!.dateAndTime ??
                                ""),
                        align: TextAlign.right,
                        size: 12,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextVariation(
                      text: "Postage Fee",
                      size: 11,
                      weight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 2),
                    TextVariation(
                      text: "Travel Method",
                      size: 11,
                      weight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextVariation(
                      text:
                          formatCurrency(value: packageRequest.postageFee ?? 0),
                      size: 12,
                      weight: FontWeight.w600,
                      align: TextAlign.right,
                    ),
                    const SizedBox(height: 2),
                    TextVariation(
                      text: packageRequest.trip?.travelMethod?.name ?? "",
                      size: 12,
                      weight: FontWeight.w600,
                      align: TextAlign.right,
                    ),
                  ],
                ),
              ],
            ),
            Divider(
                color: Colors.grey.withOpacity(.3), thickness: 1, height: 20),
            Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[400],
                    image: DecorationImage(
                      image: NetworkImage(
                        packageRequest.trip?.postman?.image ?? "",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: const EdgeInsets.only(right: 8),
                  child: packageRequest.trip?.postman?.image == null
                      ? const Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 15,
                        )
                      : const SizedBox(),
                ),
                TextVariation(
                  text: packageRequest.trip?.postman?.name ?? "",
                  size: 13,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
