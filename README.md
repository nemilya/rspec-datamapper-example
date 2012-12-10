Rspec DataMapper example
========================


Init
----

Create `rspec-datamapper-example` folder, initialize Rspec:

    rspec --init .

Create `spec/user_spec.rb`.

Start autotest:

    autotest .

Or in Windows:

    start autotest .


Create test for instance of class User `spec/spec_user.rb`:

```ruby
    require 'spec_helper.rb'

    describe 'User' do
      it "should exists" do
        user = User.new
        user.should be_an_instance_of(User)
      end
    end
```

Create class
------------

Create `lib/user.rb`:

```ruby
    class User
    end
```

And add `require 'user'` line to RSpec's config file `spec/spec_helper.rb` on top.


Install DataMapper
------------------

   gem install dm-core
   gem install dm-migrations

Install SQLite adapter for tests:

   gem install dm-sqlite-adapter


Install Sqlite3
---------------

For windows http://www.sqlite.org/sqlite-dll-win32-x86-3071401.zip unzip, and place



Configure RSpec for DataMapper
------------------------------

Add to `spec/spec_helper.rb` (over `require 'user'` line):

```ruby
    require 'dm-core'
    require 'dm-migrations'
```

And add this into `RSpec.configure do |config|` ... `end` section:


```ruby
    DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/demo_test.db")
    DataMapper.finalize
    User.auto_migrate!
```


DataMapper model User
---------------------

User class have to be ORM table, with fields `id`, `name`  and handled by DataMapper, 
change `user.rb` to follow:

```ruby
    class User
      include DataMapper::Resource

      property :id,   Serial, :key => true
      property :name, String
    end
```

Configire Autotest to exclude some files
----------------------------------------

Create `.autotest` and exclude wathing for sqlite database:

```ruby
    Autotest.add_hook :initialize do |at|
      at.add_exception('demo_test.db')
    end
```

Write Rspec test for User class
-------------------------------

Add follow spec to `user_spec.rb` file:

Test creation:

```ruby
    it "should add record" do
      user = User.new
      user.name = 'User Name'
      ret = user.save

      ret.should be_true
      User.count.should equal 1
    end
```

Test setting attributes:

```ruby
    it "should proper store attributes" do
      # create
      user = User.new
      user.name = 'User Name'
      user.save

      # get
      user_test = User.get(user.id)
      user_test.name.should == 'User Name'
    end
```
