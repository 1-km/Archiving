---
marp: true
paginate: true
---

# Flutter 화면 전환

김성박(urstory@gmail.com), 강경미(carami@nate.com)

---

### 1. Navigator를 이용한 화면 전환
Navigator는 Flutter에서 화면 전환을 관리하는 기본적인 방법입니다. 화면을 push, pop할 수 있으며, 다양한 애니메이션을 사용할 수 있습니다.

---

#### A. 기본 화면 전환 (Push/Pop)
```dart
// 다음 화면으로 이동
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => NextPage()),
);

// 현재 화면에서 이전 화면으로 돌아가기
Navigator.pop(context);
```

---

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
```

---

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NextPage()),
            );
            print('after Navigator push');
          },
          child: Text('Go to Next Page'),
        ),
      ),
    );
  }
}
```

---

```dart
class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
```

---

Flutter의 Navigator.push 메서드는 비동기로 동작하며, Future 객체를 반환합니다. 이 메서드가 호출될 때 현재 함수의 실행이 즉시 중단되지 않기 때문에 Navigator.push 다음에 오는 코드는 화면 전환이 완료되기 전에 실행될 수 있습니다.

---

예를 들어, 다음과 같은 코드가 있다고 가정할 때:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => NextPage()),
);
print('after Navigator push');
```

이 코드는 Navigator.push가 호출된 직후에 print('after Navigator push')가 실행됩니다. Navigator.push가 비동기적으로 동작하면서 화면 전환을 수행하는 동안, print는 즉시 실행되기 때문에 화면 전환 후에도 print 문이 실행된 결과를 볼 수 있습니다.

---

이러한 동작은 Flutter의 비동기 프로그래밍 모델에 의한 것입니다. Flutter에서 비동기 작업은 Future와 async/await 키워드를 통해 관리되며, 이는 다른 작업이 완료될 때까지 기다리지 않고 즉시 다음 작업을 실행할 수 있게 합니다.

---

만약 화면 전환이 완료된 후에 특정 작업을 수행하고 싶다면, await 키워드를 사용하여 Navigator.push의 완료를 기다릴 수 있습니다:

```dart
void _navigateToNextPage(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NextPage()),
  );
  print('after Navigator push');
}
```
이제 _navigateToNextPage 함수는 Navigator.push가 완료될 때까지 기다린 후 print('after Navigator push')를 실행하게 됩니다.

---

#### B. Named Route를 이용한 화면 전환
미리 정의된 경로를 이용하여 화면 전환을 할 수 있습니다.

```dart
// 경로 정의 (main.dart)
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/next': (context) => NextPage(),
    },
  ));
}

// 경로를 이용한 화면 전환
Navigator.pushNamed(context, '/next');
```

---

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/next': (context) => NextPage(),
      },
    );
  }
}
```

---

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/next');
          },
          child: Text('Go to Next Page'),
        ),
      ),
    );
  }
}
```

---

```dart
class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
```

---

Named Route를 이용한 화면 전환은 다음과 같은 상황에서 유용하게 사용할 수 있습니다:

1. 경로 관리를 쉽게 하고 싶을 때
앱의 규모가 커짐에 따라 여러 화면이 생기면 각 화면에 대한 경로를 중앙에서 관리하는 것이 중요합니다. Named Route를 사용하면 각 화면의 경로를 한 곳에서 정의할 수 있어 경로 관리를 더 쉽게 할 수 있습니다.

2. 동적으로 화면을 전환할 때
사용자 액션이나 앱 상태에 따라 동적으로 화면을 전환해야 할 때 Named Route를 사용하면 경로 이름만 변경하여 쉽게 전환할 수 있습니다. 이는 복잡한 조건에 따라 여러 화면을 전환해야 하는 경우 유용합니다.

---

3. 유지보수와 확장성을 고려할 때
경로 이름을 사용하면 나중에 화면 경로를 변경해야 할 때 코드 전반에 걸쳐 일일이 수정할 필요 없이 경로 정의만 수정하면 되므로 유지보수가 더 쉬워집니다. 또한, 새로운 화면을 추가할 때도 경로 이름을 통해 쉽게 추가할 수 있습니다.

4. 내비게이션을 통한 특정 화면으로의 접근을 용이하게 할 때
특정 기능에서 특정 화면으로 이동할 때 경로 이름을 사용하면 더 명확하고 직관적으로 코드 작성이 가능합니다. 예를 들어, 사용자 프로필 화면, 설정 화면 등 특정 기능 화면으로의 접근이 필요한 경우 유용합니다.

---

### 2. PageRouteBuilder를 이용한 화면 전환 애니메이션
PageRouteBuilder를 사용하여 사용자 정의 애니메이션을 적용할 수 있습니다.

```dart
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => NextPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
);
```

---

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
```

