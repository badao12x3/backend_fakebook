import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'package:fakebook_frontend/screens/post/widgets/post_widgets.dart';


class EmotionScreen extends StatefulWidget  {
  EmotionScreen({Key? key}) : super(key: key);

  @override
  State<EmotionScreen> createState() => _EmotionScreenState();
}

class _EmotionScreenState extends State<EmotionScreen> {
  String? status;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  handleChangeStatus (String value) {
    setState(() {
      status = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("#Emotion_screen receiver: $status");
    // print("#Emotion_screen: $status");
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PostAppbar(
          title: 'Bạn thế nào rồi?',
          action: 'Xong',
          extras: {'status': status},
        ),
        body: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black, width: 0.2),
                  bottom: BorderSide(color: Colors.black, width: 0.2)
                )
              ),
              child: const TabBar(
                  tabs: <Widget>[
                    Tab(
                      text: 'Cảm xúc',
                    ),
                    Tab(
                      text: 'Hoạt động',
                    )
                  ],
                  indicatorColor: Colors.blue,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Hiện đang cảm thấy... ',  style: TextStyle(color: Colors.black, fontSize: 16)),
                    if(status != null) TextSpan(text: '$status', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
                  ],
                ),
                // maxLines: 2,
                // overflow: TextOverflow.ellipsis
              ),
            ),
            Expanded(
                child: TabBarView(
                  children: [
                    EmotionGrid(onHandleChangeStatus: handleChangeStatus),
                    ActivityGrid()
                  ],
                )
            )
          ],

        ),
    )
    );
  }
}

class EmotionGrid extends StatelessWidget {
  final Function(String value) onHandleChangeStatus;

