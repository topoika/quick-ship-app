part of "../components.dart";

class QImage extends StatelessWidget {
  const QImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.fit = BoxFit.cover,
    this.color,
    super.key,
    this.cacheHeight,
    this.cacheWidth,
    this.radius = 0,
  });

  final String imageUrl;
  final double radius;
  final Alignment alignment;
  final BoxFit fit;
  final Color? color;
  final double? height;
  final double? width;
  final double? cacheHeight;
  final double? cacheWidth;

  @override
  Widget build(BuildContext context) {
    const errorImg = AppStrings.placeholderImage;
    final image = imageUrl.isEmpty ? errorImg : imageUrl;

    final isNetworked = image.startsWith('http');
    final isSvg = image.endsWith('.svg');
    final isNotSvg = image.startsWith('assets/') && !isSvg;

    final colorFilter =
        color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null;

    final errorWidget = Image.asset(
      errorImg,
      width: width,
      height: height,
      fit: fit,
    );
    if (isNotSvg) {
      return Image.asset(
        image,
        width: width,
        height: height,
        fit: fit,
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: switch ((isNetworked, isSvg)) {
          (false, false) => Image.asset(
              image,
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
              color: color,
              errorBuilder: (_, o, s) => errorWidget,
            ),
          (false, true) => SvgPicture.asset(
              image,
              width: width,
              height: height,
              colorFilter: colorFilter,
              fit: fit,
              alignment: alignment,
            ),
          (true, false) => CachedNetworkImage(
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
              imageUrl: image,
              errorWidget: (_, s, o) => errorWidget,
              placeholder: (context, val) =>
                  LoadingWidget(width: width, height: height, radius: radius),
            ),
          (true, true) => SvgPicture.network(
              image,
              width: width,
              height: height,
              colorFilter: colorFilter,
              fit: fit,
              alignment: alignment,
            ),
        },
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  const LoadingWidget({super.key, this.height, this.width, this.radius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height ?? double.maxFinite,
        width: width ?? double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
      ),
    );
  }
}
