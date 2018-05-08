Aceadmin 
===================

===================

Ace V1.0使用ThinkPHP5.10核心版框架开发.
其主要目的是为了提高开发效率.需要开发什么功能.后台直接添加菜单.程序里直接写控制器!
> 首次使用导入数据库,后台账号admin,密码admin
 + 菜单管理
 + 管理员分组
 + 组分配权限
 + 一个管理员可以属于多个组
 + 操作日志管理
> 运行环境要求PHP5.4以上。


## 虚拟机配置,v.1.0版需要绑定到public目录中,这样比较安全.

Nginx虚拟机配置如下：

~~~
server {
        listen       80; 
        server_name  aceadmin.com;
        root   "/Users/mac/wwwroot/work/aceadmin";
        location / { 
            index  index.html index.htm index.php;
            autoindex  on; 
         if (!-e $request_filename) {
                        rewrite ^/(.*)$ /index.php/$1 last;#隐藏index.php文件
                }   
        }   
        location ~ \.php(.*)$ {
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            fastcgi_split_path_info  ^((?U).+\.php)(/?.+)$;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            fastcgi_param  PATH_INFO  $fastcgi_path_info;
            fastcgi_param  PATH_TRANSLATED  $document_root$fastcgi_path_info;
            include        fastcgi_params;
        }   
}
~~~


window环境 LAMP 配置
~~~


1   在 C:\Windows\System32\drivers\etc\hosts文件底部添加
      127.0.0.1 aceadmin.com


2  在httpd.conf 文件底部添加 aceadmin 网站配置

<virtualhost *:80>

    ServerName aceadmin.com

    DocumentRoot C:\xampp\htdocs\tp5admin

<virtualhost>

3 重启apache 即可 运行aceadmin.com/admin 即可
~~~






