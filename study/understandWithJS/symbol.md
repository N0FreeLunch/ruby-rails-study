## 루비의 심볼
- 심볼은 값의 타입이다. 심볼의 표현은 `:심볼_이름`과 같은 방식으로 사용된다.
- 동일한 이름의 심볼은 코드의 어디서 사용이 되더라도 메모리상에서 똑같은 대상을 가리킨다. 일반적인 값의 경우에는 서로 다른 곳에서 사용된 코드로 생성된 값은 똑같은 코드라도 메모리상에서 서로 다른 대상을 가리키지만, 심볼은 같은 대상을 가리킨다. (물론 이는 동일한 루비 프로세스 안에서 동일 대상이다.)
- 심볼은 변경할 수 없는 불변값이며, 소프트웨어에서 전체 프로그램에서 고유한 값을 나타내는데 사용된다.

### 어떤 경우 심볼을 사용할까?
- 어떤 대상을 나타내기 위해 사람들은 다양한 표현을 사용할 것이다. 예를 들어 '거래 자료 저장소'라는 개념을 영어로 나타낼 때는 다음과 같은 다양한 표기로 나타낼 수 있다.
  - Transaction Data Repository
  - Transaction Documentation Storage
  - Deal Information Archive
  - Trade Data Vault
  - Transaction Records Warehouse
  - Transaction Files Depot
  - Deal Documents Depot
  - Trade Information Repository
  - Transaction Records Hub
  - Deal Documentation Archive
- 프로그래밍을 사용하는 사람들은 이런 용어에 대해 통일된 용어로 사용하면 코드마다 서로 다른 이름을 피할 수 있다. 심볼은 비슷한 표현의 용어를 중복되게 사용하지 않고 어떤 하나의 표현으로 정해서 사용하고자 할 때 주로 사용한다.

---

## 자바스크립트의 심볼
- 자바스크립트의 심볼에 대한 설명은 이해하기 어려울 수 있다. 이 부분은 루비의 심볼과 자바스크립트의 심볼을 비교하여 심볼에 대한 이해를 늘리기 위한 부분이다.
- 또한 자바스크립트의 심볼은 자주 사용하지 않는 표현이고 고급 사용자를 위한 문법이기 때문에 이해가 어려울 수 있다. 이 부분이 이해가 되지 않는다면 건너 뛰어도 무방하다.

### 루비의 심볼과 자바스크립트의 심볼은 다르다.
- 루비의 심볼은 모든 동일한 이름의 심볼이 메모리상의 동일한 대상을 가리키고 있다. 하지만 루비의 심볼과는 달리 자바스크립트의 심볼은 동일한 이름의 심볼이라도 서로 다른 대상을 가리키고 있다.

### 자바스크립트 심볼의 특징
```js
console.log(1 === 1); // true
console.log('문자열' === '문자열'); // true
console.log({} === {}); // false
console.log(Symbol('symbol_name') === Symbol('symbol_name')); // false
```
- 자바스크립트의 심볼은 동일한 심볼이라도 서로 다른 심볼로 취급된다.

