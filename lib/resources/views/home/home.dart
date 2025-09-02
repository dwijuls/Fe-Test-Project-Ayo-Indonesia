import 'package:fetestproject/helpers/constants.dart';
import 'package:fetestproject/helpers/drawable.dart';
import 'package:fetestproject/helpers/responsive.dart';
import 'package:fetestproject/resources/global/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: constants.primaryColor,
      //   centerTitle: true,
      //   title: Text(
      //     "FE Test Project",
      //     overflow: TextOverflow.ellipsis,
      //     style: TextStyle(
      //       fontFamily: 'Rubik',
      //       fontWeight: FontWeight.w600,
      //       fontSize: 16.0,
      //       color: Colors.white,
      //     ),
      //   ),
      //   elevation: 0,
      // ),
      body: ResponsiveLayout(
        mobile: _buildHomeNav(context, crossAxis: 1.0),
        tablet: _buildHomeNav(context, crossAxis: 2.0),
        desktop: _buildHomeNav(context, crossAxis: 4.0),
      ),
    );
  }

  Widget _buildHomeNav(BuildContext context, {double crossAxis = 1}){
    return SingleChildScrollView(
      // controller: _scrollController,
      physics: ClampingScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: constants.primaryColor,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Center(
                child: Image.asset(
                  DrawableX.imageAsset(AssetGambar.backAccent),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi,",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Berikut ini test project FE yang sudah saya kerjakan.",
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      crossAxisSpacing: 10.0, // Spacing between columns
                      mainAxisSpacing: 10.0, // Spacing between rows
                      childAspectRatio: crossAxis, // Aspect ratio of each grid item
                    ),
                    // physics: AlwaysScrollableScrollPhysics(),
                    itemCount: 4, // Number of items in the grid
                    padding: EdgeInsets.all(15.0), // Padding around the grid
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          context.go((index + 1) == 1 ? '/one' : (index + 1) == 2 ? '/two' : (index + 1) == 3 ? '/three' : '/four');
                        },
                        child: Card(
                          // Apply border radius to the Card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // Adjust radius as needed
                          ),
                          elevation: 2.0, // Optional: Add a subtle shadow
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.auto_graph, size: 80.0, color: constants.primaryColor,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(
                                    'Leaderboard ${index + 1}',
                                    style: TextStyle(fontFamily: 'Rubik', fontSize: 14.0, color: constants.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      GlobalBottomsheet().createState().showDeveloperInfo(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: constants.secondaryColor,
                      foregroundColor: Colors.white, // Example: white text
                    ),
                    child: Text('Developer Detail', style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
