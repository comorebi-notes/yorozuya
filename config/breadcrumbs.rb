crumb :root do
  link 'Home', root_path
end

crumb :admin_root do
  link tag.i('', class: 'fa fa-home fa-fw fa-lg'), admin_root_path
end

crumb :admin_users do
  link t('admin.users.index.title'), admin_users_path
  parent :admin_root
end

crumb :new_admin_user do |user|
  link t('admin.users.new.title'), new_admin_user_path(user)
  parent :admin_users
end

crumb :edit_admin_user do |user|
  link user.name, edit_admin_user_path(user)
  parent :admin_users
end
