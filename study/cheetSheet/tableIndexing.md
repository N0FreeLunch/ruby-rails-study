## 인덱싱
### 사전의 비유
- 종이 사전의 단어를 찾을 때, 알파벳의 순서를 알고 있기 때문에 빠르게 단어를 찾을 수 있다.
- 만약 사전의 단어가 순서대로 나열되어 있지 않다면, 한 단어씩 찾아야 하기 때문에 글자를 찾는데 오랜 시간이 걸릴 것이다.

### 테이블 인덱싱
- 데이터베이스도 마찬가지이다. 인덱싱이란 컬럼의 데이터에 순서를 부여하여 많은 데이터 가운데 원하는 데이터를 빨리 찾기 위해 사용하는 기술이다.
- 예를 들어 2, 3, 5, 7, 9, 11, 13, 17, 19, 23, 29, 31, 37, 41, 47의 수가 나열되어 있다고 해 보자.
- 사람은 위의 수가 나열된 것을 보고 순차적이구나 순차적이지 않구나를 쉽게 판단할 수 있지만, 컴퓨터는 수가 순차적으로 나열되어 있는지 확인하기 위해서 값 하나하나를 확인 해 봐야 한다.
- 무작위로 나열한 23, 37, 31, 17, 41, 11, 13, 9, 47, 7, 3, 19, 5, 29, 2에서 사람은 한 눈에 47이란 단어를 쉽게 찾을 수 있지만 컴퓨터는 하나하나 비교해 가면서 값을 찾으며 사람도 한 눈에 알기 어려운 많은 데이터 중에서 필요한 데이터를 찾기는 어렵다.

### 테이터베이스 컬럼
| 번호 |
| --- |
| 23 |
| 37 |
| 31 |
| 17 |
| 41 |
| 11 |
| 13 |
| 9 |
| 47 |
| 7 |
| 3 |
| 19 |
| 5 |
| 29 |
| 2 |

- 위와 같이 데이터가 있을 때 원하는 행을 컴퓨터는 어떻게 빠르게 찾을 수 있을까?
- 테이블의 컬럼에 인덱싱 작업을 하면 각각의 데이터에 보이지 않는 순서를 매겨 놓는 작업을 하게 된다.

### 인덱싱의 예
| 번호 | 보이지 않는 컬럼 |
| --- | ------------ |
| 23 | (10) |
| 37 | (13)
| 31 | (12) |
| 17 | (8) |
| 41 | (14) |
| 11 | (6) |
| 13 | (7) |
| 9 | (5) |
| 47 | (15) |
| 7 | (4) |
| 3 | (2) |
| 19 | (9) |
| 5 | (3) |
| 29 | (11) |
| 2 | (1) |

- 보이지 않는 컬럼의 예가 인덱싱이다.
- 각 수에 대한 인덱스는 수의 순서대로 매겨져 있다.
- 인덱스 번호를 나열하고 인덱스 번호에 매칭되는 수를 찾으면 인덱스가 순차적으로 나열되어 있기 때문에 컴퓨터가 훨씬 빨리 찾을 수 있다.
- 예를 들어 17이란 값을 찾는다고 하자. 전체 인덱스가 15개 이므로 중간인 7번 인덱스를 확인해 본다. 값이 13이다. 따라서 8번 인덱스 보다 큰 인덱스에 값이 있을 것으로 판단한다. 7과 16의 중간값인 11번 인덱스를 확인해 본다. 값이 29이다. 그럼 11번 인덱스 보다는 작은 번호의 인덱스에 값이 있을 것이다. 7과 11의 중간값인 9번 인덱스를 확인해 본다. 값이 19이다. 따라서 9번 인덱스 보다는 작은 번호의 인덱스에 값이 있을 것이다. 따라서 8번 인덱스를 확인 한 후 17이란 값이 있는지 확인을 한다.
- 범위를 반씩 좁혀가면서 어떤 수가 있는지 찾는 알고리즘을 통해서 값을 하나하나 확인하고 비교하는 것보다 훨씬 빠르게 원하는 값이 어디 있는지 확인할 수 있다.
- 무언가를 찾을 때 값이 순서대로 나열되어 있다면 대상이 어디있는지 빠르게 찾을 수 있고, 이를 위해 각각의 값에 번호를 매기는 것이 인덱싱이란 작업이다.
- 물론 위의 예시는 설명을 위한 것이고, 데이터베이스는 내부적으로 위의 방법을 더욱 최적화한 방법을 사용해서 여러 행들 중에서 원하는 값을 빠르게 찾는 기술을 제공한다. 하지만 방식은 위의 방식과 비슷하게 내부적으로 각 행의 컬럼 값에 순서를 부여하는 인덱싱을 활용하고 있다.

