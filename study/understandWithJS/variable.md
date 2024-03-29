## 변수

### 변수명

#### 루비

- 루비의 변수명으로 사용할 수 있는 이름의 규칙은 영문 대소문자, 숫자, \_(언더스코어)를 사용한다.
- 변수명의 첫 글자는 숫자로 시작할 수 없는데 수의 경우 0x로 시작하는 경우 16진수, 0으로 시작하는 경우 8진수, 0b로 시작하는 경우 2진수가 되는 등 숫자로 시작하면 수와 연관된 방식으로 해석을 하기 때문에 변수와 수의 영역을 확실히 구분하기 위해서 변수명은 숫자로 시작하지 않는다. 이것은 대부분의 다른 언어에서도 마찬가지이다.

#### 자바스크립트

- 자바스크립트의 변수명은 다양한 알파벳 문자(영문 대소문자뿐만 아니라 다양한 언어의 문자들로 한글, 한자, 히라가나, 카타카나 등등), 숫자, \_(언더스코어), $(달러) 표기를 변수에 사용할 수 있다.
- 루비와의 차이점은 루비가 변수명으로 영문 대소문자만을 쓸 수 있는 것에 반해, 자바스크립트는 다양한 언어의 알파벳을 사용할 수 있다는 점이다. 물론 자바스크립트에서 다양한 문자를 사용할 수 있지만 일반적으로 영대소자를 변수명에 사용한다.

### 변수 선언의 종류

- 자바스크립트에서는 var, const, let 등의 변수를 선언하는 키워드가 있고 이를 통해서 변수의 특성을 설정할 수 있다. `var`는 function 함수를 지역변수 범위로 하는 재할당 가능한 변수이고, let은 중괄호 {}를 지역변수 범위로 하는 재할당 가능한 변수이고, const는 중괄호 {}를 지역변수 범위로 하는 재할당 불가능한 변수이다.
- 자바스크립트에서 변수를 선언할 수 있는 것과 달리 루비 언어의 변수는 선언하는 키워드가 없다. 하지만 변수를 표기하는 방식에 따라서 변수의 특징이 달라지는데 그냥 '변수명'인 경우에는 지역변수, '$변수명'은 전역변수로 사용하는 방법이 있다. 또한 루비에서는 자바스크립트와 같이 상수를 선언하는 키워드는 없지만 변수명의 첫 문자가 대문자로 시작하면 재할당이 불가능한 상수가 된다.
- 자바스크립트에서 지역변수의 범위를 결정하는 것은 중괄호이다. (var의 경우는 function 키워드 함수의 중괄호이다.) 루비에서 지역변수의 범위는 범위를 여는 키워드 def, do으로 시작해서 end로 끝나는 영역까지가 지역변수의 범위이다.
- 루비 언어에서 `def` ... `end`에서 ...은 함수 내부의 코드가 위치하는 부분이며 지역 변수의 범위이며, `do` ... `end`에서 ...은 블록 영역이라고 불리며 코드가 위치하는 부분으로 지역 변수를 갖는다.

### 변수의 재할당

```js
var a = 1;
a = 2;
console.log(a);
let b = 3;
b = 4;
console.log(b);
```

- 자바스크립트에서 `var` 또는 `let` 으로 선언한 변수는 재할당 가능하다. 따라서 선언될 때 할당된 값이 아닌 재할당된 값이 `console.log`에 출력된다.

```rb
a = 1
a = 2
puts a
b = 3
b = 4
puts b
```

- 루비의 변수도 마찬가지로 재할당이 가능하다. 따라서 처음 변수를 생성할 때 할당된 값이 아닌 재할당된 값이 `puts`에 출력된다.

### 상수

```js
const immutable = 1;
immutable = 2;
```

-　위의 자바스크립트 코드는 상수로 선언된 변수 `immutable`에 재할당을 하려고 시도했기 때문에 에러가 발생하는 코드이다. 상수로 선언된 변수는 재할당을 할 수 없다.