  const EmotionGrid({Key? key, required this.onHandleChangeStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emotionArray = [
      {'icon': 'hạnh phúc', 'value': 'hạnh phúc'},
      {'icon': 'có phúc', 'value': 'có phúc'},
      {'icon': 'được yêu', 'value': 'được yêu'},
      {'icon': 'buồn', 'value': 'buồn'},
      {'icon': 'đáng yêu', 'value': 'đáng yêu'},
      {'icon': 'biết ơn', 'value': 'biết ơn'},
      {'icon': 'hào hứng', 'value': 'hào hứng'},
      {'icon': 'đang yêu', 'value': 'đang yêu'},
      {'icon': 'điên', 'value': 'điên'},
      {'icon': 'cảm kích', 'value': 'cảm kích'},
      {'icon': 'sung sướng', 'value': 'sung sướng'},
      {'icon': 'tuyệt vời', 'value': 'tuyệt vời'},
      {'icon': 'ngốc nghếch', 'value': 'ngốc nghếch'},
      {'icon': 'vui vẻ', 'value': 'vui vẻ'},
      {'icon': 'tuyệt vời', 'value': 'tuyệt vời'},
      {'icon': 'thật phong cách', 'value': 'thật phong cách'},
      {'icon': 'thú vị', 'value': 'thú vị'},
      {'icon': 'thư giãn', 'value': 'thư giãn'},
      {'icon': 'positive', 'value': 'positive'},
      {'icon': 'rùng mình', 'value': 'rùng mình'},
      {'icon': 'đầy hi vọng', 'value': 'đầy hi vọng'},
      {'icon': 'hân hoan', 'value': 'hân hoan'},
      {'icon': 'mệt mỏi', 'value': 'mệt mỏi'},
      {'icon': 'có động lực', 'value': 'có động lực'},
      {'icon': 'proud', 'value': 'proud'},
      {'icon': 'chỉ có một mình', 'value': 'chỉ có một mình'},
      {'icon': 'chu đáo', 'value': 'chu đáo'},
      {'icon': 'OK', 'value': 'OK'},
      {'icon': 'nhớ nhà', 'value': 'nhớ nhà'},
      {'icon': 'giận dữ', 'value': 'giận dữ'},
      {'icon': 'ốm yếu', 'value': 'ốm yếu'},
      {'icon': 'hài lòng', 'value': 'hài lòng'},
      {'icon': 'kiệt sức', 'value': 'kiệt sức'},
      {'icon': 'xúc động', 'value': 'xúc động'},
      {'icon': 'tự tin', 'value': 'tự tin'},
      {'icon': 'rất tuyệt', 'value': 'rất tuyệt'},
      {'icon': 'tươi mới', 'value': 'tươi mới'},
      {'icon': 'quyết đoán', 'value': 'quyết đoán'},
      {'icon': 'kiệt sức', 'value': 'kiệt sức'},
      {'icon': 'bực mình', 'value': 'bực mình'},
      {'icon': 'vui vẻ', 'value': 'vui vẻ'},
      {'icon': 'gặp may', 'value': 'gặp may'},
      {'icon': 'đau khổ', 'value': 'đau khổ'},
      {'icon': 'buồn tẻ', 'value': 'buồn tẻ'},
      {'icon': 'buồn ngủ', 'value': 'buồn ngủ'},
      {'icon': 'tràn đầy sinh lực', 'value': 'tràn đầy sinh lực'},
      {'icon': 'đói', 'value': 'đói'},
      {'icon': 'chuyên nghiệp', 'value': 'chuyên nghiệp'},
      {'icon': 'đau đớn', 'value': 'đau đớn'},
      {'icon': 'thanh thản', 'value': 'thanh thản'},
      {'icon': 'thất vọng', 'value': 'thất vọng'},
      {'icon': 'lạc quan', 'value': 'lạc quan'},
      {'icon': 'lạnh', 'value': 'lạnh'},
      {'icon': 'dễ thương', 'value': 'dễ thương'},
      {'icon': 'tuyệt cú mèo', 'value': 'tuyệt cú mèo'},
      {'icon': 'thật tuyệt', 'value': 'thật tuyệt'},
      {'icon': 'hối tiếc', 'value': 'hối tiếc'},
      {'icon': 'thật giỏi', 'value': 'thật giỏi'},
      {'icon': 'lo lắng', 'value': 'lo lắng'},
      {'icon': 'vui nhộn', 'value': 'vui nhộn'},
      {'icon': 'tồi tệ', 'value': 'tồi tệ'},
      {'icon': 'xuống tinh thần', 'value': 'xuống tinh thần'},
      {'icon': 'đầy cảm hứng', 'value': 'đầy cảm hứng'},
      {'icon': 'hài lòng', 'value': 'hài lòng'},
      {'icon': 'phấn khích', 'value': 'phấn khích'},
      {'icon': 'bình tĩnh', 'value': 'bình tĩnh'},
      {'icon': 'bối rối', 'value': 'bối rối'},
      {'icon': 'goofy', 'value': 'goofy'},
      {'icon': 'trống vắng', 'value': 'trống vắng'},
      {'icon': 'tốt', 'value': 'tốt'},
      {'icon': 'mỉa mai', 'value': 'mỉa mai'},
      {'icon': 'cô đơn', 'value': 'cô đơn'},
      {'icon': 'mạnh mẽ', 'value': 'mạnh mẽ'},
      {'icon': 'lo lắng', 'value': 'lo lắng'},
      {'icon': 'đặc biệt', 'value': 'đặc biệt'},
      {'icon': 'chán nản', 'value': 'chán nản'},
      {'icon': 'vui vẻ', 'value': 'vui vẻ'},
      {'icon': 'tò mò', 'value': 'tò mò'},
      {'icon': 'ủ dột', 'value': 'ủ dột'},
      {'icon': 'được chào đón', 'value': 'được chào đón'},
      {'icon': 'gục ngã', 'value': 'gục ngã'},
      {'icon': 'xinh đẹp', 'value': 'xinh đẹp'},
      {'icon': 'tuyệt vời', 'value': 'tuyệt vời'},
      {'icon': 'cáu', 'value': 'cáu'},
      {'icon': 'căng thẳng', 'value': 'căng thẳng'},
      {'icon': 'thiếu', 'value': 'thiếu'},
      {'icon': 'kích động', 'value': 'kích động'},
      {'icon': 'tinh quái', 'value': 'tinh quái'},
      {'icon': 'kinh ngạc', 'value': 'kinh ngạc'},
      {'icon': 'tức giận', 'value': 'tức giận'},
      {'icon': 'buồn chán', 'value': 'buồn chán'},
      {'icon': 'bối rồi', 'value': 'bối rồi'},
      {'icon': 'mạnh mẽ', 'value': 'mạnh mẽ'},
      {'icon': 'phẫn nộ', 'value': 'phẫn nộ'},
      {'icon': 'mới mẻ', 'value': 'mới mẻ'},
      {'icon': 'thành công', 'value': 'thành công'},
      {'icon': 'ngạc nhiên', 'value': 'ngạc nhiên'},
      {'icon': 'bối rối', 'value': 'bối rối'},
      {'icon': 'nản lòng', 'value': 'nản lòng'},
      {'icon': 'tẻ nhạt', 'value': 'tẻ nhạt'},
      {'icon': 'xinh xắn', 'value': 'xinh xắn'},
      {'icon': 'khá hơn', 'value': 'khá hơn'},
      {'icon': 'tội lỗi', 'value': 'tội lỗi'},
      {'icon': 'an toàn', 'value': 'an toàn'},
      {'icon': 'tự do', 'value': 'tự do'},
      {'icon': 'hoang mang', 'value': 'hoang mang'},
      {'icon': 'già nua', 'value': 'già nua'},
      {'icon': 'lười biếng', 'value': 'lười biếng'},
      {'icon': 'tồi tệ hơn', 'value': 'tồi tệ hơn'},
      {'icon': 'khủng khiếp', 'value': 'khủng khiếp'},
      {'icon': 'thoải mái', 'value': 'thoải mái'},
      {'icon': 'ngớ ngẩn', 'value': 'ngớ ngẩn'},
      {'icon': 'hổ thẹn', 'value': 'hổ thẹn'},
      {'icon': 'kinh khủng', 'value': 'kinh khủng'},
      {'icon': 'đang ngủ', 'value': 'đang ngủ'},
      {'icon': 'khỏe', 'value': 'khỏe'},
      {'icon': 'nhanh nhẹn', 'value': 'nhanh nhẹn'},
      {'icon': 'ngại ngùng', 'value': 'ngại ngùng'},
      {'icon': 'gay go', 'value': 'gay go'},
      {'icon': 'kỳ lạ', 'value': 'kỳ lạ'},
      {'icon': 'như con người', 'value': 'như con người'},
      {'icon': 'bị tổn thương', 'value': 'bị tổn thương'},
      {'icon': 'khủng khiếp', 'value': 'khủng khiếp'}
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 5),
      ),
      itemCount: emotionArray.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            final status = emotionArray[index]["value"]!;
            onHandleChangeStatus(status);
          },
          child: GridTile(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              decoration: BoxDecoration(
                border: Border.all(width: 0.05, color: Colors.grey)
              ),
              child: Row(
                children: [
                  Text('🙂'),
                  SizedBox(width: 6),
                  Text(emotionArray[index]["value"] as String)
                ],
              ),
            )
          ),
        );
      },
    );
  }
}