## 마이그레이션으로 인덱싱하기
- 목적 : photo 테이블에서 `date_taken` 컬럼을 인덱싱해 보자.

### 현재 마이그레이션 상태 확인하기
```sh
rake db:migrate:status
```
- 현재 마이그레이션 상태를 확인해 보면
```
 Status   Migration ID    Migration Name
--------------------------------------------------
   up     20230518155320  Create photos
  down    20230523144425  Add date taken to photos
```
- 위의 상태로 `20230523144425`란 `date_taken` 컬럼을 생성하는 마이그레이션이 만들어졌다.
- 따라서 위의 마이그레이션을 실행행하면 되므로 컬럼을 생성하는 마이그레이션을 따로 만들 필요는 없는 상태이다.
- 이미 만들어진 컬럼인 `date_taken`에 인덱스를 추가하는 마이그레이션만 만들면 된다.

### 마이그레이션 명령을 통한 코드 생성
- 레일즈에서는 마이그레이션 `rails g migration` 명령으로 파일을 생성하는 것과 동시에 코드를 생성할 수 있는 기능을 제공한다.
- 이 기능은 테이블 생성, 컬럼 생성, 컬럼 추가, 참조 관계 설정, 조인 관계 설정 등을 제공한다.
- 하지만 `rails g migration` 명령으로 컬럼에 속성을 부여하는 작업은 반드시 컬럼의 생성과 함께 정의를 해야 마이그레이션 파일 내에 코드가 생성이 된다.
- 예를 들어 컬럼에 인덱싱을 부여하고 싶을 경우에는 `rails g migration` 명령으로 생성하는 코드로는 이미 만들어진 컬럼에 인덱싱을 부여할 수 없고, 컬럼을 새로 만드는 경우에만 생성할 컬럼에 타입이나 인덱싱 등을 지정하여 마이그레이션 파일 내에 코드를 생성할 수 있다.

### 인덱싱 마이그레이션 추가하기
```sh
rails g migration AddIndexToPhoto date_taken:datetime:index
```
```
      invoke  active_record
      create    db/migrate/20230526174218_add_index_to_photo.rb
```
- 위 명령어로 생성된 마이그레이션 파일을 보자. `db/migrate/20230526174218_add_index_to_photo.rb` 경로의 파일을 연다.
```rb
class AddIndexToPhoto < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :date_taken, :datetime
    add_index :photos, :date_taken
  end
end
```
- 컬럼을 생성하는 코드와 `add_column :photos, :date_taken, :datetime`와 인덱스를 컬럼에 추가하는 코드 `add_index :photos, :date_taken`가 담겨 있다.
- 그런데 이미 `date_taken` 컬럼을 생성하는 마이그레이션 파일이 만들어져 있기 때문에 `add_column :photos, :date_taken, :datetime` 코드를 실행하게 되면 이미 테이블에 컬럼이 있어서 생성하는 명령을 사용할 수 없다는 에러가 나오게 된다.

### 데이터베이스에서 인덱싱 전의 테이블 구성 확인하기
```sh
sqlite3 db/development.sqlite3
```
- `sqlite3 데이터베이스_파일명`으로 `sqlite3` 명령이후 `.open db/development.sqlite3`를 입력할 필요 없이 바로 데이터베이스에 접근 가능하다.