### 자바스크립트 심볼의 예제
```js
const symbolKeyObj = {
  [Symbol('key1')]: 'value1',
  key2: 'value2',
};

console.log('symbol key: ', symbolKeyObj[Symbol('key1')]);
console.log('string key: ', symbolKeyObj['key2']);
```
- 기본적으로 자바스크립트의 오브젝트의 키는 문자열이 오는 것을 가정한다. 오브젝트의 키에 문자를 쓸 때는 문자열 표기 `'` 또는 `"` 또는 ``` ` ```  기호로 감싸서 표기를 해도 되지만 이들 기호를 생략을 해도 문자열로 자동으로 변환이 된다.
- 자바스크립트에서 심볼 타입을 사용할 때는 `Symbol('심볼_이름')` 방식으로 사용한다. 그런데 `Symbol`이라는 글자를 오브젝트의 키로 입력을 했을 때 오브젝트는 이 키워드를 문자열로 인식을 하려고 한다. 문자열로 인식을 하려고 하는데, 심볼이란 자바스크립트 타입이 와서 에러를 발생 시킨다. 이런 문제를 방지하기 위해서 오브젝트의 키로 심볼을 사용할 때는 대괄호 표기 `[]`를 사용해 주어야 한다.
- 위 코드를 실행해 보면 `symbolKeyObj` 오브젝트 안의 키로 선언된 `Symbol('key1')`와 오브젝트 안의 키에 해당하는 값을 얻기 위해 접근을 하는 `symbolKeyObj[Symbol('key1')]`의 `Symbol('key1')`은 같은 이름의 심볼을 사용하였지만 두 심볼이 이름이 같더라도 서로 다른 심볼이기 때문에 `오브젝트[찾을_값]`의 방식으로 찾을 값에 매칭되는 키 값을 찾아서 그 키의 벨류를 얻는 방식으로 사용되는 문법에 `찾을_값`으로 동일한 값에 해당하는 대상을 찾는 심볼로는 키 이름을 선택할 수 없다.
- 따라서 `symbolKeyObj[Symbol('key1')]`의 값은 동일한 심볼을 찾을 수 없기 때문에 `undefined`이며 `symbolKeyObj['key2']`의 값은 동일한 문자열 값에 해당하는 키를 찾을 수 있기 때문에 `'key2'`키의 `'value2'` 벨류를 얻을 수 있다.
- 심볼은 동일한 이름의 심볼이라도 서로 다른 곳에서 선언된 심볼은 서로 다른 심볼이므로 객체 내에 매칭되는 키의 값을 얻기 위해 동일한 이름의 심볼을 사용하여도 심볼은 값이 매칭이 되지 않으므로 매칭되는 키를 찾을 수 없어서 심볼 이름에 해당하는 키를 얻을 수 없다.

### 자바스크립트에서 동일 심볼 이용하기
- 따라서 자바스크립트에서의 심볼이 서로 같은 값이 되려면 심볼을 변수에 저장하여 이름만 같은 심볼이 아니라 완전히 동일한 심볼을 사용해야 한다.
```js
const key1Symbol = Symbol('key1');
const symbolKeyObj = {
  [key1Symbol]: 'value1',
  key2: 'value2',
};

console.log('symbol key: ', symbolKeyObj[key1Symbol]);
console.log('string key: ', symbolKeyObj['key2']);
```
- 위의 예제는 동일한 이름의 심볼이 아니라 동일한 값의 심볼을 사용하기 위해 한 번 선언된 심볼을 변수에 할당을 하였다. 이 변수 `key1Symbol`는 동일한 심볼인 `const key1Symbol = Symbol('key1')`의 `Symbol('key1')`을 가리킨다.
- 따라서 오브젝트 내의 키로 사용된 심볼 `[key1Symbol]:`의 `key1Symbol` 심볼과 오브젝트에서 찾을 키 값을 지정해서 매칭되는 키의 값을 얻는 `symbolKeyObj[key1Symbol]`의 `key1Symbol` 심볼은 동일한 심볼을 가리키기 때문에 매칭이 된다.
- 따라서 `symbolKeyObj[key1Symbol]`는 `key1Symbol` 심볼과 동일한 심볼 값의 키가 매칭이 되어 `'value1'` 값을 얻을 수 있다.
- 하지만 위의 문법은 변수에 심볼을 저장해서 동일한 심볼을 사용하는 것이기 때문에, 이름이 동일한 심볼은 전역적으로 동일한 값을 사용하는 루비의 심볼과는 다른 방식이다.

### 자바스크립트에서 전역 심볼 이용하기
- 자바스크립트에서도 루비와 비슷한 방식의 심볼 사용방식을 지원하는데 `Symbol.for('심볼_이름')` 문법을 사용하는 것이다.
- `Symbol.for('심볼_이름')`을 사용하면 코드의 한 부분에서 선언된 심볼 이름이 다른 부분에서 선언된 심볼과 동일한 대상을 가리키게 된다. 곧, 모든 동일한 심볼 이름은 동일한 대상을 공유한다.
- 곧 동일한 이름의 심볼 이름이 동일한 값의 심볼을 가리키므로 루비의 심볼과 매우 유사한 기능을 한다.
```js
const symbolKeyObj = {
  [Symbol.for('key1')]: 'value1',
  key2: 'value2',
};

console.log('symbol key: ', symbolKeyObj[Symbol.for('key1')]);
console.log('string key: ', symbolKeyObj['key2']);
```
- 따라서 `symbolKeyObj[Symbol.for('key1')]`의 `Symbol.for('key1')` 심볼 값과 오브젝트의 키를 정의할 때 사용한 `[Symbol.for('key1')]:`의 `Symbol.for('key1')`의 심볼 값이 동일한 대상을 가리키므로 `오브젝트[찾는_키]`의 구분에서 찾는 키에 해당하는 값을 매칭할 수 있어서 `symbolKeyObj[Symbol.for('key1')]`으로 `'value1'` 값을 얻을 수 있다.

---

## Reference
- https://docs.ruby-lang.org/en/2.3.0/Symbol.html