import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../_importer.dart';

class CurriculumState extends ChangeNotifier {
  double _defaultWidth = 60;
  double _width = 60;
  int _selectedSectorIndex = -1;
  List<double> _sectorHeightList = [
    100.h,
    100.h,
    100.h,
    100.h,
    100.h,
  ];
  double _sectorStackOpacity = 0;

  List<Subject> _allSubjectList = [];
  late List<Widget> _dragAndDropList;
  List<Widget> get dragAndDropList => _dragAndDropList;

  final TransformationController _transformationController = TransformationController();

  int get selectedSectorIndex => _selectedSectorIndex;

  List<double> get sectorHeightList => _sectorHeightList;

  double get width => _width;

  TransformationController get transformationController => _transformationController;

  double get scale => _transformationController.value.getMaxScaleOnAxis();

  double get sectorStackOpacity => _sectorStackOpacity;

  List<Subject> get allSubjectList => _allSubjectList;

  void init() {
    _allSubjectList.clear();

    /// 모든 주제 draggable list에 담기
    for(int gradeIndex = 0; gradeIndex < _curriculum.length; gradeIndex++) {
      for(int sectorIndex = 0; sectorIndex < _curriculum[gradeIndex].length; sectorIndex++) {
        for(int bigUnitIndex = 0; bigUnitIndex < _curriculum[gradeIndex][sectorIndex].bigUnit!.length; bigUnitIndex++) {
          for(int middleUnitIndex = 0; middleUnitIndex < _curriculum[gradeIndex][sectorIndex].bigUnit![bigUnitIndex].middleUnit!.length; middleUnitIndex++) {
            for(int smallUnitIndex = 0; smallUnitIndex < _curriculum[gradeIndex][sectorIndex].bigUnit![bigUnitIndex]
                .middleUnit![middleUnitIndex].smallUnit!.length; smallUnitIndex++) {
              for(int subjectIndex = 0; subjectIndex < _curriculum[gradeIndex][sectorIndex].bigUnit![bigUnitIndex]
                  .middleUnit![middleUnitIndex].smallUnit![smallUnitIndex].subject!.length; subjectIndex++) {
                _allSubjectList.add(_curriculum[gradeIndex][sectorIndex].bigUnit![bigUnitIndex]
                    .middleUnit![middleUnitIndex].smallUnit![smallUnitIndex].subject![subjectIndex]);
              }
            }
          }
        }
      }
    }

    /// drag and drop list 에 담기
    _dragAndDropList = _allSubjectList.map(buildList).toList();
  }