---

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => NextPage(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: Text('Go to Next Page'),
        ),
      ),
    );
  }
}
```

---

```dart
class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
```

---

위 코드에서 사용된 애니메이션은 `FadeTransition`입니다. `PageRouteBuilder` 클래스는 사용자 정의 페이지 전환 애니메이션을 적용할 수 있는 방법을 제공합니다. `PageRouteBuilder`는 `pageBuilder`와 `transitionsBuilder`를 사용하여 화면 전환을 정의합니다.

---

### PageRouteBuilder 클래스 사용 방법

1. **pageBuilder**: 전환될 새 페이지를 정의합니다. `pageBuilder`는 세 개의 인자를 받습니다: `context`, `animation`, `secondaryAnimation`. 여기서 `context`는 BuildContext, `animation`은 전환 애니메이션, `secondaryAnimation`은 부가 애니메이션입니다.

---
  
2. **transitionsBuilder**: 전환 애니메이션을 정의합니다. `transitionsBuilder`는 네 개의 인자를 받습니다: `context`, `animation`, `secondaryAnimation`, `child`. 여기서 `child`는 새 페이지 위젯입니다. `animation`과 `secondaryAnimation`을 사용하여 전환 효과를 정의할 수 있습니다.

---


### 다른 애니메이션 적용 예제

`FadeTransition` 대신 다른 애니메이션을 적용할 수도 있습니다. 예를 들어, 슬라이드 인/아웃 애니메이션을 적용하려면 `SlideTransition`을 사용할 수 있습니다:

```dart
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => NextPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  ),
);
```

---

여기서 `SlideTransition`은 새 페이지가 오른쪽에서 왼쪽으로 슬라이드 인 되는 애니메이션을 적용합니다.

이처럼 `PageRouteBuilder`를 사용하면 다양한 전환 애니메이션을 쉽게 정의하고 적용할 수 있습니다.

---

### 3. CupertinoPageRoute를 이용한 화면 전환
iOS 스타일의 화면 전환을 원할 때 CupertinoPageRoute를 사용할 수 있습니다.

```dart
Navigator.push(
  context,
  CupertinoPageRoute(builder: (context) => NextPage()),
);
```

---

아래는 `CupertinoPageRoute`를 사용하여 iOS 스타일의 화면 전환을 구현한 실행 가능한 예제 코드입니다. `CupertinoPageRoute`를 사용하면 화면 전환이 iOS의 네이티브 애니메이션과 유사하게 작동합니다.

---

```dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
```

---

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => NextPage()),
            );
          },
          child: Text('Go to Next Page (iOS Style)'),
        ),
      ),
    );
  }
}
```

---

```dart
class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
```

---

### 설명
- `MyApp`: 앱의 루트 위젯입니다. `MaterialApp`을 사용하여 홈 페이지를 설정합니다.
- `HomePage`: 첫 번째 화면입니다. 버튼을 눌렀을 때 `CupertinoPageRoute`를 사용하여 `NextPage`로 전환합니다.
- `NextPage`: 두 번째 화면입니다. 버튼을 눌렀을 때 이전 화면으로 돌아갑니다.

### 주요 포인트
- `CupertinoPageRoute`는 iOS 스타일의 페이지 전환 애니메이션을 제공합니다.
- `Navigator.push` 메서드를 사용하여 새로운 페이지로 전환합니다.
- `CupertinoPageRoute`의 `builder` 속성에 전환할 페이지를 지정합니다.

이 예제를 실행하면 첫 번째 화면에서 버튼을 눌러 두 번째 화면으로 전환될 때 iOS 스타일의 애니메이션을 경험할 수 있습니다.

---

### 4. PageView를 이용한 화면 전환
PageView를 사용하면 스와이프를 통해 화면 전환을 할 수 있습니다.

```dart
class PageViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        FirstPage(),
        SecondPage(),
        ThirdPage(),
      ],
    );
  }
}
```

---

아래는 `PageView`를 사용하여 스와이프를 통해 화면 전환을 구현한 실행 가능한 예제 코드입니다. 이 코드는 여러 페이지를 스와이프를 통해 전환할 수 있도록 합니다.

