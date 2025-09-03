import 'package:fetestproject/controller/main_controller.dart';
import 'package:fetestproject/helpers/constants.dart';
import 'package:fetestproject/helpers/drawable.dart';
import 'package:fetestproject/helpers/responsive.dart';
import 'package:fetestproject/models/rank_models.dart';
import 'package:fetestproject/resources/global/bottomsheet.dart';
import 'package:fetestproject/services/bloc/rank_bloc.dart';
import 'package:fetestproject/services/state/rank_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LeaderBoardOne extends StatefulWidget {
  const LeaderBoardOne({super.key});

  @override
  State<LeaderBoardOne> createState() => _LeaderBoardOneState();
}

class _LeaderBoardOneState extends State<LeaderBoardOne> {
  final _mainCtrl = Get.find<MainController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GlobalBottomsheet().createState().showBottomSheetPodiumList(context);
    });
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
        title: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            GlobalBottomsheet().createState().showBottomSheetSelectSeason(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Obx(()=>Text(
                  _mainCtrl.selectPeriodeName.value !='' ? _mainCtrl.selectPeriodeName.value : "[Current Season]",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                )),
              ),
              SizedBox(width: 5.0),
              Icon(Icons.arrow_drop_down_circle, color: Colors.white, size: 20.0),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              GlobalBottomsheet().createState().showBottomSheetQuestion(context);
            },
            child: Card(
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
      body: BlocBuilder<RankBloc, RankState>(
        builder: (context, state) {
          if (state is RankInit || state is RankLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RankLoaded) {
            return ResponsiveLayout(
              mobile: _buildList(context, state.rankingItems, crossAxis: 1),
              tablet: _buildList(context, state.rankingItems, crossAxis: 2),
              desktop: _buildList(context, state.rankingItems, crossAxis: 4),
            );
          }
          return const Center(child: Text('Failed to load data'));
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<RankModels> items, {int crossAxis = 1}) {
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
              // Top dropdowns
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Obx(()=>Row(
                  children: [
                    _buildDropdown("sports"),
                    _mainCtrl.setHideCat.value ? SizedBox.shrink() : const SizedBox(width: 12),
                    _mainCtrl.setHideCat.value ? SizedBox.shrink() : _buildDropdown("cat"),
                    const SizedBox(width: 12),
                    _buildDropdown("loc"),
                  ],
                )),
              ),
              const SizedBox(height: 5),
              // Card
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 15.0,
                  right: 15.0,
                  bottom: 10.0
                ),
                child: Stack(
                  children: [
                    // Footer
                    Container(
                      margin: const EdgeInsets.only(top: 60.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4D37A5),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        top: 20.0,
                        bottom: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Flexible(
                            child: Text(
                              "Komunitasmu peringkat #456, bagikan yuk!",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Rubik',
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 5.0,),
                          Icon(Icons.share_outlined, color: Colors.white, size: 15.0,),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Circle icon
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.orange,
                                ),
                                child: Image.asset(
                                  DrawableX.imageAsset(AssetGambar.iconsAvatar),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Team name & location
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Far East United",
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                      "Surabaya",
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 13.0,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Points badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: constants.primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  "50 Pts",
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 10.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildPodiumPlace(
                        place: items[1].id,
                        name: items[1].name,
                        points: "${items[1].points} Pts",
                        color: constants.secondaryColor,
                        value: double.parse(items[1].points.toString()),
                        maxValue: MediaQuery.of(context).size.height,
                        avatarColor: Colors.teal,
                        icon: items[1].icon,
                      ),
                      const SizedBox(width: 15),
                      _buildPodiumPlace(
                        place: items[0].id,
                        name: items[0].name,
                        points: "${items[0].points} Pts",
                        color: constants.secondaryColor,
                        value: double.parse(items[0].points.toString()),
                        maxValue: MediaQuery.of(context).size.height,
                        avatarColor: constants.secondaryColor,
                        icon: items[0].icon,
                      ),
                      const SizedBox(width: 15),
                      _buildPodiumPlace(
                        place: items[2].id,
                        name: items[2].name,
                        points: "${items[2].points} Pts",
                        color: constants.secondaryColor,
                        value: double.parse(items[2].points.toString()),
                        maxValue: MediaQuery.of(context).size.height,
                        avatarColor: constants.secondaryColor,
                        icon: items[2].icon,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Reusable rounded dropdown
  Widget _buildDropdown(String type) {
    return Expanded(
      child: GestureDetector(
        onTap: type== 'sports' ? (){
          GlobalBottomsheet().createState().showBottomSheetSelectSports(context);
        } : type == 'cat' ? (){
          GlobalBottomsheet().createState().showBottomSheetSelectCategory(context);
        } : (){
          GlobalBottomsheet().createState().showProvinceBottomSheet(context);
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 35.0,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            children: [
              Expanded(child: type== 'sports' ? Obx(()=>Text(_mainCtrl.selectSportsName.value,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w400,
                fontSize: 12.0
              ),)) : type== 'cat' ? Obx(()=>Text(_mainCtrl.selectCatName.value,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0
                ),)) : Obx(()=>Text(_mainCtrl.selectLocName.value,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0
                ),))),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPodiumPlace({
    required int place,
    required String name,
    required String points,
    required Color color,
    required double value,       // raw bar value (e.g. points)
    required double maxValue,
    required Color avatarColor,
    required String icon,
  }) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final maxBarHeight = deviceHeight * 1.0; // max = 30% of screen height

    final barHeight = (value / maxValue) * maxBarHeight;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar + Name + Points
        Column(
          children: [
            place == 1 ? Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: avatarColor,
                  child: Image.asset(icon),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 45.0,
                    left: 20,
                    right: 20,),
                    child: Image.asset(DrawableX.imageAsset(AssetGambar.iconsCrown)))
              ],
            ) : CircleAvatar(
              radius: 28,
              backgroundColor: avatarColor,
              child: Image.asset(icon),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                points,
                style: TextStyle(
                  color: constants.secondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Podium Bar
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              GlobalBottomsheet().createState().showBottomSheetPodiumList(context);
            },
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                  ),
                ),
                Positioned(
                  top: 8,
                  child: Text(
                    "$place",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


}
