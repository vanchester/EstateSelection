<?php

class MyTags extends \Phalcon\Tag
{
	//Override an existing method
	public static function mySelect($name, $list, $params)
	{
		$options = array();
		if (!empty($params['useEmpty'])) {
			$options[isset($params['emptyValue']) ? $params['emptyValue'] : ''] = isset($params['emptyText']) ? $params['emptyText'] : '';
		}
		if (is_array($list)) {
			foreach ($list as $key => $val) {
				$options[$key] = $val;
			}
		} else {
			/** @var Phalcon\Mvc\Model\Resultset\Simple $list */
			for ($i = 0; $i < $list->count(); $i++) {
				$row = $list->offsetGet($i);
				$using = $params['using'];
				$param1 = array_shift($using);
				$param2 = array_shift($using);
				$options[$row->$param1] = $row->$param2;
			}
		}

		$val = self::getValue($name);
		$out = "<select id=\"{$name}\" name=\"{$name}\">\n";
		foreach ($options as $key => $val) {
			$out .= "<option value=\"{$key}\"" .
				((string)$key === self::getValue($name) ? 'selected' : '') .
				">{$val}</option>\n";
		}
		$out .= "</select>\n";

		return $out;
	}

	public static function setDefault($id, $value)
	{
		parent::setDefault($id, base64_encode($value));
	}

	public static function getValue($name, $params=null)
	{
		return base64_decode(html_entity_decode(parent::getValue($name)));
	}
}