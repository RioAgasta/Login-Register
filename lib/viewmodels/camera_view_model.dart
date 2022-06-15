import 'package:projectrio/locator.dart';
import 'package:projectrio/services/navigation_service.dart';
import 'base_model.dart';

import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  CameraController controller; // Deklarasi
  List cameras;
  int selectedCameraIdx;
  String imagePath;
  String data = "";

  void initModel(bool mounted){
    getAvailableCamera(mounted);  // Memanggil fungsi
  }

  void getAvailableCamera(bool mounted){
    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras.length > 0){
        selectedCameraIdx = 1;
        setBusy(false);

        _initCameraController(cameras[selectedCameraIdx], mounted).then((void v) {});
      } else {
        print("camera not available");
      }
    }).catchError((err){
      print("Errpr: $err.code\nError Message: $err.message");
    });
    setBusy(false);
  }

  Future _initCameraController(
      CameraDescription cameraDescription, bool mounted) async{
    if (controller != null){
      await controller.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.max);

    controller.addListener(() {
      if (mounted) {
        setBusy(false);
      }
      if (controller.value.hasError){
        print("Camera error ${controller.value.errorDescription}");
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      showCameraException(e);
    }

    if (mounted){
      setBusy(false);
    }
  }

  void showCameraException(CameraException e){
    String errorText = "error: ${e.code}\nError message: ${e.description}";
  }

  void onCapturePressed(context) async {
    try{
      final directory = await getExternalStorageDirectory();
      final dateFormat = formatDate();
      final fileName = '${dateFormat.toString()}-PPTIK.png';

      final path = join(
          (await getTemporaryDirectory()).path,
          '${dateFormat.toString()}-PPTIK.png');
      await controller.takePicture(path);
      print('Explorer ${directory.path}');
      _navigationService.popUpWithValue('$path#$fileName');
    } catch (e){
      print(e);
    }
    setBusy(false);
  }

  void onSwitchedCamera(bool mounted){
    selectedCameraIdx =
    selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    _initCameraController(selectedCamera, mounted);
  }

  String formatDate(){
    DateFormat dateFormat = DateFormat("MM_dd_yyyy_HH_mm_ss");
    return dateFormat.format(DateTime.now());
  }
}