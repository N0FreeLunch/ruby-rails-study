## 클래스

### 표현식과 구문
프로그래밍 언어에서는 표현식(Expression)과 구문(Statement)이란 개념이 있다.

표현식은 일반적으로 값에 해당하며 값을 사용하거나 전달하는 다양한 위치에서 사용된다.

구문은 문법적인 요소에 해당하며 표현식이 사용되는 곳에서 사용될 수 없으며 표현식 보다 엄격한 구문적 제약 사항이 존재한다.

### 클래스 구문
클래스는 구문에 해당하며, 클래스를 인스턴스화(오브젝트로 만들 때) 오브젝트는 표현식에 해당한다.

클래스는 구문에 해당하기 때문에 표현식이 위치하는 곳에 쓰이지 않으며, 정해진 형태로 사용해야 한다.

#### 자바스크립트의 클래스 구문
```js
class ClassName {
  memberVariable = 'value';
  memberFunction = function () {
    return "method call: " + this.memberVariable;
  }
}

const obj = (new ClassName);
console.log(obj.memberVariable);
console.log(obj.memberFunction());
```
자바스크립트에서 클래스를 만들 때는 `class 클래스명 {}` 구문을 사용한다.

클래스에 멤버를 만들 때는 const, let, var 등의 키워드 없이 클래스의 중괄호 {} 안에 중첩 중괄호 없이 '멤버명 = 값'의 방식으로 적어 준다. `class 클래스명 { 멤버명1 = 값1; 멤버명2 = 값2; 멤버명3 = 값3 }`의 문법을 갖는다.

```js
memberVariable = 'value';
```
- 위 코드에서 멤버명은 memberVariable이고, 그 값은 'value'이다.
```js
memberFunction = function () {
  return "method call: " + this.memberVariable;
}
```
- 위 코드에서 멤버명은 memberFunction이고 값은 `function () { return "method call: " + this.memberVariable; }`이다. 자바스크립트에서는 함수도 값에 해당하므로 `멤버명 = 값`의 구문을 따른다.

클래스 내에 변수를 만드는 것을 멤버 변수라고 하고, 클래스 내에 메소드를 만든는 것을 멤버 메소드라고 한다. 멤버 변수와 멤버 메소드는 클래스를 오브젝트로 만들 었을 때 '오브젝트.멤버'로 코드를 접근할 수 있게 한다.
```js
obj.memberVariable
obj.memberFunction();
```
- '오브젝트.멤버'를 통해서 멤버의 값에 접근할 수 있다.
- 오브젝트의 멤버의 값으로 함수를 정의한 경우에는 '오브젝트.멤버'는 함수 그 자체가 들어가 있으며, '오브젝트.멤버()'로 쓰면 함수의 실행한 결과 값이 나온다.
- 오브젝트의 멤버가 변수인 경우를 멤버 변수, 함수인 경우를 멤버 메소드라고 부른다.

오브젝트는 클래스에 new란 키워드를 붙여서 만들 수 있다.
```js
const obj = (new ClassName);
```
- 클래스는 구문이었지만, 오브젝트(여기서는 `(new ClassName)`)는 값으로 표현식에 해당한다. 따라서 변수 내에 넣을 수 있다.

#### 루비의 클래스 구문
```rb
class ClassName
  def initialize
    @memberVariable = 'value'
  end
  
  def memberFunction
    "method call: "+@memberVariable
  end
end

obj = ClassName.new
puts obj.instance_variable_get(:@memberVariable)
puts obj.memberFunction
```
루비에서 클래스를 정의할 때는 `class ClassName ... end`구문을 사용한다.

루비에서 멤버 변수를 만들 때는 항상 메소드 안에서 만들어 줘야 한다. 루비에서는 `class ClassName ... end`에서 ... 부분 안에 표현식에 해당하는 코드를 넣을 수 없다.

멤버 변수를 선언할 때는 클래스 내에 `def initialize ... end`라는 메소드를 만들고 이 메소드 안에 멤버 변수를 만들어 줘야 한다.
```rb
def initialize
  @memberVariable = 'value'
end
```
- 루비에서 클래스에서 공통적으로 사용할 변수에는 앞에 @를 붙여 줘야 한다. @를 붇이지 않으면 같은 클래스의 다른 메소드에서는 사용할 수 없다.
```rb
def memberFunction
  "method call: " + @memberVariable
end
```
- initialize 메소드에서 정의한 `@memberVariable`를 memberFunction 메소드에서 사용한 것을 알 수 있다.

루비의 클래스는 다음과 같은 구문을 사용한다.
```rb
class 클래스명
  def 메소드명1
    @멤버명1 = 값1
    변수명 = 값2
  end
  def 메소드명2
    @멤버명2 = 값3
    변수명 = 값4
  end
end
```
- 변수는 변수가 정의된 메소드에서만 사용할 수 있는 변수이며, 멤버는 변수가 선언된 클래스에서 사용할 수 있는 변수로 여러 메소드에서 사용할 수 있는 값이다.

루비에서 클래스로 인스턴스를 만들 때는 '클래스명.new'라는 방식을 사용한다. 인스턴스는 오브젝트라고도 불린다. 오브젝트는 값으로 표현식에 해당하므로 `obj = ClassName.new`와 같이 변수에 넣을 수 있다.

루비에서 멤버 변수를 만들 때는 메소드 내에서만 만들 수 있다. 자바스크립트와 비슷한 방식의 `class ClassName @memberVariable = 'value' end`와 같은 코드는 불가능하다. 클래스 내부에 바로 정의할 수 있는 멤버는 클래스를 인스턴스화 했을 때 'obj.@memberVariable'와 같은 방식으로 접근할 수 있다는 느낌을 주게 된다. 루비에서는 멤버 변수를 인스턴스에서 직접 접근할 수 없게 하기 위해서 의도적으로 클래스 내부에 멤버를 직접 정의할 수 없게 만들어 두었다.
```rb
obj.instance_variable_get(:@memberVariable)
```
- 굳이 멤버 변수에 접근하고자 한다면 `instance_variable_get` 메소드 사용한 코드를 사용할 수 있다. `instance_variable_get`는 클래스에서 정의하지 않아도 루비에서 인스턴스를 생성할 때 공통으로 갖는 디폴트 메소드 중 하나이다.

또한 루비에서는 인스턴스에서 멤버변수를 직접 접근할 수 없고 멤버 메소드만 접근할 수 있기 때문에 `obj.memberFunction`으로 `obj.memberFunction()`으로 괄호를 붙이지 않고 함수를 호출할 수 있도록 코드가 설계 되었다.
