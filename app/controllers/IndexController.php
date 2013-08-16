<?php

class IndexController extends ControllerBase
{

    public function indexAction()
    {
		$params = array();
		if ($address = $this->request->get('address')) {
			$params[] = "address LIKE '%{$address}%'";
		}
		if ($priceFrom = (int)$this->request->get('price_from')) {
			$params[] = "price >= {$priceFrom}";
		}
		if ($priceTo= (int)$this->request->get('price_to')) {
			$params[] = "price <= {$priceTo}";
		}
		if ($squareFrom = (int)$this->request->get('square_from')) {
			$params[] = "square_all >= {$squareFrom}";
		}
		if ($squareTo= (int)$this->request->get('square_to')) {
			$params[] = "square_all <= {$squareTo}";
		}
		if ($floorNotFirst = $this->request->get('floor_not_first')) {
			$params[] = "flat_floor > 1";
		}
		if ($floorNotLast = $this->request->get('floor_not_last')) {
			$params[] = "flat_floor < home_floor";
		}
		if ($matherial = $this->request->get('matherial')) {
			$params[] = "matherial = '{$matherial}'";
			$this->tag->setDefault('matherial', $matherial);
		}
		if ($layout = $this->request->get('layout')) {
			$params[] = "layout = '{$layout}'";
			$this->tag->setDefault('layout', $layout);
		}
		$toilet = $this->request->get('toilet');
		if (is_numeric($toilet)) {
			$params[] = "toilet = {$toilet}";
			$this->tag->setDefault('toilet', trim($toilet));
		}

		$this->view->homes = Home::find(implode(' AND ', $params));
		$this->view->priceRange = Home::getPriceRange($this->modelsManager);
		$this->view->squareRange = Home::getSquareRange($this->modelsManager);
		$this->view->get = $_GET;

		$this->view->matherialList = Home::getMatherials($this->modelsManager);;

		$this->view->layoutList = Home::getLayouts($this->modelsManager);;

		$toilets = array(
			'-' => '...',
			0 => 'Смежный',
			1 => 'Раздельный'
		);
		$this->view->toiletList = $toilets;


    }

	public function addAction()
	{
		$url = $this->request->get('url');
		if (!$url) {
			throw new \Phalcon\Exception('Wrong url', 503);
		}

		if (UrlParser::parseUrl($url)) {
			$this->response->redirect($url, true);
		} else {
			throw new \Phalcon\Exception('There is an error with saving data', 503);
		}
	}

	public function delAction()
	{
		$id = $this->request->get('id');
		if (!$id) {
			throw new \Phalcon\Exception('Not found', 404);
		}

		Home::deleteById($this->modelsManager, $id);

		$this->response->redirect('/');
	}

	public function viewAction()
	{
		$id = (int)$this->request->get('id');
		if (!$id) {
			$this->response->setStatusCode(404, 'Квартира не найдена');
		}

		$this->view->home = Home::findFirst('id = '.$id);

		$imagesFiles = glob(__DIR__.'/../../public/images/'.$id.'/*.*');
		$images = array();
		foreach ($imagesFiles as $file) {
			$file = basename($file);
			if (strpos($file, 'thumb_') !== false) {
				continue;
			}
			$images[] = array(
				"content" => "<div class='slide_inner'><img class='photo' src='/images/{$id}/{$file}' /></div>",
      			"content_button" => "<div class='thumb'><img src='/images/{$id}/thumb_{$file}' /></div>"
			);
		}
		$this->view->id = $id;
		$this->view->images = json_encode($images);
	}
}

