## 라우트
- `https://github.com/자신의_깃허브_아이디/리포지토리명`이란 URL에서 라우트는 도메인 부분인 `github.com` 다음 부분을 정의하는 역할을 한다. `자신의_깃허브_아이디/리포지토리명` 부분을 'PATH', '경로'라고 부르는데 이 경로를 설정할 수 있는 역할을 하는 부분이다.

## 라우트 만들어 보기
- 프로젝트 루트에서 `config/routes.rb` 파일로 이동한다.
```rb
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
```
- 위의 코드에 라우터와 라우터로 접속했을 때 간단한 메시지를 출력하는 코드를 만들어 보자.
```rb
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'test' => proc { |env| [200, {}, ['Hello, world!']] }
end
```

## 브라우저에서 동작 확인하기
- `http://127.0.0.1:3000/welcome` 경로로 들어가 보자.
- 그럼 웹 화면에 `Hello, world!`라는 글자가 표시된다.

## 코드 이해하기
### 루비에서의 블록
```rb
Rails.application.routes.draw do
end
```
- 위 구문은 `객체 do ... end` 구문이라고 불린다. 일반적으로 `객체.메소드 do ... end` 형태로 사용된다.
- 메소드는 객체가 가지고 있는 함수를 의미한다.
- `...`은 코드가 위치하며 `do`와 `end` 사이의 코드를 블록이라고 부른다.
- 이 블록에는 메소드가 인자로 받을 수 있는 값이 정의된다.

### 코드 이해하기
- `Rails.application.routes` 객체에서 `draw` 메소드를 실행하기 위해서 `do ... end` 블록 안에 키-벨류 쌍의 값을 정의한다.
```rb
Rails.application.routes.draw do
  get 'test' => proc { |env| [200, {}, ['Hello, world!']] }
end
```
- 키에 해당하는 값은 `get 키_이름`으로 벨류에 해당하는 값은 `=> 벨류` 또는 `, 벨류` 방식으로 사용된다.

#### proc 함수 이해하기
```rb
get 'test' => proc { |env| [200, {}, ['Hello, world!']] }
```
- "`get 'test'`은 'test'이라는 경로의 페이지로 접속을 하면" 이라는 의미를 가지고 있다.
- `=> proc { |env| [200, {}, ['Hello, world!']] }` 부분의 코드는 그대로 사용하되, `'Hello, world!'`에 해당하는 문자열만 바꾸어 주는 방식으로 사용하면 된다. (현 단계에서 위의 코드의 원리를 자세하게 이해할 필요는 없다.)
```rb
get '경로' => proc { |env| [200, {}, ['페이지에 띄울 메시지']] }
```
- '경로' 부분과 '페이지에 띄울 메시지' 부분만 바꿔가면서 사용하면 된다는 것 정도로만 알아 두도록 하자.

#### 루비에서의 함수
- 루비에서 함수를 만드는 방법 중 하나는 proc 문법을 사용하는 것이다.
```rb
my_proc = proc { |param1, param2| puts "Hello, #{param1} and #{param2}!" }
```
- 위의 문법을 보면 `env`는 함수의 파라메터이고, 함수의 반환 값은 `[200, {}, ['페이지에 띄울 메시지']]`라는 배열이라는 것을 알 수 있다.
- 그리고 위 함수를 `my_proc`라는 변수에 넣었다는 것을 알 수 있다.
- 함수가 담긴 변수를 실행하기 위해서는 `.call` 메소드를 사용한다.
```rb
my_proc.call('Alice', 'Bob')
```
- 함수의 param1 매개 변수에 `'Alice'`란 값을 전달하고 param2 매개 변수에 `'Bob'`을 전달해서 함수를 실행한다는 의미이다.

### 자바스크립트 문법으로 이해하기
#### proc 문법 변환하기
```js
let my_proc = function (param1, param2) { console.log(`Hello, ${param1} and ${param2}!`) }
my_proc('Alice', 'Bob')
```
#### 라우터의 proc 함수 변환하기
```js
function (env) { return [200, {}, ['Hello, world!']]; }
```
또는
```js
(env) => [200, {}, ['Hello, world!']];
```

#### 라우터 전체를 변환해 보기
```js
Rails.application.routes.draw({
  test: function (env) { return [200, {}, ['Hello, world!']]; } 
}) 
```
또는
```js
Rails.application.routes.draw({
  test: (env) => [200, {}, ['Hello, world!']]
}) 
```
- draw 객체는 키-벨류 형식의 값을 인자로 받기 때문에 자바스크립트에서 키-벨류 형식의 데이터인 리터럴 오브젝트를 사용하였다.

---
---
## 깃에 추가하기
```sh
git status
```
- 위의 명령을 사용하면 코드의 변경 사항을 확인할 수 있다.
```
modified:   config/routes.rb
```
- `config/routes.rb` 라는 파일의 코드가 바뀌었다는 것을 의미한다.
- 빨간색으로 표기가 된 것은 깃허브에 올릴 대상으로 선정하지 않았다는 것을 의미한다.

```sh
git add config/routes.rb
```
- 깃허브에 올릴 대상으로 선정하겠다는 의미를 가지고 있다.

```sh
git status
```
- 다시 위 명령을 입력해서 확인하면
```
modified:   config/routes.rb
```
- 초록색으로 변한 것을 알 수 있다.
- 깃허브에 올릴 대상으로 선정하겠다는 의미이다.
```sh
git commit -m "간단한 라우터 만들어 보기"
```
- 깃허브에 파일을 올리기 위해서는 대상 파일들을 어떤 목적으로 추가했는지 메시지를 적어 주어야 한다.
```sh
git status
```
- 위 명령을 다시 입력하면 
```
modified:   config/routes.rb
```
- 위 메시지가 더 이상 나오지 않는다.
- 변경사항을 커밋 명령어로 기록을 남겨 두었기 때문에 기록을 남긴 부분 부터는 파일 및 폴더의 변경 사항이 없기 때문이다.
```sh
git push origin main
```
- 위 명령을 통해 남긴 기록을 깃허브에 업로드 할 수 있다.