```rb
Immutable = 1
Immutable = 2
```

- 위의 루비 코드는 변수의 첫 문자가 대문자이므로 상수이다. 따라서 재할당이 불가능하다. 하지만 다음과 같이 첫 문자를 대문자로 쓰지 않는다면 상수가 되지 않으므로 재할당을 할 수 있다.

```rb
immutable = 1
immutable = 2
puts immutable
```

### 스코프

- 프로그래밍 언어에서 생성된 변수가 살아 있는 영역을 스코프라고 부른다. 변수가 생성되고 해당 변수가 지역 변수로 존재할 수 있는 범위를 스코프라고 한다.

### 지역변수

```js
function foo() {
  var a = 1;
  console.log(`inner a = ${a}`);
}

foo();
console.log(`outer a = ${a}`);
```

- 위 코드에서 a는 foo라는 함수가 실행되는 동안만 살아있는 변수이다. `foo()`라는 함수 실행 코드에 의해서 함수가 실행되면, 함수의 중괄호가 시작하는 부분 `{`부터의 코드를 실행하여 `}`로 함수가 끝나는 부분까지는 함수 내부의 코드가 실행된다.
- 함수가 실행되고 끝나기 전까지의 코드에서 선언된 변수는 함수가 끝날 때까지 함수 내에서 사용할 수 있으며, 함수가 끝나면 함수 내에서 생성된 변수를 더 이상 사용할 수 없다.
- 위의 코드에서 `var a = 1`으로 함수가 실행되고 종료되기 전 사이에 변수가 생성되었다. 이 변수는 함수가 끝나기 전의 코드의 실행에서는 살아있기 때문에 `` console.log(`inner a = ${a}`) ``코드에서 변수 `a`의 값인 1이 표시된다.
- 스코프 내에서 생성된 변수는 스코프 밖에서는 수명이 종료된다. `foo()`라는 코드는 함수를 실행한다는 의미도 있지만, 함수 내부의 코드들을 실행하고 함수를 종료한다는 의미도 갖고 있다. 함수 내에서 생성된 변수는 함수가 종료된 이후에는 사라지므로 함수 밖의 `` console.log(`outer a = ${a}`) `` 코드에서는 변수 `a`가 사라져서 실행할 수 없다. 존재하지 않는 변수의 값을 접근하려고 시도했기 때문에 `Uncaught ReferenceError: a is not defined`라는 에러가 발생한다.

```rb
def foo
  a = 1
  puts "inner a = #{a}"
end

foo

puts "outer a = #{a}"
```

- 앞선 자바스크립트 코드를 루비로 만든 것이다. `foo`를 통해서 함수가 실행이 되었고, `def foo`로 함수 내부의 코드가 실행이 되고, `end`으로 함수가 종료된다. 함수 내부의 코드가 실행이 될 때 `a = 1`로 변수가 생성된다. 이 변수는 함수가 종료될 때까지 살아있으므로 `puts "inner a = #{a}"`의 코드의 `#{a}` 부분이 1로 바뀐 결과를 갖는다. 하지만 함수가 종료된 이후 실행되는 `puts "outer a = #{a}"`에서는 더 이상 변수 `a`가 존재하지 않기 때문에 존재하지 않는 a값을 사용하려고 하기 때문에 에러가 발생한다. 존재하지 않는 변수에 접근하려고 시도했기 때문에 `undefined local variable or method `a'`라는 에러 메시지가 나온다.

### 전역변수

- 전역 변수란 스코프 내에 포함되지 않기 때문에 변수가 생성되고 자바스크립트의 실행이 종료되지 않는 한 변수가 죽지 않고 살아 있는 변수이다.

```js
function foo() {
  var a = 1;
  var b = 2;
  console.log(`inner a = ${a}`);
  console.log(`inner b = ${b}`);
}

foo();

console.log(`outer a = ${a}`);
console.log(`outer b = ${b}`);
```

