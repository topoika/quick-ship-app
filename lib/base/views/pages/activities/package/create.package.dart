part of "../../pages.dart";

class CreatePackage extends StatefulWidget {
  const CreatePackage({super.key});

  @override
  State<CreatePackage> createState() => _CreatePackageState();
}

class _CreatePackageState extends State<CreatePackage> {
  List<File> packageImage = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Package package = context.watch<NewItemCubit>().package;
    bool isEdit = package.id != null;
    return PopScope(
      canPop: true,
      onPopInvoked: (val) {
        homeSysSettings();
      },
      child: Scaffold(
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
          title: TextVariation(
            text: isEdit ? "Edit Package" : "Create Package",
            size: 15,
            weight: FontWeight.w600,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.horPad),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 15),
                  const TextVariation(
                    text: "Package Images",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: () {
                      showPickOptionsDialog(
                        context,
                        () => takePackageImage(context).then(
                            (val) => setState(() => packageImage.add(val))),
                        () => loadImages(context).then((val) {
                          setState(() => packageImage.addAll(val));
                        }),
                        profile: true,
                      );
                    },
                    child: packageImage.isEmpty && !isEdit
                        ? Container(
                            height: context.height * 0.2,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.primaryColor.withOpacity(.2),
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.image_outlined, size: 42),
                                Text(
                                  'Upload Package Images',
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ImagesWidget(
                            packageImage: packageImage,
                            onRemoveLocal: (int i) {
                              setState(() => packageImage.removeAt(i));
                            },
                          ),
                  ),
                  const SizedBox(height: 10),
                  NewItemInputField(
                    hint: "Item Name",
                    type: "item_name",
                    onSaved: (value) => package.name = value,
                  ),
                  NewItemInputField(
                    hint: "Item Value",
                    type: "money",
                    onSaved: (value) => package.value = double.parse(value!),
                  ),
                  NewItemInputField(
                    hint: "Package Description",
                    type: "description",
                    onSaved: (value) => package.description = value,
                  ),
                  const SizedBox(height: 10),
                  const TextVariation(
                    text: "Do you want to insure this package?",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  Row(
                    children: <Widget>[
                      radioItem(true, package.insurance, "Yes", (val) {
                        package.insurance = val;
                        setPackage(package: package, context: context);
                      }),
                      radioItem(false, package.insurance, "No", (val) {
                        package.insurance = val;
                        setPackage(package: package, context: context);
                      }),
                    ],
                  ),
                  Visibility(
                    visible: package.insurance!,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: NewItemInputField(
                        hint: "Approximate Insurance Amount",
                        type: "money",
                        onSaved: (value) =>
                            package.approximateValue = double.parse(value!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const TextVariation(
                    text: "Did you pack this package yourself?",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  Row(
                    children: <Widget>[
                      radioItem(true, package.packBySender, "Yes", (val) {
                        package.packBySender = val;
                        setPackage(package: package, context: context);
                      }),
                      radioItem(false, package.packBySender, "No", (val) {
                        package.packBySender = val;
                        setPackage(package: package, context: context);
                      }),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const TextVariation(
                    text: "Shipment Address",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  SelectInputField(
                    hint: "Departure Address",
                    value: package.sourceAddress?.nameAddress,
                    hasValue: package.sourceAddress?.nameAddress != null,
                    onTap: () async {
                      await pickLocation(
                              context: context, address: package.sourceAddress)
                          .then((value) {
                        if (value != null) {
                          package.sourceAddress = value;
                          setPackage(package: package, context: context);
                        }
                      });
                    },
                  ),
                  NewItemInputField(
                    hint: "Neareby Place",
                    type: "address",
                    onSaved: (value) {
                      package.sourceAddress?.meetingPoint = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  const TextVariation(
                    text: "Destination Address",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  SelectInputField(
                    hint: "Destination Address",
                    value: package.destinationAddress?.nameAddress,
                    hasValue: package.destinationAddress?.nameAddress != null,
                    onTap: () async {
                      await pickLocation(
                              context: context,
                              address: package.destinationAddress)
                          .then((value) {
                        if (value != null) {
                          package.destinationAddress = value;
                          setPackage(package: package, context: context);
                        }
                      });
                    },
                  ),
                  NewItemInputField(
                    hint: "Neareby Place",
                    type: "address",
                    onSaved: (value) {
                      package.destinationAddress?.meetingPoint = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  const TextVariation(
                    text: "Size/Dimensions(cm)",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: NewItemInputField(
                          hint: "Length",
                          type: "number",
                          init: package.dimLength?.toString(),
                          onSaved: (value) =>
                              package.dimLength = double.parse(value!),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: NewItemInputField(
                          hint: "Width",
                          type: "number",
                          init: package.dimWidth?.toString(),
                          onSaved: (value) =>
                              package.dimWidth = double.parse(value!),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: NewItemInputField(
                          hint: "Height",
                          type: "number",
                          init: package.dimHeight?.toString(),
                          onSaved: (value) =>
                              package.dimHeight = double.parse(value!),
                        ),
                      ),
                    ],
                  ),
                  NewItemInputField(
                    hint: "Weight (kg)",
                    type: "number",
                    init: package.weight?.toString(),
                    onSaved: (value) => package.weight = double.parse(value!),
                  ),
                  const SizedBox(height: 10),
                  const TextVariation(
                    text: "Reciever Details",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  NewItemInputField(
                    hint: "Receiver’s Name",
                    type: "name",
                    init: package.recieverName,
                    onSaved: (value) {
                      package.recieverName = value;
                    },
                  ),
                  NewItemInputField(
                    hint: "Receiver’s Mobile",
                    type: "phone_number",
                    init: package.recieverPhone,
                    onSaved: (value) {
                      package.recieverPhone = value;
                    },
                  ),
                  NewItemInputField(
                    hint: "Alternate Mobile No.",
                    type: "phone_number",
                    init: package.recieverAltPhone,
                    onSaved: (value) {
                      package.recieverAltPhone = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  const TextVariation(
                    text: "Note for Postman",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  NewItemInputField(
                    hint: "Note to Postman",
                    type: "description",
                    init: package.postManNote,
                    onSaved: (value) => package.postManNote = value,
                  ),
                  const SizedBox(height: 10),
                  const TextVariation(
                    text: "Date",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  SelectInputField(
                    hint: "Date",
                    value: package.dateOfShipment,
                    hasValue: package.dateOfShipment != null,
                    onTap: () async {
                      await pickDate(context).then((value) {
                        if (value != null) {
                          package.dateOfShipment = formatToDate(date: value);
                          setPackage(package: package, context: context);
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocListener<PackageBloc, PackageStates>(
                    listener: (context, state) {
                      if (state is PackageCreated) {
                        showCustomToast(
                            message: "Package created successfully",
                            type: "suc");
                        context.read<PackageBloc>().add(FetchUserPackages());
                        context
                            .read<PackageDetailsBloc>()
                            .add(GetPackageDetails(id: state.package.id!));
                        context.read<NewItemCubit>().clear();
                        context
                            .read<DetailsItemCubit>()
                            .setPackageId(state.package.id!);
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.packageDetails);
                      } else if (state is PackageUpdated) {
                        showCustomToast(
                            message: "Package updated successfully",
                            type: "success");
                        context.read<PackageBloc>().add(FetchUserPackages());
                        context.read<NewItemCubit>().clear();
                        context
                            .read<DetailsItemCubit>()
                            .setPackageId(state.package.id!);
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.packageDetails);
                      } else if (state is PackageError) {
                        showCustomToast(message: state.message, type: "err");
                      }
                    },
                    child: BlocBuilder<PackageBloc, PackageStates>(
                      builder: (context, state) {
                        return PrimaryButton(
                          text: "Submit",
                          loading: state is PackageLoading,
                          onPressed: () {
                            validationErrors.clear();
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              if (packageImage.isEmpty && !isEdit) {
                                showCustomToast(
                                    message: "Please upload package images",
                                    type: "err");
                              } else {
                                if (isEdit) {
                                  context.read<PackageBloc>().add(UpdatePackage(
                                      package: package, images: packageImage));
                                } else {
                                  context.read<PackageBloc>().add(
                                      CreatePackageEvent(
                                          package: package,
                                          images: packageImage));
                                }
                              }
                            } else {
                              if (validationErrors.isNotEmpty) {
                                showCustomToast(
                                    message: validationErrors[0], type: "err");
                              }
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
