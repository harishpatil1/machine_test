// user_provider.dart
import 'package:flutter/material.dart';
import '../../../network/models/response/user/user_modal.dart';
import '../../../network/repositories/user_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
class UserProvider extends ChangeNotifier {
  List<User> _userList = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _currentPage = 1;

  List<User> get userList => _userList;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  Future<void> fetchUserList({bool isLoadMore = false}) async {
    if (isLoadMore) {
      _isLoadingMore = true;
    } else {
      _isLoading = true;
    }
    notifyListeners();

    List<ConnectivityResult> connectivityResult =
    await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      // Show warning toast
      _isLoading = false;
      _isLoadingMore = false;
      notifyListeners();
      return;
    }

    try {
      final value = await UserRepository.userRepositoryInstance
          .homePageApi(url: 'https://mmfinfotech.co/machine_test/api/userList?page=$_currentPage');
      final userListResponse = UserListResponse.fromJson(value);

      if (userListResponse.status) {
        if (isLoadMore) {
          _userList.addAll(userListResponse.userList);
        } else {
          _userList = userListResponse.userList;
        }
        _hasMore = _currentPage < userListResponse.lastPage;
        _currentPage++;
      } else {
        // Handle API error
      }
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> refreshUserList() async {
    _currentPage = 1;
    _userList = [];
    _hasMore = true;
    await fetchUserList();
  }
}