- 자바 스크립트에서 전역 변수는 `var`의 경우 아무런 function 함수의 중괄호 내에 들어 있지 않은 경우 또는 `let`, `const`의 경우는 중괄호 {} 안에 들어 있지 않은 경우 전역 변수로 선언 된다.
- 참고로 자바스크립트의 모듈 내에 있을 때는 중괄호가 없어도 모듈 파일 내부가 스코프를 가지기 때문에 아무런 중괄호 안에 들어 있는 것이 아니더라도 전역 변수가 될 수 없다.
- 위의 코드를 보면 `var`로 선언된 변수는 function 함수 안에서 선언되었다. 따라서 `foo()`함수가 실행되고 함수 내부에서 선언된 `var a = 1`와 `var b = 2`는 함수 내의 코드가 다 실행되어 종료될 때까지 살아 있으며 함수가 종료된 `foo()` 다음 코드 부터는 함수 내부에서 선언된 변수는 사라진다. 그래서 함수 외부의 `` console.log(`outer a = ${a}`) ``와 `` console.log(`outer b = ${b}`) `` 코드를 실행할 때는 `VM45:10 Uncaught ReferenceError: a is not defined`라는 에러메시지가 나타난다.

```js
function foo() {
  a = 1;
  var b = 2;
}

foo();

console.log(`outer a = ${a}`);
console.log(`outer b = ${b}`);
```

- 위와 같이 함수 내의 변수에 함수를 선언할 때 사용하는 `var`, `let`, `const` 등의 키워드를 사용하지 않는 경우에는 조금 특이할 수 있는데, 자바스크립트는 아무런 선언이 되어 있지 않은 변수에 대입이 일어나면 이미 존재하는 변수로 판단한다. 함수 내부의 선언 키워드 없이 할당되는 `a = 1` 코드는 이미 `a`라는 변수가 존재하기 때문에 할당 가능한 것이라 판단하고 전역 변수의 `a`에 1을 할당한 것으로 처리한다.
- 따라서 위의 코드를 실행하면 함수가 실행되고 전역변수의 영역에 생성된 `a = 1`의 변수와 함수 내에서 선언된 `var b = 2`의 변수 중에서 `b`는 함수가 종료되면서 사라지고 전역 변수인 a만 남게 된다. 따라서 `` console.log(`outer a = ${a}`) `` 코드는 변수가 살아 있으므로 실행이 되고 `` console.log(`outer b = ${b}`) ``는 변수가 사라졌기 때문에 실행되지 않는다.

```js
var a;
function foo() {
  a = 1;
  var b = 2;
}
```

- 일반적으로 코드를 짤 때는 전역 스코프에 변수의 선언을 해 주어 선언된 부분을 명확하게 만들어 주는 코드를 짜도록 하고 암묵적으로 변수가 만들어지지 않도록 하는 것이 좋다.

```rb
def foo
  $a = 1
  b = 2
  puts "inner a = #{$a}" # inner a = 1
  puts "inner b = #{b}" # inner b = 2
end

foo

puts "outer a = #{$a}" # outer a = 1
puts "outer b = #{b}" # undefined local variable or method `b'
```

- 루비에서는 전역 변수를 `$a`으로 만든다. 이것은 스코프에 관계 없이 전역변수로 만들기 때문에 함수나 블록 스코프 내에 있어도 전역 변수가 된다.
- 위의 코드를 실행하면 함수 내부에서 `$a = 1`으로 선언된 변수는 전역 변수로 선언되었기 때문에 스코프에 관계 없이 전역변수로 사용되고, `b = 2`으로 선언된 변수는 지역변수로 선언되었기 때문에 스코프 범위에서만 변수가 존재할 수 있다.
- 따라서 함수가 종료된 이후의 코드인 `puts "outer a = #{$a}"`와 `puts "outer b = #{b}"`에서는 전역 변수인 `a`의 경우 변수가 존재하므로 1의 값이 표시되지만, 지역변수인 `b`의 경우 함수의 종료와 함께 사라지므로 `undefined local variable or method `b'`라는 에러가 발생한다.