  Widget buildList(Subject subject) => Container(
    width: 448.w,
    height: 74.h,
    // margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 4.h),
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: MidColors.subjectColor,
    ),
    child: Row(
      children: [
        /// 성취도
        Container(
          width: 8.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: subject.achievement! < 20
                ? MidColors.tier5Color
                : subject.achievement! < 40
                ? MidColors.tier4Color
                : subject.achievement! < 60
                ? MidColors.tier3Color
                : subject.achievement! < 80
                ? MidColors.tier2Color
                : MidColors.tier1Color,
            borderRadius: BorderRadius.circular(11),
            border: subject.achievement! < 20
                ? Border.all(
              width: 2,
              color: MidColors.unSelectedBorderColor,
            )
                : null,
          ),
        ),
        SizedBox(width: 8.w),

        /// 주제, 학습 횟수
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  subject.title!,
                  style: TextStyle(
                    color: MidColors.textColor,
                    fontSize: 16.sp,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 1.11,
                    letterSpacing: -0.20,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '학습 횟수 : ${subject.count}',
                style: TextStyle(
                  color: const Color(0xFF707070),
                  fontSize: 12.sp,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  height: 1.10,
                  letterSpacing: 0.06,
                ),
              ),
            ],
          ),
        ),

        /// 진도율
        Container(
          alignment: Alignment.center,
          width: 42.w,
          height: 42.w,
          padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 3.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: subject.progress == 100 ? MidColors.tableBorderColor : MidColors.transparent,
          ),
          child: Text(
            '${subject.progress}%',
            style: TextStyle(
              color: subject.progress == 100 ? Colors.white : Color(0xFF5A5A5A),
              fontSize: 14.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.20,
            ),
          ),
        )
      ],
    ),
  );

  void setStackOpacity(double value) {
    _sectorStackOpacity = value;

    notifyListeners();
  }

  double getPaddingWidth(sectorIndex, int grade) {
    if (scale < 1.2) {
      /// 대단원
      return 17.w + (_width * getTransferWidth(sectorIndex, grade) + 4.w * (getTransferWidth(sectorIndex, grade) - 1)) / 3;
    } else if (scale < 1.5) {
      /// 중단원
      return 17.w + (_width * getTransferWidth(sectorIndex, grade) + 4.w * (getTransferWidth(sectorIndex, grade) - 1)) / 2;
    } else if (scale < 1.8) {
      /// 소단원
      return 17.w + (_width * getTransferWidth(sectorIndex, grade) + 4.w * (getTransferWidth(sectorIndex, grade) - 1)) / 1.5;
    } else {
      /// 주제
      return 17.w + (_width * getTransferWidth(sectorIndex, grade) + 4.w * (getTransferWidth(sectorIndex, grade) - 1));
    }
  }

  /// 소단원 갯수만큼 총 너비 구하기
  double getWidth(sectorIndex, grade) {
    if (scale < 1.2) {
      /// 대단원
      return ((_width * smallUnitCount(sectorIndex, grade) + 4.w * (smallUnitCount(sectorIndex, grade) - 1)) / 3);
    } else if (scale < 1.5) {
      /// 중단원
      return ((_width * smallUnitCount(sectorIndex, grade) + 4.w * (smallUnitCount(sectorIndex, grade) - 1)) / 2);
    } else if (scale < 1.8) {
      /// 소단원
      return ((_width * smallUnitCount(sectorIndex, grade) + 4.w * (smallUnitCount(sectorIndex, grade) - 1)) / 1.5);
    } else {
      /// 주제
      return ((_width * smallUnitCount(sectorIndex, grade) + 4.w * (smallUnitCount(sectorIndex, grade) - 1)));
    }
  }

  /// 소단원 갯수 세기
  int smallUnitCount(int sectorIndex, int grade) {
    int count = 0;

    for (int bigUnitIndex = 0; bigUnitIndex < _curriculum[grade][sectorIndex].bigUnit!.length; bigUnitIndex++) {
      for (int middleUnitIndex = 0;
          middleUnitIndex < _curriculum[grade][sectorIndex].bigUnit![bigUnitIndex].middleUnit!.length;
          middleUnitIndex++) {
        count += _curriculum[grade][sectorIndex].bigUnit![bigUnitIndex].middleUnit![middleUnitIndex].smallUnit!.length;
      }
    }
    // logger.d('소단원 갯수 세기 => sectorIndex : $sectorIndex, count : $count');
    return count;
  }

  int getTransferWidth(int sectorIndex, int grade) {
    int count = 0;

    for (int i = 0; i < sectorIndex; i++) {
      count += smallUnitCount(i, grade);
    }
    // for (int i = 0; i < sectorIndex; i++) {
    //   for (int bigUnitIndex = 0; bigUnitIndex < _curriculum[i].bigUnit!.length; bigUnitIndex++) {
    //     for (int middleUnitIndex = 0; middleUnitIndex <
    //         _curriculum[i].bigUnit![bigUnitIndex].middleUnit!.length; middleUnitIndex++) {
    //       count += _curriculum[i].bigUnit![bigUnitIndex].middleUnit![middleUnitIndex].smallUnit!.length;
    //     }
    //   }
    // }
    // logger.d('영역 앞 padding width를 위한 소단원 갯수 세기 => sectorIndex : $sectorIndex, count : $count');
    return count;
  }

  void update() {
    notifyListeners();
  }

  void setSectorHeight(int sectorIndex) {
    /// 넓혀진 영역을 다시 누르면 150.h로 초기화, 다른 영역 누르면 해당 영역을 300.h으로 변경
    if (sectorIndex == _selectedSectorIndex) {
      for (int i = 0; i < _sectorHeightList.length; i++) {
        _sectorHeightList[i] = 100.h;
        _selectedSectorIndex = -1;
      }
    } else {
      for (int i = 0; i < _sectorHeightList.length; i++) {
        if (i == sectorIndex) {
          _sectorHeightList[i] = 300.h;
          _selectedSectorIndex = i;
        } else {
          _sectorHeightList[i] = 100.h;
        }
      }
    }
    notifyListeners();
  }

  setScaleWithSlider(double value) {
    _transformationController.value = Matrix4(value, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);

    _width = _defaultWidth * value.clamp(0.8, 2);

    notifyListeners();
  }

  double getAllWidth(int grade) {
    if (scale < 1.2) {
      /// 제목영역 + padding + 전 단원 모든 중단원 너비
      return 150.w + 17.w + (_width * getTransferWidth(5, grade) + 4.w * (getTransferWidth(5, grade) - 1)) / 3;
    } else if (scale < 1.5) {
      /// 제목영역 + padding + 전 단원 모든 중단원 너비
      return 150.w + 17.w + (_width * getTransferWidth(5, grade) + 4.w * (getTransferWidth(5, grade) - 1)) / 2;
    } else if (scale < 1.8) {
      /// 제목영역 + padding + 전 단원 모든 중단원 너비
      return 150.w + 17.w + (_width * getTransferWidth(5, grade) + 4.w * (getTransferWidth(5, grade) - 1)) / 1.5;
    } else {
      /// 제목영역 + padding + 전 단원 모든 중단원 너비
      return 150.w + 17.w + (_width * getTransferWidth(5, grade) + 4.w * (getTransferWidth(5, grade) - 1));
    }
  }

  final List<List<Curriculum>> _curriculum = [
    [
      Curriculum.fromJson({
        "title": "수와 연산",
        "bigUnit": [
          {
            "title": "수와 연산",
            "middleUnit": [
              {
                "title": "소인수분해",
                "smallUnit": [
                  {
                    "title": "소인수분해",
                    "subject": [
                      {"title": "소수와 합성수", "count": 1, "progress": 89, "achievement": 90},
                      {"title": "소인수분해", "count": 2, "progress": 47, "achievement": 40},
                      {"title": "소인수분해를 이용하여 약수 구하기", "progress": 52, "count": 2, "achievement": 20},
                        ],
                  },
                  {
                    "title": "최대공약수와 최소공배수",
                    "subject": [
                      {
                        "title": "공약수와 최대공약수",
                        "count": 1,
                        "progress": 37,
                        "achievement": 70,
                      },
                      {"title": "소인수분해를 이용하여 최대공약수 구하기", "count": 2, "progress": 68, "achievement": 50},
                      {"title": " 공배수와 최소공배수", "count": 2, "progress": 52, "achievement": 70},
                      {"title": " 소인수분해를 이용하여 최소공배수 구하기", "count": 2, "progress": 56, "achievement": 40},
                      {"title": " 최대공약수와 최소공배수의 활용", "count": 3, "progress": 100, "achievement": 100},
                      {"title": " 최대공약수와 최소공배수의 관계", "count": 1, "progress": 30, "achievement": 80}
                    ],
                  }
                ]
              },
              {
                "title": "정수와 유리수",
                "smallUnit": [
                  {
                    "title": "정수와 유리수",
                    "subject": [
                      {"title": "양수와 음수", "count": 1, "progress": 40, "achievement": 20},
                      {"title": "정수와 유리수", "count": 2, "progress": 70, "achievement": 70},
                    ],
                  },
                  {
                    "title": "정수와 유리수의 대소 관계",
                    "subject": [
                      {"title": "수직선", "count": 1, "progress": 20, "achievement": 17},
                      {"title": "절댓값", "count": 1, "progress": 30, "achievement": 25},
                      {"title": "수의 대소 관계", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "부등호의 사용", "count": 1, "progress": 42, "achievement": 22},
                    ],
                  },
                  {
                    "title": "정수와 유리수의 덧셈, 뺄셈",
                    "subject": [
                      {"title": "유리수의 덧셈", "count": 1, "progress": 36, "achievement": 35},
                      {"title": "유리수의 뺄셈", "count": 2, "progress": 17, "achievement": 45},
                    ],
                  },
                  {
                    "title": "정수와 유리수의 곱셈, 나눗셈",
                    "subject": [
                      {"title": "유리수의 곱셈", "count": 1, "progress": 40, "achievement": 17},
                      {"title": "세 개 이상의 수의 곱셈", "count": 2, "progress": 63, "achievement": 36},
                      {"title": "덧셈에 대한 곱셈의 분배법칙", "count": 1, "progress": 25, "achievement": 21},
                      {"title": "유리수의 나눗셈(+)", "count": 3, "progress": 86, "achievement": 96},
                      {"title": "유리수의 나눗셈(x역수)", "count": 1, "progress": 46, "achievement": 45},
                      {"title": "유리수의 덧셈, 뺄셈, 곱셈, 나눗셈의 혼합계산", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  }
                ]
              }
            ]
          }
        ]
      }),
      Curriculum.fromJson({
        "title": "문자와 식",
        "bigUnit": [
          {
            "title": "문자와 식",
            "middleUnit": [
              {
                "title": "문자의 사용과 식의 계산",
                "smallUnit": [
                  {
                    "title": "문자의 사용",
                    "subject": [
                      {"title": "문자를 사용한 식", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "곱셈 기호와 나눗셈 기호의 생략", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "식의 값(대입)", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "식의 계산",
                    "subject": [
                      {"title": "다항식과 일차식", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "일차식과 수의 곱셈, 나눗셈", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "일차식의 덧셈과 뺄셈", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  }
                ]
              },
              {
                "title": "일차방정식",
                "smallUnit": [
                  {
                    "title": "방정식과 그 해",
                    "subject": [
                      {"title": "방정식과 항등식", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "등식의 성질", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "일차방정식",
                    "subject": [
                      {"title": "일차방정식의 풀이", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "여러 가지 일차방정식의 풀이", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "일차방정식을 활용한 문제 해결 단계", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "속력에 대한 문제", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "농도에 대한 문제", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  }
                ]
              }
            ]
          }
        ]
      }),
      Curriculum.fromJson({
        "title": "함수",
        "bigUnit": [
          {
            "title": "좌표평면과 그래프",
            "middleUnit": [
              {
                "title": "좌표평면과 그래프",
                "smallUnit": [
                  {
                    "title": "순서쌍과 좌표",
                    "subject": [
                      {"title": "순서쌍과 좌표평면", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "사분면", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "그래프",
                    "subject": [
                      {"title": "그래프", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "정비례와 반비례",
                    "subject": [
                      {"title": "정비례", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "반비례", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  }
                ]
              },
            ]
          }
        ]
      }),
      Curriculum.fromJson({
        "title": "기하",
        "bigUnit": [
          {
            "title": "도형의 기초",
            "middleUnit": [
              {
                "title": "기본 도형",
                "smallUnit": [
                  {
                    "title": "점, 선, 면, 각",
                    "subject": [
                      {"title": "점, 선, 면", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "직선, 반직선, 선분", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "두 점 사이의 거리", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "각", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "맞꼭지각", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "수직과 수선", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "점, 직선, 평면의 위치 관계",
                    "subject": [
                      {"title": "점과 직선, 점과 평면의 위치 관계", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "평면에서 두 직선의 위치 관계", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "공간에서 두 직선의 위치 관계", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "공간에서 직선과 평면의 위치 관계", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "공간에서 두 평면의 위치 관계", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "동위각과 엇각",
                    "subject": [
                      {"title": "동위각과 엇각", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "평행선의 성질", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "두 직선이 평행할 조건", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  }
                ]
              },
              {
                "title": "작도와 합동",
                "smallUnit": [
                  {
                    "title": "삼각형의 작도",
                    "subject": [
                      {"title": "길이가 같은 선분의 작도", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "크기가 같은 각의 작도", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "평행선의 작도", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "삼각형", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "삼각형의 작도", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "삼각형이 정해질 조건", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "삼각형의 합동",
                    "subject": [
                      {"title": "도형의 합동", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "삼각형의 합동 조건", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  }
                ]
              }
            ]
          },
          {
            "title": "평면도형과 입체도형",
            "middleUnit": [
              {
                "title": "평면도형의 성질",
                "smallUnit": [
                  {
                    "title": "다각형의 성질",
                    "subject": [
                      {"title": "다각형", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "삼각형의 내각과 외각의 관계", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "다각형의 대각선의 개수", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "다각형의 내각과 외각의 크기의 합", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "정다각형의 한 내각과 한 외각의 크기", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "원과 부채꼴",
                    "subject": [
                      {"title": "원과 부채꼴", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "부채꼴의 성질", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "원의 둘레의 길이와 넓이", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "부채꼴의 호의 길이와 넓이", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  }
                ]
              },
              {
                "title": "입체도형의 성질",
                "smallUnit": [
                  {
                    "title": "다면체의 성질",
                    "subject": [
                      {"title": "다면체", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "각뿔대", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "다면체의 면, 모서리, 꼭짓점의 개수", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "정다면체", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "정다면체의 전개도", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "회전체의 성질",
                    "subject": [
                      {"title": "회전체", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "회전체의 성질", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "회전체의 전개도", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "입체도형의 겉넓이와 부피",
                    "subject": [
                      {"title": "기둥의 겉넓이", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "기둥의 부피", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "뿔의 겉넓이", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "뿔의 부피", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "구의 겉넓이와 부피", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                ]
              }
            ]
          }
        ]
      }),
      Curriculum.fromJson({
        "title": "확률과 통계",
        "bigUnit": [
          {
            "title": "통계",
            "middleUnit": [
              {
                "title": "자료의 정리와 해석",
                "smallUnit": [
                  {
                    "title": "줄기와 잎 그림",
                    "subject": [
                      {"title": "줄기와 잎 그림", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "도수분포표",
                    "subject": [
                      {"title": "도수분포표", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "히스토그램과 도수분포다각형",
                    "subject": [
                      {"title": "히스토그램", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "도수분포다각형", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "상대도수",
                    "subject": [
                      {"title": "상대도수", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "상대도수의 분포를 나타낸 그래프", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "도수의 총합이 다른 두 자료의 분포의 비교", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                ]
              },
            ]
          }
        ]
      }),
      // Curriculum.fromJson({
      //   "title": "",
      //   "bigUnit": [
      //     {
      //       "title": "",
      //       "middleUnit": [
      //         {
      //           "title": "",
      //           "smallUnit": [
      //             {
      //               "title": "",
      //               "subject": [
      //                 "",
      //                 "",
      //                 ""
      //               ],
      //             },
      //             {
      //               "title": "",
      //               "subject": [
      //                 "",
      //                 "",
      //                 ""
      //               ],
      //             }
      //           ]
      //         },
      //         {
      //           "title": "",
      //           "smallUnit": [
      //             {
      //               "title": "",
      //               "subject": [
      //                 "",
      //                 "",
      //               ],
      //             },
      //             {
      //               "title": "",
      //               "subject": [
      //                 "",
      //                 "",
      //                 "",
      //                 "",
      //               ],
      //             },
      //             {
      //               "title": "",
      //               "subject": [
      //                 "",
      //                 "",
      //               ],
      //             },
      //             {
      //               "title": "",
      //               "subject": [
      //                 "",
      //                 "",
      //                 "",
      //                 "",
      //                 "",
      //                 "",
      //               ],
      //             }
      //           ]
      //         }
      //       ]
      //     }
      //   ]
      // })
    ],
    [
      Curriculum.fromJson({
        "title": "수와 연산",
        "bigUnit": [
          {
            "title": "수와 식의 계산",
            "middleUnit": [
              {
                "title": "유리수와 순환소수",
                "smallUnit": [
                  {
                    "title": "유리수와 순환소수",
                    "subject": [
                      {"title": "유리수와 소수", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "순환소수", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "유한소수 또는 순환소수로 나타낼 수 있는 유리수", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "순환소수를 분수로 나타내기", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "유리수와 순환소수의 관계", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                ]
              },
              {
                "title": "단항식과 다항식의 계산",
                "smallUnit": [
                  {
                    "title": "지수법칙",
                    "subject": [
                      {"title": "지수법칙", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "다항식의 덧셈과 뺄셈",
                    "subject": [
                      {"title": "다항식의 덧셈과 뺄셈", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "다항식의 곱셈과 나눗셈(2)",
                    "subject": [
                      {"title": "단항식의 곱셈", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "단항식의 나눗셈", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "단항식의 곱셈과 나눗셈의 혼합계산", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "단항식과 다항식의 곱셈", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "단항식과 다항식의 나눗셈", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "식의 대입", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                ]
              }
            ]
          }
        ]
      }),
      Curriculum.fromJson({
        "title": "문자와 식",
        "bigUnit": [
          {
            "title": "부등식과 연립방정식",
            "middleUnit": [
              {
                "title": "일차부등식",
                "smallUnit": [
                  {
                    "title": "부등식과 그 해",
                    "subject": [
                      {"title": "부등식과 그 해", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "부등식의 성질", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "일차부등식",
                    "subject": [
                      {"title": "일차부등식의 풀이", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "여러 가지 일차부등식의 풀이", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "일차부등식의 활용", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "거리, 속력, 시간에 대한 문제", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "소금물의 농도에 대한 문제", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  }
                ]
              },
              {
                "title": "연립일차방정식",
                "smallUnit": [
                  {
                    "title": "미지수가 2개인 연립일차방정식",
                    "subject": [
                      {"title": "미지수가 2개인 일차방정식", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "미지수가 2개인 연립일차방정식", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "연립방정식의 풀이(가감법)", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "연립방정식의 풀이(대입법)", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "여러 가지 연립방정식의 풀이", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "A=B=C꼴 방정식의 풀이", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "해가 특수한 연립방정식", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "연립일차방정식의 활용", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "거리, 속력에 대한 문제", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "소금물의 농도에 대한 문제", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  }
                ]
              }
            ]
          }
        ]
      }),
      Curriculum.fromJson({
        "title": "함수",
        "bigUnit": [
          {
            "title": "함수",
            "middleUnit": [
              {
                "title": "일차함수와 그래프",
                "smallUnit": [
                  {
                    "title": "함수와 함숫값",
                    "subject": [
                      {"title": "함수", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "일차함수와 그 그래프",
                    "subject": [
                      {"title": "일차함수", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "일차함수 y=ax+b의 그래프의 성질", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "일차함수의 그래프와 절편", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "일차함수의 그래프와 기울기", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "일차함수 그래프의 성질과 활용",
                    "subject": [
                      {"title": "일차함수 y=ax+b의 그래프의 성질", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "일차함수 그래프의 평행, 일치", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "기울기와 y절편을 알 때, 일차함수의 식 구하기", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "기울기와 한 점의 좌표를 알 때, 일차함수의 식 구하기", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "두 점의 좌표를 알 때, 일차함수의 식 구하기", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "일차함수의 활용", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                ]
              },
              {
                "title": "일차함수와 일차방정식의 관계",
                "smallUnit": [
                  {
                    "title": "일차함수와 일차방정식",
                    "subject": [
                      {"title": "일차함수와 미지수가 2개인 일차방정식", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "방정식 x=p, y=q의 그래프", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "두 일차함수의 그래프와 연립일차방정식",
                    "subject": [
                      {"title": "일차함수의 그래프와 연립일차방정식의 해", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "연립일차방정식의 해의 개수와 그래프", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                ]
              }
            ]
          }
        ]
      }),
      Curriculum.fromJson({
        "title": "기하",
        "bigUnit": [
          {
            "title": "도형의 성질",
            "middleUnit": [
              {
                "title": "삼각형의 성질",
                "smallUnit": [
                  {
                    "title": "이등변삼각형의 성질",
                    "subject": [
                      {"title": "이등변삼각형의 성질", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "이등변삼각형이 되는 조건", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "직각삼각형의 합동 조건", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "각의 이등분선의 성질", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "삼각형의 외심과 내심",
                    "subject": [
                      {"title": "삼각형의 외심", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "삼각형의 외심의 응용", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "접선과 접점", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "삼각형의 내심", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "삼각형의 내심의 응용", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  }
                ]
              },
              {
                "title": "사각형의 성질",
                "smallUnit": [
                  {
                    "title": "평행사변형",
                    "subject": [
                      {"title": "평행사변형", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "평행사변형이 되는 조건", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "평행사변형이 되는 조건의 응용", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "평행사변형과 넓이", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "여러 가지 사각형",
                    "subject": [
                      {"title": "직사각형의 성질", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "마름모의 성질", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "정사각형의 성질", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "등변사다리꼴의 성질", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "여러 가지 사각형의 관계", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "평행선과 넓이", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                ]
              },
            ]
          },
          {
            "title": "도형의 닮음과 피타고라스 정리",
            "middleUnit": [
              {
                "title": "도형의 닮음",
                "smallUnit": [
                  {
                    "title": "닮은 도형",
                    "subject": [
                      {"title": "닮은 도형", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "닮은 도형의 성질", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "삼각형의 닮음 조건",
                    "subject": [
                      {"title": "삼각형의 닮음 조건", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "직각삼각형의 닮음", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "평행선 사이의 선분의 길이의 비",
                    "subject": [
                      {"title": "삼각형에서 평행선 사이의 선분의 길이의 비", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "삼각형의 각의 이등분선", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "평행선 사이의 선분의 길이의 비", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "사다리꼴에서 평행선 사이의 선분의 길이의 비", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "평행선 사이의 선분의 길이의 비와 응용", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "삼각형의 두 변의 중점을 연결한 선분의 성질", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "삼각형의 무게중심", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "삼각형의 무게중심과 넓이", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "닮은 도형의 넓이의 비와 부피의 비", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "닮음의 활용", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  }
                ]
              },
              {
                "title": "피타고라스 정리",
                "smallUnit": [
                  {
                    "title": "피타고라스 정리",
                    "subject": [
                      {"title": "피타고라스 정리", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "피타고라스 정리의 확인", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "직각삼각형이 되기 위한 조건", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "피타고라스 정리의 활용", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                ]
              }
            ]
          }
        ]
      }),
      Curriculum.fromJson({
        "title": "확률과 통계",
        "bigUnit": [
          {
            "title": "확률",
            "middleUnit": [
              {
                "title": "확률과 그 기본 성질",
                "smallUnit": [
                  {
                    "title": "경우의 수",
                    "subject": [
                      {"title": "사건과 경우의 수", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "사건 A 또는 사건 B가 일어나는 경우의 수", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "두 사건 A와 B가 동시에 일어나는 경우의 수", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "일렬로 세우는 경우의 수", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "자연수의 개수", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "대표를 뽑는 경우의 수", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  },
                  {
                    "title": "확률",
                    "subject": [
                      {"title": "확률의 뜻", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "확률의 기본 성질", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "어떤 사건이 일어나지 않을 확률", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "사건 A 또는 사건 B가 일어날 확률", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "두 사건 A와 B가 동시에 일어날 확률", "count": 0, "progress": 0, "achievement": 0},
                      {"title": "연속하여 꺼내는 경우의 확률", "count": 0, "progress": 0, "achievement": 0},
                    ],
                  }
                ]
              },
            ]
          }
        ]
      }),
    ]
  ];

  // final List<Curriculum> _curriculum2 = [
  //   Curriculum.fromJson({
  //     "title": "수와 연산",
  //     "bigUnit": [
  //       {
  //         "title": "수와 식의 계산",
  //         "middleUnit": [
  //           {
  //             "title": "유리수와 순환소수",
  //             "smallUnit": [
  //               {
  //                 "title": "유리수와 순환소수",
  //                 "subject": [
  //                   {"title": "유리수와 소수", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "순환소수", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "유한소수 또는 순환소수로 나타낼 수 있는 유리수", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "순환소수를 분수로 나타내기", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "유리수와 순환소수의 관계", "count": 0, "progress": 0, "achievement": 0},
  //                 ],
  //               },
  //             ]
  //           },
  //           {
  //             "title": "단항식과 다항식의 계산",
  //             "smallUnit": [
  //               {
  //                 "title": "지수법칙",
  //                 "subject": [
  //                   {"title": "지수법칙", "count": 0, "progress": 0, "achievement": 0},
  //                 ],
  //               },
  //               {
  //                 "title": "다항식의 덧셈과 뺄셈",
  //                 "subject": [
  //                   {"title": "다항식의 덧셈과 뺄셈", "count": 0, "progress": 0, "achievement": 0},
  //                 ],
  //               },
  //               {
  //                 "title": "다항식의 곱셈과 나눗셈(2)",
  //                 "subject": [
  //                   {"title": "단항식의 곱셈", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "단항식의 나눗셈", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "단항식의 곱셈과 나눗셈의 혼합계산", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "단항식과 다항식의 곱셈", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "단항식과 다항식의 나눗셈", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "식의 대입", "count": 0, "progress": 0, "achievement": 0},
  //                 ],
  //               },
  //             ]
  //           }
  //         ]
  //       }
  //     ]
  //   }),
  //   Curriculum.fromJson({
  //     "title": "문자와 식",
  //     "bigUnit": [
  //       {
  //         "title": "부등식과 연립방정식",
  //         "middleUnit": [
  //           {
  //             "title": "일차부등식",
  //             "smallUnit": [
  //               {
  //                 "title": "부등식과 그 해",
  //                 "subject": [
  //                   {"title": "부등식과 그 해", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "부등식의 성질", "count": 0, "progress": 0, "achievement": 0},
  //                 ],
  //               },
  //               {
  //                 "title": "일차부등식",
  //                 "subject": [
  //                   {"title": "일차부등식의 풀이", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "여러 가지 일차부등식의 풀이", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "일차부등식의 활용", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "거리, 속력, 시간에 대한 문제", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "소금물의 농도에 대한 문제", "count": 0, "progress": 0, "achievement": 0},
  //                 ],
  //               }
  //             ]
  //           },
  //           {
  //             "title": "연립일차방정식",
  //             "smallUnit": [
  //               {
  //                 "title": "미지수가 2개인 연립일차방정식",
  //                 "subject": [
  //                   {"title": "미지수가 2개인 일차방정식", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "미지수가 2개인 연립일차방정식", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "연립방정식의 풀이(가감법)", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "연립방정식의 풀이(대입법)", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "여러 가지 연립방정식의 풀이", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "A=B=C꼴 방정식의 풀이", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "해가 특수한 연립방정식", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "연립일차방정식의 활용", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "거리, 속력에 대한 문제", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "소금물의 농도에 대한 문제", "count": 0, "progress": 0, "achievement": 0},
  //                 ],
  //               }
  //             ]
  //           }
  //         ]
  //       }
  //     ]
  //   }),
  //   Curriculum.fromJson({
  //     "title": "함수",
  //     "bigUnit": [
  //       {
  //         "title": "함수",
  //         "middleUnit": [
  //           {
  //             "title": "일차함수와 그래프",
  //             "smallUnit": [
  //               {
  //                 "title": "함수와 함숫값",
  //                 "subject": [
  //                   {"title": "함수", "count": 0, "progress": 0, "achievement": 0}
  //                 ],
  //               },
  //               {
  //                 "title": "일차함수와 그 그래프",
  //                 "subject": [
  //                   {"title": "일차함수", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "일차함수 y=ax+b의 그래프의 성질", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "일차함수의 그래프와 절편", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "일차함수의 그래프와 기울기", "count": 0, "progress": 0, "achievement": 0},
  //                 ],
  //               },
  //               {
  //                 "title": "일차함수 그래프의 성질과 활용",
  //                 "subject": [
  //                   {"title": "일차함수 y=ax+b의 그래프의 성질", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "일차함수 그래프의 평행, 일치", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "기울기와 y절편을 알 때, 일차함수의 식 구하기", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "기울기와 한 점의 좌표를 알 때, 일차함수의 식 구하기", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "두 점의 좌표를 알 때, 일차함수의 식 구하기", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "일차함수의 활용", "count": 0, "progress": 0, "achievement": 0},
  //                 ],
  //               },
  //             ]
  //           },
  //           {
  //             "title": "일차함수와 일차방정식의 관계",
  //             "smallUnit": [
  //               {
  //                 "title": "일차함수와 일차방정식",
  //                 "subject": [
  //                   {"title": "일차함수와 미지수가 2개인 일차방정식", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "방정식 x=p, y=q의 그래프", "count": 0, "progress": 0, "achievement": 0},
  //                 ],
  //               },
  //               {
  //                 "title": "두 일차함수의 그래프와 연립일차방정식",
  //                 "subject": [
  //                   {"title": "일차함수의 그래프와 연립일차방정식의 해", "count": 0, "progress": 0, "achievement": 0},
  //                   {"title": "연립일차방정식의 해의 개수와 그래프", "count": 0, "progress": 0, "achievement": 0},
  //                 ],
  //               },
  //             ]
  //           }
  //         ]
  //       }
  //     ]
  //   }),
  //   Curriculum.fromJson({
  //     "title": "기하",
  //     "bigUnit": [
  //       {
  //         "title": "도형의 성질",
  //         "middleUnit": [
  //           {
  //             "title": "삼각형의 성질",
  //             "smallUnit": [
  //               {
  //                 "title": "이등변삼각형의 성질",
  //                 "subject": ["이등변삼각형의 성질", "이등변삼각형이 되는 조건", "직각삼각형의 합동 조건", "각의 이등분선의 성질"],
  //               },
  //               {
  //                 "title": "삼각형의 외심과 내심",
  //                 "subject": ["삼각형의 외심", "삼각형의 외심의 응용", "접선과 접점", "삼각형의 내심", "삼각형의 내심의 응용"],
  //               }
  //             ]
  //           },
  //           {
  //             "title": "사각형의 성질",
  //             "smallUnit": [
  //               {
  //                 "title": "평행사변형",
  //                 "subject": [
  //                   "평행사변형",
  //                   "평행사변형이 되는 조건",
  //                   "평행사변형이 되는 조건의 응용",
  //                   "평행사변형과 넓이",
  //                 ],
  //               },
  //               {
  //                 "title": "여러 가지 사각형",
  //                 "subject": [
  //                   "직사각형의 성질",
  //                   "마름모의 성질",
  //                   "정사각형의 성질",
  //                   "등변사다리꼴의 성질",
  //                   "여러 가지 사각형의 관계",
  //                   "평행선과 넓이",
  //                 ],
  //               },
  //             ]
  //           },
  //         ]
  //       },
  //       {
  //         "title": "도형의 닮음과 피타고라스 정리",
  //         "middleUnit": [
  //           {
  //             "title": "도형의 닮음",
  //             "smallUnit": [
  //               {
  //                 "title": "닮은 도형",
  //                 "subject": [
  //                   "닮은 도형",
  //                   "닮은 도형의 성질",
  //                 ],
  //               },
  //               {
  //                 "title": "삼각형의 닮음 조건",
  //                 "subject": [
  //                   "삼각형의 닮음 조건",
  //                   "직각삼각형의 닮음",
  //                 ],
  //               },
  //               {
  //                 "title": "평행선 사이의 선분의 길이의 비",
  //                 "subject": [
  //                   "삼각형에서 평행선 사이의 선분의 길이의 비",
  //                   "삼각형의 각의 이등분선",
  //                   "평행선 사이의 선분의 길이의 비",
  //                   "사다리꼴에서 평행선 사이의 선분의 길이의 비",
  //                   "평행선 사이의 선분의 길이의 비와 응용",
  //                   "삼각형의 두 변의 중점을 연결한 선분의 성질",
  //                   "삼각형의 무게중심",
  //                   "삼각형의 무게중심과 넓이",
  //                   "닮은 도형의 넓이의 비와 부피의 비",
  //                   "닮음의 활용",
  //                 ],
  //               }
  //             ]
  //           },
  //           {
  //             "title": "피타고라스 정리",
  //             "smallUnit": [
  //               {
  //                 "title": "피타고라스 정리",
  //                 "subject": [
  //                   "피타고라스 정리",
  //                   "피타고라스 정리의 확인",
  //                   "직각삼각형이 되기 위한 조건",
  //                   "피타고라스 정리의 활용",
  //                 ],
  //               },
  //             ]
  //           }
  //         ]
  //       }
  //     ]
  //   }),
  //   Curriculum.fromJson({
  //     "title": "확률과 통계",
  //     "bigUnit": [
  //       {
  //         "title": "확률",
  //         "middleUnit": [
  //           {
  //             "title": "확률과 그 기본 성질",
  //             "smallUnit": [
  //               {
  //                 "title": "경우의 수",
  //                 "subject": [
  //                   "사건과 경우의 수",
  //                   "사건 A 또는 사건 B가 일어나는 경우의 수",
  //                   "두 사건 A와 B가 동시에 일어나는 경우의 수",
  //                   "일렬로 세우는 경우의 수",
  //                   "자연수의 개수",
  //                   "대표를 뽑는 경우의 수"
  //                 ],
  //               },
  //               {
  //                 "title": "확률",
  //                 "subject": [
  //                   "확률의 뜻",
  //                   "확률의 기본 성질",
  //                   "어떤 사건이 일어나지 않을 확률",
  //                   "사건 A 또는 사건 B가 일어날 확률",
  //                   "두 사건 A와 B가 동시에 일어날 확률",
  //                   "연속하여 꺼내는 경우의 확률",
  //                 ],
  //               }
  //             ]
  //           },
  //         ]
  //       }
  //     ]
  //   }),
  // ];

  List<List<Curriculum>> get curriculum => _curriculum;

  // List<Curriculum> get curriculum2 => _curriculum2;
}
