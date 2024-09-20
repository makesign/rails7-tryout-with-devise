# README

# Docker deployment

Änderungen in diesem Branch sind im PR zu sehen:
https://github.com/makesign/rails7-tryout-with-devise/pull/1


## Local docker
docker-compose.override.yml adds configuration for local development.
usage:
```
docker compose up -d
```

## Deployment

grober ablauf: 
- gh action baut image und pusht ihn zur github container registry 
(sie pipeline_04_docker_build_and_push.yml)
- pipeline_01 starten jeweils die pipeline (von branch, tag, pr, push in main)
  mit entsprechenden Parametern.
- staging pusht ein image mit tag sha-1234567 (aktueller commit sha) 
- branch gerade auch mit slim target
- von der action gepushte images sind dann als packages verfügbar:
https://github.com/orgs/makesign/packages?repo_name=rails7-tryout-with-devise
(war zunächst auf private, muss auf dieser Seite auf public gesetzt werden)

Dockerfile.rails.original enthält ein leicht erweitertes Dockerfile so wie rails
das generiert. Dies kann direkt so getestet werden:
```bash
docker build -f Dockerfile.rails.original --tag original:base --target base .
docker run original:base tail -f /dev/null
docker exec -ti vibrant_leavitt bash
````
(vibrant_leavitt ist der generierte containername den man mit docker ps sieht)

### start auf production:

edit .env to contain the correct tag (e.g. sha-a980110)

export RAILS_MASTER_KEY=
docker compose  -f docker-compose.yml up -d

(nutzt nur docker-compose.yml)

wenn der master key fehlt, kommt dieser fehler:

   | bin/rails aborted!
railsapp-container      | ArgumentError: Missing `secret_key_base` for 'production' environment, set this string with `bin/rails credentials:edit` (ArgumentError)
railsapp-container      |
railsapp-container      |         raise ArgumentError, "Missing `secret_key_base` for '#{Rails.env}' environment, set this string with `bin/rails credentials:edit`"
railsapp-container      |               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
railsapp-container      | /railsapp/config/environment.rb:17:in `<main>'
railsapp-container      | Tasks: TOP => db:migrate => db:load_config => environment
railsapp-container      | (See full trace by running task with --trace)


###

Die Images sind ziemlich groß, hier im vgl. Zu modulehandbook:

ghcr.io/makesign/rails7-tryout-with-devise   latest        ea9b5728c543   20 minutes ago      924MB
ghcr.io/makesign/rails7-tryout-with-devise   xxxx          5c404f18c0e8   24 minutes ago      926MB
vs. 
mh-local-dev                                 latest        8e782ed64937   2 weeks ago         522MB

die ersten verkleinerungsversuche haben nur wenig gebracht:

ghcr.io/makesign/rails7-tryout-with-devise   sha-857afc2   7d2469dcad71   15 hours ago    859MB

## Generate selfsigned certificate:
(for nginx ssl)

from https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04

```bash
cd secrets/nginx
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx-selfsigned.key -out nginx-selfsigned.crt
```



# Installation

- install ruby 
- install a recent node version

db migration 

    

nodemon 
esbuild



## active_storage

bin/bundle add image_processing

bin/rails active_storage:install
bin/rails db:migrate





see https://edgeguides.rubyonrails.org/active_storage_overview.html#setup
for the tables:

active_storage_blobs	Stores data about uploaded files, such as filename and content type.
active_storage_attachments	A polymorphic join table that connects your models to blobs. If your model's class name changes, you will need to run a migration on this table to update the underlying record_type to your model's new class name.
active_storage_variant_records	If variant tracking is enabled, stores records for each variant that has been generated.


LoadError (Could not open library 'vips.42':
https://stackoverflow.com/questions/70849182/could-not-open-library-vips-42-could-not-open-library-libvips-42-dylib
brew install vips