```sql
.tables
```
- 데이터베이스의 테이블 리스트를 확인한다.

```sql
.schema photos
```
- photos 테이블의 스키마를 확인한다.
```
CREATE TABLE IF NOT EXISTS "photos" ("id" integer NOT NULL PRIMARY KEY, "path" varchar DEFAULT NULL, "caption" text DEFAULT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "date_taken" datetime(6));
```
- 테이블이 생성되는데 필요한 쿼리들을 확인할 수 있다.
```sql
.quit
```
- Sqlite CLI에서 나간다. 만약 위 명령어를 사용해도 나갈 수 없다면 쿼리의 종결을 나타내는 `;`를 사용한 후 `.quit` 명령어를 사용하자.

### 마이그레이션 해 보기
```sh
rake db:migrate
```
- 위 명령을 실행하면
```
== 20230526174218 AddIndexToPhoto: migrating ==================================
-- add_column(:photos, :date_taken, :datetime)
rake aborted!
StandardError: An error has occurred, this and all later migrations canceled:

SQLite3::SQLException: duplicate column name: date_taken
```
- 위 에러 메시지가 나타난다. 똑같은 컬럼 이름이 있기 때문에 컬럼을 생성할 수 없다는 의미이다.

#### 실패한 마이그레이션의 상태
```sh
rake db:migrate:status
```
```
database: db/development.sqlite3

 Status   Migration ID    Migration Name
--------------------------------------------------
   up     20230518155320  Create photos
   up     20230523144425  Add date taken to photos
  down    20230526174218  Add index to photo
```
- 마이그레이션이 실패하면 up 상태로 전환되지 않는다.

### 생성된 마이그레이션 코드 변경하기
```rb
class AddIndexToPhoto < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :date_taken, :datetime
    add_index :photos, :date_taken
  end
end
```
- 위 코드에서 인덱싱을 추가하는 부분을 제외한 컬럼을 추가하는 부분의 코드를 지워주자.

```rb
class AddIndexToPhoto < ActiveRecord::Migration[7.0]
  def change
    add_index :photos, :date_taken
  end
end
```

### 마이그레이션 실행하기
```sh
rake db:migrate
```

```sh
rake db:migrate:status
```
- 위 명령으로 마이그레이션의 상태를 확인하면
```
 Status   Migration ID    Migration Name
--------------------------------------------------
   up     20230518155320  Create photos
   up     20230523144425  Add date taken to photos
   up     20230526174218  Add index to photo
```
- 위의 상태가 된다. `Add date taken to photos`라는 파일 이름을 메시지화 한 부분을 통해서 알 수 있듯이 테이블에 컬럼을 추가하는 마이그레이션인 `20230523144425`가 존재하며, `Add index to photo`을 통해서 알 수 있는 인덱스를 추가하는 마이그레이션인 `20230526174218`가 존재한다. 
- `Status`가 `down`인 상태는 아직 마이그레이션이 완료되지 않았다는 의미로 마이그레이션 파일이 생성된 상태만을 의미한다.

### 인덱싱이 컬럼에 추가 되었는지 확인하기
```sh
sqlite3 db/development.sqlite3
```
```sql
.tables
```
```sql
.schema photos
```
- 여기까지의 명령어는 위에서 다루었으므로 설명을 생략한다.
```
CREATE TABLE IF NOT EXISTS "photos" ("id" integer NOT NULL PRIMARY KEY, "path" varchar DEFAULT NULL, "caption" text DEFAULT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "date_taken" datetime(6));
CREATE INDEX "index_photos_on_date_taken" ON "photos" ("date_taken");
```
- `CREATE INDEX "index_photos_on_date_taken" ON "photos" ("date_taken")` 부분에 대한 코드가 추가 되었는데 `photos` 테이블의 `date_taken` 컬럼에 `index_photos_on_date_taken`이름을 가진 인덱스가 걸어서 테이블이 만들어 졌다는 의미를 나타낸다.
- 따라서 컬럼에 인덱스가 추가되어 있는 테이블임을 확인할 수 있다.

