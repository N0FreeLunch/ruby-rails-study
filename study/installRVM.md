## 루비 버전 관리 메니저 설치
- 컴퓨터에 설치된 루비를 다양한 버전으로 변경 가능하다.

## 가이드
- https://rvm.io/rvm/install

## 설치하기
```sh
\curl -sSL https://get.rvm.io | bash -s stable
```
- 위 명령어를 입력한다.
- 만약 설치가 되어 있다면 터미널 창에서 `rvm` 명령어를 사용할 수 있다.
```sh
rvm --version
```
- 위 명령어를 입력했을 때 `command not found: rvm`이란 말이 나온다면 
```sh
source ~/.rvm/scripts/rvm
```
- 위 명령어를 입력하자. 기본적으로 터미널을 열 때 명령어들이 등록이 된다. 따라서 이미 연 터미널에는 rvm 명령어가 등록되지 않은 상태이다. 터미널을 닫았다가 실행하면 `rvm` 명령어가 등록된 상태로 터미널이 실행된다. 터미널을 닫았다가 다시 실행하지 않고 `source`라는 명령어을 실행하면 등록된 명령어 리스트을 기존에 켜져 있던 터미널이 다시 불러오기 때문에 터미널을 닫았다가 다시 열지 않아도 된다.
- 다시 한 번 `rvm --version` 명령을 실행해 보자. 그러면 `rvm 1.29.12 (latest) by Michal Papis, Piotr Kuczynski, Wayne E. Seguin [https://rvm.io]`과 같은 메시지가 나올 것이다. 이 메시지가 나오면 실행이 된 것이다. 물론 rvm을 설치하는 시점에 따라서 버전이 다를 수 있다. (이 때 rvm의 버전은 ruby 언어의 버전과는 다르다.)

## 사용하기
- 먼저 rvm으로 루비를 설치하기 위해서는 설치할 수 있는 대상 리스트를 확보하는 것이 필요하다.
```sh
rvm list known
```
- 위의 명령어를 입력하면 설치할 수 있는 루비의 리스트가 나온다.
- 여러가지 루비의 리스트가 나오는데 일반적으로는 MRI 루비를 사용한다.
```sh
# MRI Rubies
[ruby-]1.8.6[-p420]
[ruby-]1.8.7[-head] # security released on head
[ruby-]1.9.1[-p431]
[ruby-]1.9.2[-p330]
[ruby-]1.9.3[-p551]
[ruby-]2.0.0[-p648]
[ruby-]2.1[.10]
[ruby-]2.2[.10]
[ruby-]2.3[.8]
[ruby-]2.4[.10]
[ruby-]2.5[.8]
[ruby-]2.6[.6]
[ruby-]2.7[.2]
[ruby-]3[.0.0]
ruby-head
```
- 현재 리스트에서 3버전의 루비가 가장 최신이므로 3 버전의 루비를 설치해 보자.
- 위 리스트에는 \[\] 문자가 있는데 \[\] 생략할 수 있으며 생략하면 \[\] 안의 버전이 설치된다는 의미이다.
- 예를 들어 `rvm install 3`이란 명령은 `rvm install 3.0` 또는 `rvm install 3.0.0`과 동일한 명령어로 3.0.0 버전의 루비를 설치한다는 의미이다. `rvm install 2.4`를 입력하면 `rvm install 2.4.10` 버전과 동일한 버전의 루비가 설치된다는 의미이다. 물론 `rvm install ruby-2.4` 또는  `rvm install ruby-2.4.10`로 입력해도 된다.
```sh
rvm install 3.0
```
- 위 명령어를 입력하면 (`rvm install 3`의 경우 버전을 인식하지 못하는 에러가 있으므로 3.0을 써 준다.)
```
Searching for binary rubies, this might take some time.
No binary rubies available for: osx/12.2/arm64/ruby-3.0.0.
Continuing with compilation. Please read 'rvm help mount' to get more information on binary rubies.
Checking requirements for osx.
About to install Homebrew in the default location `/usr/local`.

It is possible to select a custom location, however it is not recommended and some things might not work.
You should do it only if you do not have write rights to `/usr/local`.

Press ENTER to install Homebrew in the default location `/usr/local`
or type a custom path (needs to be writable for the current user)
: 
```
- 위와 같은 메시지가 나온다. 루비를 설치할 폴더를 `/usr/local`로 하겠냐는 의미인데 일반적으로 rvm을 만든 사람들이 기본적으로 설정한 곳이 `/usr/local`이므로 가장 일반적인 설치 장소이다. 승인하기 위해서 터미널에서 enter 키를 입력해 주자.

