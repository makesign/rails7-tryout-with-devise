# README

## active_storage

bin/bundle add image_processing

bin/rails active_storage:install
bin/rails db:migrate

see https://edgeguides.rubyonrails.org/active_storage_overview.html#setup
for the tables:

active_storage_blobs	Stores data about uploaded files, such as filename and content type.
active_storage_attachments	A polymorphic join table that connects your models to blobs. If your model's class name changes, you will need to run a migration on this table to update the underlying record_type to your model's new class name.
active_storage_variant_records	If variant tracking is enabled, stores records for each variant that has been generated.