---

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageViewExample(),
    );
  }
}
```

---

```dart
class PageViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageView Example'),
      ),
      body: PageView(
        children: <Widget>[
          FirstPage(),
          SecondPage(),
          ThirdPage(),
        ],
      ),
    );
  }
}
```

---

```dart
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text(
          'First Page',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
```

---

```dart
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Text(
          'Second Page',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
```

---

```dart
class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          'Third Page',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
```

---

### 설명
- `MyApp`: 앱의 루트 위젯입니다. `MaterialApp`을 사용하여 홈 화면을 설정합니다.
- `PageViewExample`: `PageView`를 포함하는 화면입니다. 여러 페이지를 자식으로 가지며, 스와이프를 통해 페이지를 전환할 수 있습니다.
- `FirstPage`, `SecondPage`, `ThirdPage`: 각 페이지를 나타내는 위젯입니다. 각각 다른 배경색과 텍스트를 가집니다.

---

### 주요 포인트
- `PageView`: 여러 페이지를 스와이프하여 전환할 수 있도록 하는 위젯입니다.
- `children`: `PageView`의 자식 위젯들로, 각 페이지가 됩니다.
- 각 페이지는 `Container`를 사용하여 배경색과 텍스트를 설정했습니다.

이 예제를 실행하면 각 페이지를 스와이프하여 다음 페이지로 이동할 수 있습니다. 첫 번째 페이지는 빨간색 배경에 "First Page" 텍스트를, 두 번째 페이지는 초록색 배경에 "Second Page" 텍스트를, 세 번째 페이지는 파란색 배경에 "Third Page" 텍스트를 표시합니다.

---

### 5. AnimationController를 이용한 화면 전환
더욱 복잡한 애니메이션을 적용하려면 AnimationController를 사용할 수 있습니다.

```dart
class AnimatedTransition extends StatefulWidget {
  @override
  _AnimatedTransitionState createState() => _AnimatedTransitionState();
}

class _AnimatedTransitionState extends State<AnimatedTransition> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _controller,
        child: NextPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.forward();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
```

---

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
```

---

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnimatedTransition()),
            );
          },
          child: Text('Go to Animated Transition'),
        ),
      ),
    );
  }
}
```

---

```dart
class AnimatedTransition extends StatefulWidget {
  @override
  _AnimatedTransitionState createState() => _AnimatedTransitionState();
}

class _AnimatedTransitionState extends State<AnimatedTransition> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }
```

---

```dart
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Transition'),
      ),
      body: FadeTransition(
        opacity: _controller,
        child: NextPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.forward();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
```

---

```dart
class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
```

---

### 설명
- `late` 키워드를 사용하여 `AnimationController`를 늦은 초기화로 선언했습니다.
- `_controller`는 `initState`에서 초기화됩니다. 이렇게 하면 `null-safety`가 보장됩니다.

이 코드를 실행하면 `AnimationController`가 정상적으로 초기화되어 애니메이션 전환이 올바르게 동작할 것입니다.

---

### 6. GetX를 이용한 화면 전환
GetX 패키지를 사용하면 간단하게 화면 전환과 상태 관리를 할 수 있습니다.

```dart
// GetX 설치
dependencies:
  get: ^4.3.8

// 화면 전환
Get.to(NextPage());

// Named Route
Get.toNamed('/next');

// 이전 화면으로 돌아가기
Get.back();
```

---

`GetX`를 이용하여 화면 전환과 상태 관리를 구현하는 실행 가능한 예제 코드를 작성하겠습니다. 먼저, `pubspec.yaml` 파일에 `get` 패키지를 추가합니다.

### Step 1: `pubspec.yaml` 파일에 GetX 패키지 추가

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.3.8
```

---

### Step 2: GetX를 사용한 화면 전환 예제 코드 작성

아래는 GetX를 사용하여 기본 화면 전환, Named Route를 이용한 화면 전환, 그리고 이전 화면으로 돌아가는 기능을 포함한 Flutter 애플리케이션의 예제 코드입니다.

---

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/next', page: () => NextPage()),
      ],
    );
  }
}
```

---

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.to(NextPage());
              },
              child: Text('Go to Next Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/next');
              },
              child: Text('Go to Next Page with Named Route'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

```dart
class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
```

---

### 설명
- `GetMaterialApp`: GetX에서 제공하는 MaterialApp의 대체 클래스입니다. 이를 사용하여 GetX의 다양한 기능을 쉽게 활용할 수 있습니다.
- `getPages`: 애플리케이션의 모든 경로를 정의합니다. 각 경로는 `GetPage` 객체로 정의되며, `name`과 `page` 속성을 갖습니다.
- `Get.to`: 주어진 페이지로 이동합니다.
- `Get.toNamed`: 이름으로 정의된 경로로 이동합니다.
- `Get.back`: 이전 화면으로 돌아갑니다.

이 예제를 실행하면 홈 페이지에서 두 가지 버튼을 볼 수 있습니다. 첫 번째 버튼은 `Get.to`를 사용하여 `NextPage`로 이동하고, 두 번째 버튼은 `Get.toNamed`를 사용하여 Named Route로 `NextPage`로 이동합니다. `NextPage`에서는 버튼을 눌러 이전 화면으로 돌아갈 수 있습니다.

---

# 끝