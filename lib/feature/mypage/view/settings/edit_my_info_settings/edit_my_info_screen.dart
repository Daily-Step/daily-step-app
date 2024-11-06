import 'package:dailystep/feature/mypage/view/settings/edit_my_info_settings/edit_my_info_provider.dart';
import 'package:dailystep/widgets/widget_buttons.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


class EditMyInfoScreen extends ConsumerWidget {
  const EditMyInfoScreen({Key? key}) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // TODO: Picked 이미지 파일을 프로필로 설정하는 로직 추가
    }
  }

Future<void> _selectBirthday(BuildContext context, WidgetRef ref) async {
  final DateTime? pickedDate = await showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), 
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0), 
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              // Limit the height of the calendar
              Container(
                width: double.infinity, 
                height: 400, 
                child: TableCalendar(
                  locale: 'ko_KR', 
                  focusedDay: ref.watch(selectedDateProvider) ?? DateTime.now(),
                  firstDay: DateTime(1900),
                  lastDay: DateTime.now(),
                  selectedDayPredicate: (day) {
                    return isSameDay(day, ref.watch(selectedDateProvider));
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    ref.read(selectedDateProvider.notifier).state = selectedDay;
                    Navigator.of(context).pop(selectedDay);
                  },
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false, 
                    titleCentered: true, 
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.black), 
                    weekendStyle: TextStyle(color: Colors.red), 
                  ),
                  calendarBuilders: CalendarBuilders(
                    dowBuilder: (context, day) {
                      
                      if (day.weekday == DateTime.sunday) {
                        return Center(
                          child: Text(
                            DateFormat.E('ko_KR').format(day), 
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (day.weekday == DateTime.saturday) {
                        return Center(
                          child: Text(
                            DateFormat.E('ko_KR').format(day), 
                            style: TextStyle(color: Colors.blue),
                          ),
                        );
                      }
                      return Center(
                        child: Text(DateFormat.E('ko_KR').format(day)), 
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  if (pickedDate != null) {
    // 날짜를 선택한 후, 상태 업데이트
    ref.read(birthdayProvider.notifier).state = pickedDate;
  }
}


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nicknameController =
        TextEditingController(text: ref.watch(nicknameProvider));
    final selectedGender = ref.watch(genderProvider);
    final selectedDate = ref.watch(birthdayProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('내 정보 수정'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // 프로필 이미지
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3f4ec842-6f7a-4d31-ab32-a35b7c42e7d8/dgvd6bj-d8c21830-800a-4642-954f-249381540aae.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzNmNGVjODQyLTZmN2EtNGQzMS1hYjMyLWEzNWI3YzQyZTdkOFwvZGd2ZDZiai1kOGMyMTgzMC04MDBhLTQ2NDItOTU0Zi0yNDkzODE1NDBhYWUuZ2lmIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.DXNYAFrTUPlJjEfgUpPXR_YY_znMJ4qNWyu2QEG442E'),
                          // 기본 이미지
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () => _pickImage(context),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.blue,
                              child: const Icon(Icons.camera_alt,
                                  color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 닉네임 텍스트 필드 및 중복 확인 버튼
                  Row(
                    children: [
                      const Text(
                        '닉네임',
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nicknameController,
                          onChanged: (value) =>
                              ref.read(nicknameProvider.notifier).state = value,
                          decoration: InputDecoration(
                            labelText: '닉네임을 입력해 주세요',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 15),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: UnderlineInputBorder(
                              // 아래쪽만 테두리
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              // 포커스 상태에서도 아래쪽만 테두리
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              // 활성화 상태에서 아래쪽만 테두리
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusColor: Colors.transparent, // 애니메이션 제거
                            suffixIcon: Container(
                              child: Container(
                                width: 93,
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: TextButton(
                                    onPressed: () async {
                                      // 중복 확인 기능
                                    },
                                    style: TextButton.styleFrom(
                                      side: BorderSide(
                                        color: Colors.black, // 테두리 색상
                                        width: 1, // 테두리 두께
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            1000), // 테두리 둥글기
                                      ),
                                    ),
                                    child: Text('중복확인'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 60),

                  Row(
                    children: [
                      const Text(
                        '생년월일',
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),

                  // 생년월일 입력 필드 및 달력 아이콘
                  TextField(
                    controller: TextEditingController(
                      text: selectedDate != null
                          ? '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'
                          : '',
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: '생년월일을 입력해 주세요',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      floatingLabelBehavior:
                          FloatingLabelBehavior.never, // 라벨 애니메이션 제거
                      border: UnderlineInputBorder(
                        // 아래쪽만 테두리
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        // 포커스 상태에서도 아래쪽만 테두리
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        // 활성화 상태에서 아래쪽만 테두리
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusColor: Colors.transparent, // 애니메이션 제거
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectBirthday(context, ref),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),

                  // 성별 선택 라디오 버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('성별:'),
                      Row(
                        children: [
                          Radio<String>(
                            value: '여성',
                            groupValue: selectedGender,
                            onChanged: (value) {
                              ref.read(genderProvider.notifier).state = value!;
                            },
                          ),
                          const Text('여성'),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Radio<String>(
                              value: '남성',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                ref.read(genderProvider.notifier).state =
                                    value!;
                              },
                            ),
                          ),
                          const Text('남성'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // 하단 고정 버튼
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: WCtaButton(
              '저장하기',
              onPressed: () {
                // 저장 버튼 동작
              },
            ),
          ),
        ],
      ),
    );
  }
}
