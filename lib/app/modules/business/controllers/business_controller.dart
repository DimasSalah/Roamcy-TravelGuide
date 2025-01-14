import 'package:get/get.dart';
import '../data/model/business_model.dart';
import '../data/services/business_services.dart';

class BusinessController extends GetxController {
  final BusinessServices _businessServices = BusinessServices();
  final RxList<BusinessModel> businesses = <BusinessModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getBusinesses();
  }

  void getBusinesses() {
    isLoading.value = true;
    _businessServices.getBusinesses().listen(
      (List<BusinessModel> businessList) {
        businesses.value = businessList;
        isLoading.value = false;
      },
      onError: (error) {
        print('Error: $error');
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Failed to load businesses',
          snackPosition: SnackPosition.TOP,
        );
      },
    );
  }

  void searchBusinesses(String query) {
    if (query.isEmpty) {
      getBusinesses();
      return;
    }

    _businessServices.searchBusinesses(query).listen(
      (List<BusinessModel> businessList) {
        businesses.value = businessList;
      },
      onError: (error) {
        print('Error: $error');
        Get.snackbar(
          'Error',
          'Failed to search businesses',
          snackPosition: SnackPosition.TOP,
        );
      },
    );
  }
}
