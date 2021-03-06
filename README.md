![logo](public/logo.png)

# Tiket

一个简单，易用的票务系统

## 技术栈

- Ruby 2.1.x
- Rails 4.2.x
- PostgreSQL
- Bootstrap 3.2
- Redis
- Rspec

## API

### 票务类

#### 抢票

POST
```ruby
    {
      collection_id: '2',
      timestamp: "2014-11-13T11:25:56+08:00", #符合ISO8601
      user_email: "chzsh1995@gmail.com",
      user_cucId: "201408223005",
      token: "#{Digest::MD5.hexdigest(timestamp + user_email + user_cucId + Rails.application.secrets.secret_key_base[7...21])}"
    }
```
 success:
```ruby
    {
      status: 200,
      content: {
        admission: "#{@event.short_name}-#{@collection.id.to_s.rjust(4,'0')}-#{id.to_s.rjust(4, '0')}",
        cucId: "201408223005"
        secret: "#{Digest::MD5.hexdigest(admission + cucId + Rails.application.secrets.secret_key_base[23...27])}"
      }
    }
```
 failure:
```ruby
    {
      status: 304,
      content: {
        reason: "limited"  #抢光了
      }
    }
```

#### 验票

GET
```ruby
    {
      admission: 057,
      cucId: "201408223005"
      token: "#{Digest::MD5.hexdigest(admission + cucId + Rails.application.secrets.secret_key_base[23...27])}"
    }
```
 success:
```ruby
    {
      status: 200,
      content: {
        admission: 057,
        user: {
          cucId: "201408223005",
          email: "chzsh1995@gmail.com"
      }
    }
```
 failure:
```ruby
    {
      status: 401,
      content: {
        reason: "wrong_token"   #验票错误
      }
    }
```
