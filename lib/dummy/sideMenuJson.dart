import 'package:line_icons/line_icons.dart';
import 'package:vedio_project/pages/favouritePage.dart';
import 'package:vedio_project/pages/homePage.dart';
import 'package:vedio_project/pages/orderPage.dart';

List sideMenuItems = [
  {
    "label": "Home",
    "selected": true,
    "icon": LineIcons.home,
    "page": HomePage()
  },
  // {
  //   "label": "My Cart",
  //   "selected": false,
  //   "icon": LineIcons.shoppingCart,
  //   "page": MyCartPage()
  // },
  // {
  //   "label": "Favourite",
  //   "selected": false,
  //   "icon": LineIcons.heart,
  //   "page": FavouritePage()
  // },
  // {
  //   "label": "Orders",
  //   "selected": false,
  //   "icon": LineIcons.history,
  //   "page": OrderPage()
  // },
];