class ActivityGrid extends StatelessWidget {
  const ActivityGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activityArray = [
      {'icon': 'Đang chúc mừng...', 'value': 'Đang chúc mừng...'},
      {'icon': 'Đang ăn...', 'value': 'Đang ăn...'},
      {'icon': 'Đang tham gia...', 'value': 'Đang tham gia...'},
      {'icon': 'Đang nghe...', 'value': 'Đang nghe...'},
      {'icon': 'Đang nghĩ về...', 'value': 'Đang nghĩ về...'},
      {'icon': 'Đang chơi...', 'value': 'Đang chơi...'},
      {'icon': 'Đang xem...', 'value': 'Đang xem...'},
      {'icon': 'Đang uống...', 'value': 'Đang uống...'},
      {'icon': 'Đang đi tới....', 'value': 'Đang đi tới....'},
      {'icon': 'Đang tìm...', 'value': 'Đang tìm...'},
      {'icon': 'Đang đọc', 'value': 'Đang đọc'},
      {'icon': 'Đang ủng hộ...', 'value': 'Đang ủng hộ...'}
    ];
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 5),
      ),
      itemCount: activityArray.length,
      itemBuilder: (context, index) {
        return GridTile(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.05, color: Colors.grey)
              ),
              child: Row(
                children: [
                  Text('🙂'),
                  SizedBox(width: 6),
                  Text(activityArray[index]["value"] as String)
                ],
              ),
            )
        );
      },
    );
  }
}





