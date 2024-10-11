import 'dart:io';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/utils/route.dart';
import 'package:coswan/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_compression/image_compression.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:video_compress/video_compress.dart';

class ReviewApi {
  static Future<void> review(BuildContext context, String star, String comment,
      String productId, File? photo, File? video) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      const url = '${APIRoute.route}/api/review';
      final uri = Uri.parse(url);

      // Create multipart request
      showDialog(
        context: context,
        barrierDismissible: false,
        // Prevent dismissing
        builder: (BuildContext context) {
          return const  Center(
            child:  CircularProgressIndicator(),
          );
        },
      );
      final request = http.MultipartRequest("POST", uri);
      request.fields['productId'] = productId;
      request.fields['stars'] = star;
      request.fields['comment'] = comment;
      request.fields['userId'] = userprovider.id;
      // Add photo file if not null

      if (photo != null) {
        final compressedPhoto = await compressImage(photo);
        if (compressedPhoto != null) {
          request.files.add(http.MultipartFile(
            'image',
            compressedPhoto.readAsBytes().asStream(),
            compressedPhoto.lengthSync(),
            filename: photo.path.split('/').last,
            contentType: MediaType('image', 'jpeg'),
          ));
        }
      }

      //  compress a video file

      // Add video file if not null

      if (video != null) {
        final compressedVideo = await compressVideo(video);
        if (compressedVideo != null) {
          request.files.add(
            http.MultipartFile(
              'video',
              compressedVideo.readAsBytes().asStream(),
              compressedVideo.lengthSync(),
              filename: video.path.split('/').last,
              contentType: MediaType('video', 'mp4'),
            ),
          );
        }
      }

      //set headers

      request.headers.addAll({'Authorization': 'Bearer ${userprovider.token}'});

      // Send request
      var res = await request.send();
      print(res.reasonPhrase);
      print(res.statusCode);
      Navigator.pop(context);
      if (res.statusCode == 200 || res.statusCode == 201) {
        CustomNotifyToast.showCustomToast(context, 'Review Added Successfully');
        Navigator.pop(context);
      }
    } catch (e) {
      rethrow;
    }
  }
}

Future<File?> compressImage(File file) async {
  final config = ImageFileConfiguration(
      input: ImageFile(filePath: file.path, rawBytes: file.readAsBytesSync()),
      config: const Configuration(
        pngCompression: PngCompression.bestSpeed,
        outputType: OutputType.jpg, // Output format
      ));

  //compress the image

  final compressedImage = await compressInQueue(config);

  if (compressedImage != null) {
    final compressedFile = File(file.path)
      ..writeAsBytesSync(compressedImage.rawBytes);

    return compressedFile;
  }

  return null;
}

Future<File?> compressVideo(File videoFile) async {
  MediaInfo? info = await VideoCompress.compressVideo(videoFile.path,
      quality: VideoQuality.LowQuality, deleteOrigin: false);
  return info!.file;
}
