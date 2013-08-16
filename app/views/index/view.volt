{% if home %}
	<div style="margin-bottom: 20px">
		<a href="/">Главная</a> &rarr; {{ home.address }} (ID {{ id }})
	</div>

	<div style="float: left; width: 50%; padding: 0 10px">
		<table class="table table-striped table-hover table-condensed table-bordered">
			<tr>
				<td>URL</td>
				<td>
					<a href="{{ home.url }}">{{ home.url }}</a>
					<button type="button" data-id="{{ home.id }}" class="close pull-right">&times;</button>
				</td>
			</tr>
			<tr>
				<td>Адрес</td>
				<td>{{ home.address }}</td>
			</tr>
			<tr>
				<td>Цена</td>
				<td>{{ home.price }} ({{ home.price_to_square }})</td>
			</tr>
			<tr>
				<td>Площадь</td>
				<td>{{ home.square_all }}/{{ home.square_live }}/{{ home.square_kitchen }}</td>
			</tr>
			<tr>
				<td>Этаж</td>
				<td>{{ home.flat_floor }}/{{ home.home_floor }}</td>
			</tr>
			<tr>
				<td>Материал</td>
				<td>{{ home.matherial }}</td>
			</tr>
			<tr>
				<td>Тип квартиры</td>
				<td>{{ home.flat_type }}</td>
			</tr>
			<tr>
				<td>Планировка</td>
				<td>{{ home.layout }}</td>
			</tr>
			<tr>
				<td>Санузел</td>
				<td>{% if home.toilet %}Раздельный{% else %}Смежный{% endif %}</td>
			</tr>
			<tr>
				<td>Балкон</td>
				<td>{{ home.balcony }}</td>
			</tr>
			<tr>
				<td>Телефон</td>
				<td>{{ home.phone }}</td>
			</tr>
			<tr>
				<td>Форма собственности</td>
				<td>{{ home.type_of_ownership }}</td>
			</tr>
			<tr>
				<td colspan="2">{{ home.comment }}</td>
			</tr>
		</table>

		<div id="map" style="width:100%; height:400px"></div>
		<script type="text/javascript">
			ymaps.ready(init);

			function init() {
				// Поиск координат центра Нижнего Новгорода.
				ymaps.geocode('{{ home.address }}', { results: 1 }).then(function (res) {
					// Выбираем первый результат геокодирования.
					var firstGeoObject = res.geoObjects.get(0);

					// Создаем карту с нужным центром.
					var myMap = new ymaps.Map("map", {
						center: firstGeoObject.geometry.getCoordinates(),
						zoom: 15,
						behaviors:['default', 'scrollZoom']
					});

					myMap.controls.add('smallZoomControl');

					myMap.container.fitToViewport();
					myMap.geoObjects.add(firstGeoObject);

				}, function (err) {
					// Если геокодирование не удалось, сообщаем об ошибке.
				});
			}
		</script>
	</div>
	<div style="float: right; width: 50%">

		<link rel="stylesheet" href="/css/agile_carousel.css" type='text/css' />
		<div id="flavor_2"></div>
		<script src="/js/agile_carousel.alpha.js"></script>

		<script>
			$(document).ready(function(){

				$('.close').click(function () {
					if (!confirm('Вы действительно хотите удалить этот вариант?')) {
						return false;
					}

					$.get('/index/del?id=' + $(this).data('id'), function () {
						location.href = '/';
					});

					return false;
				});

				var data = {{ images }};
				$("#flavor_2").agile_carousel({
					carousel_data: data,
					carousel_outer_height: 800,
					carousel_height: 600,
					slide_height: 600,
					carousel_outer_width: 800,
					slide_width: 800,
					transition_type: "fade",
					transition_time: 600,
					timer: 3000,
					continuous_scrolling: true,
					control_set_1: "numbered_buttons,previous_button,pause_button,next_button",
					control_set_2: "content_buttons",
					change_on_hover: "content_buttons"
				});
			});
		</script>
	</div>
{% else %}
	Квартира не найдена
{% endif %}