---

## 깃허브에 올리기

### 변경사항 확인하기
```sh
git status
```
```
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   db/schema.rb

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        db/migrate/20230526174218_add_index_to_photo.rb
```
- `db/schema.rb`란 파일이 변경이 되었다.
- `db/migrate/20230526174218_add_index_to_photo.rb`라는 인덱스를 추가하는 마이그레이션 파일이 생성되었다.

### 변경된 코드 확인하기
- `db/migrate/20230526174218_add_index_to_photo.rb`는 테이블 인덱싱을 위해 추가한 마이그레이션이므로 특별한 문제가 없다.
- `db/schema.rb` 파일을 git으로 추적하는 것에는 문제가 있는데 살펴보자.

#### 스키마 파일
```sh
git diff db/schema.rb
```

```
-ActiveRecord::Schema[7.0].define(version: 2023_05_18_155320) do
+ActiveRecord::Schema[7.0].define(version: 2023_05_26_174218) do
   create_table "photos", force: :cascade do |t|
     t.string "path"
     t.text "caption"
     t.datetime "created_at", null: false
     t.datetime "updated_at", null: false
+    t.datetime "date_taken"
+    t.index ["date_taken"], name: "index_photos_on_date_taken"
   end
```
- `db/schema.rb` 파일은 마이그레이션이 일어난 이후 최종적인 테이블의 구성을 확인할 수 있다.
- 각 행의 `-``+`는 추가된 부분과 삭제된 부분이다.
- `t.datetime "date_taken"` 부분을 통해서 이전 커밋 상태와 비교해 `date_taken` 컬럼이 추가된 것을 알 수 있다.
- `t.index ["date_taken"], name: "index_photos_on_date_taken"` 부분을 통해서 `index_photos_on_date_taken`라는 이름의 인덱싱이 `date_taken` 컬럼에 추가된 것을 확인할 수 있다.
```
-ActiveRecord::Schema[7.0].define(version: 2023_05_18_155320) do
+ActiveRecord::Schema[7.0].define(version: 2023_05_26_174218) do
```
- 위 부분을 통해서 최종적으로 데이터베이스 테이블 구성에 적용된 마이그레이션 버전이 갱신 된 것을 확인할 수 있다.
- 스키마 파일은 레일즈가 데이터베이스에 있는 테이블의 구조를 파악하는 중요한 기능을 가지고 있다. 만약 스키마 파일이 없으면 레일즈를 통해 디비를 조작하는 작업이 불가능하게 된다.

#### 스키마 파일은 git의 추적을 하지 않는다.
- 동일한 프로젝트를 하는 사람 또는 서버나 프로덕션 환경에서 데이터베이스 구성이 완전히 동일하지 않은 경우가 있다.
- 예를 들어 어떤 컬럼을 새로 만드는 마이그레이션을 만들었을 때, 새로 만든 마이그레이션 파일은 동일한 프로젝트를 하는 다른 사람의 프로젝트 폴더에는 적용되지 않았으며, 개발 서버나 프로덕션 서버에도 적용이 되지 않았을 것이다.
- `db/schema.rb` 파일을 깃으로 추적하게 되면, `db/schema.rb`는 다른 사람의 프로젝트, 개발 서버, 프로덕션 서버에 동일하게 적용이 된다. 하지만 마이그레이션 단계가 차이가 나는 경우 각 서버의 데이터베이스 구성이 일치하지 않게 된다. 따라서 실제 디비에는 적용되지 않은 구성이 `db/schema.rb` 스키마 파일에는 있기 때문에 레일즈로 디비에 명령을 전달할 때 일치되지 않는 부분으로 인해 에러가 발생할 수 있다. 
- 따라서 각각의 서버의 데이터베이스 구성에 맞는 스키마 파일을 갖는 것이 좋고, `db/schema.rb`는 마이그레이션을 실행하면 자동으로 생성되기 때문에 git으로 추적하지 않게 하여 다른 사람의 프로젝트, 개발 서버, 프로덕션 서버 간에 서로 공유하지 않고 각각이 독립된 스키마 파일을 갖도록 해야 한다.

