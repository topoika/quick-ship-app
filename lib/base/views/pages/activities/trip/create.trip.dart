part of "../../pages.dart";

class CreateTrip extends StatelessWidget {
  const CreateTrip({super.key});

  @override
  Widget build(BuildContext context) {
    Trip trip = Trip();
    bool isEdit = trip.id != null;
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
        title: TextVariation(
          text: isEdit ? "Edit Trip" : "Create Trip",
          size: 15,
          weight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.horPad),
          child: const Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15),
                TextVariation(
                  text: "Select a Travel Method",
                  size: 16,
                  weight: FontWeight.w600,
                ),
                SizedBox(height: 10),
                TravelMethodWidget(),
                YouAreAWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
