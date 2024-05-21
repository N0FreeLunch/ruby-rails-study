## 멤버
- 멤버는 클래스가 인스턴스화 되었을 때 `인스턴스.멤버명`을 통해서 접근할 수 있는 값을 만드는 것을 뜻한다.
- 클래스는 인스턴스를 만드는 설계도, 청사진으로 클래스에서 멤버를 정의하면 인스턴스에서 해당 멤버를 사용할 수 있다.

### 설계도과 구현
클래스는 멤버를 정의할 뿐, 멤버를 사용할 수는 없다. 클래스는 멤버를 정의하고 인스턴스의 멤버를 사용한다. 클래스는 설계도이고 멤버는 구현에 해당한다.

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
- 위의 코드에서 `ClassName.memberVariable`, `ClassName.memberFunction()`으로 클래스에 멤버를 사용할 수는 없으며, 클래스를 인스턴스화 한 `const obj = (new ClassName)`에 대해 `obj.memberVariable`, `obj.memberFunction()`를 사용할 수 있다. 자바스크립트에서는 `클래스.멤버명`은 undefined가 된다.

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
- 루비에서도 마찬가지로 `ClassName.memberFunction` 클래스에서 멤버를 사용할 수는 없다. 루비에서 `클래스.멤버명`은 에러를 발생시킨다. 이에 반해 인스턴스화 된 객체 `obj = ClassName.new`에 대해서는 `obj.memberFunction`와 같이 멤버에 접근할 수 있다.

### 인스턴스와 상태
일반적으로 클래스는 붕어빵 틀에, 인스턴스는 붕어빵에 비유한다. 붕어빵 틀 하나로 여러개의 붕어빵을 만들 수 있으며, 안에 어떤 속을 넣을 것인지에 따라서, 팥 붕어빵, 슈크림 붕어빵, 고구마 붕어빵, 카레 붕어빵 등 다양한 붕어빵을 만들 수 있다.

다양한 속의 붕어빵을 만들 수 있듯이, 클래스의 멤버를 어떻게 설정하느냐에 따라서 다양한 상태를 가진 인스턴스를 만들 수 있다. 클래스를 통해서 인스턴스의 동작 방식을 정의할 수 있고, 클래스를 인스턴스로 만들면서 인스턴스의 상태를 정의할 수 있다.

```js
class ClassName {
  memberVariable = 'value';

  setMemberVariable = function (value) {
    this.memberVariable = value;
  }

  memberFunction = function () {
    return "method call: " + this.memberVariable;
  }
}

const obj1 = (new ClassName)
obj1.setMemberVariable('hello');
console.log(obj1.memberVariable);
console.log(obj1.memberFunction());

const obj2 = (new ClassName)
obj2.setMemberVariable('world');
console.log(obj2.memberVariable);
console.log(obj2.memberFunction());
```
- 위의 코드에서 `setMemberVariable`라는 메소드를 추가하였다. `obj1.setMemberVariable();`메소드를 통해서 `memberVariable`의 값을 설정한다. `obj1`의 멤버 변수 `memberVariable`는 `'hello'`가 되며, obj2의 `memberVariable`는 `'world'`가 된다.
- `obj1`은 붕어빵 속에 `'hello'`를 넣은 것과 같고, `obj2`는 붕어빵 속에 `'world'`를 넣은 것으로 생각하면 된다. 동일한 클래스를 사용하지만, 인스턴스 각각의 멤버 변수를 어떻게 바꾸냐에 따라서 서로 다른 특성을 가진 인스턴스가 된다.

```rb
class ClassName
  def initialize
    @memberVariable = 'value'
  end

  def setMemberVariable(value)
    @memberVariable = value
  end
  
  def memberFunction
    "method call: "+@memberVariable
  end
end

obj1 = ClassName.new
obj1.setMemberVariable('hello')
puts obj1.instance_variable_get(:@memberVariable)
puts obj1.memberFunction

obj2 = ClassName.new
obj2.setMemberVariable('world')
puts obj2.instance_variable_get(:@memberVariable)
puts obj2.memberFunction
```
- 위의 코드에서 `setMemberVariable` 메소드를 통해서 각각의 인스턴스에 대해 멤버 변수의 상태를 `obj1`은 `memberVariable`를 `'hello'`으로 `obj2`는 `'world'`으로 만들어 두었다. 이에 따라서 `obj1`과 `obj2`에서 동일한 멤버 `memberFunction`를 호출하지만 그 결과는 멤버 변수가 다르기 때문에 `method call: hello`과 `method call: world`으로 서로 다른 결과를 갖는다.
