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
        context.read<DetailsItemCubit>().setId(package.id!);
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
