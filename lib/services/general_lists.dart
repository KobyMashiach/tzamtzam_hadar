import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/screens/new_order/new_order.dart';
import 'package:tzamtzam_hadar/screens/orders_managment/order_managment.dart';

List<String> categoriesList(context) => [
      appTranslate(context, "canvas"),
      appTranslate(context, "pictures"),
      appTranslate(context, "sublimation"),
      appTranslate(context, "general"),
    ];

List<String> picturesSizesList(context) => [
      "9X13",
      "10X15",
      "13X18",
      "15X21",
      "20X30",
      "30X40",
      "30X45",
      appTranslate(context, "other")
    ];

List<String> picturesTypeList(context) => [
      appTranslate(context, 'matte'),
      appTranslate(context, 'glossy'),
    ];
List<String> picturesFillList(context) => [
      appTranslate(context, 'fill_type'),
      appTranslate(context, 'fit_type'),
    ];

List<String> sublimationProductsList(context) => [
      appTranslate(context, 'basalt'),
      appTranslate(context, 'glass'),
      appTranslate(context, 'bear'),
      appTranslate(context, 'shirt'),
      appTranslate(context, 'mug'),
      appTranslate(context, 'bottle'),
    ];

List<String> canvasSizesList(context) => [
      "20X30",
      "30X40",
      "30X45",
      "35X50",
      "40X60",
      "50X70",
      "70X100",
      "20X20",
      "30X30",
      "40X40",
      "50X50",
      appTranslate(context, "other")
    ];

Map<String, dynamic> mainCategories(context) => {
      appTranslate(context, "new_order"): NewOrder(),
      appTranslate(context, "orders_managment"): OrderManagment(),
      // appTranslate(context, "orders_history"):
      //     NewOrder(title: appTranslate(context, "orders_history")),
    };

Map<String, dynamic> sendFilesMap() => {
      "vkiosk": {
        "type": "images",
        "networkUrl": "https://hadar.vkiosk.co.il/ODP8KtPw7c2dW",
        "imageUrl":
            "https://play-lh.googleusercontent.com/sFImNWpSB59fM3DNvViZCzShBBR0BQUx1tK_UGt_n8wMEJAZ6l1dT_zFPTXPg7frUw",
        "qrCode":
            "https://cdn.britannica.com/17/155017-050-9AC96FC8/Example-QR-code.jpg"
      },
      "whatsapp": {
        "type": "images",
        "networkUrl":
            "https://wa.me/972528061716?text=%2fstart+026739911+(%d7%a6%d7%9e%d7%a6%d7%9d+-+%d7%94%d7%93%d7%a8+)",
        "imageUrl":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/WhatsApp.svg/800px-WhatsApp.svg.png",
        "qrCode":
            "https://cdn.britannica.com/17/155017-050-9AC96FC8/Example-QR-code.jpg"
      },
      "google photos": {
        "type": "images",
        "networkUrl": "https://photochoose.com/hadar/googlephotos",
        "imageUrl":
            "https://1000logos.net/wp-content/uploads/2020/05/Google-Photos-Logo-2015.png"
      },
      "email": {
        "type": "documents",
        "networkUrl": "send email",
        "imageUrl":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/TK_email_icon.svg/1200px-TK_email_icon.svg.png"
      },
    };
