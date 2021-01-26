## Running

If your user is not part of the docker group, you will need to preface all of the following commands with sudo. Sorry for requiring admin access. I promise there is nothing malicious.

```
# build image to install dependencies
docker build -t junze:recent .

# run container to execute ruby scripts
docker run -it --rm -v $(pwd):/home/submission junze:recent /bin/bash 

# run image to run submission using file
docker run -it --rm -v $(pwd):/home/submission junze:recent /bin/bash -c "cat sample_file | bin/scheduler"

# run image to run specs
docker run -it --rm -v $(pwd):/home/submission junze:recent /bin/bash -c "bundle exec rspec spec/"

# run image to run rubocop/linting
docker run -it --rm -v $(pwd):/home/submission junze:recent /bin/bash -c "rubocop"
```
