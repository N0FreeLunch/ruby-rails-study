## 루비에서의 함수는 3가지 방법이 있다.
1. def를 사용하여 함수 정의
2. proc를 사용하여 함수 정의
3. lambda를 사용하여 함수 정의
- 이번에 다를 내용은 def를 사용하여 함수를 정의하는 방법이다.

## def를 사용하여 함수 정의하기
```rb
def 함수명(파라메터1, 파라메터2 ...)
end
```
- 루비에서 def를 사용한 함수는 위와 같은 방법으로 사용할 수 있다.
```rb
def 함수명(파라메터1, 파라메터2 ...)
    return 반환값
end
```
- 또한 위와 같이 함수의 반환 값을 반환할 수 있다.
```rb
함수명(인자1, 인자2, ...)
```
- 함수를 사용할 때도 다른 언어에서 함수를 사용하는 것과 동일하게 사용한다.

### 자바스크립트와의 비교
```js
function 함수명(파라메터1, 파라메터2, ...) {
  return 반환값;
}
```
- `function`이 `def`로 바뀐 것과 `{}` 블록이 `def 함수명(파라메터1, 파라메터2 ...)`와 `end` 사이로 변한 것 이외에는 차이가 없다.

### def 함수는 불가능한 것
- 자바스크립트의 함수와 루비의 `def` 함수의 대표적인 차이점은 외부 변수를 내부로 가져올 수 없다는 것이다.

#### 루비
```rb
outerVariable = '변수'
def func()
    puts outerVariable
end
func()
```
- 루비에서는 위의 코드를 사용할 경우 블록 외부에서 선언한 변수를 블록 내부로 가져올 수 없기 때문에 함수 내부에서 변수를 선언하지 않으면 함수 내에서 변수를 사용할 수 없다.
- 함수 밖에서 선언된 `outerVariable` 변수는 함수 내부로 가져올 수 없기 때문에 `puts outerVariable` 코드에서 `outerVariable`를 사용하려고 하면 존재하지 않는 변수를 사용했다면서 에러가 발생한다.
- 에러 내용 : `func': undefined local variable or method `outerVariable' for main:Object (NameError)`

#### 자바스크립트
```js
var outerVariable = '변수'
function func() {
  console.log(outerVariable)
}
func()
```
- 자바스크립트 코드는 블록(`{}`) 외부의 변수를 블록 내에서 사용하더라도 외부의 변수를 가져와서 사용할 수 있다.
- 따라서 함수 내부에서 선언되지 않는 변수인 `outerVariable`를 `console.log(outerVariable)`로 사용하더라도 함수 내부에 변수가 없으면 함수 밖의 변수를 찾아서 사용하기 때문에 루비와 같이 변수가 없다는 에러가 발생하지 않는다.

### 익명함수
- 익명 함수란 함수에 이름을 지어주지 않은 함수를 의미한다.
- 루비의 def 함수는 익명함수로 사용할 수 없다.

#### 자바스크립트의 익명 함수
```js
function 함수_이름() {
  console.log('함수가 실행되었습니다.');
}

함수_이름();
```
- 일반적으로 함수를 사용하려면 함수에 붙여준 이름으로 실행(`함수_이름()`)을 해 줘야 한다.
```js
(function () {
  console.log('함수가 실행되었습니다.');
})();
```
- 익명함수란 위와 같이 함수의 이름을 설정하지 않더라도 함수로서 사용할 수 있는 함수를 의미한다.
- 위와 같이 생성과 동시에 `()`으로 사용되는 함수를 '즉시 실행 함수'라고 부른다.
```js
[1, 2, 3, 4, 5].map(function (e) {
    return e+1;
});
```
- 브라우저의 콘솔 창에 위의 코드를 입력하면 배열의 `[1, 2, 3, 4, 5]`의 각 원소(1, 2, 3, 4, 5)에 1을 더한 결과 값을 얻는다.
- 위에서 `function (e) { return e+1; }` 부분은 함수의 이름이 정해지지 않은 익명함수이다. `배열.map()`의 map 메소드는 함수를 받는데, 함수를 생성하고 생성한 함수 코드 덩어리를 메소드의 인자로 넣어주었다.
- 위 코드는 다음과 같이 함수에 이름을 붙여서 함수 이름을 전달해서 사용할 수도 있다.
```js
function addOne(e) {
    return e+1;
}
[1, 2, 3, 4, 5].map(addOne);
```
- 위의 코드는 함수 이름을 `addOne`으로 지어주었다.
```js
const addOne = function (e) {
    return e+1;
}
[1, 2, 3, 4, 5].map(addOne);
```
- 위와 같이 익명함수를 변수에 넣어주면 `addOne` 변수는 함수를 가지고 있으므로 `함수()` 꼴로 실행가능하다.
- `addOne`이란 변수에 `function (e) { return e+1; }`이란 익명함수를 넣어 준 형태이다.
- 함수의 이름을 지어주는 방법으로는 함수를 만들 때 함수의 이름을 지어주는 방법도 있지만, 익명 함수를 만들고 익명함수를 변수에 할당하면 변수명으로 함수의 이름을 붙여줄 수 있다.

#### 루비에서의 익명 함수
- `def`를 사용한 함수는 반드시 이름을 붙여 주어야 한다. 자바스크립트의 함수와 같이 이름 없는 함수로 사용할 수 없다.
```rb
[1, 2, 3, 4, 5].map { |e| e + 1 }
```
- 위의 코드는 루비에서 `lambda` 함수 표기법이다. `lambda` 함수 표기법으로는 위의 자바스크립트와 유사하게 사용할 수 있다.
- 하지만 `def` 함수를 사용한다면 이름을 붙여서 사용 가능하다.
```rb
def addOne(e)
        e + 1
end
[1, 2, 3, 4, 5].map { |e| addOne(e) }
```
- 하지만 `addOne` 함수 이름이 들어갈 자리에 `def`로 정의되는 함수를 그대로 사용할 수는 없다. 
```rb
[1, 2, 3, 4, 5].map { |e| 
    (def (e)
        e + 1
    end)(e)
}
```
- 위의 코드는 루비에서 사용할 수 없는 코드이다.
- `def` 함수는 익명함수로 사용될 수 없기 때문에 위와 같은 '즉시 실행 함수'로 사용될 수 없다.
- 루비의 함수에서 자바스크립트와 유사한 방식으로 함수를 익명함수로 만들고 또는 즉시 실행 함수로 만들어 사용하기 위해서는 `def` 함수가 아닌 proc 또는 lambda 함수를 사용해야 한다. (proc와 lambda 함수에 관해서는 따로 다루기로 하자.)
