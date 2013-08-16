<?php
include(__DIR__.'/../vendors/simple_html_dom.php');

class UrlParser
{
	private static $_imgPath;

	public static function parseUrl($url)
	{
		self::$_imgPath = __DIR__.'/../../public/images/';

		$urlData = parse_url($url);

		switch ($urlData['host']) {
			case 'homes.ngs.ru':
				return self::_parseNgs($url);
		}
	}

	/**
	 * @param $url
	 */
	private static function _parseNgs($url)
	{
		$html = file_get_html($url);
		if (!$html) {
			return false;
		}

		$page = $html;

		if (!$page) {
			return false;
		}

		$home = new Home();

		$home->url = $url;

		$home->address = trim($page->find('.card__address', 0)->innertext);
		$home->price = (int)(str_replace(' ', '', trim($page->find('.card__cost', 0)->innertext)));
		$home->price_to_square = (float)(str_replace(' ', '', trim($page->find('.card__price', 0)->innertext)));

		$squares = $page->find('.card__area-section', 0);
		$home->square_all = (int)trim($squares->find('.key-value__value', 0)->innertext);
		$home->square_live = (int)trim($squares->find('.key-value__value', 1)->innertext);
		$home->square_kitchen = (int)trim($squares->find('.key-value__value', 2)->innertext);

		$details = $page->find('.card__details-section', 0);

		$values = $details->find('.key-value__value');
		foreach ($details->find('.key-value__key') as $key => $row) {
			$value = trim($values[$key]->innertext);
			switch (trim($row->innertext)) {
				case 'Этаж':
					$home->flat_floor = (int)$value;
					break;
				case 'Этажность':
					$home->home_floor = (int)$value;
					break;
				case 'Материал дома':
					$home->matherial = $value;
					break;
				case 'Тип квартиры':
					$home->flat_type = $value;
					break;
				case 'Планировка':
					$home->layout = $value;
					break;
				case 'Санузел':
					$home->toilet = trim($value) == 'Раздельный' ? 1 : 0;;
					break;
				case 'Балкон':
					$home->balcony = $value;
					break;
				case 'Телефон':
					$home->phone = $value;
					break;
				case 'Форма собственности':
					$home->type_of_ownership = $value;
					break;
			}
		}

		$home->comment = trim($page->find('.card__comments-section', 0)->find('p', 0)->innertext);

		if (!$home->save()) {
			return false;
		}

		$images = $page->find('a[rel="card-photo"]');
		if ($images) {
			mkdir(self::$_imgPath.'/'.$home->id, 0777, true);
		}

		foreach ($images as $image) {
			$fileName = basename($image->href);
			$fullFileName = self::$_imgPath.'/'.$home->id.'/'.$fileName;
			file_put_contents($fullFileName, file_get_contents($image->href));
			exec("convert {$fullFileName} -resize 100x100 ".dirname($fullFileName).'/thumb_'.$fileName);
		}

		return $home->id;
	}
}
 