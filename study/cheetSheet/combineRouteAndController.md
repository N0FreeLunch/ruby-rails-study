## 컨트롤러 만들기
```sh
rails g controller PageController
```

### rails 명령어를 아직 사용할 수 없는 경우
- rails 명령어를 터미널에서 사용하면 다음과 같은 에러가 발생한다.
```
Rails is not currently installed on this system. To get the latest version, simply type:

    $ sudo gem install rails

You can then rerun your "rails" command.
```
- 위의 메시지가 나온다면 레일즈 버전이 우선 레일즈를 설치할 때의 버전과 일치하는지 `ruby --version`명령어로 확인한다. 만약 일치하지 않는다면 `rvm use ruby-3.0.0` 명령을 통해서 3 버전의 루비 언어를 사용하도록 하자.
- 여전히 문제가 해결되지 않는다면 `sudo gem install rails` 명령을 실행한다.
- 이 때 맥북의 비밀번호를 입력해야 한다.

```
ERROR:  Error installing rails:
        There are no versions of activesupport (= 7.0.4.3) compatible with your Ruby & RubyGems. Maybe try installing an older version of the gem you're looking for?
        activesupport requires Ruby version >= 2.7.0. The current ruby version is 2.6.8.205.
```
- 만약 위와 같은 에러가 발생했다면
```sh
gem install activesupport -v 6.1.7.3
```
- 위 명령어를 실행한다.
```sh
sudo gem install rails
```
- 다시 레일즈 명령어를 실행할 수 있는 기능을 설치하자.


### 컨트롤러 생성
```sh
rails g controller PageController
```
- 위 명령이 성공적으로 실행 되었다면 다음과 같은 메시지가 나온다.
```
      create  app/controllers/page_controller.rb
      invoke  erb
      create    app/views/page
      invoke  test_unit
      create    test/controllers/page_controller_test.rb
      invoke  helper
      create    app/helpers/page_helper.rb
      invoke    test_unit
```
- `app/controllers/page_controller.rb` 부분의 소스 코드로 가 보자.

### 컨트롤러 메소드 정의하기
app/controllers/page_controller.rb
```rb
class PageController < ApplicationController
end
```
- 위 문법은 루비에서 클래스 문법에 해당한다.
- 클래스 내에 함수를 정의할 수 있고 클래스 내의 함수는 메소드라고 부른다.

```rb
class PageController < ApplicationController
    def home
        # 'Hello, world!'
        render plain: 'Hello, world!'
    end
end
```
- `home`이라는 명칭의 메소드를 만들고 화면에 `'Hello, world!'`를 출력 해 보자.
- 화면에 텍스트를 띄우기 위해서는 `render`라는 메소드를 사용해야 한다.
- 만약에 단순 텍스트가 아니라 HTML로 출력하고 싶다면 `plain:` 부분을 `html:`으로 사용할 수 있다.

## 라우트 정의하기
- 라우트는 웹 페이지의 URL의 경로를 설정한다.
- 하지만 라우트에 화면에 출력될 메시지를 적는 것은 일반적으로 태스트로 라우트의 동작을 확인할 때 사용하며, 라우트는 접속 경로를 정의하는 부분으로 접속 했을 때 연결할 컨트롤러를 지정하는 방식으로 사용된다.
- 곧, 라우트에서 화면에 출력할 메시지를 정하는 것은 컨트롤러의 세부 구현에 맡기는 방식으로 만들도록 한다.
```rb
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'test' => proc { |env| [200, {}, ['Hello, world!']] }
  get 'welcome' => 'pages#home'
end
```
- 기존 라우트 코드에 `get 'welcome' => 'pages#home'`를 입력 해 보자.
- 지금 컨트롤러 파일의 이름은 `page_controller`이다. 라우터에 이 컨트롤러 파일의 이름을 적을 때에는 위의 `_controller` 부분을 빼고 적어주며, 컨트롤러의 이름이 단수이어도 단수로도 복수로도 연결할 컨트롤러를 지정할 수 있다. `'pages#home'`도 가능하며 `'page#home'`도 가능하다.
- 이 때 # 뒷 부분의 라우트의 컨트롤러 클래스가 갖고 있는 메소드를 지정한다.
- `get 'welcome' => 'pages#home'`의 뜻은 유저가 브라우저를 통해 `'welcome'`이라는 경로로 접근을 하면 page 컨트롤러의 home 메소드(= 클래스 내부의 함수)를 실행한 반환 결과를 보여주겠다는 의미이다.

---
---

## 깃허브에 올리기
### 파일을 나눠서 커밋하기
```sh
git status
```
- 위의 명령어를 입력하면 이전 커밋 기록에서 부터 변경된 파일들의 리스트를 볼 수 있다.
```
커밋하도록 정하지 않은 변경 사항:
  (무엇을 커밋할지 바꾸려면 "git add <파일>..."을 사용하십시오)
  (use "git restore <file>..." to discard changes in working directory)
        수정함:        config/routes.rb

추적하지 않는 파일:
  (커밋할 사항에 포함하려면 "git add <파일>..."을 사용하십시오)
        app/controllers/page_controller.rb
        app/helpers/page_helper.rb
        test/controllers/page_controller_test.rb
```
- `app/helpers/page_helper.rb`와 `test/controllers/page_controller_test.rb`는 컨트롤러를 생성할 때 함께 만들어진 파일이다. 따로 커스터마이징 하지 않았으므로 `app/controllers/page_controller.rb`와 `config/routes.rb`과 분리해서 커밋을 해 보자.
```sh
git add app/helpers/page_helper.rb
```
```sh
git add test/controllers/page_controller_test.rb
```
```sh
git status
```
- 빨간 색 파일 경로가 초록색 파일 경로로 변한 것을 확인
```sh
git commit -m "page 컨트롤러 파일 생성시 함께 생성된 파일 커밋"
```
```sh
git status
```
- 초록색으로 변했던 파일 경로들이 사라진 것을 확인.
- git은 커밋을 하면 커밋을 한 시점에서 변경사항을 파악하기 때문에 커밋을 한 후에는 `git status`로 나타나던 변경된 파일들이 더 이상 나타나지 않는다.

### 변경된 코드 커밋하기
```sh
git status
```
- 위의 코드를 실행하면
```
config/routes.rb
app/controllers/page_controller.rb
```
- 위의 두 파일은 커밋되지 않았기 때문에 커밋 시점에서 변경사항이 있는 대상이라 여전히 `git status` 명령어를 사용했을 때 존재한다.
```sh
git add config/routes.rb
```
```sh
git add app/controllers/page_controller.rb
```
```sh
git commit -m "라우트와 컨트롤러를 연결하여 페이지에 출력하기"
```

### 커밋된 2개의 작업을 동시에 깃허브에 올리기
```sh
git push origin main
```
- 앞서 커밋을 하고 깃허브에 파일을 올리지 않은 상태에서 커밋이 한 번 더 이뤄졌기 때문에 총 push 명령어를 통해 깃허브에 파일을 업로드 하게 되면 2개의 커밋에 대한 파일 기록이 깃허브에 올라가게 된다.