<?php

class Baselogmoderation extends Record{

	const Table = 'forum_log_moderation';

	/**
	 * Id dans la base
	 * @var int
	 */
	public $id;

	/**
	 * Date de l action
	 * @var DATETIME
	 */
	public $date_action;

	/**
	 * Id du moderateur
	 * @var int
	 */
	public $moderateur_id;

	/**
	 * [$thread_id description]
	 * @var int
	 */
	public $thread_id;

	/**
	 * [$forum_id description]
	 * @var int
	 */
	public $forum_id;

	/**
	 * [$message_id description]
	 * @var int
	 */
	public $message_id;

	/**
	 * Action realiser par le moderateur
	 * @var string
	 */
	public $action;

	/**
	 * Detail sur le log
	 * @var string
	 */
	public $detail;

}