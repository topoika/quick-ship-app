// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../components.dart";

class ListLoadingWidget extends StatelessWidget {
  final double? height;
  final double? padding;
  final int? itemCount;
  const ListLoadingWidget({
    super.key,
    this.height,
    this.padding,
    this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount ?? 10,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: padding ?? context.horPad),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: shimmerContainer(
            context,
            height ?? 100,
            double.maxFinite,
            5,
          ),
        );
      },
    );
  }
}

Widget shimmerContainer(context, double h, double w, double r) =>
    Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 209, 208, 208),
      highlightColor: const Color.fromARGB(255, 150, 148, 148),
      period: const Duration(seconds: 2),
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(r),
          color: const Color.fromARGB(223, 209, 207, 207),
        ),
      ),
    );
