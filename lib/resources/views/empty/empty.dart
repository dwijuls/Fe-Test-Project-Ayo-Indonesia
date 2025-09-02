import 'package:fetestproject/helpers/constants.dart';
import 'package:fetestproject/helpers/drawable.dart';
import 'package:fetestproject/helpers/responsive.dart';
import 'package:fetestproject/resources/global/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmptyPage extends StatefulWidget {
  const EmptyPage({super.key});

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constants.primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 15.0,
          ), // The back arrow icon
          onPressed: () {
            // This navigates back to the previous screen in the navigation stack
            context.go("/");
          },
        ),
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                "[CurrentSession]",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 5.0),
            Icon(Icons.arrow_drop_down_circle, color: Colors.white, size: 20.0),
          ],
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              GlobalBottomsheet().createState().showBottomSheetQuestion(context);
            },child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ), // Set the desired radius
              ),
              color: constants.iconBack,
              elevation: 2.0, // Optional: Add a shadow to the card
              margin: EdgeInsets.all(5.0), // Optional: Add margin around the card
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  DrawableX.imageAsset(AssetGambar.iconsQuestion),
                  width: 20.0,
                  height: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ResponsiveLayout(
        mobile: _buildList(context, crossAxis: 1),
        tablet: _buildList(context, crossAxis: 2),
        desktop: _buildList(context, crossAxis: 4),
      ),
    );
  }

  Widget _buildList(BuildContext context, {int crossAxis = 1}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: constants.primaryColor,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Center(child: Image.asset(DrawableX.imageAsset(AssetGambar.backAccent), fit: BoxFit.fill,)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 120.0,
                      child: _buildDropdown("Mini Soccer", [
                        "Mini Soccer",
                        "Futsal",
                        "Padel",
                      ], ''),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 120.0,
                      child: _buildDropdown("Surabaya", [
                        "Surabaya",
                        "Jakarta",
                        "Bandung",
                      ], 'loc'),
                    ),
                  ],
                ),
              ),
              Expanded(child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: Image.asset(DrawableX.imageAsset(AssetGambar.iconsEmpty)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0, bottom: 5.0),
                      child: Text(
                        'Leaderboard belum tersedia',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0, bottom: 15.0),
                      child: Text(
                        'Jadilah yang pertama untuk memulai pertandingan dan raih posisi terbaikmu!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/one');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.white, // Example: white text
                        ),
                        child: Text('Mulai Tanding', style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w600,
                            color: constants.primaryColor
                        ),),
                      ),
                    )
                  ],
                ),
              ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // Reusable rounded dropdown
  Widget _buildDropdown(String value, List<String> items, String type) {
    return Container(
      height: 30.0,
      width: type == 'loc' ? 20.0 : 50.0,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: items
              .map(
                (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
                style: TextStyle(fontSize: 12.0, fontFamily: 'Rubik'),
              ),
            ),
          )
              .toList(),
          onChanged: (val) {},
        ),
      ),
    );
  }
}
