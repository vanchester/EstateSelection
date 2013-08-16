<style>
	table.table tr {
		cursor: pointer;
	}
	.form-group {
		display: inline-table;
		margin-right: 20px;
	}
</style>
<div id="filter">
	<link rel="stylesheet" href="/css/jquery-ui-1.10.3.custom.min.css" type='text/css' />
	<script src="/js/jquery-ui-1.10.3.custom.min.js"></script>

	<form class="form-inline">
		<div class="form-group">
			<label for="address">Адрес</label>
			<div><input type="text" name="address" value="{{ get['address'] }}" /></div>
		</div>
		<div class="form-group" style="width: 150px">
			<label>Цена</label>&nbsp;
			<span id="price_range_value">
				{% if get['price_from'] %}{{ get['price_from'] }}{% else %}{{ priceRange.min }}{% endif %} -
				{% if get['price_to'] %}{{ get['price_to'] }}{% else %}{{ priceRange.max }}{% endif %}
			</span>
			<div id="price_range"></div>
			<input type="hidden" id="price_from" name="price_from" value="{{ get['price_from'] }}"/>
			<input type="hidden" id="price_to" name="price_to" value="{{ get['price_to'] }}"/>
		</div>
		<div class="form-group" style="width: 150px">
			<label>Площадь</label>&nbsp;
			<span id="square_range_value">
				{% if get['square_from'] %}{{ get['square_from'] }}{% else %}{{ squareRange.min }}{% endif %} -
				{% if get['square_to'] %}{{ get['square_to'] }}{% else %}{{ squareRange.max }}{% endif %}
			</span>
			<div id="square_range"></div>
			<input type="hidden" id="square_from" name="square_from" value="{{ get['square_from'] }}"/>
			<input type="hidden" id="square_to" name="square_to" value="{{ get['square_to'] }}"/>
		</div>
		<div class="form-group">
			<label>Этаж</label>
			<div><label><input type="checkbox" name="floor_not_first" {% if get['floor_not_first'] %}checked=checked{% endif %}/> Не первый</label></div>
			<div><label><input type="checkbox" name="floor_not_last" {% if get['floor_not_last'] %}checked=checked{% endif %}/> Не последний</label></div>
		</div>
		<div class="form-group">
			<label>Материал</label>
			<div>
				{{ my_select('matherial', matherialList, ['using': ['matherial', 'matherial'], 'useEmpty': true, 'emptyText': '...']) }}
			</div>
		</div>
		<div class="form-group">
			<label>Планировка</label>
			<div>
				{{ my_select('layout', layoutList, ['using': ['layout', 'layout'], 'useEmpty': true, 'emptyText': '...']) }}
			</div>
		</div>
		<div class="form-group">
			<label>Санузел</label>
			<div>
				{{ my_select('toilet', toiletList) }}
			</div>
		</div>
		<div class="form-group">
			<div><input type="submit" value="Найти" style="margin-bottom: 10px; width: 100%"/></div>
			<div><button id="reset">Сбросить</button></div>
		</div>
	</form>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#price_range").slider({
				range: true,
				min: {{ priceRange.min }},
				max: {{ priceRange.max }},
				values: [
					{% if get['price_from'] %}{{ get['price_from'] }}{% else %}{{ priceRange.min }}{% endif %},
					{% if get['price_to'] %}{{ get['price_to'] }}{% else %}{{ priceRange.max }}{% endif %}
				],
				slide: function(event, ui) {
					$("#price_from").val(ui.values[0]);
					$("#price_to").val(ui.values[1]);
					$('#price_range_value').text(ui.values[0] + ' - ' + ui.values[1]);
				}
			});

			$("#square_range").slider({
				range: true,
				min: {{ squareRange.min }},
			max: {{ squareRange.max }},
			values: [
				{% if get['square_from'] %}{{ get['square_from'] }}{% else %}{{ squareRange.min }}{% endif %},
				{% if get['square_to'] %}{{ get['square_to'] }}{% else %}{{ squareRange.max }}{% endif %}
			],
			slide: function(event, ui) {
				$("#square_from").val(ui.values[0]);
				$("#square_to").val(ui.values[1]);
				$('#square_range_value').text(ui.values[0] + ' - ' + ui.values[1]);
			}
			});

			$('#reset').click(function () {
				location.href='/';
				return false;
			});
		});
	</script>
</div>
<div style="width: 50%; float: left; padding: 0 10px">
	<link rel="stylesheet" href="/css/tablesorter/style.css" type='text/css' />
	<script src="/js/jquery.tablesorter.min.js"></script>
	<table class="table table-striped table-hover table-condensed table-bordered tablesorter">
		<thead>
			<tr>
				<th>Адрес</th>
				<th>Цена</th>
				<th>за кв.м</th>
				<th>Площадь</th>
				<th>Этаж</th>
				<th>Материал</th>
				<th>Планировка</th>
				<th>Санузел</th>
				<th>Форма собственности</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			{% for home in homes %}
				<tr data-id="{{ home.id }}">
					<td>{{ home.address|shortAddress }}</td>
					<td>{{ home.price }}</td>
					<td>{{ home.price_to_square }}</td>
					<td>{{ home.square_all }}/{{ home.square_live }}/{{ home.square_kitchen }}</td>
					<td>{{ home.flat_floor }}/{{ home.home_floor }}</td>
					<td>{{ home.matherial }}</td>
					<td>{{ home.layout }}</td>
					<td>{% if home.toilet %}Раздельный{% else %}Смежный{% endif %}</td>
					<td>{{ home.type_of_ownership }}</td>
					<td class="on-map" style="vertical-align: center"><b>&#8658;</b></td>
				</tr>
			{% endfor %}
		</tbody>
	</table>
</div>
<div style="width: 50%; float: right">
<div id="map" style="width:100%; height:400px"></div>
	<script type="text/javascript">
		ymaps.ready(init);
		var points = {};
		var myMap;

		function init() {
			$('#map').css('height', document.height - 120);
			// Создаем карту с нужным центром.
			myMap = new ymaps.Map("map", {
				center: [55.0135, 82.9254],
				zoom: 12,
				behaviors:['default', 'scrollZoom']
			});

			myMap.controls.add('smallZoomControl');

			{% for home in homes %}
				// Поиск координат центра Нижнего Новгорода.
				ymaps.geocode('{{ home.address }}', { results: 1 }).then(function (res) {
					// Выбираем первый результат геокодирования.
					var firstGeoObject = res.geoObjects.get(0);

					myMap.container.fitToViewport();
					myMap.geoObjects.add(firstGeoObject);

					points['{{ home.id }}'] = firstGeoObject;
				}, function (err) {
					// Если геокодирование не удалось, сообщаем об ошибке.
				});
			{% endfor %}
		}

		var $table = $("table.table");

		$table.tablesorter();
		$('tr', $table).click(function () {
			if (!$(this).data('id')) {
				return;
			}
			location.href = '/index/view?id=' + $(this).data('id');
		});

		$('.on-map')
			.mouseover(function () {
				var id = $(this).parent('tr').data('id');
				points[id].options.set('preset', 'twirl#redIcon');
				console.log(points[id].geometry.getCoordinates());
				myMap.setCenter(points[id].geometry.getCoordinates(), 14);
			})
			.mouseout(function () {
				var id = $(this).parent('tr').data('id');
				points[id].options.unset('preset');
			});
	</script>
</div>