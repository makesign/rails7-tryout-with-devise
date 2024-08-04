# README

# Docker deployment




## Generate selfsigned certificate:


from https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04

```bash
cd secrets/nginx
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx-selfsigned.key -out nginx-selfsigned.crt
```



# Installation

- install ruby 
- install a recent node version
- install a recent yarn version

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