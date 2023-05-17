## 로컬애서 서버 실행하기
```sh
rails s
```
- 위 명령어를 실행하면 다음의 메시지가 나온다.
```
=> Booting Puma
=> Rails 7.0.4.3 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.6.5 (ruby 3.0.0-p0) ("Birdie's Version")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 67733
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
Use Ctrl-C to stop
```
- 브라우저에서 `http://127.0.0.1:3000` 경로로 접속을 해 보자.
- 그러면 빨간 원의 레일즈라는 로고가 표시되는 화면이 나온다.
