## 뷰 만들어 보기
- 레일즈에서 뷰를 만드는 명령어는 뷰 단독으로 만들어지는 것이 아닌 뷰 컨트롤러를 생성할 때 함께 만드는 방식으로 만든다.
- 만약 컨트롤러는 기존의 컨트롤러를 사용하고 컨트롤러에 뷰를 추가하고자 한다면 뷰 파일을 직접 만들어 줘야 한다.
```sh
rails g controller ViewToDisplayController sampleView
```
- 위 명령어를 실행하면 다음과 같은 메시지가 나온다.
```
      create  app/controllers/view_to_display_controller.rb
       route  get 'view_to_display/sampleView'
      invoke  erb
      create    app/views/view_to_display
      create    app/views/view_to_display/sampleView.html.erb
      invoke  test_unit
      create    test/controllers/view_to_display_controller_test.rb
      invoke  helper
      create    app/helpers/view_to_display_helper.rb
      invoke    test_unit
```

### 컨트롤러 생성
- 레일즈 명령어를 사용했을 때 컨트롤러는 파스칼 케이스로 적어준다. 그러면 레일즈는 스네이크케이스의 파일명을 만들어준다.
- 컨트롤러 명을 파스칼 케이스로 하면 `ViewToDisplayController`이고 스테이크케이스로 하면 `view_to_display_controller`이다.
- `app/controllers/view_to_display_controller.rb`라는 컨트롤러가 생겼다. 첫 글자가 대문자이고 `view_to_display_controller`가 된다.

#### 파스칼 케이스와 스테이크 케이스
**파스칼 케이스**
- 첫 문자가 대문자로 띄어쓰기 다음에 나오는 문자는 대문자로 띄어쓰기는 붙여 쓰는 방식의 표기 방식을 말한다.
- `view to display controller`라는 문장을 파스칼 케이스로 바꾸면 `ViewToDisplayController`가 된다.

**스테이크 케이스**
- 스테이크 케이스는 모든 띄어쓰기를 언버바(`_`)로 바꾼 것을 의미한다.
- `view to display controller`라는 문장을 스네이크 케이스로 바꾸면 `view_to_display_controller`가 된다.

#### 컨트롤러 코드
app/controllers/view_to_display_controller.rb
```rb
class ViewToDisplayController < ApplicationController
  def sampleView
  end
end
```
- 컨트롤러만 단독으로 생성하는 레일즈 명령어와 달리 컨트롤러와 뷰를 함께 생성하는 경우에는 컨트롤러 클래스 내부에 메소드가 생성이 된다.

### 라우트 추가
- 레일즈 명령어로 컨트롤러를 단독으로 만들 때는 라우트의 추가가 되지 않았지만, 컨트롤러와 함께 뷰도 생성하는 명령을 사용하면 라우터도 자동으로 추가되는 것을 확인할 수 있다.

#### 레일즈 명령의 결과
```
route  get 'view_to_display/sampleView'
```
- 기존의 라우트 파일에서 무언가 바뀌었다는 것을 알 수 있다.
- 이를 확인 해 보자.
```sh
git status
```
- 위의 명령어를 입력해서 변경 사항을 확인하면 이전 커밋 기록에서 파일 변경 사항을 확인할 수 있다.
```
커밋하도록 정하지 않은 변경 사항:
  (무엇을 커밋할지 바꾸려면 "git add <파일>..."을 사용하십시오)
  (use "git restore <file>..." to discard changes in working directory)
        수정함:        config/routes.rb
```
- `config/routes.rb` 파일의 코드가 변경이 되었다고 나온다.
```sh
git diff config/routes.rb
```
- `git diff` 명령어는 어떤 코드가 변경되었는지 확인할 수 있는 기능을 제공한다.
```
 Rails.application.routes.draw do
+  get 'view_to_display/sampleView'
```
- `+` 표시로 ` get 'view_to_display/sampleView'`의 코드가 변경되었다는 것을 알려준다.
- 이 라우터 경로(`http://127.0.0.1:3000/view_to_display/sampleView`)로 접근을 해 보면 웹 페이지를 확인할 수 있다.
- 그런데 컨트롤러의 코드를 보면 `=> 컨트롤러명#메소드명`과 같은 컨트롤러와 연결하는 부분의 코드가 없다. 이 부분의 코드가 없을 때는 라우터의 경오에 매칭되는 컨트롤러와 메소드가 사용된다.
- 라우터에 설정된 경로가 `view_to_display/sampleView`이므로 매칭되는 컨트롤러의 이름은 `view_to_display`이고, 매칭되는 컨트롤러의 메소드 이름은 `sampleView`가 된다.

