import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:invertar_us/core/class/statusrequest.dart';
import 'package:path/path.dart';

import '../function/checkinternet.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(
      String urlLink, Map<String, String>? headers, Map data) async {
    try {
      if (await checkInternet()) {
        print(urlLink);
        var response =
            await http.post(Uri.parse(urlLink), headers: headers, body: data);
        print('==========${response.body}================');

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responceBody = jsonDecode(response.body);
          print('==========responceBody.length================');
          return Right(responceBody);
        } else {
          return const Left(StatusRequest.failure);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (_) {
      return const Left(StatusRequest.serverExp);
    }
  }

  Future<Either<StatusRequest, Map>> putUserData(
      String urlLink, Map<String, String>? headers, Map data) async {
    try {
      if (await checkInternet()) {
        print(data);
        var response = await http.put(
          Uri.parse(urlLink),
          headers: headers,
          body: data,
        );
        print('=============putData========');
        print(response.body.length  );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responceBody = jsonDecode(response.body);
          return Right(responceBody);
        } else {
          return const Left(StatusRequest.failure);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (e) {
      print(e.toString());
      return const Left(StatusRequest.serverExp);
    }
  }

  Future<Either<StatusRequest, Map>> putData(
      String urlLink, Map<String, String>? headers, String data) async {
    try {
      print('=====================j');
      if (await checkInternet()) {
        print(data);
        var response =
            await http.put(Uri.parse(urlLink), headers: headers, body: data);
               print(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responceBody = jsonDecode(response.body);
          return Right(responceBody);
        } else {
          return const Left(StatusRequest.failure);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (_) {
      return const Left(StatusRequest.serverExp);
    }
  }

  Future<Either<StatusRequest, Map>> getData(
      String urlLink, Map<String, String>? headers) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(
          Uri.parse(urlLink),
          headers: headers,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responceBody = jsonDecode(response.body);

          return Right(responceBody);
        } else {
          return const Left(StatusRequest.failure);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (_) {
      return const Left(StatusRequest.serverExp);
    }
  }

  Future<Either<StatusRequest, Map>> deleteData(
      String urlLink, Map<String, String>? headers) async {
    try {
      if (await checkInternet()) {
        var response = await http.delete(
          Uri.parse(urlLink),
          headers: headers,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responceBody = jsonDecode(response.body);
          print('==========responceBody.length================');
          print(responceBody.length);
          print('==========Crud================');
          return Right(responceBody);
        } else {
          return const Left(StatusRequest.failure);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (_) {
      return const Left(StatusRequest.serverExp);
    }
  }

  Future<Either<StatusRequest, Map>> postDataWithImage(
      String urlLink, Map data, File file) async {
    try {
      print(data);
      print(file);
      if (await checkInternet()) {
        var request = http.MultipartRequest('POST', Uri.parse(urlLink));
        var length = await file.length();
        var stream = http.ByteStream(file.openRead());
        var multiparFile = http.MultipartFile('file', stream, length,
            filename: basename(file.path));
        request.files.add(multiparFile);
        data.forEach((key, value) {
          request.fields[key] = value;
          print(key + ':' + value);
        });
        var myreq = await request.send();

        var response = await http.Response.fromStream(myreq);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responceBody = jsonDecode(response.body);
          print('==========responceBody.length================');
          print(responceBody.length);
          print('==========Crud================');
          return Right(responceBody);
        } else {
          return const Left(StatusRequest.failure);
        }
      } else {
        return const Left(StatusRequest.offline);
      }
    } catch (_) {
      return const Left(StatusRequest.serverExp);
    }
  }
}
