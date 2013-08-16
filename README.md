EstateSelection
===============

Небольшой web-скрипт для удобного подбора недвижимости.

Написан на PHP с использованием фреймворка [Phalcon](http://phalconphp.com). 

Позволяет быстро сохранять страницы с интересующими вариантами недвижимости с 
последующим удобным представлением сохраненной информации: с фильтром, всеми 
результатами в виде таблице и маркеров на карте Yandex, возможностью сортировки
и подробной информацией с фотографиями.

На данный момент поддерживается работа только с сайтом [НГС-недвижимость](http://realty.ngs.ru/),
но добавить другие ресурсы не составляет большого труда (для PHP-разработчиков).

[Демо](http://realty.vanchester.ru)



Установка
---------

1. Установить Phalcon согласно [инструкции](http://docs.phalconphp.com/en/latest/reference/install.html) 
или воспользоваться хостингом с поддержкой этого фреймворка

2. Клонировать репозиторий, настроить веб-сервер на папку public

3. Разрешить web-серверу запись в папки app/cache и public/images 

4. Импортировать дамп базы данных из файла data/base.sql

5. Скопировать файл app/config/config.php.example в app/config/config.php и прописать свои параметры подключения к базе

6. Добавить закладку в браузер со ссылкой

 ```javascript
 javascript:(function(){location.href = 'http://your.domain/index/add?url=' + location.href})()
 ```
 
 заменив в ней your.domain на Ваш домен. При клике по этой закладке будет происходить 
 добавление информации с текущей страницы в базу скрипта.
 

Используемые компоненты
-----------------------

* [Phalcon] (http://phalconphp.com)

* [jQuery] (http://jquery.com)

* [jQuery-UI] (http://jqueryui.com)

* [Twitter Bootstrap] (http://bootstrap-ru.com/)

* [TableSorter] (http://tablesorter.com/docs/)

* [Agile Carousel] (http://www.agilecarousel.com/)

* [Simple HTML DOM] (http://simplehtmldom.sourceforge.net/)

