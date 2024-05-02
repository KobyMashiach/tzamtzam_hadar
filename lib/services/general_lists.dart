import 'package:tzamtzam_hadar/models/contact_model.dart';

final List<String> globalPicturesSizes = [];
final List<String> globalPicturesSizesTranslated = [];

final List<String> globalPicturesFill = [];
final List<String> globalPicturesFillTranslated = [];

final List<String> globalPicturesType = [];
final List<String> globalPicturesTypeTranslated = [];

final List<String> globalCanvasSizes = [];
final List<String> globalCanvasSizesTranslated = [];

final List<String> globalManagmentCategories = [];
final List<String> globalManagmentCategoriesTranslated = [];

final List<String> globalProductsCategories = [];
final List<String> globalProductsCategoriesTranslated = [];

final List<String> globalSublimationProducts = [];
final List<String> globalSublimationProductsTranslated = [];

final List<String> globalSendFilesType = [];
final List<String> globalSendFilesTypeTranslated = [];

final Map<dynamic, dynamic> globalMainCategories = {};
final Map<String, dynamic> globalMainCategoriesTranslated = {};

final Map<dynamic, dynamic> globalSendFiles = {};
final Map<String, dynamic> globalSendFilesTranslated = {};

final Map<dynamic, dynamic> globalContactsList = {};
final Map<String, List<ContactModel>> globalContactsListTranslated = {};

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
