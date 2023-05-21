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