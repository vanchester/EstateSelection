<?php


class Home extends \Phalcon\Mvc\Model
{

	const TABLENAME = 'home';

    /**
     *
     * @var integer
     */
    public $id;
     
    /**
     *
     * @var string
     */
    public $url;
     
    /**
     *
     * @var string
     */
    public $address;
     
    /**
     *
     * @var double
     */
    public $square_all;
     
    /**
     *
     * @var double
     */
    public $square_live;
     
    /**
     *
     * @var double
     */
    public $square_kitchen;
     
    /**
     *
     * @var double
     */
    public $price;
     
    /**
     *
     * @var double
     */
    public $price_to_square;
     
    /**
     *
     * @var integer
     */
    public $flat_floor;
     
    /**
     *
     * @var integer
     */
    public $home_floor;
     
    /**
     *
     * @var string
     */
    public $matherial;
     
    /**
     *
     * @var string
     */
    public $flat_type;
     
    /**
     *
     * @var string
     */
    public $layout;
     
    /**
     *
     * @var integer
     */
    public $toilet;
     
    /**
     *
     * @var string
     */
    public $balcony;
     
    /**
     *
     * @var string
     */
    public $phone;
     
    /**
     *
     * @var string
     */
    public $type_of_ownership;
     
    /**
     *
     * @var string
     */
    public $comment;
     
    /**
     * Independent Column Mapping.
     */
    public function columnMap() {
        return array(
            'id' => 'id', 
            'url' => 'url', 
            'address' => 'address', 
            'square_all' => 'square_all', 
            'square_live' => 'square_live', 
            'square_kitchen' => 'square_kitchen', 
            'price' => 'price', 
            'price_to_square' => 'price_to_square', 
            'flat_floor' => 'flat_floor', 
            'home_floor' => 'home_floor', 
            'matherial' => 'matherial', 
            'flat_type' => 'flat_type', 
            'layout' => 'layout', 
            'toilet' => 'toilet', 
            'balcony' => 'balcony', 
            'phone' => 'phone', 
            'type_of_ownership' => 'type_of_ownership',
            'comment' => 'comment'
        );
    }

	/**
	 * @param \Phalcon\Mvc\Model\Manager $modelsManager
	 * @return mixed
	 */
	public static function getPriceRange(Phalcon\Mvc\Model\Manager $modelsManager)
	{
		return $modelsManager->createBuilder()
			->columns('MAX(price) max, MIN(price) min')
			->from(__CLASS__)
			->getQuery()
			->execute()
			->getFirst();
	}

	public static function getSquareRange(Phalcon\Mvc\Model\Manager $modelsManager)
	{
		return $modelsManager->createBuilder()
			->columns('MAX(square_all) max, MIN(square_all) min')
			->from(__CLASS__)
			->getQuery()
			->execute()
			->getFirst();
	}

	public static function getMatherials(Phalcon\Mvc\Model\Manager $modelsManager)
	{
		return $modelsManager->createBuilder()
			   ->columns('DISTINCT(matherial) matherial')
			   ->from(__CLASS__)
			   ->getQuery()
			   ->execute();
	}

	public static function getLayouts(Phalcon\Mvc\Model\Manager $modelsManager)
	{
		return $modelsManager->createBuilder()
			   ->columns('DISTINCT(layout) layout')
			   ->from(__CLASS__)
			   ->getQuery()
			   ->execute();
	}

	public static function deleteById(Phalcon\Mvc\Model\Manager $modelsManager, $id)
	{
		$id = (int)$id;
		File::deleteDir(__DIR__.'/../../public/images/'.$id);
		return $modelsManager->executeQuery("DELETE FROM " . __CLASS__ . " WHERE id = {$id}");
	}

}