### 지역 변수 내의 지역 변수

JS

```js
function fn() {
  var a = 1;
  function nestedFn() {
    console.log(a);
  }
  nestedFn();
};

fn();
```

- 위 코드에서 변수 `a`는 `fn` 함수 내에서 선언되었는데 `nestedFn` 함수 내에서 `a` 상위 스코프에서 선언된 변수에 접근을 할 수 있다.
- 자바스크립트에서는 현재 스코프에서 변수를 찾을 수 없다면 상위 스코프에서 변수를 찾는데 `console.log(a)`의 `a`의 값을 찾기 위해서 `nestedFn` 스코프를 살핀다. 하지만 `nestedFn` 스코프에는 값이 없기 때문에 다음 상위 스코프인 fn 함수 스코프에서 변수 a의 값을 찾는다. fn 스코프에서 선언된 변수의 값을 찾을 수 있기 때문에 `nestedFn` 함수 내부에서 접근하는 `a`의 값은 1이 된다.
- 현재 스코프에서 선언된 값이 없으면 그 상위 스코프에서 찾고 그 상위 스코프에서 없으면 그 상위 스코프에서 찾는 방식을 사용하지만, 간단히는 자바스크립트에서 지역 변수는 지역 변수가 속한 스코프에 내포된 `function` 함수 또는 블록(`{}`)에 전달된다고 간단히 이해하면 된다.

Ruby

```rb
def fn
  a = 1
  def nestedFn
    puts a
  end
  nestedFn
end

fn
```

- 하지만 루비의 경우 현재 스코프에서 변수가 선언되어 있지 않다면 상위 스코프에서 변수를 찾지 않는다. 또는 상위 스코프의 변수가 하위 스코프로 전달되지 않는다. 따라서 `nestedFn` 함수 내에 `a`값이 선언되어 있지 않다면 접근 할 수 없어서 위의 코드는 `undefined local variable or method `a'`라는 에러를 발생시킨다.

```rb
def fn
  a = 1
  def nestedFn(parameter)
    puts parameter
  end
  nestedFn(a)
end

fn
```

- `def 함수명 (파라메터)` 방식으로 함수를 써 주면 `함수명`으로 함수를 사용할 수 없고, `함수명(전달할_값)`의 방식으로 함수를 사용해 주어야 한다.
- 상위 스코프 안에 있는 함수를 사용할 때 상위 스코프의 함수를 함수의 파라메터를 통해서 내부로 전달하는 방식으로 상위 스코프의 변수를 하위 스코프의 함수로 전달할 수 있다.
- 하지만 자바스크립트 처럼, 파라메터로 전달하지 않더라도 상위 스코프의 값을 접근할 수 있도록 하고 싶을 때가 있다. 하지만 def 함수는 파라메터를 사용하여 전달 받지 않는 한 외부 스코프의 변수를 받아 올 수 없기 때문에 `def`가 아닌 다른 방식의 내포된 함수를 만드는 방식으로 해결할 수 있다.

#### Proc 객체를 통해서 함수 만들기

```rb
def fn
  a = 1
  nestedFn = Proc.new do
    puts a
  end
  nestedFn.call
end

fn
```

- `Proc` 객체를 사용하여 블록 스코프에 실행할 코드를 적는 방법이다. 블록 스코프인 `do` ... `end` 안에 실행할 코드를 적는다. 객체를 가리키는 변수에 블록으로 정의한 `Proc` 객체를 넣고 이 변수를 `.call`으로 호출하면 블록 스코프 내부의 코드가 실행이 된다.
- 블록 스코프는 외부의 변수를 전달 받을 수 있기 때문에 `fn` 스코프에서 정의된 지역변수를 `Proc` 객체의 블록 스코프에서 사용할 수 있다.

#### lambda 블록 사용하기

