## 자신의 깃허브 아이디로 로그인 하기
- https://github.com/자신의_깃허브_아이디
- 위의 페이지로 접근을 하자.
- 화면의 상단 메뉴를 보면 Overview Repositories Projects Packages Stars 라는 메뉴를 볼 수 있다.
- Repositories 메뉴를 클릭하여 페이지에 들어가면 초록색 배경의 new 버튼이 보일 것이다. 클릭을 한다.

### 새 포로젝트 설정하기
- `Repository name *` 부분에 프로젝트 명을 아무거나 정하자. 여기서는 `ruby-rails-study`란 이름을 사용하였다.
- `Description (optional)` 부분은 비워두어도 된다.
- Public과 Private의 선택을 할 수 있는 라디오 버튼 창이 뜨는데 Public으로 선택하도록 한다. (깃 허브 메인에 잔디를 심기 위해서)
- `Add a README file`은 굳이 만들지 않아도 된다. 프로젝트 메인 폴더에 `README.md` 파일을 추가하면 되기 때문이다.
- `Add .gitignore` gitignore 파일은 루비온레일즈를 설치하면서 레일즈에서 추가할 것이므로 체크하지 않도록 하자.
- `Choose a license` 부분은 남이 코드를 사용해도 공개를 의무적으로 하기 때문에 함부로 사용하기 어려운 `GNU Affero General Public License 3.0`으로 선택하도록 한다.
- create Repository 버튼을 누른다.

### 새 프로젝트 클론하기
- 새로운 프로젝트가 생성되었다면 `https://github.com/자신의_깃허브_아이디/리포지토리명`의 경로에 새로운 리포지토리의 페이지가 나온다.
- 오른쪽 상단을 보면, Go to file, Add file, <> Code 라는 메뉴가 있다. <> Code라는 메뉴의 하위 항목에서 `https://github.com/자신의_깃허브_아이디/리포지토리명.git`라는 주소를 복사한다.
- 이제 이 리포지토리를 자신의 로컬 브렌치에 가져오도록 하자.
- 자신의 컴퓨터의 적당한 폴더 (예를 들어 맥북의 경우에는 터미널을 열고 `mkdir ~/dev` `cd ~/dev`로 폴더를 만들고 터미널의 명령 실행 위치를 `~/dev` 경로로 옮긴 상태에서) `git clone` 명령어를 사용해서 `git clone 복사한_깃허브_리포지토리의_주소.git`이란 명령어를 실행하면, 지정된 깃허브 리포지토리 이름의 폴더가 생성된다.
- 터미널에서 `cd 지정된_깃허브_리포지토리_이름`으로 접근을 하도록 하자. `pwd`라는 명령어를 터미널에 입력하면 `/Users/맥북_유저명/dev/리포지토리_이름` 이란 폴더임을 알 수 있다.
- 이 경로를 이제부터 '프로젝트 루트'라고 부른다.