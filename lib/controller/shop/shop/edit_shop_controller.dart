import 'dart:io';
import 'package:ecommerce/core/services/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditShopController extends GetxController {
  MyServices myServices = Get.find();
  String? profile;
  File? image;

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final currentTime = DateTime.now();
      final newName =
          'FarmFinds_${currentTime.hour}${currentTime.minute}${currentTime.second}${currentTime.millisecond}${currentTime.microsecond}_.jpg';
      final newPath = file.parent.path + '/' + newName;
      final renamedFile = await file.rename(newPath);
      final compressedFile = await compressFile(renamedFile);
      final compressedFileName = compressedFile.path;
      final newFileName = compressedFileName.replaceFirst('_compressed', '');
      final renamedCompressedFile = await compressedFile.rename(newFileName);
      image = File(renamedCompressedFile.path);
      update();
    }
  }

  Future<File> compressFile(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: 15,
    );
    return compressedFile;
  }

  @override
  void onInit() {
    profile = myServices.getShop()?["profile"] ?? "";
    super.onInit();
  }
}
