## 마이그레이션으로 스키마 되돌리기

### 롤백으로 되돌리는 것과 마이그레이션으로 되돌리는 것의 차이
- 일반적으로 롤백으로 마이그레이션을 되돌리는 것은 커멘드라인에서 `rake db:migrate:rollback`이란 명령어를 입력하는 것으로 되돌릴 수 있다.
- 그런데 모르고 롤백 명령어를 두 번 입력했다면 어떻게 될까?
- 서버에서는 데이터가 쌓이게 된다. 이전의 마이그레이션으로 추가/변경된 스키마에 데이터가 쌓였는데 롤백이 되면 해당 스키마가 없어지거나 변경이 되면서 기존의 데이터가 사라지거나 변형되어 손실되는 경우가 생길 수 있다. 예를 들어 블로그 서비스를 하는데 마이그레이션 롤백으로 인해 사용자가 힘들게 쓴 글이라면 글이 사라지면서 고객이 힘들여 만든 데이터가 사라지게 될 것이다.
- 롤백은 명령어 조작 미스로 인해서 중요한 정보를 손실할 가능성을 갖기 때문에, 개발이나 검증 서버와 같이 데이터가 손실되어도 크게 문제 없는 경우에만 롤백을 사용하며 프로덕션 서버에서는 가능한 한 롤백을 사용하지 않는다. 물론 아주 급하게 마이그레이션을 되돌려야 하는 경우라면 롤백을 사용하겠지만 실수가 없도록 굉장히 신중하게 전략적으로 작업을 해야 할 것이다.
- 크리티컬하지 않다면 롤백을 사용하기 보다는 마이그레이션을 정의해서 변경된 스키마를 이전 상태로 되돌리도록 한다. 로컬에서 개발한 마이그레이션 코드는 검증 환경을 거치면서 스키마를 다시 되돌리는 것에 문제가 없는지 확인 작업을 거치게 되고, 이를 프로덕션 서버에 적용하게 되어 스키마를 변경할 때 안정성이 높아진다.
- 여기서는 로컬 환경에서 코드를 작성하는 것이지만 마이그레이션으로 스키마를 이전 상태로 되돌리는 것에 대한 연습을 해 보도록 하자.
- 좀 더 자세한 사항은 [마이그레이션을 하는 이유](../webFramework/whyUseMigration.md) 부분의 설명을 참고하자.

### 추가한 `date_taken` 컬럼을 삭제하는 마이그레이션 만들기
```sh
rails g migration RemoveDateTakenFromPhotos date_taken:datetime
```
- 기본적으로 `rails g migration` 명령어로 마이그레이션 파일을 만들 때, `Add컬럼명To테이블명`과 같은 이름을 붙이면 `date_taken:datetime`와 같이 컬럼을 추가하는 코드를 뒤에 적었을 때 컬럼이 추가가 되고, `Remove컬럼명To테이블명`과 같은 이름을 붙이면 `date_taken:datetime`와 같이 컬럼을 지정하면 해당 컬럼을 삭제하는 코드가 들어 있는 마이그레이션을 만들 수 있다.
```
      invoke  active_record
      create    db/migrate/20230530171354_remove_date_taken_from_photos.rb
```
- 새롭게 마이그레이션 파일을 생성하였다.

### 만들어진 마이그레이션 코드 확인하기
```rb
class RemoveDateTakenFromPhotos < ActiveRecord::Migration[7.0]
  def change
    remove_column :photos, :date_taken, :datetime
  end
end
```
- `RemoveDateTakenFromPhotos` 클래스의 `change` 메소드에서 `ActiveRecord::Migration[7.0]` 클래스에서 상속 받아 사용할 수 있는 `remove_column` 메소드를 사용하여 `remove_column(테이블명, 컬럼명, 컬럼타입)` 또는 `remove_column 테이블명, 컬럼명, 컬럼타입`으로 컬럼을 삭제하는 마이그레이션을 만든다.

### 마이그레이션 실행하기
```sh
rake db:migrate:status
```
- 마이그레이션 상태 확인하기
```
 Status   Migration ID    Migration Name
--------------------------------------------------
   up     20230518155320  Create photos
   up     20230523144425  Add date taken to photos
   up     20230526174218  Add index to photo
  down    20230530171354  Remove date taken from photos
```
- 삭제하는 마이그레이션 `Remove date taken from photos`이 만들어 졌고 아직 마이그레이션이 실행되지 않은 `down` 상태이다.
```sh
rake db:migrate
```
- 위 명령으로 마이그레이션이 실행 되었다면