### 뷰 생성
- `app/views/view_to_display/sampleView.html.erb` 경로에 `sampleView.html.erb`라는 파일이 생겼다.
- 파일을 열어 보면 다음과 같은 HTML 코드가 나오는 것을 알 수 있고, 이 HTML 코드는 `http://127.0.0.1:3000/view_to_display/sampleView` 주소로 접근을 했을 때 마크업에 해당하는 표현이 변경되어 표시된다.
```html
<h1>ViewToDisplay#sampleView</h1>
<p>Find me in app/views/view_to_display/sampleView.html.erb</p>
```
- 레일즈에셔 뷰 파일은 `.html`과 비슷한 기능을 하지만, `.erb`라는 확장자명을 사용한다. 왜냐하면 레일즈의 뷰 파일은 HTML과 달리 레일즈의 컨트롤러에서 전달 받은 값을 레일즈 뷰에 표시하여 HTML을 만들 수 있는, 순수 HTML에서는 할 수 없는 기능을 제공하기 때문이다.

## 컨트롤러와 뷰의 연결
app/controllers/view_to_display_controller.rb
```rb
class ViewToDisplayController < ApplicationController
  def sampleView
  end
end
```
- 컨트롤러는 뷰를 연결하는 역할을 한다.
- 루비의 컨트롤러가 뷰를 연결할 때는 `app/Views` 폴더 안에서 컨트롤러명을 소문자의 스네이크케이스로 바꾼 폴더 안에 메소드명과 일이치한 파일명.erb 뷰 파일을 연결한다.
- 따라서 라우트를 통해 컨트롤러의 특정한 메소드를 실행하면 컨트롤러의 메소드에 연결되어 있는 뷰 파일이 반환된다.

### 컨트롤러에서 뷰로 값 전달하기
app/controllers/view_to_display_controller.rb
```rb
class ViewToDisplayController < ApplicationController
  def sampleView
    @description = '컨트롤러에서 전달된 문자열 값입니다.'
  end
end
```
- 컨트롤러에서 뷰로 값을 전달할 때는 `@변수명`의 표현을 사용하여 `@변수명`에 값을 저장한다.

app/views/view_to_display/sampleView.html.erb
```html
<h1>ViewToDisplay#sampleView</h1>
<p>Find me in app/views/view_to_display/sampleView.html.erb</p>
<%=@description%>
```
- 뷰에서 컨트롤러에서 전달 받은 값을 표현할 때는 `@변수명`으로 컨트롤러에서 보낸 값을 받을 수 있다.
- 이 때, 레일즈에서 사용하는 기능과 순수 HTML을 구분하기 위해서 레일즈의 기능을 사용할 수 있는 영역을 `<%=` `%>`으로 구분을 해 주고 이 영역 안에서 레일즈의 코드를 추가해 주어야 한다.
- 컨트롤러에서 보낸 `@description`이란 값을 `<%=` `%>` 영역 안에 써 주면 웹 페이지 브라우저에 뜨는 body 태그에는 다음과 같은 HTML값이 나온다.
```html
    <h1>ViewToDisplay#sampleView</h1>
    <p>Find me in app/views/view_to_display/sampleView.html.erb</p>
    컨트롤러에서 전달된 문자열 값입니다.
```
- 레일즈 기능을 사용할 수 있는 영역을 표기하기 위해 감싸는 코드 `<%=` `%>`는 최종 브라우저에서 로드되는 HTML에서는 사라졌다는 것을 확인할 수 있다.