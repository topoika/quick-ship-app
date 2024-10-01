// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../components.dart";

class ImagesWidget extends StatelessWidget {
  final List<File> packageImage;
  final Function onRemoveLocal;
  const ImagesWidget({
    super.key,
    required this.packageImage,
    required this.onRemoveLocal,
  });

  @override
  Widget build(BuildContext context) {
    Package package = context.watch<NewItemCubit>().package;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        height: context.height * 0.25,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            ...packageImage.map(
              (i) => Container(
                margin: const EdgeInsets.only(right: 15),
                height: context.height * 0.25,
                width: context.width * 0.7,
                alignment: Alignment.topRight,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.primaryColor,
                  image: DecorationImage(
                    image: FileImage(i),
                    fit: BoxFit.cover,
                  ),
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () => onRemoveLocal(packageImage.indexOf(i)),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ),
            ...(package.images ?? []).map(
              (i) => Container(
                margin: const EdgeInsets.only(right: 15),
                height: context.height * 0.25,
                width: context.width * 0.7,
                alignment: Alignment.topRight,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.primaryColor,
                  image: DecorationImage(
                    image: NetworkImage(i.url ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    package.images!.removeAt(package.images!.indexOf(i));
                    setPackage(package: package, context: context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: context.height * 0.125,
              width: context.width * 0.7,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

void setPackage({required Package package, required BuildContext context}) {
  context.read<NewItemCubit>().setPackage(package);
}
