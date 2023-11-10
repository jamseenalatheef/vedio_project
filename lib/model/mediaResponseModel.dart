import 'package:vedio_project/model/media_model.dart';

class medias {
  final MediaModel datas;

  medias({required this.datas});

  String? get id {
    return this.datas.id;
  }

  String? get subcat_id {
    return this.datas.subcatId;
  }

  String? get vedio {
    return this.datas.vedio;
  }

  String? get audio {
    return this.datas.audio;
  }

  String? get text {
    return this.datas.text;
  }
}
