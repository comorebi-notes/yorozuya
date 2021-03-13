crumb :root do
  link 'Home', root_path
end

crumb :admin_root do
  link tag.i('', class: 'fa fa-home fa-fw fa-lg'), admin_root_path
end

crumb :admin_users do
  link t('admin.page_title.index', model: User.model_name.human), admin_users_path
  parent :admin_root
end

crumb :new_admin_user do |user|
  link t('admin.page_title.new', model: User.model_name.human), new_admin_user_path(user)
  parent :admin_users
end

crumb :edit_admin_user do |user|
  link t('admin.page_title.edit', model: User.model_name.human), edit_admin_user_path(user)
  parent :admin_users
end

crumb :admin_creators do
  link t('admin.page_title.index', model: Creator.model_name.human), admin_creators_path
  parent :admin_root
end

crumb :admin_creator do |creator|
  link creator.name, admin_creator_path(creator)
  parent :admin_creators
end

crumb :new_admin_creator do |creator|
  link t('admin.page_title.new', model: Creator.model_name.human), new_admin_creator_path(creator)
  parent :admin_creators
end

crumb :edit_admin_creator do |creator|
  link t('admin.page_title.edit', model: Creator.model_name.human), edit_admin_creator_path(creator)
  parent :admin_creators
end

crumb :admin_works do
  link t('admin.page_title.index', model: Work.model_name.human), admin_works_path
  parent :admin_root
end

crumb :admin_work do |work|
  link work.title, admin_work_path(work)
  parent :admin_works
end

crumb :new_admin_work do |work|
  link t('admin.page_title.new', model: Work.model_name.human), new_admin_work_path(work)
  parent :admin_works
end

crumb :edit_admin_work do |work|
  link t('admin.page_title.edit', model: Work.model_name.human), edit_admin_work_path(work)
  parent :admin_works
end
