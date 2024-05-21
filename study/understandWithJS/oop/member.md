## 멤버
- 멤버는 클래스가 인스턴스화 되었을 때 `인스턴스.멤버명`을 통해서 접근할 수 있는 값을 만드는 것을 뜻한다.
- 클래스는 인스턴스를 만드는 설계도, 청사진으로 클래스에서 멤버를 정의하면 인스턴스에서 해당 멤버를 사용할 수 있다.

### 설계도
클래스는 멤버를 정의할 뿐, 멤버를 사용할 수는 없다.

클래스는 멤법를 정의하고 인스턴스의 멤버를 사용한다.

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

### 인스턴스를 만드는 의도
일반적으로 클래스는 붕어빵 틀에, 인스턴스는 붕어빵에 비유한다. 붕어빵 틀 하나로 여러개의 붕어빵을 만들 수 있으며, 안에 어떤 속을 넣을 것인지에 따라서, 팥 붕어빵, 슈크림 붕어빵, 고구마 붕어빵, 카레 붕어빵 등 다양한 붕어빵을 만들 수 있다.

다양한 속의 붕어빵을 만들 수 있듯이, 클래스의 멤버를 어떻게 설정하느냐에 따라서 다양한 상태를 가진 인스턴스를 만들 수 있다. 클래스를 통해서 인스턴스의 동작 방식을 정의할 수 있고, 클래스를 인스턴스로 만들면서 인스턴스의 상태를 정의할 수 있다.
