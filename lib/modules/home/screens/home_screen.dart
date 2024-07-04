import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/components/background_widget.dart';
import 'package:machine_test/core_utils/app_colors.dart';
import 'package:machine_test/core_utils/app_dimens.dart';
import 'package:machine_test/core_utils/app_style.dart';
import 'package:provider/provider.dart';

import '../../../network/models/response/auth/login_response.dart';
import '../../../network/models/response/user/user_modal.dart';
import '../home_provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  final UserRecord? record;

  const HomeScreen({super.key, this.record});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.fetchUserList();
    },);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        leading: Row(
          children: [
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.record!.profileImg!),
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.record!.firstName} ${widget.record!.lastName}',
              style: AppTextStyle.euclidMedium(
                  AppDimens.fontSize16, AppColors.color212226),
            ),
            Text(
              widget.record!.email.toString(),
              style: AppTextStyle.euclidRegular(
                  AppDimens.fontSize12, AppColors.color949BA5),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: backgroundImg(child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              await userProvider.refreshUserList();
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!userProvider.isLoadingMore &&
                    userProvider.hasMore &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  userProvider.fetchUserList(isLoadMore: true);
                }
                return false;
              },
              child: _isGridView
                  ? GridView.builder(
                padding: EdgeInsets.symmetric(vertical: AppDimens.height10),
                itemCount: userProvider.userList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.w / 2.5.h,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  final user = userProvider.userList[index];
                  return _buildUserGridCard(user);
                },
              )
                  : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: AppDimens.height10),
                itemCount: userProvider.userList.length,
                itemBuilder: (context, index) {
                  final user = userProvider.userList[index];
                  return _buildUserListCard(user);
                },
              ),
            ),
          );
        },
      ), context: context),
    );
  }

  Widget _buildUserListCard(User user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.white,
        shape: Border.all(color: AppColors.colorDCDEDF),
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: Text('${user.email} ${user.phoneNo}'),
        trailing: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.radius8),
              border: Border.all(color: AppColors.color0084FF)),
          child: Text(
            'View profile',
            style: AppTextStyle.euclidRegular(
                AppDimens.fontSize14, AppColors.color0084FF),
          ),
        ),
      ),
    );
  }

  Widget _buildUserGridCard(User user) {
    return Card(color: AppColors.whiteColor,
      shape: Border.all(color: AppColors.colorDCDEDF),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Text('${user.firstName} ${user.lastName}'),
            SizedBox(height: AppDimens.height5,),

           Text('${user.email} ',maxLines: 1,overflow: TextOverflow.ellipsis,),
            SizedBox(height: AppDimens.height5,),

           Text(user.phoneNo),
            SizedBox(height: AppDimens.height5,),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimens.radius8),
                  border: Border.all(color: AppColors.color0084FF)),
              child: Text(
                'View profile',
                style: AppTextStyle.euclidRegular(
                    AppDimens.fontSize14, AppColors.color0084FF),
              ),
            )
          ],
        ),
      ),
    );

  }
}
