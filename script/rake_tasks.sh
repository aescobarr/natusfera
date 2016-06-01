export PATH=/home/natura/.rvm/gems/ruby-1.9.3-p551/bin:/home/natura/.rvm/gems/ruby-1.9.3-p551@global/bin:/home/natura/.rvm/rubies/ruby-1.9.3-p551/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/natura/.rvm/bin:/home/natura/.rvm/bin:/home/natura/.rvm/bin:/home/natura/.rvm/bin:/home/natura/.rvm/bin:/home/natura/.rvm/bin:/home/natura/.rvm/bin
export GEM_HOME=/home/natura/.rvm/gems/ruby-1.9.3-p551
export GEM_PATH=/home/natura/.rvm/gems/ruby-1.9.3-p551:/home/natura/.rvm/gems/ruby-1.9.3-p551@global

RAILS_ENV=production rake denormalize:ancestries
RAILS_ENV=production rake denormalize:places
RAILS_ENV=production rake denormalize:windshaft 
