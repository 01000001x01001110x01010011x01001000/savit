import 'package:flutter/material.dart';
import 'package:savit/helper_classes/app_colors.dart';
import 'package:savit/helper_classes/app_constants.dart';
import 'package:savit/helper_classes/app_images.dart';
import 'package:savit/helper_classes/custom_appbar.dart';
import 'package:savit/helper_classes/style.dart';
import 'package:savit/views/meets/meets_home.dart';
import 'package:savit/views/notes/notes_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.baseGreenColor,
          drawer: Drawer(
            backgroundColor: AppColors.drawerBackgroundColor,
            width: AppConstants.mobileWidth * 0.6,
          ),
          floatingActionButton: GestureDetector(
            onTap: tabController?.index == 0
                ? () async {
                    await addMeetPopup();
                  }
                : () {},
            child: Image.asset(
              AppImages.addButton,
              height: AppConstants.mobileHeight * 0.12,
            ),
          ),
          appBar: CustomAppBar().customAppBar(context),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
                gradient: LinearGradient(
                  colors: [
                    AppColors.lightGreyColor,
                    AppColors.lightGreenColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: tabController,
                    tabs: const [
                      Tab(
                        text: AppConstants.meets,
                      ),
                      Tab(
                        text: AppConstants.notes,
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: const [
                        MeetsHome(),
                        NotesHome(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addMeetPopup() {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController dobController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController reasonController = TextEditingController();
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: AppConstants.mobileWidth,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            gradient: LinearGradient(
              colors: [
                AppColors.lightGreenColor,
                AppColors.lightGreyColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: AppConstants.paddingHeight * 0.5,
              ),
              Text(
                AppConstants.clickOutsideToClose,
                style: Style.descriptionTextStyle,
              ),
              SizedBox(
                height: AppConstants.paddingHeight * 0.5,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: AppConstants.name,
                  hintStyle: Style.cardNameStyle,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.baseGreenColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppConstants.paddingHeight * 0.5,
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  hintText: AppConstants.name,
                  hintStyle: Style.cardNameStyle,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.baseGreenColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