### 설치가 되지 않을 때

#### brew 설치
- 설치를 위해서는 홈브류가 필요하다. 만약 설치가 되어 있지 않다면
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
- 위 명령어를 통해서 설치할 수 있다. `Downloading and installing Homebrew...` 라는 메시지가 나오고 한참 동안 설치가 되지 않을 수도 있으니 기다리도록 한다.
- `brew`가 설치되고 나서 `command not found: brew`라는 메시자가 나오면 brew 명령어를 등록해야한다.
```sh
eval $(/opt/homebrew/bin/brew shellenv)
```
- 위 명령어를 실행하여 brew 명령어를 등록한 후 brew 명령어를 사용할 수 있는지 확인 해 보자.
```sh
brew --version
```
- brew가 설치 되었다면 `Homebrew 4.0.18 Homebrew/homebrew-core`와 같은 메시지가 나올 것이다. 메시지가 나왔다면 다시 루비 언어를 설치하도록 하자.
```sh
rvm install 3.0
``` 

### 설치 확인하기
```sh
rvm list
```
- 위 명령을 사용하면 현재 설치된 루비 버전을 알 수 있다. 
```
# => - current
# =* - current && default
#  * - default
```
- 명령어를 실행한 후에 위의 메시지가 나오는 것을 알 수 있는데, `default`는 터미널을 열었을 때 기본적으로 사용되는 `ruby` 명령에서 사용되는 루비 언어의 버전이며, `current`는 현재 사용되고 있는 `ruby` 명령에서 사용되는 루비 언어의 버전이다.
- `current`에 해당하는 버전이 3.0.0 버전이 아니라 다른 버전을 사용중이라면 루비 버전을 3.0.0으로 바꿔주도록 하자.
```
=* ruby-3.0.0 [ arm64 ]
```
- `=*`를 통해서 알 수 있듯이 현재의 루비 버전은 `ruby-3.0.0`이므로 굳이 바꿔줄 필요는 없다.

## 참고
### rvm에서 사용하는 루비 버전 바꾸기
- 다른 버전의 루비를 먼저 설치해야 한다. 위에서 3.0.0을 설치할 때와 마찬가지로 다른 버전을 설치한다.
- 디폴트 버전으로 3.0.0이 선택되어 있기 때문에 바꿔줘야 한다.
```
rvm use 원하는_루비_버전
```
- 위 명령어를 통해서 루비의 버전을 바꿀 수 있으며 '원하는_루비_버전'에 해당하는 값은 `rvm list` 명령에서 나오는 버전명을 써 주면 된다.
- rvm이 사용하는 루비의 버전을 바뀌었는지 확인하기 위해서는 `rvm list`를 실행 한 후 버전 목록 앞에 `=` 기호가 붙어 있는 버전이 현재 rvm이 사용하고 있는 버전이다.

### 디폴트 버전 바꾸기
- 터미널을 새로 실행했을 때 rvm에 의해 처음 선택되는 루비의 버전이 디폴트 버전이다.
- 현재 디폴트 버전은 3.0.0으로 세팅 되어 있는데 만약 다른 버전으로 바꾸고 싶다면 다음을 입력한다.
```sh
rvm --default use 원하는_루비_버전
```
- `rvm list` 명령으로 확인해 보면 `원하는_루비_버전` 앞에 `*`가 붙어서 ` * 원하는_루비_버전`의 형태로 디폴트 버전이 표시되는 것을 알 수 있다.

## 최종적으로 루비 명령이 버전 확인하기
- rvm으로 원하는 버전의 루비가 정상적으로 선택이 되었다면 다음 명령어를 통해서 원하는 루비 버전이 사용할 수 있는 상태인지 확인할 수 있다.
```sh
ruby --version
```
- 그럼 `ruby 3.0.0p0 (2020-12-25 revision 95aff21468)`와 같은 메시지가 나온다.
- rvm에 의해서 선택된 버전과 ruby 명령이 실행하는 루비 언어의 버전이 3.0.0으로 동일한 것을 확인할 수 있다.
