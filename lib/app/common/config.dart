import 'package:flutter/material.dart';

//192.168.19.91 (CT)
//192.168.0.104 (LN)
const kApiUrlStaging = 'http://192.168.19.91:8000/mobi';
const kApiUrlProduction = 'https://boading-group.onrender.com/mobi';

const kPrimaryColor = Color(0xff00695c);
const kBodyText = Color(0xff707070);
const kRedColor400 = Color(0xFFef5350);
const kRedColor600 = Color(0xffe53935);
const kGreyColor400 = Color(0xffBDBDBD);
const kIndigoBlueColor900 = Color(0xff344585);
const kBlackColor900 = Color(0xff212121);
const kWhiteColor = Color(0xffffffff);
const kBlueColor500 = Color(0xff2196f3);
const kYellowColor800 = Color(0xfff9a825);
const kGreenColor700 = Color(0xff689f38);
const kOrangeColor800 = Color(0xffef6c00);

Map<int, Color> color = {
  50: const Color.fromRGBO(0, 105, 92, .1),
  100: const Color.fromRGBO(0, 105, 92, .2),
  200: const Color.fromRGBO(0, 105, 92, .3),
  300: const Color.fromRGBO(0, 105, 92, .4),
  400: const Color.fromRGBO(0, 105, 92, .5),
  500: const Color.fromRGBO(0, 105, 92, .6),
  600: const Color.fromRGBO(0, 105, 92, .7),
  700: const Color.fromRGBO(0, 105, 92, .8),
  800: const Color.fromRGBO(0, 105, 92, .9),
  900: const Color.fromRGBO(0, 105, 92, 1),
};

// config message app
const MSG_ERR_ADMIN = "Có một lỗi xảy ra, vui lòng liên hệ với admin.";
const MSG_SYSTEM_HANDLE =
    'Lỗi trong quá trình xử lý hệ thống. Vui lòng khởi động lại ứng dụng...';
const MSG_SAVE_FILE = 'Có một lỗi xảy ra trong quá trình lưu file.';
const MSG_FORMAT_PASS =
    'Mật khẩu phải có ký tự chữ và số bao gồm cả chữ hoa, chữ thường';
const MSG_NOT_CONNECT =
    "Không có kết nối mạng, vui lòng khởi động lại ứng dụng sau khi kiểm tra kết nối.";
const MSG_TIME_OUT =
    "Hiện máy chủ đang bận, vui lòng thử lại trong ít phút nữa.";
