### 현재 테이블
| id | path | caption | created_at | updated_at |
|----|------|---------| ---------- | ---------- |
| 1 | 사진첩/초코 케이크.png | 생일날 먹은 케익 | 2023-05-01 | 2023-05-01 |
| 2 | 사진첩/남방 돌고래.jpg | 제주도 놀러 갔을 때 남방 돌고래 찍은 사진 | 2023-05-15 | 2023-05-15 |

## 컬럼 추가 마이그레이션 생성하기
```sh
rails g migration AddDateTakenToPhotos date_taken:datetime
```
- `date_taken`는 찍은 날을 의미한다. 데이터베이스에는 `datetime`라는 타입이 있는데 시간 정보를 저장하는 타입이다.
- 마이그레이션은 데이터베이스의 구조를 변경하기 위한 명령을 정의한다고 하였다. 
- `rails g migration` 명령을 통해서 마이그레이션이 생성될 때의 데이터베이스의 구조를 어떻게 변경지 마이그레이션의 이름을 통해서 지을 수 있다.
- 여기서 마이그레이션 클래스 명은 `AddDateTakenToPhotos`이다. 이 마이그레이션의 이름은 `Add` 추가한다. `DateTaken` 컬럼을 `ToPhotos` photos 테이블에 라는 의미를 가지고 있다.
- 마이그레이션 이름을 정하는 몇 가지 규칙이 있는데 공식 문서의 예제를 보면 어느 정도 파악 가능하다. 물론 마이그레이션 파일을 생성하고 나서 데이터베이스를 변경할 명령 코드를 따로 적어주는 방법도 사용할 수 있다.
- 더 많은 예제를 확인하려면 [엑티브 레코드 마이그레이션 공식 문서](https://guides.rubyonrails.org/active_record_migrations.html)를 참고하자.

### 생성된 마이그레이션
```
      invoke  active_record
      create    db/migrate/20230523144425_add_date_taken_to_photos.rb
```
- `rails` 명령으로 마이그레이션을 실행하면 위와 같은 메시지가 나타난다.
- `db/migrate/20230523144425_add_date_taken_to_photos.rb` 경로의 파일을 열어보자.

### 마이그레이션 코드 
```rb
class AddDateTakenToPhotos < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :date_taken, :datetime
  end
end
```
- `change`라는 메소드가 나왔다. `change` 내부에는 테이블 변경에 관한 명령을 추가할 수 있다. `change`라는 메소드는 뜬금없이 나타난 것이 아니라 `AddDateTakenToPhotos` 클래스가 `ActiveRecord::Migration[7.0]` 클래스의 상속을 받으면서 `ActiveRecord::Migration[7.0]`에 정의되어 있는 `change` 메소드를 
- `add_column` 컬럼을 추가한다라는 의미이다. 그리고 `:photos`, `:date_taken`, `:datetime`의 3개의 인자를 받았는데 `add_column(:photos, :date_taken, :datetime)`와 동일한 표현의 괄호가 생략된 코드이다.
- `add_column(테이블명, 커럼명, 컬럼_타입)`의 방식으로 적어준다.

## 마이그레이션 하기
- 이번에 실행될 마이그레이션은 기존의 `photo` 테이블에 `date_taken`라는 컬럼을 추가하는 작업이다.

### 마이그레이션 이전의 상태 확인하기
#### 테이블 컬럼 확인하기
```sh
sqlite3
```
- Sqlite CLI를 열고 기존의 테이블을 확인해 보자.
```sql
.open db/development.sqlite3
```
- 데이터 베이스를 열고

```sql
.tables
```
- 데이터베이스 안의 테이블 리스트를 표시한다.
```
ar_internal_metadata  photos                schema_migrations 
```

```sql
PRAGMA table_info(photos);
```
- `PRAGMA table_info(테이블명);`이란 명령어로 테이블의 컬럼과 그 타입을 확인할 수 있다.
```
0|id|integer|1||1
1|path|varchar|0|NULL|0
2|caption|text|0|NULL|0
3|created_at|datetime(6)|1||0
4|updated_at|datetime(6)|1||0
```

#### 마이그레이션 단계 확인하기
- 테이블 리스트에는 `schema_migrations`라는 테이블이 있다. 이 테이블은 실행된 마이그레이션을 기록하는 테이블이다.
```sql
select * from schema_migrations;
```
- 위 명령어를 입력하면 `schema_migrations` 테이블 안에 든 데이터를 확인할 수 있다.
```
20230518155320
```
- 위의 값이 나왔는데, 가장 처음 생성한 마이그레이션 파일인 `db/migrate/20230518155320_create_photos.rb`의 명령으로 데이터베이스를 변경했다는 의미를 가지고 있다.
- 이 테이블에 기록이 되는 것으로, 마이그레이션 파일의 코드가 실행이 되었는지 아직 실행이 되지 않았는지를 알 수가 있고, 마이그레이션을 실행하는 명령어 `rake db:migrate`로 마이그레이션이 성공하면 이 테이블에 마이그레이션 파일이 생성된 시점의 번호가 기록된다.

#### 마이그레이션 하기
- 별도의 터미널을 열어서 Sqlite CLI를 닫지 않고 다른 테이블에서 작업을 해도 되고, Sqlite CLI가 실행된 터미널에서 `.exit`라는 코드를 써서 Sqlite CLI를 종료할 수도 있다.
```sh
rake db:migrate
```
- 마이그레이션 명령을 실행하면 마이그레이션 파일에 정의한 코드가 데이터베이스를 변경할 수 있는 쿼리로 변환이 되어 데이터베이스로 전달되고 데이터베이스를 변경시킨다.
```
== 20230523144425 AddDateTakenToPhotos: migrating =============================
-- add_column(:photos, :date_taken, :datetime)
   -> 0.0008s
== 20230523144425 AddDateTakenToPhotos: migrated (0.0008s) ====================
```
- 테이블의 변경 기록을 확인하자.

```sh
sqlite3
```
- sqlite CLI를 실행한다.
```sql
.open db/development.sqlite3
```
- 파일 베이스로 데이터를 저장하는 sqlite 데이터베이스 파일을 연다.

```sql
.tables
```
- 테이블 리스트를 표기한다.

```sql
PRAGMA table_info(photos);
```
- `photo` 테이블의 컬럼 정보를조회한다.
```
0|id|integer|1||1
1|path|varchar|0|NULL|0
2|caption|text|0|NULL|0
3|created_at|datetime(6)|1||0
4|updated_at|datetime(6)|1||0
5|date_taken|datetime(6)|0||0
```
- 마이그레이션을 하기 전에는 5번 칼럼인 `date_taken` 칼럼이 없었는데 칼럼이 추가 된 것을 알 수 있다.
- 이는 마이그레이션 명령에 의해 `AddDateTakenToPhotos` 클래스의 코드가 실행되었기 때문이다.
```rb
def change
    add_column :photos, :date_taken, :datetime
end
```
- 위 코드가 `5|date_taken|datetime(6)|0||0` 부분의 데이터를 추가 시켰다.

#### 마이그레이션 후 마이그레이션 단계 확인하기
```sql
select * from schema_migrations;
```
- 테이블의 데이터를 확인해 보면
```
20230518155320
20230523144425
```
- `20230523144425` 부분이 한 줄 더 늘었다. `20230523144425_add_date_taken_to_photos.rb` 파일이 마이그레이션으로 실행되어 기록이 된 것이다.

## 롤백하기
- 롤백이란 다시 되돌린다는 의미이다. 데이터 마이그레이션에서 롤백이란 마이그레이션 했던 이전 단계로 돌아간다는 의미이다.
```sh
rake db:rollback
```

```
== 20230523144425 AddDateTakenToPhotos: reverting =============================
-- remove_column(:photos, :date_taken, :datetime)
   -> 0.0046s
== 20230523144425 AddDateTakenToPhotos: reverted (0.0073s) ====================
```
- `20230523144425`에 해당하는 마이그레이션 실행을 되돌리겠다는 의미이다.
- 에러가 발생하지 않고 위의 코드가 생겨났다면 정상적으로 실행 된 것이다.

### 롤백 확인하기
```sh
sqlite3
```
- 터미널에서 Sqlite를 실행하도록 하자.

```sql
.open db/development.sqlite3
```
- 데이터베이스 파일을 열도록 한다.

```sql
.tables
```
- 테이블 리스트를 확인한 후

#### 컬럼 변경 확인하기
```sql
PRAGMA table_info(photos);
```
- 데이터베이스 테이블의 컬럼 정보를 조회한다.

```
0|id|integer|1||1
1|path|varchar|0|NULL|0
2|caption|text|0|NULL|0
3|created_at|datetime(6)|1||0
4|updated_at|datetime(6)|1||0
```
- `5|date_taken|datetime(6)|0||0` 부분의 컬럼이 사라진 것을 확인할 수 있다.
- 마이그레이션을 이전 상태로 되돌리는 롤백이 된 것을 확인할 수 있다.

#### 마이그레이션 기록 이해하기
```sql
select * from schema_migrations;
```
- 또한 마이그레이션 기록을 확인해 보면
```
20230518155320
```
- `20230523144425`에 해당하는 마이그레이션 기록이 사라진 것을 확인할 수 있다.

#### 마이그레이션 좀 더 이해하기
- `20230518155320` 마이그레이션은 `db/migrate/20230518155320_create_photos.rb` 파일을 가리키고, `20230523144425`는 `20230523144425_add_date_taken_to_photos.rb` 파일을 가리킨다.
- `20230518155320`는 기록이 된 상태이기 때문에 다음에 `rake db:migrate` 마이그레이션 명령어를 사용했을 때는 `20230518155320`는 실행하지 않고 `20230523144425` 부터 실행하게 된다.

## 자바스크립트 코드로 이해하기
```js
const ActiveRecord = {
  Migration : {
    '7.0' : class {
      add_column(tableName, columnName, columnType) {
        console.log(`대상 테이블명은 : ${tableName.description}입니다.`);
        console.log(`추가할 컬럼명은 : ${columnName.description}입니다.`);
        console.log(`추가할 컬럼의 타입은 : ${columnType.description}입니다.`);
      }
    }
  }
}
class AddDateTakenToPhotos extends ActiveRecord.Migration['7.0'] {
  change () {
    this.add_column(Symbol.for('photos'), Symbol.for('date_taken'), Symbol.for('datetime'));
  };
}

(new AddDateTakenToPhotos).change();
```
- `ActiveRecord.Migration['7.0']`에 해당하는 코드는 원래는 데이터베이스 변경을 정의할 수 있는 기능이 와야 하지만 간단히 동작하는 자바스크립트 예제를 보여주기 위해 문자열을 출력하는 `console.log`로 간단히 나타내었다.
- 자바스크립트 클래스에서 클래스가 가지고 있는 함수인 메소드는 클래스 내부 블록에 `change () {}`로 정의하였고, `this.add_column`을 사용하여 메소드 내부에서 클래스에 담겨 있는 다른 메소드를 호출하기 위해 `this.add_column`를 사용하였다.
- `AddDateTakenToPhotos` 클래스는 `ActiveRecord.Migration['7.0']`의 코드를 상속 받았기 때문에 `add_column`라는 메소드를 가지게 되어 `AddDateTakenToPhotos`의 클래스 블록 내부에서 사용할 수 있게 되었다.
- `(new AddDateTakenToPhotos).change();`에서 클래스는 객체로 만들어서 사용해야 하기 때문에 `new 클래스`로 객체를 만들기 위해 `(new AddDateTakenToPhotos)` 객체를 만들고 객체의 메소드를 `.change()`으로 사용하였다. 물론 루비의 코드에는 클래스의 실행 부분은 레일즈 내부에서 처리하므로 따로 적어주지 않지만 위 코드에서는 동작을 확인하기 위해서 실행까지의 단계를 적어 준 것이다.

---
## 깃허브에 올리기
```sh
git status
```
- 변경된 파일 확인하기
```
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        db/migrate/20230523144425_add_date_taken_to_photos.rb
```
- 새로 추가된 파일 존재 확인
```sh
git add db/migrate/20230523144425_add_date_taken_to_photos.rb
```
- 커밋 대상으로 올리기
```sh
git status
```
- 커밋 대상으로 올라가져 있는지 확인.
```
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   db/migrate/20230523144425_add_date_taken_to_photos.rb
```
- 초록색의 파일 경로로 새로운 파일로 커밋할 대상이 되었다는 메시지 확인
```sh
git commit -m "컬럼 추가 마이그레이션 추가"
```
- 커밋 대상을 커밋하여 기록을 남기기
```sh
git log
```
- 커밋한 기록을 확인하기
```
commit a79d123a422cb0fd2a46bb671825cb163ba04439 (HEAD -> main)
Author: 깃허브_아이디 <깃허브_등록_이메일@gmail.com>
Date:   Thu May 25 03:19:45 2023 +0900

    컬럼 추가 마이그레이션 추가
```
- `a79d123a422cb0fd2a46bb671825cb163ba04439` 부분은 커밋에 부여된 고유한 ID이다. 특정 커밋으로 되돌아 가고 싶을 때 이 ID를 지정하여 과거 커밋 시점의 코드로 되돌아 갈 수 있다.
- 커밋에 붙여준 이름을 확인하여 원하는 시점으로 코드를 되돌릴 수 있다.
- `git log` 명령으로 이전에 붙여준 커밋 이름을 확인할 수 있으므로 이 전에 어떤 작업을 하여 깃으로 기록을 남겼는지 확인할 수 있다.

### 깃허브에 올리기
- 커밋된 대상을 깃허브에 올리려면
```
git push origin main
```