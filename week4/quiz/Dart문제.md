---
marp: true
paginate: true
---

1. **Null Safety**: Dart에서 null safety는 어떻게 구현됩니다? 예를 들어 변수를 선언할 때 `?`와 `!` 연산자는 각각 어떤 의미를 가지며 언제 사용되나요?

2. **Asynchronous Programming**: `async`와 `await` 키워드의 사용법과 중요성에 대해 설명해주세요. Dart에서 비동기 프로그래밍이 왜 중요한가요?

3. **Extension Methods**: Dart에서 extension methods는 무엇이며, 왜 유용한가요? 간단한 예를 들어 extension method의 사용법을 설명해주세요.

4. **Collection Literals**: Dart에서 제공하는 다양한 컬렉션 리터럴(types)에는 어떤 것들이 있나요? 각각의 특징과 차이점에 대해 설명해주세요.

5. **Spread Operators and Collection Ifs and Fors**: Dart에서 spread 연산자는 어떻게 사용되며, 컬렉션 내에서 `if`와 `for`를 사용하는 방법에 대해 설명해주세요.

6. **Type Inference with the `var`, `final`, and `const` Keywords**: `var`, `final`, `const` 키워드는 Dart에서 어떻게 사용되며, 각각 어떤 경우에 적합한가요? 타입 추론과 관련하여 이들 키워드의 역할을 설명해주세요.

7. **Mixins**: Dart에서 mixins는 무엇이며, 어떻게 사용하나요? 클래스 상속과 비교했을 때 mixins의 장점과 적용 사례를 설명해주세요.

8. **Generics and Type Safety**: Dart에서 제네릭(generics)을 사용하는 이유와 이점은 무엇인가요? 간단한 예를 들어 제네릭의 구현 방법을 설명해주세요.

---

### 답변:

1. **Null Safety**:
   Dart에서 null safety는 값이 null이 될 수 있는 변수와 그렇지 않은 변수를 명확히 구분하는 기능입니다. Dart에서 변수가 null 값을 가질 수 있도록 하려면 변수 타입 뒤에 `?`를 붙여야 합니다. 예를 들어, `int? a`는 `a`가 `int` 또는 `null`을 가질 수 있음을 의미합니다. 반대로 `int a`는 `a`가 결코 `null`이 될 수 없음을 의미합니다. `!` 연산자는 null이 아님을 단언(assert)하는 연산자로, null이 아닐 것이 확실한 상황에서 null 가능 타입의 변수를 사용할 때 붙여 사용합니다. 예를 들어, `int? a`에서 `a`가 null이 아니라고 확신할 때 `a!`를 사용하여 `int`로 처리할 수 있습니다.

2. **Asynchronous Programming**:
   Dart에서 `async`와 `await` 키워드는 비동기 프로그래밍을 구현하는데 사용됩니다. `async` 키워드를 함수 선언에 추가함으로써 그 함수는 비동기 함수가 되며, 이 함수 내부에서 `await`를 사용하여 비동기적으로 실행되는 다른 함수의 완료를 기다릴 수 있습니다. 이 기능은 I/O 작업, 네트워크 요청, 긴 계산 작업 등을 처리할 때 UI가 멈추지 않도록 하며, 프로그램의 전반적인 반응성을 향상시킵니다. `await`를 사용하는 것은 비동기 작업의 결과를 동기적인 방식으로 처리할 수 있게 해주어 코드의 가독성과 유지보수성을 높여줍니다.

3. **Extension Methods**:
   Dart에서 extension methods는 기존의 클래스에 새로운 메서드를 추가할 수 있게 해주는 기능입니다. 이는 기존 라이브러리를 수정하지 않고도 클래스의 기능을 확장할 수 있게 해줍니다. 예를 들어, `String` 클래스에 팰린드롬을 확인하는 메서드를 추가하고 싶다면 다음과 같이 작성할 수 있습니다:

   ```dart
   extension StringExtension on String {
       bool get isPalindrome {
           String reversed = this.split('').reversed.join('');
           return this == reversed;
       }
   }
   ```

   이렇게 하면 모든 `String` 객체에서 `.isPalindrome`을 호출하여 팰린드롬 여부를 확인할 수 있습니다.