### git 추적에서 제외하기
- 한 번 깃에 올라간 데이터를 지우려면 데이터가 올라간 시점 부터 현재까지의 모든 커밋 기록을 날려야 한다.
- 따라서 유출되어서는 안 되는 정보가 있는 파일이 업로드 되지 않은 경우에는 기존의 커밋 기록은 남겨 두고 더 이상 git으로 추적되지 않도록 하는 작업만 하도록 한다.
- `.gitignore` 파일에 `db/schema.rb`를 추가하도록 하자.
```
# Ignore the default SQLite database.
/db/*.sqlite3
/db/*.sqlite3-*
```
- 위 부분의 하단에 
```
# Ignore schema file.
/db/schema.rb
```
- 추가해 주었다.

```sh
git status
```
- 하지만 여전히 `db/schema.rb` 파일은 `Changes not staged for commit:` 부분에 의해 변경되었다고 변경 기록을 추적하는 중이다.
- 따라서 git에서는 파일이 삭제된 것으로 처리하는 작업을 한다. 하지만 실제 파일을 삭제하는 것은 아니기 때문에 git의 추적에서 파일을 삭제하는 명령어인 `git rm db/schema.rb --cached` 명령어를 실행한다.
- `--cached` 옵션이 없다면 깃의 추적에서 제거되는 동시에 파일이 삭제될 수도 있기 때문에 주의해야한다.
```sh
git rm db/schema.rb --cached
```
```sh
git status
```
```
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    db/schema.rb
```
- 이러면 git에서는 삭제 되었지만, 실제 파일은 삭제되지 않고 남아 있는 모습을 볼 수 있다.
- git에서 삭제되고 .gitignore 파일에 경로가 추가되면 더 이상 git은 해당 파일의 변경사항을 기록하지 않는다.

```
git commit -m "db/schema.rb 파일은 git의 추적에서 제외하기"
```
- 이 때 추적 대상에서 제외한다는 `.gitignore` 파일을 추가해 주어야 하며, 만약 추가하지 않는다면 자신의 프로젝트 폴더 안의 .gitignore에는 추적 대상에서 제외되므로 더 이상 `db/schema.rb` 파일이 추적되지 않겠지만, 다른 사람의 프로젝트나 서버 환경에서는 스키마 파일이 `.gitignore`에 추가되지 않았기 때문에 계속 위 파일을 추적하는 일이 생긴다.
- 따라서 .gitignore 파일도 같이 커밋하도록 한다.
```sh
git add .gitignore
```
```sh
git commit -m "db/schema.rb 파일이 더 이상 추적되지 않도록 .gitignore에 등록하기"
```

### 마이그레이션 파일 커밋하기
```sh
git status
```
```sh
git add db/migrate/20230526174218_add_index_to_photo.rb
```
```sh
git status
```
```
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   db/migrate/20230526174218_add_index_to_photo.rb
```
- `db/migrate/20230526174218_add_index_to_photo.rb`가 초록색이 되었다. 커밋하면 커밋 기록으로 등록 대상이 되는 파일이 된 것이다.
```sh
git add db/migrate/20230526174218_add_index_to_photo.rb
```
```sh
git commit -m "photo 테이블의 date_taken 컬럼에 인덱스 추가 마이그레이션 생성"
```
```sh
git status
```
- 커밋이 되었기 때문에 이전 커밋과 비교했을 때 변경사항이 없으므로 `status` 명령어에서 대상이 나타나지 않는 것을 알 수 있다.
```sh
git push origin main
```