### 마이그레이션 실행 확인하기
```sh
rake db:migrate:status
```
```
 Status   Migration ID    Migration Name
--------------------------------------------------
   up     20230518155320  Create photos
   up     20230523144425  Add date taken to photos
   up     20230526174218  Add index to photo
   up     20230530171354  Remove date taken from photos
```
- 마이그레이션이 실행된 것을 확인할 수 있다. 정상적으로 마이그레이션이 실행되었다면 데이터베이스에도 이미 적용이 된 것이기 때문에 굳이 확인을 하지 않아도 된다.
- 그런데 테이블의 컬럼을 지우면 컬럼에 걸려있던 인덱싱도 사라진다. 인덱싱은 컬럼에 부여되는 것인데 컬럼이 사라지면 인덱싱도 사라지는 것이 당연하다. 따라서 컬럼만 지웠지만 인덱싱도 사라진 것을 확인할 수 있다.

### 테이터베이스에서 스키마 확인하기
```sh
sqlite3 db/development.sqlite3
```
- 터미널에서 위 명령어를 입력한다.

```sql
.schema photos
```
- `photos` 테이블의 스키마를 확인하는 쿼리를 날린다.

```
CREATE TABLE IF NOT EXISTS "photos" ("id" integer NOT NULL PRIMARY KEY, "path" varchar DEFAULT NULL, "caption" text DEFAULT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
```
- `photos` 테이블에 인덱스가 있을 때는 `CREATE INDEX "index_photos_on_date_taken" ON "photos" ("date_taken");`이란 스키마 정보가 존재했지만 컬럼이 사라진 지금은 없는 것을 확인할 수 있다. `photos` 테이블의 스키마 정보에서 인덱싱을 찾을 수 없다.

```sql
.quit
```
- 확인을 마쳤으면 위 명령어로 Sqlite CLI에서 나오도록 하자.

---
## 깃허브에 올리기
```sh
git status
```
```
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        db/migrate/20230530171354_remove_date_taken_from_photos.rb
```
```sh
git add *
```
- `git add db/migrate/20230530171354_remove_date_taken_from_photos.rb`와 같이 뒤에 파일 경로를 직접 입력해 줘도 되지만 `git status`으로 표시되는 리스트에 커밋할 대상 경로만 있을 때는 리스트의 모든 대상을 커밋 대상으로 등록하는 `git add *`를 사용해도 된다.
- `git add *`는 `git status`의 리스트로 나타나는 빨간색의 경로 중에서 닷 `.`으로 시작하는 모든 파일을 제외한 파일을 커밋 대상으로 등록할 때 사용한다. 만약 닷 `.`으로 시작하는 파일을 포함하여 모든 파일을 커밋 대상으로 등록하고자 한다면 `git add .`을 사용한다. 하지만 닷`.`으로 시작하는 파일은 커밋을 할지 안 할지 더 신중하게 결정해야 하므로 가능하면 `git add .` 보다는 `git add *`을 위주로 사용하고, 한 단위의 커밋 대상은 하나의 커밋 메시지를 붙일 수 있는 파일들만을 커밋 대상으로 선정하는 것이 중요하기 때문에 `git add *` 보다는 `git add 대상_경로`를 사용해서 커밋 대상을 지정하는 습관을 들이다.
```sh
git status
```
```
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   db/migrate/20230530171354_remove_date_taken_from_photos.rb
```
- 만약 위 파일 이외의 다른 파일이 커밋 대상으로 등록이 되었다면 초록색을 다시 빨간색으로 변경시킬 수 있는 명령어를 사용하면 된다.
```sh
git reset 초록색_경로를_빨간색_경로로_바꿀_대상_파일_경로
```
- 위 명령어를 사용해서 커밋 대상으로 된 초록색 경로의 파일을 커밋 대상에서 제외하여 빨간색 경로로 바꿀 수 있다.
```sh
git commit -m "date_taken 컬럼을 삭제하는 마이그레이션 추가"
```
```sh
git push origin main
```
- 깃허브에 커밋을 등록할 때는 항상 위와 같은 절차를 거처서 올리도록 한다.
- 중요한 점은 가능한 커밋 주제에 맞는 코드 변경이 올라가도록 하는 것이다. 커밋 메시지와 관계없는 파일은 배제한다. 배제한 파일은 그 파일에 맞는 새로운 커밋으로 메시지를 붙어 별도로 커밋을 하도록 한다.