4. **Collection Literals**:
   Dart에서는 다양한 컬렉션 리터럴을 지원합니다. 주요 컬렉션 타입에는 List, Set, 그리고 Map이 포함됩니다.

   - **List**: 순서가 있는 컬렉션으로, 중복된 요소를 포함할 수 있습니다. `var list = [1, 2, 3];`
   - **Set**: 순서를 갖지 않고, 중복된 요소를 허용하지 않는 컬렉션입니다. `var set = {1, 2, 3};`
   - **Map**: 키-값 쌍을 저장하는 컬렉션으로, 각 키는 고유해야 합니다. `var map = {'first': 'Tom', 'second': 'Jerry'};`
     각 컬렉션 타입은 특정 상황에 따라 선택하여 사용할 수 있으며, 각기 다른 메서드와 프로퍼티를 제공하여 데이터를 관리하는 데 최적화되어 있습니다.

   ***

   ### 답변:

5. **Collection Literals**:
   Dart는 List, Set, Map 등의 컬렉션 리터럴을 제공합니다.

   - **List**: 순서 있는 요소의 컬렉션을 생성합니다. 예: `var myList = [1, 2, 3];`
   - **Set**: 중복을 허용하지 않는 요소의 컬렉션입니다. 예: `var mySet = {1, 2, 3};`
   - **Map**: 키-값 쌍을 포함하는 컬렉션입니다. 예: `var myMap = {'first': 'Tom', 'second': 'Jerry'};`
     List는 순서를 유지하고, 같은 요소를 여러 번 포함할 수 있습니다. Set은 순서를 유지하지 않고, 같은 요소를 한 번만 포함할 수 있습니다. Map은 키에 대응하는 값을 저장하며, 각 키는 고유해야 합니다.

6. **Spread Operators and Collection Ifs and Fors**:
   Dart에서 spread 연산자(`...`)는 컬렉션 내부의 모든 요소를 현재 컬렉션에 포함시킬 때 사용됩니다. `if`와 `for`는 컬렉션을 빌드할 때 조건부로 요소를 추가하거나 반복해서 요소를 추가하는 데 사용됩니다.
   예시:

   ```dart
   var list = [1, 2, 3];
   var anotherList = [0, ...list, 4];
   var yetAnotherList = [for (var i in list) i * 2];
   var conditionalList = [if (list.length > 2) 'Big list'];
   ```

   `anotherList`는 `[0, 1, 2, 3, 4]`가 됩니다. `yetAnotherList`는 각 요소를 두 배로 늘린 `[2, 4, 6]`이 됩니다. `conditionalList`는 조건이 참일 때만 'Big list' 요소를 포함합니다.

7. **Type Inference with the `var`, `final`, and `const` Keywords**:

   - **var**: 초기화 시점에 변수의 타입이 결정됩니다. 이후 다른 타입의 값을 할당할 수 없습니다.
   - **final**: 한 번만 값을 할당할 수 있는 변수를 선언합니다. 값은 런타임에 할당될 수 있지만, 한 번 할당된 후에는 변경할 수 없습니다.
   - **const**: 컴파일 시점에 값이 결정되는 상수를 선언합니다. `final`과 유사하지만, 모든 `const` 변수는 컴파일 시에 값이 확정됩니다.
     예를 들어, `var`는 타입이 명확하지 않을 때, `final`은 값이 한 번 설정되고 변경되지 않을 때, `const`는 컴파일 시점에 알려진 상수 값이 필요할 때 사용합니다.

8. **Mixins**:
   Dart에서 mixins는 클래스의 코드를 여러 클래스 간에 재사용하기 위한 방법입니다. 클래스 상속과 비교했을 때, mixins는 다중 상속의 이점을 제공하면서도 다이아몬드 문제(상속의 모호성)를 피할 수 있습니다.
   예시:

   ```dart
   mixin Musical {
       void play() => print("Playing music.");
   }

   class Performer {}

   class Musician extends Performer with Musical {}
   ```

   여기서 `Musician` 클래스는 `Performer`로부터 상속받고 `Musical` mixin을 사용하여 `play` 기능을 추가합니다.

9. **Generics and Type Safety**:
   Dart에서 제네릭을 사용하는 이유는 타입 안전성을 보장하고, 다양한 데이터 타입에 유연하게 대응할 수 있는 코드를 작성하기 위해서입니다. 제네릭은 컴파일 시 타입 검사를 강화하여 런타임 오류

를 줄여줍니다.
예시:

```dart
class Box<T> {
    final T value;
    Box(this.value);
}

var box = Box<int>(123);
```

여기서 `Box<T>`는 어떤 타입의 값을 저장할 수 있는 범용 컨테이너를 만듭니다. `Box<int>`는 정수만 저장하는 상자를 생성합니다.
