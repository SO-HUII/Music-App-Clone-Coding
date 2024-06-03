## 🔉 프로젝트 소개

네이버 VIBE를 기반으로 한 클론코딩 프로젝트입니다.
<br>
기본적인 노래 재생, 가사 감상, 음원 검색 기능을 구현했습니다.

<br>

**디자인 패턴**
<br>
`mvc 패턴 + repository 패턴`

<br>

**사용 패키지**
```
get: ^4.6.6
dio: ^5.4.3+1
http: ^1.2.1
cupertino_icons: ^1.0.6
flutter_svg: ^2.0.10+1
audioplayers: ^6.0.0
scrollable_positioned_list: ^0.3.8
```

**사용 API**
```
1. https://api.manana.kr/karaoke.json
2. 프로그래머스 연습과제 뮤직 플레이어 앱
``` 

<br>

## 🌱 핵심 기능

1️⃣ **음악 재생**

- 홈 화면 하단의 small player 재생 버튼 클릭시 음악 재생
- small player 클릭 시 player view로 이동

![캡처](https://github.com/SO-HUII/Music-App-Clone-Coding/assets/109736890/552555dc-2671-4e25-843f-43a346037278)


<br>

2️⃣ **음악 싱크로율에 맞추어 가사 이동**

- 현재 재생되는 노래에 맞는 가사 focus 및 위치 이동
- player view에서는 두 줄 감상 가능
- bottom bar 가사 icon 클릭 시 전체 가사 감상 가능 

![캡처1](https://github.com/SO-HUII/Music-App-Clone-Coding/assets/109736890/0785ad36-4c10-4ac7-99ee-982d8ae7043e)

<br>

3️⃣ **음원 검색**

- 검색어 입력시 해당 단어가 포함되어있는 음원 목록을 보여줌.
- 입력된 문자가 없을시, 음원 전체 목록이 보여짐.
- cancel icon 클릭시, 입력된 제목이 리셋되고 전체 목록이 보여짐.
- 단, 검색은 최소 음절 입력시 음원 찾기 가능.

![캡처2](https://github.com/SO-HUII/Music-App-Clone-Coding/assets/109736890/865d92ff-3654-4f6d-858d-1ad677d5f788)

<br>

4️⃣ **음원 상세정보**

- search view의 음원 커버 사진 클릭시, 해당 음원의 상세 정보 페이지로 이동.
- `노래 제목, 가수, 발매일, 작곡가, 작사가` 정보 존재.

<img src="Screenshot_1717388427.png" width="300" height="600"/>

<br>

## ✅ 커밋 컨벤션

| 제목        | 내용                                                                             |
| ----------- | -------------------------------------------------------------------------------- |
| Init        | 작업 세팅 커밋 (패키지 설치 등)                                                  |
| Feat        | 새로운 기능을 추가할 경우 커밋                                                   |                         
| Style       | 기능에 영향을 주지 않는 커밋 (코드 순서, 문법, 포맷 수정에 대한 커밋)             |
| Design      | CSS 등 사용자 UI 디자인 변경에 관한 커밋                                         |
| Fix         | 버그 수정에 대한 커밋                                                            |
| Docs        | 문서를 수정한 경우, 파일 삭제, 파일명 수정 등에 대한 커밋 ex) README.md           |                                                |

<br>

## 📫 폴더 구조
```
lib
 ┣ 📂api
 ┃ ┗ 📜api_service.dart
 ┣ 📂common
 ┃ ┣ 📂components
 ┃ ┗ 📂style
 ┃ ┃ ┣ 📜color.dart
 ┃ ┃ ┣ 📜font.dart
 ┃ ┃ ┗ 📜icon.dart
 ┣ 📂models
 ┃ ┣ 📜home.model.dart
 ┃ ┣ 📜music.model.dart
 ┃ ┗ 📜player.model.dart
 ┣ 📂repository
 ┃ ┣ 📜music.repository.dart
 ┃ ┗ 📜player.repository.dart
 ┣ 📂routes
 ┃ ┣ 📂home
 ┃ ┃ ┣ 📂components
 ┃ ┃ ┃ ┣ 📜homeHeader.widget.dart
 ┃ ┃ ┃ ┣ 📜magazine.widget.dart
 ┃ ┃ ┃ ┣ 📜mixtape.widget.dart
 ┃ ┃ ┃ ┣ 📜partyRoom.widget.dart
 ┃ ┃ ┃ ┣ 📜recentAlbum.widget.dart
 ┃ ┃ ┃ ┣ 📜recentListenedMusic.widget.dart
 ┃ ┃ ┃ ┣ 📜recommendPlayList.widget.dart
 ┃ ┃ ┃ ┣ 📜smallPlayer.widget.dart
 ┃ ┃ ┃ ┗ 📜twoLineLyrics.widget.dart
 ┃ ┃ ┗ 📜home.view.dart
 ┃ ┗ 📂player
 ┃ ┃ ┣ 📜lyrics.view.dart
 ┃ ┃ ┣ 📜music.controller.dart
 ┃ ┃ ┣ 📜musicDetail.view.dart
 ┃ ┃ ┣ 📜player.controller.dart
 ┃ ┃ ┣ 📜player.view.dart
 ┃ ┃ ┗ 📜search.view.dart
 ┗ 📜main.dart
```
