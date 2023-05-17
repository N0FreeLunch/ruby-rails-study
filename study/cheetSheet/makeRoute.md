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
```rb
get 'test' => proc { |env| [200, {}, ['Hello, world!']] }
```
- "`get 'test'`은 'test'이라는 경로의 페이지로 접속을 하면" 이라는 의미를 가지고 있다.
- `=> proc { |env| [200, {}, ['Hello, world!']] }` 부분의 코드는 그대로 사용하되, `'Hello, world!'`에 해당하는 문자열만 바꾸어 주는 방식으로 사용하면 된다. (현 단계에서 위의 코드의 원리를 자세하게 이해할 필요는 없다.)
```rb
get '경로' => proc { |env| [200, {}, ['페이지에 띄울 메시지']] }
```
- '경로' 부분과 '페이지에 띄울 메시지' 부분만 바꿔가면서 사용하면 된다는 것 정도로만 알아 두도록 하자.

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