```rb
def fn
  a = 1
  nestedFn = lambda do
    puts a
  end
  nestedFn.call
end

fn
```

- `lambda` 객체에도 블록을 담을 수 있다. 실행할 코드를 람다 블록 안에 정의하고, 람다 객체를 담은 변수에 `.call`으로 람다 블록 스코프 안에 정의한 코드를 실행한다.
- 블록 스코프 안에 있으므로 블록 스코프 외부에서 선언한 변수를 사용할 수 있다.

#### 축약형 람다 블록 사용하기

Ruby

```rb
def fn
  a = 1
  nestedFn = -> {
    puts a
  }
  nestedFn.call
end

fn
```

- `lambda do` ... `end`를 대신해서 `-> {` ... `}`를 사용할 수 있다. 대체 구문이므로 마찬가지로 블록 스코프에 해당하기 때문에 외부에서 선언한 변수를 사용할 수 있다.

### 지역 변수나 인스턴스 변수를 사용에 주의하자

```rb
def fn
  @a = 1
  def nestedFn
    puts @a
  end
  nestedFn
end

fn
```

- 위와 같이 지역변수에 `@변수명`을 사용하여 변수를 선언하면 하위 스코프에서 상위 스코프의 변수에 접근할 수 있다. 하지만 자바스크립트와 같이 하위 스코프에서 상위 스코프로 접근하는 것이 아니라 객체 전체에서 사용할 수 있는 공유 변수로 이해하여야 한다.
- `@변수명`으로 변수를 선언하는 방식을 인스턴스 변수라고 한다.

#### 인스턴스 변수

```rb
def fn
  def nestedFn1
    @a = 1
  end
  nestedFn1
  def nestedFn2
    puts @a
  end
  nestedFn2
end

fn
```

- 우선은 인스턴스라는 개념을 알아야 하는데 클래스를 객체로 만드는 것을 보통 인스턴스라고 부른다. 인스턴스 변수는 클래스에 정의 되어야 한다. 하지만 위의 코드에서는 클래스가 없다. 코드의 클래스가 없으면 보이지 않는 인스턴스인 Object의 인스턴스가 되어 있다는 의미이다. Object 인스턴스는 루비 프로그램의 실행과 생성되는 인스턴스이다. 모든 코드는 Object 인스턴스 내부에 있으며 위의 코드에서 인스턴스 변수는 Object 인스턴스 내에 존재한다.
- 위의 코드에서 `fn` 함수의 스코프에서는 변수가 선언되지 않았지만, 스코프 내부의 함수에서 인스턴스 변수가 선언되었다. `nestedFn1` 함수를 사용하면 인스턴스 변수 `@a`이 선언되고 인스턴스 변수이기 때문에 객체 전체에 공유가 된다. 그런데 위의 코드에는 클래스가 없다. 클래스가 없기 때문에 인스턴스 변수의 공유 범위는 Object 인스턴스이다. Object 인스턴스의 범위는 위의 코드가 정의되는 영역이 된다.
- `nestedFn2`에서는 `@a`가 선언되지 않았지만, Object 인스턴스에서 전체 코드에서 공유되는 인스턴스 변수이므로 `nestedFn1`가 실행되면서 생긴 `@a`의 변수에 접근을 할 수 있게 된다.

```rb
def fn
  def nestedFn
    @a = 1
  end
  nestedFn
end

fn

puts @a
```

- 위의 코드를 보면 `fn` 함수 밖에서도 `@a`의 값이 1이 되었다. 인스턴스 변수가 `fn` 함수가 종료되었는데도 남아 있는 것인데, 이는 `@a`의 인스턴스가 Object 인스턴스이기 때문이다. Object 인스턴스는 루비 코드를 실행하는 오브젝트이므로 `fn` 함수가 한 번 실행되고 나서 내부의 인스턴스 변수가 선언이 되었다면 해당 인스턴스 변수는 직접 값을 제거하지 않는 한 루비 프로그램이 끝날 때 까지 존재한다.
