import 'package:get/get.dart';
import 'package:loan_apllication/views/employee/History/location_service.dart';
import 'package:loan_apllication/views/employee/History/models_history_location.dart';

class PostController extends GetxController {
  var isLoading = true.obs;
  var postList = <PostModel>[].obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      var posts = await ApiService().fetchPosts();
      postList.assignAll(posts);
    } finally {
      isLoading(false);
    }
  }
}
