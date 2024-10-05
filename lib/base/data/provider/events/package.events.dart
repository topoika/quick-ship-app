part of "../export.provider.dart";

class PackageEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUserPackages extends PackageEvents {}

class CreatePackageEvent extends PackageEvents {
  final Package package;
  final List<File> images;
  CreatePackageEvent({required this.package, required this.images});
}

class UpdatePackage extends PackageEvents {
  final Package package;
  final List<File> images;
  UpdatePackage({required this.package, required this.images});
}

class DeletePackage extends PackageEvents {
  final int id;
  DeletePackage({required this.id});
}

class GetPackageDetails extends PackageEvents {
  final int id;
  GetPackageDetails({required this.id});
}
