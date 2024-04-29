## 데이터베이스 도커

### 로컬 환경과 서버 환경의 데이터베이스
- 테스트 환경 또는 프로덕션 환경에서는 AWS와 같은 클라우드 서비스에서 제공하는 데이터베이스를 사용한다.
- 로컬 개발 환경에서는 개발 컴퓨터에 데이터베이스 프로그램을 설치해서 서버와 데이터베이스 간의 통신을 주고 받는다.

### 왜 도커를 사용하는가?
- 데이터베이스 설치가 번거롭기 때문이다. 매번 데이터베이스 프로그램을 설치하는 것은 번거로운 일이다. 도커를 사용하면 도커 세팅 명령어만으로 미리 세팅된 데이터베이스를 만들 수 있다.
- 버전 불일치를 해결하기 위함이다. 데이터베이스도 다양한 버전이 있을 것이고, 어떤 버전의 데이터베이스에서는 잘 동작 되던 것이 어떤 버전에서는 동작하지 않을 가능성이 있다. 특히 새로운 버전의 새로운 기능이나 문법을 사용했다면 이전 버전의 데이터베이스에서는 이를 지원하지 않기 때문에 동작하지 않는 문제가 발생할 수도 있으며, 버전에 따라 쿼리의 실행속도가 달라질 수 있기 때문에 데이터베이스 버전에 따라 잘 동작하던 것이 느려질 수도 있다.
- 프로젝트 별로 다른 데이터베이스를 쓰기 위함이다. 어떤 프로젝트에서는 mysql8 버전 이상을 쓰고 어떤 프로젝트에서는 mysql5 버전을 사용한다고 하자. 하나의 컴퓨터에 데이터베이스를 종류별로 다른 것을 설치하는 것은 때때로 까다로울 수 있기 때문에 각각의 프로젝트에서 잘 동작하는 데이터베이스를 별도로 사용하기 위해 프로젝트별로 도커를 사용한다.

### 도커를 사용하는 방법
- 도커를 사용할 때 명령어는 docker 명령과 docker compose 명령이 있다. docker 명령은 도커 허브란 곳에 있는 컨테이너를 명령어의 옵션에 따라 설치하는 것이고, docker compose는 여러 옵션을 docker-compose.yml에 설정한 대로 컨테이너를 설치하는 것이다.

### docker-compose 세팅하기
```yml
version: '3.9'

services:

  db:
    image: mysql
    command: --default-authentication-plugin=caching_sha2_password
    restart: always
    ports:
      - ${DB_PORT}:3306
    environment:
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD}
      MYSQL_USER: ${DB_USERNAME}
      MYSQL_PASSWORD: ${DB_PASSWORD}
```
- 도커 컴포즈 문법에서 `${환경변수명}`의 방식으로 .env 파일의 변수를 사용할 수 있다. `$환경변수명`

### .env 세팅하기
```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=46006
DB_DATABASE=ruby-rails-study
DB_USERNAME=user
DB_PASSWORD=password
DB_ROOT_PASSWORD=root_password
```
- 주의 할 점: port 번호는 다른 프로젝트에서 사용하는 port와 겹치지 않도록 한다.

### 도커 컨테이너에 접속하기
```sh
docker compose exec db mysql -u user -p
```
- Enter password: 라는 메시지가 나오면 `password`를 입력한다.
- `mysql> `으로 시작하는 명령어 입력창이 나오면 OK.
- 해당 명령 창에서 나오고 싶다면 `mysql> exit`를 입력하자.

### 레일즈에서 DB 접속하기
- config/database.yml의 파일을 연다.
```yml
  # adapter: sqlite3
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000
  encoding: utf8mb4
```
- adapter 부분을 mysql2로 바꿔준다.

```yml
  adapter: mysql2
  username: <%= ENV['DB_USERNAME'] %>
  password: <%= ENV['DB_PASSWORD'] %>
  host: <%= ENV['DB_HOST'] %>
  port: <%= ENV['DB_PORT'] %>
```
- .env 파일에서 지정한 값을 사용해서 DB에 접속한다는 설정을 한다.

### mysql2 어텝터 설치하기
- 기본적으로 mysql2 adapter는 로컬의 mysql 설치를 필요로 한다.
```
brew install mysql
```
- 만약 `command not founded`라는 메시지가 나온다면 `export PATH=/opt/homebrew/bin:$PATH`라는 명령어를 입력한 후에 위 설치 명령어를 사용하자.
- openssl을 설치해야 한다.
```
brew install openssl@1.1
```
- zstd를 설치해야 한다.
```
brew install zstd
```
```
brew info zstd
```
- 설치 후 위의 명령어를 입력하면 `Installed
/opt/homebrew/Cellar/zstd/1.5.6 (31 files, 2.2MB) *`라는 메시지를 볼 수 있다. `1.5.6` 부분은 바뀔 수 있는 부분이므로 위 경로를 확인하고 이 버전을 다음 명령어에 기입한다.

```sh
gem install mysql2 -- --with-openssl-dir=$(brew --prefix openssl@1.1) --with-ldflags=-L/opt/homebrew/Cellar/zstd/1.5.6/lib
```

> Error loading the 'mysql2' Active Record adapter. Missing a gem it depends on?


### 레일즈에서 데이터베이스에 접속되는지 확인하기
```
bin/rails runner 'puts ActiveRecord::Base.connections'
```
